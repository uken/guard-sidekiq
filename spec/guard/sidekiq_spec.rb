require 'spec_helper'
require 'guard/compat/test/helper'

describe Guard::Sidekiq, exclude_stubs: [Guard::Plugin] do
  describe 'start' do

    it 'accepts :environment option' do
      environment = :foo

      obj = Guard::Sidekiq.new :environment => environment
      obj.send(:cmd).should include "--environment #{environment}"
    end

    it 'accepts :logfile option' do
      logfile = 'log/sidekiq.log'
      obj = Guard::Sidekiq.new :logfile => logfile
      obj.send(:cmd).should include "--logfile #{logfile}"
    end

    describe 'with :queue option' do
      it 'accepts one queue' do
        queue = :foo

        obj = Guard::Sidekiq.new :queue => queue
        obj.send(:cmd).should include "--queue #{queue}"
      end

      it 'accepts array of :queue options' do
        queue = ['foo,4', 'default']

        obj = Guard::Sidekiq.new :queue => queue
        obj.send(:cmd).should include "--queue #{queue.first} --queue #{queue.last}"
      end
    end

    it 'should accept :timeout option' do
      timeout = 2

      obj = Guard::Sidekiq.new :timeout => timeout
      obj.send(:cmd).should include "--timeout #{timeout}"
    end

    it 'should accept :concurrency option' do
      concurrency = 2

      obj = Guard::Sidekiq.new :concurrency => concurrency
      obj.send(:cmd).should include "--concurrency #{concurrency}"
    end

    it 'should accept :config option' do
      config = 'sidekiq.yml'

      obj = Guard::Sidekiq.new :config => config
      obj.send(:cmd).should include "-C #{config}"
    end


    it 'should accept :verbose option' do
      obj = Guard::Sidekiq.new :verbose => true
      obj.send(:cmd).should include '--verbose'
    end

    it 'should accept :require option' do
      obj = Guard::Sidekiq.new :require => './sidekiq_helper.rb'
      obj.send(:cmd).should include '--require ./sidekiq_helper.rb'
    end

    it 'should provide default options' do
      obj = Guard::Sidekiq.new
      obj.send(:cmd).should include '--verbose'
    end

  end
end
