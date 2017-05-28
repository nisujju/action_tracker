class CreateLogActions < ActiveRecord::Migration
  def change
    create_table :log_actions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :action_list, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
