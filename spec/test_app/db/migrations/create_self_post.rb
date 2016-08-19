
                     class CreateSelf_posts < ActiveRecord::Migration
                       def change
                         create_table :self_post do |t|
                           t.string :title
t.text :content
                           
                           t.timestamps null: false
                         end
                       end
                     end
                     