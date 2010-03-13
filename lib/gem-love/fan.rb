require 'pathname'
require 'yaml'

module GemLove

  # A Fan is a hacker who loves gems and sends Notes about them to the Service.
  class Fan
    attr_reader :name
    attr_reader :email_address

    def self.load_or_init(ui, options={})
      home = options.fetch(:home_dir) {
        ENV.fetch('HOME') {
          require 'etc'
          Etc.getpwnam(Etc.getlogin).dir
        }
      }
      home  = Pathname(home)
      
      config_file = home + '.gem' + 'love.yml'

      fan = if config_file.exist?
              YAML.load(config_file.to_s)
            else
              name  = ui.ask("What is your name?")
              email = ui.ask("What is your email address?")
              new(name, email)
            end

      config_file.dirname.mkpath
      config_file.open('w+') do |f|
        YAML.dump(fan, f)
      end
      fan
    end

    def initialize(name, email_address)
      @name          = name
      @email_address = email_address
    end
  end
end
