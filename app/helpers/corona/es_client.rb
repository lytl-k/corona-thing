module Corona
  class EsClient
    class << self
      def update_cases(case_thing)
        client.update(
          index: 'corona-cases',
          type: 'data',
          id: case_thing.snapshot,
          body: { doc: case_thing, doc_as_upsert: true }
        )
      end

      def update_recovered(recover_thing)
        client.update(
          index: 'corona-recovered',
          type: 'data',
          id: recover_thing.snapshot,
          body: { doc: recover_thing, doc_as_upsert: true }
        )
      end

      def update_deaths(death_thing)
        client.update(
          index: 'corona-deaths',
          type: 'data',
          id: death_thing.snapshot,
          body: { doc: death_thing, doc_as_upsert: true }
        )
      end

      def client
        @client ||= Elasticsearch::Client.new hosts: [{
                                                host: ENV['ELASTICSEARCH_HOST'] || 'localhost',
                                                port: ENV['ELASTICSEARCH_PORT'] || 9200
                                              }]
      end
    end
  end
end