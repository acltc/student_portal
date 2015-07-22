class PagesController < ApplicationController

  def index
    @page = Page.first
  end
end
