# frozen_string_literal: true

# Schema Validator Form Object
class SchemaValidatorForm
  attr_accessor :schema_path, :params

  def initialize(params)
    @params = params
    @schema_path = "#{base_path}"\
                   "/#{@params['controller'].split('/').last}/#{@params['action']}.json"
  end

  def validate
    errors = JSON::Validator.fully_validate(schema_path, params.to_json)
    error_state = errors.present?
    error = raise_errors(errors) if error_state
    [error_state, error]
  end

  private

  def raise_errors(errors)
    error_messages = JSONSchemaErrorParser.parse(errors)
    raise JSON::Schema::CustomFormatError, error_messages
  rescue JSON::Schema::CustomFormatError => excp
    excp
  end

  def base_path
    Rails.root.join('app', 'controllers', 'api', 'v1', 'schemas').to_s
  end
end
