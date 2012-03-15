class EnquiryMailer < ActionMailer::Base
  default from: "swap.kunal@yahoo.com"
  def enquiry_confirmation(enquiry)
    @enquiry = enquiry
    mail(:to => enquiry.user_email, :subject => "Registered")
  end
end
