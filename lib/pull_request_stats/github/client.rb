require 'octokit'
require 'pull_request_stats/github'
require 'pull_request_stats/github/pull_request'

module PullRequestStats
 class Github::Client
   attr_reader :client

   def initialize(token)
     @client = Octokit::Client.new(access_token:  token, auto_paginate: true)
   end

   def pull_requests(repo, state)
     client.pull_requests(repo, state: state).lazy.map do |pull_request|
       Github::PullRequest.from_client(client, repo, pull_request.number)
     end
   end
 end
end
