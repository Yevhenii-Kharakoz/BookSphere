class User < ApplicationRecord
  has_many :books, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  after_create :initialize_books_count
  after_save :update_books_count

  def self.ransackable_associations(auth_object = nil)
    ["books", "reviews"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["age", "books_count", "city", "created_at", "email", "encrypted_password", "id", "id_value", "name", "phone_number", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at", "admin"]
  end

  def self.add_user(name, email, city, phone_number, password)
    user = User.new(name: name, email: email, city: city, phone_number: phone_number, password: password)
    if user.valid?
      user.save
      User.last
    else
      puts user.errors.full_messages
      nil
    end
  end

  def self.update_user(id, name, email, city, phone_number, password)
    user = User.find(id)
    new_user = User.new(name: name, email: email, city: city, phone_number: phone_number)
    if new_user.valid?
      user.update(name: name, email: email, city: city, phone_number: phone_number)
      User.find(id)
    else
      puts new_user.errors.full_messages
      nil
    end
  end

  def admin?
    self.admin
  end

  def self.ban_user(id)
    user = User.find(id)
    user.update(banned: true)
  end

  def self.unban_user(id)
    user = User.find(id)
    user.update(banned: false)
  end

  def self.delete_user_id(id)
    user = User.find(id)
    user.books.clear
    user.reviews.clear
    user.destroy
  end

  private

  def initialize_books_count
    update_column(:books_count, 0)
  end

  def update_books_count
    update_column(:books_count, books.count)
  end
end
