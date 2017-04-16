$LOAD_PATH << File.dirname(File.expand_path(__FILE__))

require 'pull_request_stats/github/client'

module PullRequestStats
  def self.call(token, repo)
    Github::Client.new(token).pull_requests(repo, :closed)
  end
end
