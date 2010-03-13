module GemLove

  # A little love-note passed from a Fan to a Gem's authors
  class Note
    def initialize(gem_name, comment)
      @gem_name = gem_name
      @comment  = comment
    end
  end
end
