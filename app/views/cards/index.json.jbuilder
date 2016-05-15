json.array!(@cards) do |card|
  json.extract! card, :id, :name, :description
  json.url card_url(card, format: :json)
end
