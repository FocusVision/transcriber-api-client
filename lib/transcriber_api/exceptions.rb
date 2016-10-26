module TranscriberAPI
  ERRORS = {
    100 => 'ValidationError',
    101 => 'InvalidResourceError',
    102 => 'FilterNotAllowedError',
    103 => 'InvalidFieldValueError',
    104 => 'InvalidFieldError',
    105 => 'ParamNotAllowedError',
    106 => 'ParamMissingError',
    107 => 'InvalidFilterValueError',
    108 => 'CountMismatchError',
    109 => 'KeyOrderMismatchError',
    110 => 'KeyNotIncludedInURLError',
    112 => 'InvalidIncludeError',
    113 => 'RelationExistsError',
    114 => 'InvalidSortCriteriaError',
    115 => 'InvalidLinksObjectError',
    116 => 'TypeMismatchError',
    117 => 'InvalidPageObjectError',
    118 => 'InvalidPageValueError',
    119 => 'InvalidFieldFormatError',
    120 => 'InvalidFiltersSyntaxError',
    121 => 'SaveFailedError',
    401 => 'AuthenticationError',
    403 => 'ForbiddenError',
    404 => 'RecordNotFoundError',
    406 => 'NotAcceptableError',
    415 => 'UnsupportedMediaTypeError',
    423 => 'LockedError',
    422 => 'ParamMissingError',
    500 => 'InternalServerError'
  }.freeze

  class Error < RuntimeError
    def self.from_raw(raw)
      TranscriberAPI.const_get(ERRORS.fetch(raw['code'].to_i)).new(raw)
    rescue KeyError
      raise ArgumentError, "Error code: #{raw['code'].inspect} is not defined"
    end

    def initialize(raw_error)
      @raw_error = raw_error
    end

    def code
      @raw_error['code'].to_i
    end

    def detail
      @raw_error['detail']
    end

    def title
      @raw_error['title']
    end

    def status
      @raw_error['status'].to_i
    end

    def source
      @raw_error['source']
    end
  end

  class TimeoutError < Error
    def initialize
      @raw_error = {
        'code' => 503,
        'title' => 'Server Timeout',
        'detail' => 'The server could not be reached',
        'status' => 503
      }
    end
  end

  class ValidationError < Error; end # code: 100
  class InvalidResourceError < Error; end # code: 101
  class FilterNotAllowedError < Error; end # code: 102
  class InvalidFieldValueError < Error; end # code: 103
  class InvalidFieldError < Error; end # code: 104
  class ParamNotAllowedError < Error; end # code: 105
  class ParamMissingError < Error; end # code: 106
  class InvalidFilterValueError < Error; end # code: 107
  class CountMismatchError < Error; end # code: 108
  class KeyOrderMismatchError < Error; end # code: 109
  class KeyNotIncludedInURLError < Error; end # code: 110
  class InvalidIncludeError < Error; end # code: 112
  class RelationExistsError < Error; end # code: 113
  class InvalidSortCriteriaError < Error; end # code: 114
  class InvalidLinksObjectError < Error; end # code: 115
  class TypeMismatchError < Error; end # code: 116
  class InvalidPageObjectError < Error; end # code: 117
  class InvalidPageValueError < Error; end # code: 118
  class InvalidFieldFormatError < Error; end # code: 119
  class InvalidFiltersSyntaxError < Error; end # code: 120
  class SaveFailedError < Error; end # code: 121
  class AuthenticationError < Error; end # code: 401
  class ForbiddenError < Error; end # code: 403
  class RecordNotFoundError < Error; end # code: 404
  class NotAcceptableError < Error; end # code: 406
  class UnsupportedMediaTypeError < Error; end # code: 415
  class ParamMissingError < Error; end # code: 422
  class LockedError < Error; end # code: 423
  class InternalServerError < Error; end # code: 500
end
