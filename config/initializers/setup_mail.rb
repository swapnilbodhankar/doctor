ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "swap.kunal@gmail.com",  
  :user_name            => "swap.kunal",  
  :password             => "swapnil123",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}