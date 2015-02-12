class PagesController < ApplicationController
  INSTAGRAM_USER_ID = '4352736'

  def root
  end

  def about
    @commits = Commit.where('created_at > ?', 1.month.ago)
    @total_lines_of_code = @commits.map{|c| c.total}.reduce(0){|sum, total| sum + total }
  end
end
