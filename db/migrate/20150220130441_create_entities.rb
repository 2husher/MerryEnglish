class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :word
      t.string :translation
      t.text :sentence
      t.string :part_of_speech
      t.integer :dictionary_id
      t.integer :lesson_id

      t.timestamps null: false
    end
  end
end
