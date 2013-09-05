require 'guard'
require 'guard/guard'

module Guard
  class GitWatcher < Guard
    autoload :Git, 'guard/git_watcher/git'

    def start
      UI.info "#{self.class.name} is running"
    end

    def run_on_changes(paths)
      each_directories paths do |dir, paths|
        Git.new(dir, @options).update
      end
    end

    private

    def each_directories(paths, &block)
      ::Guard.listener.directories.each do |dir|
        existent_paths = paths.map{|path| File.expand_path File.join(dir, path) }
                          .select{|path| File.exist? path }

        next if existent_paths.empty?
        
        instance_exec dir, existent_paths, &block
      end
    end

    def each_files(paths, &block)
      each_directories paths do |dir, paths|
        paths.each do |path|
          instance_exec path, dir, &block
        end
      end
    end
  end
end