# frozen_string_literal: true

# Create random alphanumeric 24 letter string
module RandomAlphaNumeric
  def generate_unique_id(field: :uid)
    return if send(field)
    loop do
      random_id = SecureRandom.hex(12)
      unless self.class.where(field => random_id).first
        break write_attribute(field, random_id)
      end
    end
  end
end
