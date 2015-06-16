class PagesController < ApplicationController

  def index
    @courses = Course.all.order('created_at DESC').take(4)
  end

  def faq
  end

  def about
  end

  def contact
  end

  def readme
  end

end