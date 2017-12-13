# frozen_string_literal: true

# Create Api Key
ApiKey.find_or_create_by!(access_token: 'app_token')
