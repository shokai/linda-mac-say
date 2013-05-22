Linda Mac Say
=============
text to audible speech with RocketIO::Linda

* https://github.com/shokai/linda-mac-say


Dependencies
------------
- say command in Mac OS
- Ruby 1.8.7 ~ 2.0.0


Install Dependencies
--------------------

    % gem install bundler foreman
    % bundle install


Run
---

    % bundle exec ruby linda-mac-say.rb "http://linda.example.com"


Install as Service
------------------

for launchd (Mac OSX)

    % sudo foreman export launchd /Library/LaunchDaemons/ --app linda-macsay -u `whoami`
    % sudo launchctl load -w /Library/LaunchDaemons/linda-macsay-macsay-1.plist
