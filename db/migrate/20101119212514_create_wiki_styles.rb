class CreateWikiStyles < ActiveRecord::Migration
  def self.up
    create_table :wiki_styles do |t|
      t.integer  "wiki_id",                       :null => false
      t.integer  "page_id",                       :null => true
      
      t.datetime "created_on",                    :null => false
      t.datetime "updated_on",                    :null => false
      
      t.integer  "author_id"
      t.text     "text"
    end
    
    add_index :wiki_styles, ["wiki_id"], :name => "index_wiki_styles_on_wiki_id"
    add_index :wiki_styles, ["page_id"], :name => "index_wiki_styles_on_page_id"
    add_index :wiki_styles, [:wiki_id, :page_id], :unique => true
  end

  def self.down
    drop_table :wiki_styles
  end
end
