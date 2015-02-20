class RemovePartOfSpeechFromEntities < ActiveRecord::Migration
  def change
    remove_column :entities, :part_of_speech, :string
  end
end
