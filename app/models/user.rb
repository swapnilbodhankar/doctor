class User < ActiveRecord::Base
  
  has_and_belongs_to_many      :roles
  has_many                     :docters
  has_many                     :patients
  has_many                     :hospitals
 
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role_ids, :s_id, :user_id
  
  # This method is used for cancan gem. It will check the user role at the time of user authentication.  
  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end
end
