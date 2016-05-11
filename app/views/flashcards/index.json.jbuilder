json.array!(@flashcards) do |flashcard|
  json.extract! flashcard, :id, :name, :description, :user_id
  json.url flashcard_url(flashcard, format: :json)
end
