class AddUserIdToDocters < ActiveRecord::Migration
  def change
    add_column :docters, :user_id, :integer
  end
end
