# frozen_string_literal: true

require 'rails_helper'

describe SchemaValidatorForm do
  describe '#validate' do
    subject(:schema_validator) do
      described_class.new(params).validate
    end

    context 'when provided parameters satisfy schema validation' do
      let(:params) do
        {
          field_name: 'Field Name',
          description: 'Testing entity schema validation',
          owner: {
            id: '1234',
            type: 'project'
          },
          controller: '/entity',
          action: 'example'
        }.with_indifferent_access
      end

      include_examples 'Form Validation Success'
    end

    context 'when provided parameters does not satisfy schema validation' do
      subject(:error_state) { schema_validator[0] }

      subject(:err_message) { schema_validator[1].message }

      let(:params) do
        {
          name: 'Project Calendar for Receipt',
          description: 'Used to keep track of all shifts',
          owner: {
            type: 'project'
          },
          controller: '/entity',
          action: 'example'
        }.with_indifferent_access
      end
      let(:error_message) do
        { message: 'Validation Failed',
          errors: [{ field: 'owner.id', message: 'must be a non-blank string' }] }.to_json
      end

      it 'returns validation as false along with error message' do
        expect(error_state).to eq(false)
        expect(err_message).to eq(error_message)
      end
    end
  end
end
