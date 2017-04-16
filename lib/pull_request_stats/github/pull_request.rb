module PullRequestStats
 class Github::PullRequest
   def self.from_client(client, repo, number)
     pull_request = client.pull_request(repo, number)
     merge_commit = client.commit(repo, pull_request.merge_commit_sha)
     self.new(repo: repo, number: number, pull_request: pull_request, merge_commit: merge_commit)
   end

   attr_reader :repo, :number, :pull_request, :merge_commit

   def initialize(repo: '', number: 0, pull_request: nil, merge_commit: nil)
     @repo = repo
     @number = number
     @pull_request = pull_request
     @merge_commit = merge_commit
   end

   def created_at
     pull_request.created_at
   end

   def merged_at
     pull_request.merged_at
   end

   def duration
     merged_at - created_at
   end

   def changes
     merge_commit.stats
   end

   def to_h
     {
       repository: repo,
       number: number,
       created_at: created_at,
       merged_at: merged_at,
       duration: duration,
       changes: changes
     }
   end
 end
end
