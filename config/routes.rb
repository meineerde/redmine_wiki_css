ActionController::Routing::Routes.draw do |map| 
  map.resources :projects do |project|
    project.wiki_start_page_format 'wiki.:format', :controller => 'wiki', :action => 'show', :conditions => {:method => :get}
    
    
    project.wiki_styles 'wiki.css/edit', :controller => 'wiki_styles', :action => 'edit', :conditions => {:method => :get}
    project.wiki_styles 'wiki.css', :controller => 'wiki_styles', :action => 'update', :conditions => {:method => :put}
    project.wiki_styles 'wiki.css', :controller => 'wiki_styles', :action => 'update', :conditions => {:method => :put}
    project.wiki_styles 'wiki/:id.css/edit', :controller => 'wiki_styles', :action => 'edit', :conditions => {:method => :get}
    project.wiki_styles 'wiki/:id.css', :controller => 'wiki_styles', :action => 'update', :conditions => {:method => :put}
  end
end