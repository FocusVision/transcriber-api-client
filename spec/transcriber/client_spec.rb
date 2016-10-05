require 'spec_helper'
require 'impostor'
describe Transcriber::Client do

  before :each do
    Impostor.stub(:transcription)
  end

  it 'creates transcript requests via the API' do
    client = Transcriber::Client.new
    response = client.create(
      notification: 'webhook',
      notification_url: '/call_me_back'
    )

    expect(response['data']['attributes']['notification_url'])
      .to eq('/call_me_back')
  end

  it 'gets transcript requests' do
    client = Transcriber::Client.new
    response = client.find(1)

    expect(response['data']['id'])
      .to eq('1')
  end

  it 'cancels transcript requests' do
    client = Transcriber::Client.new
    response = client.cancel(1)

    expect(response['data']['id'])
      .to eq('1')
  end

  it 'adds media for transcript requests' do
    client = Transcriber::Client.new
    response = client.add_media(
      1,
      audio_file_url: '/this-is-my-audio-file-url'
    )
    expect(response['data']['attributes']['audio_file_url'])
      .to eq('/this-is-my-audio-file-url')
  end
end
