class AddSIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :s_id, :integer
  end
end
