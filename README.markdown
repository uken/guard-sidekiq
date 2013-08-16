# Guard::Sidekiq

[![Build Status](https://secure.travis-ci.org/uken/guard-sidekiq.png)](http://travis-ci.org/uken/guard-sidekiq)

Guard::Sidekiq automatically starts/stops/restarts Sidekiq workers

*forked from [Guard::Resque](https://github.com/guard/guard-resque)*

## Install

Please be sure to have [Guard](http://github.com/guard/guard) installed before continue.

Install the gem:

    gem install guard-sidekiq

Add it to your Gemfile (inside test group):

    gem 'guard-sidekiq'

Add guard definition to your Guardfile by running this command:

    guard init sidekiq

## Usage

Please read [Guard usage doc](http://github.com/guard/guard#readme).

I suggest you put the sidekiq guard definition *before* your test/rspec guard if your tests depend on it
being active.

## Guardfile

    guard 'sidekiq', :environment => 'development' do
      watch(%r{^workers/(.+)\.rb})
    end

## Options

You can customize the sidekiq task via the following options:

* `environment`: the rails environment to run the workers in (defaults to `nil`)
* `queue`: the sidekiq queue to run (defaults to `default`). Can supply a list of queues here.
* `logfile`: sidekiq defaults to logging to STDOUT. Can specify a file to log to instead.
* `timeout`: shutdown timeout
* `concurrency`: the number of threads to include (defaults to `1`)
* `verbose`: whether to use verbose logging (defaults to `nil`)
* `stop_signal`: how to kill the process when restarting (defaults to `TERM`)
* `require`: location of rails application with workers or file to require (defaults to `nil`)
* `config`: can specify a config file to load queue settings


## Development

 * Source hosted at [GitHub](http://github.com/uken/guard-sidekiq)
 * Report issues/Questions/Feature requests on [GitHub Issues](http://github.com/uken/guard-sidekiq/issues)

Pull requests are very welcome! Make sure your patches are well tested. Please create a topic branch for every separate change
you make.

## Testing the gem locally

    gem install guard-sidekiq-0.x.x.gem

## Building and deploying gem

 * Update the version number in `lib/guard/sidekiq/version.rb`
 * Update `CHANGELOG.md`
 * Build the gem:

    gem build guard-sidekiq.gemspec

 * Push to rubygems.org:

    gem push guard-sidekiq-0.x.x.gem

## Guard::Delayed Authors

[David Parry](https://github.com/suranyami)
[Dennis Reimann](https://github.com/dbloete)

Ideas for this gem came from [Guard::WEBrick](http://github.com/fnichol/guard-webrick).


## Guard::Resque Authors

[Jacques Crocker](https://github.com/railsjedi)

I hacked this together from the `guard-delayed` gem for use with Resque. All credit go to the original authors though. I just search/replaced and tweaked a few things

## Guard::Sidekiq Authors
Mark Bolusmjak
Pitr Vernigorov
[David Parry](https://github.com/suranyami)

Replaces "rescue" with "sidekiq"

## Copyright

* Copyright
  * Copyright 2013 Uken Games
* License
  * Apache License, Version 2.0
