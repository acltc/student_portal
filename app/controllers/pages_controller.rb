class PagesController < ApplicationController

  def index
    @instructors = User.where(role_id: 2)
  end

end