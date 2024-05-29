class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @books = @user.books
  end
end
