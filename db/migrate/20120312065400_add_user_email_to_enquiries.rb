class AddUserEmailToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :user_email, :string
  end
end
