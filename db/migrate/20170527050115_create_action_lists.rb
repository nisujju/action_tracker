class CreateActionLists < ActiveRecord::Migration
  def change
    create_table :action_lists do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
