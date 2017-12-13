# frozen_string_literal: true

RSpec.shared_examples 'Successfully Created' do |object|
  let(:subject_body) { subject.body }
  let(:subject_status) { subject.status }
  let(:response_body) { {} }

  it 'responds with 201 code' do
    expect(subject_status).to eq(201)
  end

  it "returns created #{object} in response" do
    expect(JSON.parse(subject_body)).to eq(JSON.parse(response_body))
  end
end

RSpec.shared_examples 'Successfully Updated' do |object|
  let(:subject_body) { subject.body }
  let(:subject_status) { subject.status }
  let(:response_body) { {} }

  it 'responds with 200 code' do
    expect(subject_status).to eq(200)
  end

  it "returns updated #{object} in response" do
    expect(JSON.parse(subject_body)).to include(JSON.parse(response_body))
  end
end

# Resource body
RSpec.shared_examples 'Serving a Resource' do |resource|
  let(:response_body) { {} }
  let(:subject_body) { JSON.parse(subject.body) }
  let(:subject_status) { subject.status }

  it "returns the json representation of the #{resource}" do
    expect(subject_body).to eq(response_body)
  end

  it 'responds with 200 status code' do
    expect(subject_status).to eq(200)
  end
end

RSpec.shared_examples 'Serving array resource' do |resource|
  let(:response_body) { {} }
  let(:subject_body) { JSON.parse(subject.body) }
  let(:subject_status) { subject.status }

  it "returns the json representation of the #{resource}" do
    expect(subject_body).to match_array(response_body)
  end

  it 'responds with 200 status code' do
    expect(subject_status).to eq(200)
  end
end

RSpec.shared_examples 'Success with no content' do
  let(:subject_body) { subject.body }
  let(:subject_status) { subject.status }
  let(:response_body) { {} }

  it 'responds with 204 code' do
    expect(subject_status).to eq(204)
  end

  it 'returns no content' do
    expect(subject_body).to eq('')
  end
end
