class Page < ActiveRecord::Base
  class WrongVersion < StandardError
  end
  
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_uniqueness_of :url
  #belongs_to :sidebar, :class_name => "Page"
  belongs_to :author, :class_name => "User"
  
  before_save :save_version
  has_many :versions, :as => :versionable
  
  def initialize(*args)
    super
    @version = 0
  end
  
  def name=(value)
    self[:name] = value
    self[:url] = value.urlify
  end
  
  def current_version
    versions.last
  end
  
  def body=(value)
    @body = value
  end

  def body_html
    generate_html(body)
  end

  def body
    @body || (current_version ? current_version.body : "")
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
  
  def save_version
    return unless @body || deleted_at_changed?

    version_number = current_version ? current_version.version : 0
    raise(WrongVersion, "This page has been edited since you loaded it (from version #{version_number} -> #{version}), please copy your changes, refresh the page, and try applying them again") unless version_number == version

    self.version += 1
    new_version = versions.build :body => @body, :author => @author, :version => version
    new_version.deletion = true if deleted?
    @body = nil
  end
  
  def generate_html(markup)
    RedCloth.new(markup).to_html(:textile, :refs_wiki_links)
  end
end
