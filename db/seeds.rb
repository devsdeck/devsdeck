def article_creator(user, article_parts, tags)
  card = user.cards.new(
    name: Faker::Lorem.sentence,
    description: article_parts.join("\r\n\r\n")
  )
  CardTaggerService.new(card, tags).perform
  card.save
end

if Rails.env == 'development'
  user = User.new(username: Faker::Internet.user_name, email: Faker::Internet.safe_email, password: 'abcd1234')
  user.skip_confirmation!
  user.save

  article_creator(
    user,
    Faker::Lorem.paragraphs(2) + ["```ruby\r\nputs 'hello world'\r\n```"] + Faker::Lorem.paragraphs(2),
    %w(ruby rails)
  )
end
