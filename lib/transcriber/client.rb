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
    def find(id)
      HTTParty.get(
        api_url_for(endpoint: '/transcript_requests/' + id.to_s),
      )
    end

    # method that cancels transcript requests
    def cancel(id)
      HTTParty.patch(
        api_url_for(endpoint: '/transcript_requests/' + id.to_s + '/cancel'),
      )
    end

    # method that adds media for transcript requests
    def add_media(id, audio_file_url:)
      HTTParty.patch(
        api_url_for(endpoint: '/transcript_requests/' + id.to_s + '/media'),
        query: {
          data: {
            attributes: {
              audio_file_url: audio_file_url,
            }
          }
        }
      )
    end

    # method that updates transcript requests
    def update(
      id,
      audio_file_url: nil,
      expected_media_date: nil,
      high_accuracy: nil,
      multiple_speakers: nil,
      notification: nil,
      notification_url: nil,
      notification_email: nil,
      turnaround_time: nil
    )
      HTTParty.patch(
        api_url_for(endpoint: '/transcript_requests/' + id.to_s),
        query: {
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
            }.reject{ |_, v| v.nil? }
          }
        }
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
