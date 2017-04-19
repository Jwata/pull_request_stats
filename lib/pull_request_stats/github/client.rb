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

   def pull_request(repo, number)
     pull_request = client.pull_request(repo, number)
     merge_commit = commit(repo, pull_request.merge_commit_sha)
     Github::PullRequest.new(repository: repo, pull_request: pull_request, merge_commit: merge_commit)
   end

   private

   def commit(repo, commit_sha)
     client.commit(repo, commit_sha)
   rescue Octokit::NotFound => e
     puts "Commit not found. repo: #{repo}, sha: #{commit_sha}, error: #{e.message}"
     nil
   end
 end
end
