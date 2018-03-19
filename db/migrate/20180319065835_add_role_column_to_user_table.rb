class AddRoleColumnToUserTable < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :string, default: User::Role::DEVELOPER
  end
end
