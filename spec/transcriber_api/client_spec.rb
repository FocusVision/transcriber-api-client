require 'spec_helper'

RSpec.describe TranscriberAPI::Client do
  TEST_KEY = '9566b75b-d9fa96fd-601f2df-0ef05ab63'

  before :each do
    TranscriberAPI.configure do |config|
      config.api_key = TEST_KEY
    end
  end

  it 'creates transcript requests via the API' do
    client = TranscriberAPI::Client.new

    response = client.create(
      audio_file_url: nil,
      expected_media_date: (Time.now + (60 * 60 * 24 * 1)).iso8601,
      high_accuracy: true,
      multiple_speakers: true,
      name: '1',
      notification: 'webhook',
      notification_url: '/call_me_back',
      turnaround_time: 'normal'
    )

    expect(response.attributes['notification_url'])
      .to eq('/call_me_back')
  end

  it 'gets transcript requests' do
    client = TranscriberAPI::Client.new

    response = client.find(1)

    expect(response).to be_successful
    expect(response).to be_instance_of(TranscriberAPI::Response)
    expect(response.id).to eq(1)
  end

  it 'set Authorization headers correctly' do
    client = TranscriberAPI::Client.new
    stubbed_request =
      stub_request(:get, /https:\/\/www.24tru.com\/r\/api\/transcript_requests/)
        .with(headers: {
          'Accept' => TranscriberAPI::Client::MIME_TYPE,
          'Authorization' => "Bearer #{TEST_KEY}"
        })

    client.find(1)

    expect(stubbed_request).to have_been_requested
  end

  it 'handles 404 for resources' do
    client = TranscriberAPI::Client.new

    expect { client.find(0) }.to(
      raise_error(TranscriberAPI::RecordNotFoundError)
    )
  end

  it 'cancels transcript requests' do
    client = TranscriberAPI::Client.new

    response = client.cancel(1)

    expect(response).to be_successful
    expect(response.id).to eq(1)
  end

  it 'adds media for transcript requests' do
    client = TranscriberAPI::Client.new

    response = client.add_media(1, audio_file_url: '/this-is-my-audio-file-url')

    expect(response).to be_successful
    expect(response.attributes['audio_file_url'])
      .to eq('/this-is-my-audio-file-url')
  end

  it 'fails to add media if audio_file_url is missing' do
    client = TranscriberAPI::Client.new

    expect { client.add_media(1, audio_file_url: '') }.to(
      raise_error(TranscriberAPI::ParamMissingError)
    )
  end

  it 'updates transcript requests' do
    one_week_from_today = (Time.now + (60 * 60 * 24 * 7)).iso8601
    client = TranscriberAPI::Client.new

    response = client.update(1, expected_media_date: one_week_from_today)

    expect(response).to be_successful
    expect(response.attributes['expected_media_date'])
      .to eq(one_week_from_today)
  end
end
