class AddAcronymToPartOfSpeech < ActiveRecord::Migration
  def change
    add_column :part_of_speeches, :acronym, :string
  end
end
