# frozen_string_literal: true

# == Schema Information
#
# Table name: api_keys
#
#  id           :integer          not null, primary key
#  app_info     :jsonb
#  access_token :string
#

# Api Key model
class ApiKey < ApplicationRecord
  include RandomAlphaNumeric

  before_create -> { generate_unique_id(field: :access_token) }
end
