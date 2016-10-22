module TranscriberApi
  class Client
    MIME_TYPE = 'application/vnd.api+json'.freeze
    RESOURCE_TYPE = 'transcript_requests'.freeze

    def create(
      audio_file_url:,
      expected_media_date:,
      high_accuracy:,
      multiple_speakers:,
      notification:,
      notification_url: '',
      notification_email: '',
      turnaround_time:
    )

      handle_errors do
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

    def find(id)
      handle_errors do
        HTTParty.get(
          api_url_for("/transcript_requests/#{id}"),
          headers: get_headers
        )
      end
    end

    def cancel(id)
      handle_errors do
        HTTParty.patch(
          api_url_for("/transcript_requests/#{id}/cancel"),
          headers: post_headers
        )
      end
    end

    def add_media(id, audio_file_url:)
      handle_errors do
        HTTParty.patch(
          api_url_for("/transcript_requests/#{id}/media"),
          body: serialize_resource(audio_file_url: audio_file_url),
          headers: post_headers
        )
      end
    end

    def update(id, expected_media_date: nil)
      handle_errors do
        HTTParty.patch(
          api_url_for("/transcript_requests/#{id}"),
          body: serialize_resource(expected_media_date: expected_media_date),
          headers: post_headers
        )
      end
    end

    private

    def api_url_for(endpoint)
      TranscriberApi.configuration.__base_uri__ + endpoint
    end

    def get_headers
      {
        'Accept' => MIME_TYPE,
        'Authorization' => "Bearer #{TranscriberApi.configuration.api_key}"
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
      }.to_json
    end

    def handle_errors(&block)
      Response.new(yield).tap { |response| verify_response(response) }
    rescue Timeout::Error
      raise TimeoutError
    end

    def verify_response(response)
      raise response.errors[0] unless response.successful?
    end
  end
end
