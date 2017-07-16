namespace :hooks do
  task :link do
    sh 'ln', '-nsf', '../../hooks/pre-commit', '.git/hooks/pre-commit'
  end

  task :pre_commit do
    require 'open3'

    Dir.mktmpdir do |tmpdir|
      tree = "#{tmpdir}/tree"
      sh 'git', 'clone', Dir.getwd, tree
      diff, status = Open3.capture2(*%w(git diff --cached --binary))
      raise "git diff failed: #{status}" unless status.success?

      Dir.chdir(tree) do
        unless diff.empty?
          output, status = Open3.capture2(*%w(git apply), stdin_data: diff)
          raise "git apply failed: #{status}" unless status.success?
        end
        sh *%w(make clean build)
      end
    end
  end
end
