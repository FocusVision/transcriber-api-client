require 'spec_helper'
require 'impostor'
describe Transcriber::Client do

  before :each do
    Impostor.stub(:transcription)
  end

  it 'exists' do
    client = Transcriber::Client.new
    response = client.create(
      notification: 'webhook',
      notification_url: '/call_me_back',
    )

    expect(response['data']['attributes']['notification_url'])
      .to eq('/call_me_back')
  end
end
