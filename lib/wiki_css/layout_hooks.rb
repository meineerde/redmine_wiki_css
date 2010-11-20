module Opensearch
  class LayoutHooks < Redmine::Hook::ViewListener
    def view_layouts_base_html_head (context = {})
      params = context[:controller].params
      if params[:controller] == "wiki" && params[:action] == "show" && params[:format].blank?
        project = context[:controller].instance_variable_get("@project")
        page = context[:controller].instance_variable_get("@page")
        wiki = context[:controller].instance_variable_get("@wiki")
        return unless page
        
        styles = []
        styles << url_for(:controller => 'wiki', :action => 'show', :project_id => project) if wiki.style
        styles << url_for(:controller => 'wiki', :action => 'show', :project_id => project, :id => page.title) if page.style
        styles.collect{|style| stylesheet_link_tag(style)}
      end
    end
    
    def view_layouts_base_sidebar(context = {})
      params = context[:controller].params
      if params[:controller] == "wiki" && params[:action] == "show" && params[:format].blank?
        project = context[:controller].instance_variable_get("@project")
        page = context[:controller].instance_variable_get("@page")
        return unless page && User.current.allowed_to?(:edit_wiki_styles, project)
        
        html = ""
        html << content_tag(:h3, "Custom CSS")
        html << link_to("CSS of this wiki", {:controller => :wiki_styles, :action => 'edit', :project_id => project})
        html << content_tag(:br)
        html << link_to("CSS of this page", {:controller => :wiki_styles, :action => 'edit', :project_id => project, :id => page.title})
        html << content_tag(:br)
        html
      end
    end
  end
end