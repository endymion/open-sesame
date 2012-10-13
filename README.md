# OpenSesame

A simple way to pass an authenticated user from one Ruby web app to another.  The two web apps don't need to share a database or be on the same server.  Does not depend on Rails, and works just as well with Sinatra or any other Ruby system.

# Mechanism

Web Site A has an authenticated user that it wants to send to a protected feature on Web Site B.  It generates an authorization token that consists of a cryptographic hash of a timestamp plus a secret, plus the timestamp in plaintext.

Example:

    timestamp: 2009-06-25T10:34:29-04:00
    secret: "OPEN SESAME"
    token: 20090625T1034-93a9d935fc64285645870a59db0d287b58f7caea

Web Site B then checks that the timestamp is not more than an hour old, and it checks to verify that the timestamp plus the shared secret produces the correct hash.  Web Site B should deny access with a 401 response if the authentication token does not verify.

# Installation

    cd your_app
    script/plugin install git://github.com/endymion/open-sesame.git

# Usage

The default secret is "OPEN SESAME".  You should change that because the default secret is public knowledge.  Add the secret to your config/environment.rb:

    OPEN_SESAME_SECRET = "Don't tell anybody, this is a secret!"

Or, if you want to keep that secret out of your source code then you can use an environment variable, like ```ENV['OPEN_SESAME_SECRET']```.  You can configure that environment variable on Heroku, for example, by giving this command to the terminal:

    heroku config:add OPEN_SESAME_SECRET="Don't tell anybody, this is a secret!"

For example, with Rails, you could do this in a controller in the first web app:

    token = OpenSesame::Token.generate(OPEN_SESAME_SECRET)
    redirect_to "http://second-app.net?token=#{token}"

In the second Rails app, you can verify the presence and validity of the token with:

    before_filter :check_token
    def check_token
      return if session[:open_sesame_verified]
      if params[:token].blank? || !OpenSesame::Token.verify(params[:token], OPEN_SESAME_SECRET)
        render :text => 'access denied', :status => 401
      end
      session[:open_sesame_verified] = true
    end

# Signing messages

You can also pass signed parameters.  Let's say you want to identify each user and you don't want them to mess with the ID that you pass.

    message: 123456789
    secret: "OPEN SESAME"
    token: 123456789-e349b9416e2b9f6954e80f03a5bb63d3f7401b70

From the first web app:

    token = OpenSesame::Token.generate(OPEN_SESAME_SECRET)
    username = OpenSesame::Message.generate('username', OPEN_SESAME_SECRET)
    redirect_to "http://second-app.net?token=#{token}&username=#{username}"

In the second app, you can verify both the token and any parameters:

    before_filter :check_token
    def check_token
      return if session[:open_sesame_verified]
      if params[:token].blank? || !OpenSesame::Token.verify(params[:token], OPEN_SESAME_SECRET)
        render :text => 'access denied', :status => 401
      end
      params.keys.each do |param|
        if OpenSesame::Mesage.verify(params[param])
          session[param] = OPenSesame::Message.message(params[param], OPEN_SESAME_SECRET)
        end
      end
      session[:open_sesame_verified] = true
    end


Copyright (c) 2009 Ryan Porter, released under the MIT license
