class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :author
      t.string :message
      t.integer :additions
      t.integer :deletions
      t.integer :total
      t.string :sha
      t.text :commit_hash
      t.belongs_to :repo

      t.timestamps null: false
    end
  end
end
