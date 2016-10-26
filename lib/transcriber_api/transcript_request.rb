module TranscriberAPI
  class TranscriptRequest
    attr_reader :id

    def initialize(raw_response)
      @id = raw_response['id'].to_i
      @attributes = raw_response['attributes']
    end

    def self.create(opts = {})
      response = Client.new.create(opts)
      new(response.data)
    end

    def self.find(id)
      response = Client.new.find(id)
      new(response.data)
    end

    def self.cancel(id)
      response = Client.new.cancel(id)
      new(response.data)
    end

    def self.add_media(id, audio_file_url)
      response = Client.new.add_media(
        id,
        audio_file_url: audio_file_url
      )
      new(response.data)
    end

    def self.update(id, expected_media_date)
      response = Client.new.update(
        id,
        expected_media_date: expected_media_date
      )
      new(response.data)
    end

    private

    attr_reader :attributes

    def self.define_attribute_readers(*attrs)
      attrs.each do |attribute|
        define_method(attribute) { attributes[attribute.to_s] }
      end
    end

    private_class_method :define_attribute_readers

    define_attribute_readers :audio_file_url,
      :expected_media_date,
      :high_accuracy,
      :multiple_speakers,
      :notification,
      :notification_url,
      :notification_email,
      :turnaround_time,
      :update_dt,
      :status,
      :transcript
  end
end
