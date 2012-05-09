ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => 587,
    :domain => "scrumkook.com",
    :user_name => "sanjusoftware",
    :password => "yourpassword",
    :authentication => "plain",
    :enable_starttls_auto => true
}