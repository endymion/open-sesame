require 'spec_helper'
require 'open-sesame'

describe OpenSesame do

  before(:all) do
    @secret = "Don't tell anybody, this is a secret."
  end

  describe 'secure token' do

    it 'can be generated.' do
      token = OpenSesame::Token.generate(@secret)
      token.should match /\d{8}T\d{4}-\w{40}/

      token2 = OpenSesame::Token.generate # Default 'secret'.
      token2.should match /\d{8}T\d{4}-\w{40}/

      token.should_not == token2
    end

    it 'can be verified.' do
      token = OpenSesame::Token.generate(@secret)
      OpenSesame::Token.verify(token, @secret).should be true

      token2 = OpenSesame::Token.generate # Default 'secret'.
      OpenSesame::Token.verify(token2).should be true
    end

    it 'expires after one hour' do
      token = OpenSesame::Token.generate @secret
      Delorean.time_travel_to "59 minutes from now"
      OpenSesame::Token.verify(token, @secret).should be true
      Delorean.time_travel_to "61 minutes from now"
      OpenSesame::Token.verify(token, @secret).should_not be true
    end

    it 'cannot be verified if the time stamp is modified.' do
      token = OpenSesame::Token.generate @secret
      token.gsub!(/^(\d{8})/) {|match| match.to_i + 100 }
      OpenSesame::Token.verify(token, @secret).should_not be true
    end

    it 'cannot be verified if the hash is modified.' do
      token = OpenSesame::Token.generate @secret
      token[token.length - 1] = 'z'
      OpenSesame::Token.verify(token, @secret).should_not be true
    end

  end

  describe 'secure message' do

    it 'can be generated.' do
      message = OpenSesame::Message.generate 'WELL HELLO THERE', @secret
      message.should match /WELL HELLO THERE-\w{40}/

      message2 = OpenSesame::Message.generate 'WELL HELLO THERE' # Default 'secret'.
      message2.should match /WELL HELLO THERE-\w{40}/

      message.should_not == message2
    end

    it 'can be verified.' do
      message = OpenSesame::Message.generate 'WELL HELLO THERE', @secret
      OpenSesame::Message.verify(message, @secret).should be true

      message2 = OpenSesame::Message.generate 'WELL HELLO THERE' # Default 'secret'.
      OpenSesame::Message.verify(message2).should be true
    end

    it 'cannot be verified if the message is modified' do
      message = OpenSesame::Message.generate 'WELL HELLO THERE', @secret
      message.gsub!(/HELLO/, 'GOODBYE')
      OpenSesame::Message.verify(message, @secret).should_not be true
    end

    it 'cannot be verified if the hash is modified' do
      message = OpenSesame::Message.generate 'WELL HELLO THERE', @secret
      message[message.length - 1] = 'z'
      OpenSesame::Message.verify(message, @secret).should_not be true
    end

    it 'returns the message if it verifies' do
      message = OpenSesame::Message.generate 'WELL HELLO THERE', @secret
      OpenSesame::Message.message(message, @secret).should == 'WELL HELLO THERE'
    end

    it 'returns nil if the message is modified' do
      message = OpenSesame::Message.generate 'WELL HELLO THERE', @secret
      message.gsub!(/HELLO/, 'GOODBYE')
      OpenSesame::Message.message(message, @secret).should be_nil
    end


  end

end
