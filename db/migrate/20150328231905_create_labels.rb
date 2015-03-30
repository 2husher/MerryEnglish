class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.references :tag, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :labels, :tags
    add_foreign_key :labels, :users
  end
end
