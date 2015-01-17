class Commit < ActiveRecord::Base
  belongs_to :repo
  serialize :commit_hash
end
