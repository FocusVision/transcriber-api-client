require 'spec_helper'
require 'impostor'
describe TranscriberApi::TranscriptRequest do
  before :each do
    Impostor.stub(:transcription)
    TranscriberApi.configure do |config|
      config.api_key = TEST_KEY
    end
  end

  it 'creates transcript requests via the API' do
    response = TranscriberApi::TranscriptRequest.create(
      audio_file_url: nil,
      expected_media_date: (Time.now + (60 * 60 * 24 * 1)).iso8601,
      high_accuracy: true,
      multiple_speakers: true,
      notification: 'webhook',
      notification_url: '/call_me_back',
      turnaround_time: 'normal'
    )

    expect(response.notification_url)
      .to eq('/call_me_back')
  end

  it 'gets transcript requests' do
    response = TranscriberApi::TranscriptRequest.find(1)

    expect(response).to be_instance_of(TranscriberApi::TranscriptRequest)
    expect(response.id).to eq(1)
  end

  it 'set Authorization headers correctly' do
    stubbed_request =
      stub_request(:get, /https:\/\/www.24tru.com\/r\/api\/transcript_requests/)
        .with(headers: {
          'Accept' => TranscriberApi::Client::MIME_TYPE,
          'Authorization' => "Bearer #{TEST_KEY}"
        })
        .to_return(
          body: {
            data: {
              id: '1',
              type: 'transcript_requests',
              links: {
                self: 'https://www.24tru.com/r/api/transcript_requests/1'
              },
              attributes: {
                expected_media_date: '2016-10-20T16:52:47-07:00'
              }
            }
          }.to_json
        )
    TranscriberApi::TranscriptRequest.find(1)

    expect(stubbed_request).to have_been_requested
  end
  it 'handles 404 for resources' do
    expect {
      TranscriberApi::TranscriptRequest.find(0)
    }.to raise_error(TranscriberApi::RecordNotFoundError)
  end

  it 'cancels transcript requests' do
    response = TranscriberApi::TranscriptRequest.cancel(1)

    expect(response.id).to eq(1)
  end

  it 'adds media for transcript requests' do
    response = TranscriberApi::TranscriptRequest.add_media(
      1,
      '/this-is-my-audio-file-url'
    )

    expect(response.audio_file_url)
      .to eq('/this-is-my-audio-file-url')
  end

  it 'fails to add media if audio_file_url is missing' do
    expect {
      TranscriberApi::TranscriptRequest.add_media(1, '')
    }.to raise_error(TranscriberApi::ParamMissingError)
  end

  it 'updates transcript requests' do
    one_week_from_today = (Time.now + (60 * 60 * 24 * 7)).iso8601
    response = TranscriberApi::TranscriptRequest.update(
      1,
      one_week_from_today
    )

    expect(response.expected_media_date)
      .to eq(one_week_from_today)
  end
end
