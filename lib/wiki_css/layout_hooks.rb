module Opensearch
  class LayoutHooks < Redmine::Hook::ViewListener
    def view_layouts_base_html_head (context = {})
      params = context[:controller].params
      if params[:controller] == "wiki" && %w(show edit).include?(params[:action]) && params[:format].blank?
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
  end
end