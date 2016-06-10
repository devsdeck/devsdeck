class PostmanWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    cards = Card.where("created_at >= ?", 24.hours.ago)
    return if cards.blank?

    User.all.each do |user|
      begin
        CardsMailer.daily_mail(user, cards).deliver_now
      rescue StandardError => error
        logger.error("failed to send email for #{user.email}")
      end
    end
  end
end
