require 'pact/consumer/rspec'
require 'httparty'

class TimeConsumer
  include HTTParty
  base_uri 'localhost:1234'

  def get_time
    time = JSON.parse(self.class.get('/time').body)
    "the time is #{time['hour']}:#{time['minute']} ..."
  end
end

Pact.service_consumer 'TimeConsumer' do
  has_pact_with 'TimeProvider' do
    mock_service :time_provider do
      port 1234
    end
  end
end

describe TimeConsumer do
  context 'when telling the time', :pact => true do

    it 'formats the time with hours and minutes' do
      time_provider.
        upon_receiving('a request for the time').
        with({ method: :get, path: '/time' }).
        will_respond_with({
          status: 200,
          body: {'hour' => 10, 'minute' => 45}
        })

      expect(TimeConsumer.new.get_time).to eql('the time is 10:45 ...')
    end
  end
end