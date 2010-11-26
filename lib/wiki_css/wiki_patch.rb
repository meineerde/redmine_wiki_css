require_dependency 'wiki'

module WikiCss
  module WikiPatch
    def self.included(base) # :nodoc:
      base.class_eval do
        unloadable
        
        has_one :style, :class_name => 'WikiStyle', :foreign_key => 'wiki_id', :dependent => :destroy
      end
    end
  end
end

Wiki.send(:include, WikiCss::WikiPatch)
