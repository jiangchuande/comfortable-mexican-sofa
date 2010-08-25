class CreateCms < ActiveRecord::Migration
  
  def self.up
    
    # -- Layouts ------------------------------------------------------------
    create_table :cms_layouts do |t|
      t.string  :label
      t.text    :content
      t.timestamps
    end
    add_index :cms_layouts, :parent_id
    add_index :cms_layouts, :label
    
    # -- Pages --------------------------------------------------------------
    create_table :cms_pages do |t|
      t.integer :cms_layout_id
      t.string  :label
      t.string  :slug
      t.string  :full_path
      t.text    :content
      t.timestamps
    end
    add_index :cms_pages, :full_path
    
    # -- Page Blocks --------------------------------------------------------
    create_table :cms_blocks do |t|
      t.string    :type
      t.integer   :cms_page_id
      t.string    :label
      t.string    :content_string
      t.text      :content_text
      t.integer   :content_integer
      t.datetime  :content_datetime
      t.timestamps
    end
    add_index :cms_blocks, [:cms_page_id, :type, :label]
    # TODO: index this
    
    # -- Snippets -----------------------------------------------------------
    create_table :cms_snippets do |t|
      t.string  :label
      t.text    :content
      t.timestamps
    end
    add_index :cms_snippets, :label, :unique => true
  end
  
  def self.down
    drop_table :cms_layouts
    drop_table :cms_pages
    drop_table :cms_snippets
    drop_table :cms_blocks
  end
end
