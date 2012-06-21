require 'spec_helper'

describe Guard::Sidekiq do
  describe 'start' do

    it 'should accept :environment option' do
      environment = :foo

      obj = Guard::Sidekiq.new [], :environment => environment
      obj.send(:cmd).should include "--environment #{environment}"
    end

    it 'should accept :queue option' do
      queue = :foo

      obj = Guard::Sidekiq.new [], :queue => queue
      obj.send(:cmd).should include "--queue #{queue}"
    end

    it 'should accept :timeout option' do
      timeout = 2

      obj = Guard::Sidekiq.new [], :timeout => timeout
      obj.send(:cmd).should include "--timeout #{timeout}"
    end

    it 'should accept :concurrency option' do
      concurrency = 2

      obj = Guard::Sidekiq.new [], :concurrency => concurrency
      obj.send(:cmd).should include "--concurrency #{concurrency}"
    end

    it 'should accept :verbose option' do
      obj = Guard::Sidekiq.new [], :verbose => true
      obj.send(:cmd).should include '--verbose'
    end

    it 'should provide default options' do
      obj = Guard::Sidekiq.new []
      obj.send(:cmd).should include "--queue #{Guard::Sidekiq::DEFAULT_QUEUE}"
      obj.send(:cmd).should include "--concurrency #{Guard::Sidekiq::DEFAULT_CONCURRENCY}"
      obj.send(:cmd).should include '--verbose'
    end

  end
end
