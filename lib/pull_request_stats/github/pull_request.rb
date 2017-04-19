require 'active_support/time'

module PullRequestStats
 class Github::PullRequest
   attr_reader :repository, :pull_request, :merge_commit

   def initialize(repository:, pull_request:, merge_commit:)
     @repository = repository
     @pull_request = pull_request
     @merge_commit = merge_commit
   end

   def number
     pull_request.number
   end

   def created_at
     pull_request.created_at.to_s(:iso8601)
   end

   def merged_at
     pull_request.merged_at.to_s(:iso8601)
   end

   def duration
     pull_request.merged_at - pull_request.created_at
   end

   def merged?
     pull_request.merged
   end

   def changes
     merge_commit.stats.to_h
   end

   def to_h
     {
       repository: repository,
       number: number,
       created_at: created_at,
       merged_at: merged_at,
       duration: duration,
       changes: changes
     }
   end
 end
end
