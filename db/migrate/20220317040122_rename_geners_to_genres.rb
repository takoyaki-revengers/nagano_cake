class RenameGenersToGenres < ActiveRecord::Migration[6.1]
  def up
    rename_table :geners, :genres
  end
  def down
    rename_table :genres, :geners
  end
end
