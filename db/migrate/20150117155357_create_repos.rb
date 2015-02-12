class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :owner
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
