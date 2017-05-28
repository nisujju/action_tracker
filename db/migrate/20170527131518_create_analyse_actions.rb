class CreateAnalyseActions < ActiveRecord::Migration
  def change
    create_table :analyse_actions do |t|
      t.string :action_name1
      t.string :action_name2
      t.integer :immediate
      t.integer :weekly
      t.integer :monthly
      t.integer :yearly
      t.integer :lifetime

      t.timestamps null: false
    end
  end
end
