module Transcriber
  class Client
    # TBD auth & more
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

      response = HTTParty.post(
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

      Transcriber::Response.new(response)
    end

    # method that gets transcript requests
    def find(id)
      response = HTTParty.get(
        api_url_for(endpoint: '/transcript_requests/' + id.to_s),
      )

      Transcriber::Response.new(response)
    end

    # method that cancels transcript requests
    def cancel(id)
      response = HTTParty.patch(
        api_url_for(endpoint: '/transcript_requests/' + id.to_s + '/cancel'),
      )

      Transcriber::Response.new(response)
    end

    # method that adds media for transcript requests
    def add_media(id, audio_file_url:)
      response = HTTParty.patch(
        api_url_for(endpoint: '/transcript_requests/' + id.to_s + '/media'),
        query: {
          data: {
            attributes: {
              audio_file_url: audio_file_url,
            }
          }
        }
      )

      Transcriber::Response.new(response)
    end

    # method that updates transcript requests
    def update(
      id,
      expected_media_date: nil
    )
      response = HTTParty.patch(
        api_url_for(endpoint: '/transcript_requests/' + id.to_s),
        query: {
          data: {
            attributes: {
              expected_media_date: expected_media_date
            }
          }
        }
      )

      Transcriber::Response.new(response)
    end

    # methods that parses the callback data
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
