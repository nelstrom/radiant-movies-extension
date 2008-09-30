class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.column :url, :text
      t.column :title, :string
      t.column :description, :text
      t.column :visible, :boolean
    end
  end

  def self.down
    drop_table :movies
  end
end
