class CreatePartOfSpeeches < ActiveRecord::Migration
  def change
    create_table :part_of_speeches do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
