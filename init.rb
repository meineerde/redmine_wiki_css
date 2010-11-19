require 'redmine'

require 'dispatcher'
Dispatcher.to_prepare do
  # Patches
end

# Hooks

Redmine::Plugin.register :redmine_wiki_css do
  name 'Redmine Wiki CSS'
  url 'http://dev.holgerjust.de/projects/redmine-wiki-css'
  author 'Holger Just'
  author_url 'http://meine-er.de'
  description 'Allows privileged users to use custom CSS in wiki pages'
  version '0.1'
  
  requires_redmine :version_or_higher => '0.9'
end