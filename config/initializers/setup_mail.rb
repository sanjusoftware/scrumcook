ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => 587,
    :domain => "scrumcook.com",
    :user_name => "support@scrumcook.com",
    :password => "sanjusadhna",
    :authentication => "plain",
    :enable_starttls_auto => true
}