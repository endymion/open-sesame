require 'digest/sha1'

module OpenSesame
  class Token
    @secret = "OPEN SESAME"
    def self.generate(timestamp = DateTime.now)
      hash = (Digest::SHA1.new << @secret + timestamp.strftime('%Y%m%dT%H%M')).to_s
      timestamp + '-' + hash
    end
    def self.verify(token)
      string = token.split /-/
      timestamp = DateTime.strptime string[0], '%Y%m%dT%H%M'
      timestamp - DateTime.now <= 1.hour and token.eq? generate(timestamp)
    end
  end
end