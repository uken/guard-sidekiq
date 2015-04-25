require 'guard/compat/plugin'
require 'timeout'

module Guard
  class Sidekiq < Plugin

    DEFAULT_SIGNAL = :TERM
    DEFAULT_CONCURRENCY = 1

    # Allowable options are:
    #  - :environment  e.g. 'test'
    #  - :queue e.g. 'default'
    #  - :timeout e.g. 5
    #  - :config e.g. config/sidekiq.yml
    #  - :concurrency, e.g. 20
    #  - :verbose e.g. true
    #  - :stop_signal e.g. :TERM, :QUIT or :SIGQUIT
    #  - :logfile e.g. log/sidekiq.log (defaults to STDOUT)
    #  - :require e.g. ./sidekiq_helper.rb
    def initialize(options = {})
      @options = options
      @pid = nil
      @stop_signal = options[:stop_signal] || DEFAULT_SIGNAL
      @options[:concurrency] ||= DEFAULT_CONCURRENCY
      @options[:verbose] = @options.fetch(:verbose, true)
      super
    end

    def start
      stop
      Guard::Compat::UI.info 'Starting up sidekiq...'
      Guard::Compat::UI.info cmd

      # launch Sidekiq worker
      @pid = spawn({}, cmd)
    end

    def stop
      if @pid
        Guard::Compat::UI.info 'Stopping sidekiq...'
        ::Process.kill @stop_signal, @pid
        begin
          Timeout.timeout(15) do
            ::Process.wait @pid
          end
        rescue Timeout::Error
          Guard::Compat::UI.info 'Sending SIGKILL to sidekiq, as it\'s taking too long to shutdown.'
          ::Process.kill :KILL, @pid
          ::Process.wait @pid
        end
        Guard::Compat::UI.info 'Stopped process sidekiq'
      end
    rescue Errno::ESRCH
      Guard::Compat::UI.info 'Guard::Sidekiq lost the Sidekiq worker subprocess!'
    ensure
      @pid = nil
    end

    # Called on Ctrl-Z signal
    def reload
      Guard::Compat::UI.info 'Restarting sidekiq...'
      restart
    end

    # Called on Ctrl-/ signal
    def run_all
      true
    end

    # Called on file(s) modifications
    def run_on_changes(paths)
      restart
    end

    def restart
      stop
      start
    end

    private

    def queue_params
      params = @options[:queue]
      params = [params] unless params.is_a? Array
      params.collect {|param| "--queue #{param}"}.join(" ")
    end

    def cmd
      command = ['bundle exec sidekiq']

      command << "--logfile #{@options[:logfile]}"          if @options[:logfile]
      command << queue_params                               if @options[:queue]
      command << "-C #{@options[:config]}"                  if @options[:config]
      command << "--verbose"                                if @options[:verbose]
      command << "--environment #{@options[:environment]}"  if @options[:environment]
      command << "--timeout #{@options[:timeout]}"          if @options[:timeout]
      command << "--require #{@options[:require]}"          if @options[:require]
      command << "--concurrency #{@options[:concurrency]}"

      command.join(' ')
    end

  end
end
