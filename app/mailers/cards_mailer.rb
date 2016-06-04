class CardsMailer < ApplicationMailer
  default from: "DevsDeck <no-reply@devsdeck.com>"

  def daily_mail(user, cards)
    @user = user
    @cards = cards
    mail(to: @user.email, subject: "New cards today")
  end
end
