# frozen_string_literal: true

module Api
  module V1
    # Base controller for all V1 APIs
    class BaseController < ApplicationController
      include ActionController::HttpAuthentication::Token::ControllerMethods

      before_action :authenticate

      def status
        render json: { message: 'App is up and running' }.to_json
      end

      def catch_routing_error
        raise ActionController::RoutingError, params[:path]
      end

      # bottom-up order for exception is needed
      rescue_from Exception, with: :handle_exception
      rescue_from ActionController::RoutingError, with: :handle_routing_error
      rescue_from APIError, with: :handle_api_error

      protected

      def api_error(code, msg = '', request = nil)
        raise APIError.new(code, msg, request)
      end

      def handle_api_error(excp)
        render excp.render_json
      end

      def handle_routing_error
        render APIError.new(404, '', request).render_json
      end

      def handle_exception(excp)
        notify_error(excp)
        render APIError.new(500, '', request, excp).render_json
      end

      def authenticate
        api_error(401, '', request) unless valid_token?
      end

      def valid_token?
        token = request.env['HTTP_X_API_TOKEN']
        ApiKey.valid_token?(token)
      end

      # Schema Validation
      def validate_schema
        controller_params = { controller_name: controller_name, action_name: action_name }
        valid, error = SchemaValidator.new(params, controller_params).validate
        api_error(422, JSON.parse(error.message)) unless valid
      end

      def set_pagination_header(name, _options = {})
        scope = instance_variable_get("@#{name}")
        prepare_link_header(scope)
        headers['X-Total'] = scope.total_count.to_s
        headers['X-Per-Page'] = scope.count.to_s
        headers['X-Page'] = scope.current_page.to_s
      end

      def prepare_link_header(scope)
        last_page = scope.total_pages
        current_page = scope.current_page
        return if last_page <= 1
        query = request.query_parameters
        headers['link'] = FindHeaderLinks.new(query, request.env, current_page, last_page).call
      end

      # Pagination
      def extract_page_details(params)
        per_page = params['per_page'].to_i
        per_page = per_page.positive? && per_page <= 1000 ? per_page : 100
        page = params['page'].to_i
        page = page.positive? ? page : 1
        [page, per_page]
      end
    end
  end
end
