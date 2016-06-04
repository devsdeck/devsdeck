class PostmanWorker
  include Sidekiq::Worker

  def perform
    cards = Card.where("created_at >= ?", Time.zone.now.beginning_of_day)
    return if cards.blank?

    User.all.each do |user|
      CardsMailer.daily_mail(user, cards).deliver_now
    end
  end
end
