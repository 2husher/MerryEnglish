class AddAliasToPartOfSpeech < ActiveRecord::Migration
  def change
    add_column :part_of_speeches, :alias, :string
  end
end
