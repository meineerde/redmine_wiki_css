require 'redmine'

require 'dispatcher'
Dispatcher.to_prepare do
  # Patches
  require_dependency 'wiki_css/wiki_patch'
  require_dependency 'wiki_css/wiki_page_patch'
  
  require_dependency 'wiki_css/wiki_controller_patch'
end

# Hooks
require 'wiki_css/layout_hooks' 

Redmine::Plugin.register :redmine_wiki_css do
  name 'Redmine Wiki CSS'
  url 'http://dev.holgerjust.de/projects/redmine-wiki-css'
  author 'Holger Just'
  author_url 'http://meine-er.de'
  description 'Allows privileged users to use custom CSS in wiki pages'
  version '0.1'
  
  requires_redmine :version_or_higher => '0.9'
  
  project_module :wiki do
    permission :edit_wiki_styles, {:wiki_styles => [:edit, :update]}, :require => :member
  end
end