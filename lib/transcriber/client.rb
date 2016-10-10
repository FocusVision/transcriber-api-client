module Transcriber
  class Client
    MIME_TYPE = 'application/vnd.api+json'.freeze
    RESOURCE_TYPE = 'transcript_requests'.freeze

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

      wrap_response do
        HTTParty.post(
          api_url_for('/transcript_requests'),
          body: serialize_resource(
            {
              audio_file_url: audio_file_url,
              expected_media_date: expected_media_date,
              high_accuracy: high_accuracy,
              multiple_speakers: multiple_speakers,
              notification: notification,
              notification_url: notification_url,
              notification_email: notification_email,
              turnaround_time: turnaround_time
            }
          ),
          headers: post_headers
        )
      end
    end

    # method that gets transcript requests
    def find(id)
      wrap_response do
        HTTParty.get(
          api_url_for('/transcript_requests/' + id.to_s),
          headers: get_headers
        )
      end
    end

    # method that cancels transcript requests
    def cancel(id)
      wrap_response do
        HTTParty.patch(
          api_url_for('/transcript_requests/' + id.to_s + '/cancel'),
          headers: post_headers
        )
      end
    end

    # method that adds media for transcript requests
    def add_media(id, audio_file_url:)
      wrap_response do
        HTTParty.patch(
          api_url_for('/transcript_requests/' + id.to_s + '/media'),
          body: serialize_resource(audio_file_url: audio_file_url),
          headers: post_headers
        )
      end
    end

    # method that updates transcript requests
    def update(id, expected_media_date: nil)
      wrap_response do
        HTTParty.patch(
          api_url_for('/transcript_requests/' + id.to_s),
          body: serialize_resource(expected_media_date: expected_media_date),
          headers: post_headers
        )
      end
    end

    private

    def api_url_for(endpoint)
      Transcriber.configuration.__base_uri__ + endpoint
    end

    def get_headers
      {
        'Accept' => MIME_TYPE,
        'Authorization' => "Bearer #{Transcriber.configuration.api_key}"
      }
    end

    def post_headers
      get_headers.merge('Content-Type' => MIME_TYPE)
    end

    def serialize_resource(attributes = {})
      {
        data: {
          type: RESOURCE_TYPE,
          attributes: attributes
        }
    end

    def wrap_response(&block)
      Transcriber::Response.new(yield)
    end
  end
end
