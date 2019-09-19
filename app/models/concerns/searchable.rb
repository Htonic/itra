require 'elasticsearch/model'

module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    include Indexing
    after_touch() { __elasticsearch__.index_document }
  end
  module Indexing

    #Index only the specified fields
  #  self.settings do
    #  mappings dynamic: false do
    #    indexes :news, type: :object do
    #      indexes :title
     #     indexes :body
     #   end
     #   indexes :comments, type: :object do
    #      indexes :opinion
    #    end
   #   end
 #   end
    def as_indexed_json(options={})
      self.as_json(
          include: { news: { only: [:title,:body]},
                     comments:   { only: :opinion }
          })
    end
    def self.search(query)
      __elasticsearch__.search(
          {
              query: {
                  multi_match: {
                      query: query,
                      fields: ['name', 'description']
                  }
              },
              highlight: {
                  pre_tags: ['<em>'],
                  post_tags: ['</em>'],
                  fields: {
                      title: {},
                      text: {}
                  }
              }
          }
      )
    end
  end
end