require 'spec_helper'

RSpec.describe TranscriberAPI::TranscriptRequest do
  before :each do
    TranscriberAPI.configure do |config|
      config.api_key = '9566b75b-d9fa96fd-601f2df-0ef05ab63'
    end
  end

  it 'creates transcript requests via the API' do
    response = TranscriberAPI::TranscriptRequest.create(
      audio_file_url: nil,
      expected_media_date: (Time.now + (60 * 60 * 24 * 1)).iso8601,
      high_accuracy: true,
      multiple_speakers: true,
      notification: 'webhook',
      notification_url: '/call_me_back',
      turnaround_time: 'normal'
    )

    expect(response.notification_url).to eq('/call_me_back')
  end

  it 'gets transcript requests' do
    response = TranscriberAPI::TranscriptRequest.find(1)

    expect(response).to be_instance_of(TranscriberAPI::TranscriptRequest)
    expect(response.id).to eq(1)
  end

  it 'fetches a transcript' do
    response = TranscriberAPI::TranscriptRequest.find(99)

    expect(response).to be_instance_of(TranscriberAPI::TranscriptRequest)
    expect(response.status).to eq(TranscriberAPI::Status::COMPLETE)
    expect(response.transcript).to eq('This is the transcript of your video')
    expect(response.id).to eq(99)
  end

  it 'handles a failed transcript' do
    response = TranscriberAPI::TranscriptRequest.find(3)

    expect(response).to be_instance_of(TranscriberAPI::TranscriptRequest)
    expect(response.status).to eq(TranscriberAPI::Status::ERROR)
    expect(response.error).to eq('Unable to generate transcript')
    expect(response.id).to eq(3)
  end

  it 'handles 404 for resources' do
    expect { TranscriberAPI::TranscriptRequest.find(0) }.to(
      raise_error(TranscriberAPI::RecordNotFoundError)
    )
  end

  it 'cancels transcript requests' do
    response = TranscriberAPI::TranscriptRequest.cancel(1)

    expect(response.id).to eq(1)
  end

  it 'adds media for transcript requests' do
    response = TranscriberAPI::TranscriptRequest.add_media(
      1,
      '/this-is-my-audio-file-url'
    )

    expect(response.audio_file_url).to eq('/this-is-my-audio-file-url')
  end

  it 'fails to add media if audio_file_url is missing' do
    expect {
      TranscriberAPI::TranscriptRequest.add_media(1, '')
    }.to raise_error(TranscriberAPI::ParamMissingError)
  end

  it 'updates transcript requests' do
    one_week_from_today = (Time.now + (60 * 60 * 24 * 7)).iso8601
    response = TranscriberAPI::TranscriptRequest.update(
      1,
      one_week_from_today
    )

    expect(response.expected_media_date).to eq(one_week_from_today)
  end
end
