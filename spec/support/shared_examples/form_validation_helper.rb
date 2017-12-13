# frozen_string_literal: true

RSpec.shared_examples 'Form Validation Success' do
  let(:validation_subject) { subject }

  it 'returns true without error message' do
    expect(validation_subject).to eq([true, nil])
  end
end

# Usage:

# include_examples 'Form Validation Success'

RSpec.shared_examples 'Form Validation Failure' do
  let(:validation_subject) { subject }
  let(:error_block) { [] }
  let(:error_message) do
    {
      message: 'Validation Failed',
      errors: error_block
    }
  end

  it 'returns false along with error message' do
    expect(validation_subject).to eq([false, error_message])
  end
end

# Usage:

# Note: You can use include_examples or it_behaves_like
#       while using shared examples
#
# it_behaves_like 'Form Validation Failure' do
#   let(:error_block) do
#     [
#       {
#         field: 'end_time',
#         message: 'must be greater than or equal to start_time'
#       },
#       {
#         field: 'status',
#         message: "must be 'unpublished' or 'published'"
#       }
#     ]
#   end
# end
