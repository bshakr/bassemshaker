class PagesController < ApplicationController
  INSTAGRAM_USER_ID = '4352736'

  def root
  end

  def about
    @instagram = Instagram.user_recent_media(INSTAGRAM_USER_ID, { count: 7 })
    @github = Github.new(oauth_token: '6358eb221b217687e6bf42291ecb43c53723bcb3')
    @repos = @github.repos.all.select {|r| r.updated_at >= 4.weeks.ago }.map(&:name)
    @events = @github.activity.events.performed 'bshakr', 'moodmap', page: 10
  end
end
