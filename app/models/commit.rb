class Commit < ActiveRecord::Base
  belongs_to :repo
  serialize :commit_hash

  def self.cache_commits
    @github = Github.new(oauth_token: '6358eb221b217687e6bf42291ecb43c53723bcb3')
    @repos = Repo.all
    @repos.each do |repo|
      10.times do |i|
        @events = @github.activity.events.performed repo.owner, repo.name, page: i
        @push_events = @events.select{|event| event.type == 'PushEvent' }
        @push_events.each do |event|
          commit_repo = event.repo.name.split('/')
          event.payload.commits.each do |c|
            #find or create commit
            commit = Commit.find_by_sha c.sha
            unless commit
              commit = Commit.new
              commit.sha = c.sha
              commit.message = c.message
              cc = @github.repos.commits.get commit_repo[0], commit_repo[1], c.sha
              commit.author = cc.author.login
              commit.deletions = cc.stats.deletions
              commit.additions = cc.stats.additions
              commit.total = cc.stats.total
              commit.save
              commit.update_attribute(:created_at, DateTime.parse(event.created_at))
            end
          end
        end
      end
    end
  end
end
