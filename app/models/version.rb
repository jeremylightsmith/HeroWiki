class Version < ActiveRecord::Base
  belongs_to :versionable, :polymorphic => true
  belongs_to :author, :class_name => "User"
  
  def to_param
    version.to_s
  end
end