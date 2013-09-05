module Guard
  class GitWatcher
    class Git < Struct.new(:repository, :options)
      DEFAULT_COMMIT_MESSAGE = 'Updated.'
      DEFAULT_BRANCH         = 'master'

      def update(message = DEFAULT_COMMIT_MESSAGE, branch = DEFAULT_BRANCH)
        if changed?
          commit message or raise "#{self.class.name} failed to commit."
          push branch or raise "#{self.class.name} failed to push."
        end
      end

      def commit(message = DEFAULT_COMMIT_MESSAGE)
        run 'git add .', "git commit -am #{message.shellescape}"
      end

      def push(branch = nil)
        run "git push origin #{branch.shellescape}"
      end

      def run(*args)
        args.unshift cd
        system join(*args)
      end

      def changed?
        %x(#{cd} && git status -s | wc -l).to_i > 0
      end

      def join(*args)
        args * ' && '
      end

      def branch
        (options[:branch] || DEFAULT_BRANCH).to_s
      end

      private

      def checkout
        %Q'if [ #{current_branch.shellescape} != #{branch.shellescape} ]; then git checkout #{branch.shellescape} >& /dev/null; fi'
      end

      def current_branch
        %q{$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')}
      end

      def cd
        "cd #{repository.shellescape} && #{checkout}"
      end
    end
  end
end