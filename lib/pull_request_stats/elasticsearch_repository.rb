require 'elasticsearch'

class ElasticsearchRepository
  attr_reader :es

  ES_INDEX = :pull_request_stats

  def initialize(opts = {})
    @es = ::Elasticsearch::Client.new(opts)
  end

  def save(pull_request)
    id = pull_request.number
    es_type = pull_request.repo
    es.update(index: ES_INDEX, type: es_type, id: id, body: { doc: pull_request.to_h, doc_as_upsert: true})
  end
end
