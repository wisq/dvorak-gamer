require 'pathname'
require 'singleton'

module Dvorak
  def render_os(os)
    "<span class='os-icon os-#{os.icon}'>#{os.version}</span>"
  end

  class GameLoader
    DATA_PATH = Pathname.new(__FILE__).dirname.dirname + 'data'

    @@instance = nil
    def self.instance
      return @instance if @instance && @instance.current?
      return @instance = new
    end

    def initialize
      @depends = {}
      puts "Loading Dvorak game data ..."

      @os = load_data('os') do |key, hash|
        OS.new(self, key, hash)
      end

      @ratings = load_data('ratings') do |key, hash|
        Rating.new(self, key, hash)
      end

      @games = load_data('games') do |key, hash|
        Game.new(self, key, hash)
      end
    end

    def load_data(name)
      path = DATA_PATH + "#{name}.yml"
      path.open do |fh|
        hash = YAML.load(fh, path.to_s)
        @depends[path] = fh.stat.mtime

        return hash.map do |key, value|
          obj = yield(key, value)
          [key, obj]
        end.to_h
      end
    end

    def current?
      return @depends.all? { |path, mtime| path.stat.mtime == mtime }
    end

    def game(key)
      return @games.fetch(key)
    end

    def each_game(&block)
      @games.values.each(&block)
    end

    def os(key)
      return @os.fetch(key)
    end

    def rating(key)
      return @ratings.fetch(key)
    end
  end

  module StructInit
    def struct_init(hash)
      required =
        begin
          self.class.const_get(:REQUIRED)
        rescue NameError
          self.class.members
        end
      missing = required.to_set

      hash.each do |key, value|
        key = key.gsub('-', '_')
        key = key.to_sym

        key, value = yield(key, value) if block_given?

        self[key] = value
        missing.delete(key)
      end

      raise "Missing #{self.class.name} values: #{missing.to_a.inspect}" unless missing.empty?
    end
  end

  OSStruct ||= Struct.new(:icon, :version)
  class OS < OSStruct
    include StructInit

    def initialize(loader, key, hash)
      struct_init(hash)
    end
  end

  RatingStruct ||= Struct.new(:code, :name, :description, :wrong_layout)
  class Rating < RatingStruct
    include StructInit

    def initialize(loader, key, hash)
      struct_init(hash)
    end
  end

  GameStruct ||= Struct.new(:key, :name, :wikipedia, :tested)
  class Game < GameStruct
    def initialize(loader, key, hash)
      @loader = loader
      self.key = key
      self.name = hash.fetch('name')
      self.wikipedia = hash.fetch('wikipedia')
      self.tested = hash.fetch('tested').map do |hash|
        GameTest.new(loader, hash)
      end.sort(&:date).reverse
    end

    def latest_test
      self.tested.first
    end

    def rating
      p @loader.class
      latest_test.rating
    end
  end

  GameTestStruct ||= Struct.new(:date, :os_key, :version, :typing, :rating_key)
  class GameTest < GameTestStruct
    include StructInit

    TYPING_PROBLEMS = {
      social: 'using social features',
      naming: 'naming in-game items',
      saves:  'naming your game saves',
    }

    def initialize(loader, hash)
      @loader = loader

      struct_init(hash) do |key, value|
        key = :os_key if key == :os
        key = :rating_key if key == :rating
        value = parse_typing(value) if key == :typing
        [key, value]
      end
    end

    def os
      @os ||= @loader.os(os_key)
    end

    def rating
      @rating ||= @loader.rating(rating_key)
    end

    def rating_description
      apply_substitutions(rating.description)
    end

    def rating_wrong_layout
      apply_substitutions(rating.wrong_layout)
    end

    private

    class SkipItem < StandardError; end

    def parse_typing(hash)
      return hash.map do |key, value|
        key = key.to_sym
        raise "Unknown typing aspect: #{key}" unless TYPING_PROBLEMS.has_key?(key)
        [key, value]
      end.to_h
    end

    def apply_substitutions(list)
      return list.map do |item|
        begin
          item.gsub(/\$\$([A-Z_]+)\$\$/) do |match|
            capital = $`.empty?
            value = self.send("subst_#{$1.downcase}")
            value = value.capitalize if capital
            value
          end
        rescue SkipItem
          nil
        end
      end
    end

    def subst_typing_problems
      raise SkipItem if typing.empty?

      problems = typing.map do |item, priority|
        TYPING_PROBLEMS.fetch(item) + " (#{priority})"
      end

      if problems.count <= 2
        return "you may have difficulty #{problems.join(' and ')}"
      else
        last = problems.pop
        return "you may have difficulty #{problems.join(', ')} and #{last}"
      end
    end
  end

end

puts "Dvorak helper reloaded!"
