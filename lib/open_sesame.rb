require 'digest/sha1'

module OpenSesame
  class Token
    @secret = "OPEN SESAME"
    def self.generate
      timestamp = DateTime.now.strftime('%m%d%Y%H%M')
      hash = (Digest::SHA1.new << timestamp + @secret).to_s
      hash + '-' + timestamp
    end
    def self.verify(token)
      string = token.split /-/
      timestamp = (DateTime.strptime string[1], '%m%d%Y%H%M')
      hash = (Digest::SHA1.new << timestamp.strftime('%m%d%Y%H%M') + @secret).to_s
      return true if timestamp - DateTime.now <= 1.hour and
        string[0].eql? hash
      false
    end
  end
end