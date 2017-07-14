require 'set'

module Reloader
  extend self

  def included?(file)
    return @prefixes.any? { |p| file.start_with?(p) }
  end

  def prefixes
    @prefixes ||= Set.new
  end

  def load_all(path_str, root: Pathname.getwd)
    root = Pathname.new(root).realpath unless root.kind_of?(Pathname)

    path = Pathname.new(path_str).realpath
    prefixes << "#{path}/"

    path.children.each do |child|
      next unless child.extname == '.rb'
      Padrino::Reloader.safe_load(child.relative_path_from(root).to_s)
    end
  end
end

module Padrino::Reloader
  def self.feature_excluded?(file)
    return !(::Reloader.included?(file))
  end
end
