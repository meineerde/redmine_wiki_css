class WikiStyle < ActiveRecord::Base
  unloadable
  # TODO: this model should be versioned
  
  belongs_to :wiki
  belongs_to :page, :class_name => 'WikiPage', :foreign_key => 'page_id'
  belongs_to :author, :class_name => 'User', :foreign_key => 'author_id'

  validates_presence_of :wiki_id, :text
  validates_uniqueness_of :page_id, :scope => :wiki_id
  
  def visible?(user=User.current)
    page ? page.visible?(user) : wiki.visible?(user)
  end
  
  def editable_by?(user)
    !user.nil? && user.allowed_to?(:edit_wiki_css, project)
  end
  
end
