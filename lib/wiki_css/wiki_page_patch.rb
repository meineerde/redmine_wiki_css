require_dependency 'wiki'

module WikiCss
  module WikiPagePatch
    def self.included(base) # :nodoc:
      base.class_eval do
        unloadable
        
        has_one :style, :class_name => 'WikiStyle', :foreign_key => 'page_id', :dependent => :destroy
      end
    end
  end
end

WikiPage.send(:include, WikiCss::WikiPagePatch)
