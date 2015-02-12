class Repo < ActiveRecord::Base
  has_many :commits

  def self.cache_active_repos
    @github = Github.new(oauth_token: '6358eb221b217687e6bf42291ecb43c53723bcb3')
    @repos = @github.repos.all.select {|r| r.updated_at >= 4.weeks.ago }
    @repos.each do |r|
      repo = Repo.find_by_name(r.name)
      unless repo
        repo = Repo.new
        repo.name = r.name
        repo.owner = r.owner.login
        repo.description = r.description
        repo.save!
      end
    end
  end
end
