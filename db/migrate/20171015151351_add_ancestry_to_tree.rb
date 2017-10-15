class AddAncestryToTree < ActiveRecord::Migration[5.1]
  def change
    add_column :trees, :ancestry, :string
    add_index :trees, :ancestry
  end
end
