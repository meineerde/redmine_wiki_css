require_dependency 'wiki_helper'

module WikiCss
  module WikiHelperPatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)
      
      base.class_eval do
        unloadable
      end
    end
    
    module InstanceMethods
      def wiki_edit_tabs
        tabs  = [{:name => 'page', :partial => 'wiki/edit_page', :label => :label_wiki_page},
                 {:name => 'styles', :partial => 'wiki/edit_styles', :label => :label_wiki_styles, :style => @style},
                 {:name => 'styles_global', :partial => 'wiki/edit_styles', :label => :label_wiki_styles_global, :style => @style_global}
                ]
      end
    end
  end
end

WikiHelper.send(:include, WikiCss::WikiHelperPatch)