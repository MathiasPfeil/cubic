
                     class CreateStatics < ActiveRecord::Migration
                       def change
                         create_table :static do |t|
                           t.string :title
t.text :content
                           
                           t.timestamps null: false
                         end
                       end
                     end
                     