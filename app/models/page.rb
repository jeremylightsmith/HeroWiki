class Page < ActiveRecord::Base
  class WrongVersion < StandardError
  end
  
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_uniqueness_of :url
  #belongs_to :sidebar, :class_name => "Page"
  belongs_to :author, :class_name => "User"
  has_and_belongs_to_many :tags, order:"name"
  
  before_save :check_for_version_conflicts
  after_save :save_version
  has_many :versions, :as => :versionable
  
  has_attached_file :thumbnail, 
                    STORAGE_OPTIONS.merge(
                      styles: {
                        tiny:"160x120",
                        small:"260x180",
                        medium:"360x268",
                        large:"570x416",
                      }, 
                      processors:[:padder],
                      default_url:"/assets/missing_:style.png"
                    )
  has_many :attachments

  def initialize(*args)
    super
    @version = 0
  end
  
  def name=(value)
    self[:name] = value
    self[:url] = value.urlify
  end

  def tag_ids=(ids)
    self.tags = Tag.find(ids.reject{|id| id.blank?})
  end

  def current_version
    versions.last
  end
  
  def body_html
    generate_html(body)
  end

  def version
    @version || (current_version ? current_version.version : 0)
  end
  
  def version=(number)
    @version = number.to_i
  end
  
  def author=(user)
    @author = user
  end
  
  def published_at
    self[:published_at] || created_at || Date.today
  end
  
  def to_param
    url
  end
  
  def self.find_by_param(param)
    find_by_url(param)
  end
  
  def soft_delete! author
    self.author = author
    self.deleted_at = Time.now
    save!
  end
  
  def deleted?
    !!deleted_at
  end
    
  protected

  def check_for_version_conflicts
    version_number = current_version ? current_version.version : 0
    raise(WrongVersion, "This page has been edited since you loaded it (from version #{version_number} -> #{version}), please copy your changes, refresh the page, and try applying them again") unless version_number == version

    self.version += 1
  end
  
  def save_version
    changes = []
    changes << "Name Changed" if name_changed?
    changes << "Body Changed" if body_changed?
    changes << "Deleted" if deleted_at_changed?
    return if changes.empty?

    new_version = versions.create! :body => body, 
      :author => @author, 
      :version => version, 
      :description => changes.join(", "), 
      :deletion => deleted?
  end
  
  def generate_html(markup)
    return "" unless markup

    redcloth = RedCloth.new(markup)
    redcloth.extend(WikiTags)
    redcloth.to_html(:textile, :refs_wiki_links)
  end
end
