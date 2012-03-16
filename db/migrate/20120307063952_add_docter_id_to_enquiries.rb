class AddDocterIdToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :docter_id, :integer
  end
end
