require 'digest/sha1'

module OpenSesame

  class Token
    @default_secret = "OPEN SESAME"
    def self.generate(timestamp = DateTime.now, secret = @default_secret)
      timestamp_string = timestamp.strftime('%Y%m%dT%H%M')
      hash = (Digest::SHA1.new << secret + timestamp_string).to_s
      timestamp_string + '-' + hash
    end
    def self.verify(token, secret = @default_secret)
      string = token.split /-/
      timestamp = DateTime.strptime string[0], '%Y%m%dT%H%M'
      timestamp - DateTime.now <= 1.hour and token.eql? generate(timestamp, secret)
    end
  end

  class Signed
    @default_secret = "OPEN SESAME"
    def self.generate(message, secret =  @default_secret)
      hash = (Digest::SHA1.new << secret + message).to_s
      message + '-' + hash
    end
    def self.verify(token, secret = @default_secret)
      string = token.split /-/
      token.eql? generate(string[0], secret)
    end
  end

end