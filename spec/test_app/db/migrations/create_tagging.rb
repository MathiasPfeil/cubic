
                     class CreateTaggings < ActiveRecord::Migration
                       def change
                         create_table :tagging do |t|
                           t.string :post_type
t.integer :post_id
t.integer :tag_id
                           
                           t.timestamps null: false
                         end
                       end
                     end
                     