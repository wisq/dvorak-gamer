namespace :deploy do
  task :wait do
    expect = capture_git(%w(git ls-remote origin master))
    puts "\nGitHub version:   #{expect}"

    last_version = nil
    loop do
      version = capture_git(%w(curl -sS https://dvorakgamer.com/version))

      if version != last_version
        puts "Deployed version: #{version}"
        last_version = version
      end

      if version == expect
        puts "\n=== Deploy successful! ==="
        break
      end
      sleep(3)
    end
  end

  def capture_git(command)
    output = IO.popen(command) { |fh| fh.read.strip }
    raise "Command failed: #{command.inspect}" unless $?.success?
    raise "Unexpected output: #{output.inspect}" unless output =~ /\A([0-9a-f]+)(?:\s|\z)/
    return $1
  end
end
