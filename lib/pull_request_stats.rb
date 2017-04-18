$LOAD_PATH << File.dirname(File.expand_path(__FILE__))

require 'pull_request_stats/github/client'
require 'pull_request_stats/elasticsearch_repository'

module PullRequestStats
  def self.call(token, repo)
    repository = ElasticsearchRepository.new
    Github::Client.new(token).pull_requests(repo, :closed).each do |pull_request|
      next unless pull_request.merged?
      repository.save(pull_request)
    end
  end
end
