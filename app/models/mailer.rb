class Mailer < ActionMailer::Base
  
  
  def new_user_token_notification(user)
        recipients  "#{user.email}"
        from        %{"Do not reply" <bounce@thubhub.com>}
        subject     "[#{SITE}] Your access token"
        sent_on     Time.now
        body        :user => user
        @body[:url]  = "#{SITE}/enter/#{user.token}"
    end

    def existing_user_token_notification(user)
          recipients  "#{user.email}"
          from        %{"Do not reply" <bounce@thubhub.com>}
          subject     "[#{SITE}] Your access token"
          sent_on     Time.now
          body        :user => user
          @body[:url]  = "#{SITE}/enter/#{user.token}"
    end

end
