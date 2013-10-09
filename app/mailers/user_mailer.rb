class UserMailer < ActionMailer::Base
  default from: "notifications@cufflink.com"

  def connection_request_email(friendship)
    @friendship = friendship
    @friendee = friendship.friendee
    @friender = friendship.friender

    @approve_url = friendships_approve_url + "?code=#{friendship.token}"
    @deny_url = friendships_deny_url + "?code=#{friendship.token}"

    mail(
      to: "#{@friendee.name} <#{@friendee.email}>",
      subject: "#{@friender.name} wants to connect!"
    )
  end

  def connection_approval_email(friendship)
    @friendship = friendship
    @friendee = friendship.friendee
    @friender = friendship.friender

    mail(
      to: "#{@friendee.name} <#{@friendee.email}>",
      subject: "#{@friendee.first_name} has approved your connection request."
    )
  end

  def connection_denial_email(friendship)
    @friendship = friendship
    @friendee = friendship.friendee
    @friender = friendship.friender

    mail(
      to: "#{@friendee.name} <#{@friendee.email}>",
      subject: "#{@friendee.first_name} has denied your connection request."
    )
  end


end
