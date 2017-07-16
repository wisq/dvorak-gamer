namespace :deploy do
  task :wait do
    expect = capture_git(%w(git rev-parse HEAD))
    puts "Local version:    #{expect}"

    last_version = nil
    loop do
      version = capture_git(%w(curl -sS https://dvorakgamer.com/version))

      if version != last_version
        puts "Deployed version: #{version}"
        last_version = version
      end

      if version == expect
        puts "=== Deploy successful! ==="
        break
      end
      sleep(3)
    end
  end

  def capture_git(command)
    git = IO.popen(command) { |fh| fh.read.strip }
    raise "Unexpected git rev: #{git.inspect}" unless git =~ /\A[0-9a-f]+\z/
    return git
  end
end
