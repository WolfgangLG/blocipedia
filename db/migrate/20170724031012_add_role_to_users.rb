class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :integer
    change_column_default :wikis, :private, false
  end
end
