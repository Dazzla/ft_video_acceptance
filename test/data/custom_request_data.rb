# frozen_string_literal: true

class CustomRequestData

  ##
  # Generates a random string.
  #
  # @return [String]
  def self.random_string(length)
    # TODO: Doesn't really belong in here
    string = ''
    length.times { string += ('a'..'z').to_a.sample }
    string
  end

  ##
  # Generates a random string default 255 chars.
  #
  # @return [String]
  def self.extra_long_string(length=255)
    random_string(length)
  end

end
