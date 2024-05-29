class Genre < ApplicationRecord
  has_many :books

  validates :title, presence: true, uniqueness: true

  def self.add_genre(title)
    genre = Genre.new(title:)
    if genre.valid?
      genre.save
      Genre.last
    else
      puts genre.errors.full_messages
      nil
    end
  end

  def self.update_genre(title, id)
    genre = Genre.find(id)
    new_genre = Genre.new(title:)
    if new_genre.valid?
      genre.update(title:)
      Genre.find(id)
    else
      puts new_genre.errors.full_messages
      nil
    end
  end

  def self.delete_genre_id(id)
    genre = Genre.find(id)
    genre.books.clear
    genre.delete
  end
end
