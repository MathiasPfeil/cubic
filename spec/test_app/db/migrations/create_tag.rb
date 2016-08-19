
                     class CreateTags < ActiveRecord::Migration
                       def change
                         create_table :tag do |t|
                           t.string :name
                           
                           t.timestamps null: false
                         end
                       end
                     end
                     