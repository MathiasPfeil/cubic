
                     class CreateLink_posts < ActiveRecord::Migration
                       def change
                         create_table :link_post do |t|
                           t.string :title
t.text :link
                           
                           t.timestamps null: false
                         end
                       end
                     end
                     