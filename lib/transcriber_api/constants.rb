module TranscriberAPI
  class TurnaroundTime
    ONE_DAY = '1_day'.freeze
    TWO_DAY = '2_day'.freeze
    STANDARD = 'standard'.freeze
  end

  class Notification
    EMAIL = 'email'.freeze # this might be deprecated
    WEBHOOK = 'webhook'.freeze
  end

  class Status
    CANCELLED = 'cancelled'.freeze
    COMPLETE = 'complete'.freeze
    ERROR = 'error'.freeze
    NEW = 'new'.freeze
    PROCESSING = 'processing'.freeze
    VENDOR_NOTIFIED = 'vendor_notified'.freeze
  end
end
