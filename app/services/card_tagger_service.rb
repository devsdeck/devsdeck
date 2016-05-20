class CardTaggerService
  def initialize(card, tags)
    @card = card
    @tags = tags
  end

  def perform
    @card.tags = find_or_create_tags
  end

  private

  def find_or_create_tags
    @tags.map { |t| Tag.find_or_create_by(name: t) }
  end 
end
