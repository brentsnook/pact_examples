class TimeProvider
  def call(env)
    [200, {"Content-Type" => "application/json"}, [{hour: 10, minute: 45, second: 22}.to_json]]
  end
end

Pact.service_provider "Time Provider" do
  app { TimeProvider.new }

  honours_pact_with 'Time Consumer' do
    pact_uri File.dirname(__FILE__) + '/../pacts/timeconsumer-timeprovider.json'
  end
end