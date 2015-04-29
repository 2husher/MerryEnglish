class AddPartOfSpeedIdToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :part_of_speech_id, :integer
  end
end
