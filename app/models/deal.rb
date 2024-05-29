class Deal < ApplicationRecord
  has_many :books

  validates :address, presence: false
  validates :date, presence: true
  validates :books, presence: true

  def self.add_deal(address, date, book_ids)
    books = Book.find(book_ids)
    deal = Deal.new(address:, date:, books:)
    if deal.valid?
      deal.save
      Deal.last
    else
      puts deal.errors.full_messages
      nil
    end
  end

  def self.update_deal(id, address, date)
    deal = Deal.find(id)
    new_deal = Deal.new(address:, date:)
    if new_deal.valid?
      deal.update(address:, date:)
      Deal.find(id)
    else
      puts new_deal.errors.full_messages
      nil
    end
  end

  def self.delete_deal_id (id)
    deal = Deal.find(id)
    deal.books = []
    deal.delete
  end
end
