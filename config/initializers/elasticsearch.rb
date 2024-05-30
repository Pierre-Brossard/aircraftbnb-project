Elasticsearch::Model.client = Elasticsearch::Client.new(
  url: ENV['BONSAI_URL'],
  transport_options: {
    request: { timeout: 5 },
    pool: { size: 10, timeout: 30 }
  },
  log: true
)
