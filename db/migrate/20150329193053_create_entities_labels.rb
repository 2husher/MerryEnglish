class CreateEntitiesLabels < ActiveRecord::Migration
  def change
    create_table :entities_labels, :id => false do |t|
      t.integer :entity_id, :label_id
    end
  end
end
