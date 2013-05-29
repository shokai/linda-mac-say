Linda Mac Say
=============
text to audible speech with RocketIO::Linda

* https://github.com/shokai/linda-mac-say
* watch Tuples ["say", String] and ["saykana", String] and speech.
* write a Tuple ["say", String, "success"] or ["say", String, "fail"].

Dependencies
------------
- say command in Mac OS
- [SayKana](http://www.a-quest.com/quickware/saykana/)
- Ruby 1.8.7 ~ 2.0.0
- [LindaBase](https://github.com/shokai/linda-base)


Install Dependencies
--------------------

    % gem install bundler foreman
    % bundle install


Run
---

set ENV var "LINDA_BASE" and "LINDA_SPACE"

    % export LINDA_BASE=http://linda.example.com
    % export LINDA_SPACE=test
    % export SAYKANA=/usr/local/bin/SayKana
    % bundle exec ruby linda-mac-say.rb

or

    % LINDA_BASE=http://linda.example.com LINDA_SPACE=test SAYKANA=/usr/local/bin/SayKana  bundle exec ruby linda-mac-say.rb


Install as Service
------------------

for launchd (Mac OSX)

    % sudo foreman export launchd /Library/LaunchDaemons/ --app linda-macsay -u `whoami`
    % sudo launchctl load -w /Library/LaunchDaemons/linda-macsay-macsay-1.plist
