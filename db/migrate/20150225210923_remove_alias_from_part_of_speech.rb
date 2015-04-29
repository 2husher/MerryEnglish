class RemoveAliasFromPartOfSpeech < ActiveRecord::Migration
  def change
    remove_column :part_of_speeches, :alias, :string
  end
end
