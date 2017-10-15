class CreateTrees < ActiveRecord::Migration[5.1]
  def change
    create_table :trees do |t|
      t.string :area
      t.float :nota

      t.timestamps
    end
  end
end
