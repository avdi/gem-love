require File.expand_path('gem-love', File.dirname(__FILE__))
require 'rubygems'
require 'rubygems/command_manager'

class Gem::Commands::LoveCommand < Gem::Command

  def initialize
    super('love', "Show your love for a Gem")
  end


  def execute
    args     = options[:args]
    comment  = if args.size > 1
                 args.pop
               else
                 "(No comment)"
               end
    gem_name = get_one_gem_name
    note     = GemLove::Note.new(gem_name, comment)
    fan      = GemLove::Fan.load_or_init(ui)
    service  = GemLove::Service.new('http://gem-love.avdi.org')
    service.submit_note_from_fan!(note, fan)
  end

  def usage
    "#{program_name} GEM_NAME [COMMENT]"
  end

  def description
    <<END
This command lets you show your appreciation for a Gem.
END
  end

  def arguments
    <<END
GEM_NAME          Name of the Gem you love
COMMENT           Your (kind) words about the gem
END
  end
end

Gem::CommandManager.instance.register_command :love
