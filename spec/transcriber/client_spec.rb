require 'spec_helper'
require 'impostor'
describe Transcriber::Client do

  before :each do
    Impostor.stub(:transcription)
    @client = Transcriber::Client.new
  end

  it 'creates transcript requests via the API' do
    response = @client.create(
      notification: 'webhook',
      notification_url: '/call_me_back'
    )

    expect(response.attributes['notification_url'])
      .to eq('/call_me_back')
  end

  it 'gets transcript requests' do
    response = @client.find(1)

    expect(response).to be_successful
    expect(response.id).to eq(1)
  end

  it 'cancels transcript requests' do
    response = @client.cancel(1)

    expect(response).to be_successful
    expect(response.id).to eq(1)
  end

  it 'adds media for transcript requests' do
    response = @client.add_media(
      1,
      audio_file_url: '/this-is-my-audio-file-url'
    )

    expect(response).to be_successful
    expect(response.attributes['audio_file_url'])
      .to eq('/this-is-my-audio-file-url')
  end

  it 'fails to add media if audio_file_url is missing' do
    response = @client.add_media(
      1,
      audio_file_url: ''
    )
    expect(response.error_code).to eq(422)
    expect(response).not_to be_successful
    expect(response.error)
      .to eq("audio_file_url - can't be blank")
  end

  it 'updates transcript requests' do
    response = @client.update(
      1,
      notification: 'email',
      notification_email: 'user@example.com'
    )

    expect(response).to be_successful
    expect(response.attributes['notification']).to eq('email')
  end

  it 'updates transcript requests' do
    response = @client.update(1)

    expect(response).to be_successful
    expect(response.data['attributes']).to eq([])
  end
end
