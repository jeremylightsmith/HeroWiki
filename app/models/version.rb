class Version < ActiveRecord::Base
  belongs_to :versionable, :polymorphic => true
  belongs_to :author, :class_name => "User"
  
  def to_param
    version.to_s
  end

  def diff
    #return "First"{type:"New Page", body:body} unless previous
    Differ.format = Differ::Format::HTML
    Differ.diff_by_line(body, previous ? previous.body : "").to_s
  end

  def previous
    return nil unless versionable
    @previous ||= versionable.versions.where(version:version - 1).first
  end
end
