class PagesController < ApplicationController
  INSTAGRAM_USER_ID = '4352736'

  def root
  end

  def about
    @instagram = Instagram.user_recent_media(INSTAGRAM_USER_ID, { count: 7 })
  end
end
