require_dependency 'wiki_controller'

module WikiCss
  module WikiControllerPatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)

      base.class_eval do
        unloadable
      
        alias_method_chain :show, :css
      end
    end
    
    module InstanceMethods
      def show_with_css
        return show_without_css unless params[:format] == "css"
        
        if params[:id].blank?
          style = @wiki.style
        else
          page = @wiki.find_page(params[:id])
          style = page.style if page
        end
        style ? render(:text => style.text, :content_type => 'text/css') : render_404
      end
    end
  end
end

WikiController.send(:include, WikiCss::WikiControllerPatch)
