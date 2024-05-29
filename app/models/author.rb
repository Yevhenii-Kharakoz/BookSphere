class Author < ApplicationRecord
  has_and_belongs_to_many :books

  validates :name, presence: true, uniqueness: true

  def self.add_author(name)
    author = Author.new(name:)
    if author.valid?
      author.save
      Author.last
    else
      puts author.errors.full_messages
      nil
    end
  end

  def self.update_author(id, name)
    author = Author.find(id)
    new_author = Author.new(name:)
    if new_author.valid?
      author.update(name:)
      Author.find(id)
    else
      puts new_author.errors.full_messages
      nil
    end
  end

  def self.delete_author_id (id)
    author = Author.find(id)
    author.books.clear
    author.delete
  end
end
