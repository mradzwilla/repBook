class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :index

      t.timestamps null: false
    end
  end
end
