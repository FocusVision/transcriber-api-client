module Transcriber
  class Client
    # auth & more
    def initialize
    end

    # method that creates transcript requests via the API
    def create(
      audio_file_url: '1',
      expected_media_date: Time.now.iso8601,
      high_accuracy: false,
      multiple_speakers: true,
      notification: 'webhook',
      notification_url: '/callback',
      notification_email: '',
      turnaround_time: 'normal'
    )

      HTTParty.post(
        api_url_for(endpoint: '/transcript_requests'),
        body: {
          data: {
            attributes: {
              audio_file_url: audio_file_url,
              expected_media_date: expected_media_date,
              high_accuracy: high_accuracy,
              multiple_speakers: multiple_speakers,
              notification: notification,
              notification_url: notification_url,
              notification_email: notification_email,
              turnaround_time: turnaround_time
            }
          }
        }
      )
    end

    # method that gets transcript requests
    def find(id:)
    end

    # method that cancels transcript requests
    def cancel(id:)
    end

    # method that adds media for transcript requests
    def add_media(
      id:,
      audio_file_url:
    )
    end

    # method that updates transcript requests
    def update(
      id:,
      audio_file_url:,
      expected_media_date:,
      high_accuracy:,
      multiple_speakers:,
      notification:,
      notification_url:,
      notification_email:,
      turnaround_time:
    )
    end

    # methods that normalize response data from API
    def parse(
      response:
    )
    end

    private

    def api_url_for(endpoint:)
      Transcriber::BASE_URL + endpoint
    end

  end
end
