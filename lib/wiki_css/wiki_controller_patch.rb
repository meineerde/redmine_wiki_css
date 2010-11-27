require_dependency 'wiki_controller'

module WikiCss
  module WikiControllerPatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)
      
      base.class_eval do
        unloadable
        
        helper :wiki
        before_filter :find_style, :only => [:show, :edit, :update]
        
        alias_method_chain :show, :css
      end
    end
    
    module InstanceMethods
      def show_with_css
        if params[:format] == "css"
          if params[:id].blank?
            style = @wiki.style
          else
            page = @wiki.find_page(params[:id])
            style = page.style if page
          end
          style ? render(:text => style.text, :content_type => 'text/css') : render_404
        else
          show_without_css
        end
      end
      
    private
      def find_style
        @page = @wiki.find_or_new_page(params[:id])
        @style = @page.style || WikiStyle.new(:wiki => @wiki, :page => @page)
        @style_global = @wiki.style || WikiStyle.new(:wiki => @wiki)
      end      
    end
  end
end

WikiController.send(:include, WikiCss::WikiControllerPatch)
