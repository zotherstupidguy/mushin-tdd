require "rake"
require 'rake/testtask'
#require 'logger'

#$logger = Logger.new(STDOUT)

# task :default => :complete_test
# compelte test depends on flushin db then expecting a certain space upcoming events run the test

task 'db:flush' do
  `redis-cli flushall`
  $logger.info("Redis got a flushall")
end
=begin
desc 'Complete clean test, should depend on other stuff'
task :complete do
  #ENV['Somevariable'] = 'true'
  Rake::Task['db:info'].execute
  Rake::Task['db:flush'].invoke
  Rake::Task['test'].invoke
end
=end
task 'clear_screen' do 
  `clear`
end

task 'db:monitor' do 
  `redis-cli monitor`
end

task 'db:info' do
  `redis-cli INFO`
end

=begin
Rake::TestTask.new 'test' => ['db:flush'] do 
  libs = ["lib"]
  warning = true
  verbose = true
  test_files = FileList['spec/*_spec.rb']
end
=end
=begin
Rake::TestTask.new 'test'  => ['clear_screen', 'db:flush'] do |t|
  t.libs = ["lib"]
  t.warning = true
  t.verbose = true
  t.test_files = FileList['spec/*_spec.rb']
end
=end
Rake::TestTask.new 'env_spec' do |t|
  #libs = ["lib/env.rb"]
  #t.warning = true
  #t.verbose = true
  t.test_files = FileList['spec/env_spec.rb']
end

Rake::TestTask.new 'redis_spec' => ['clear_screen'] do |t|
  libs = ["lib/ds/redis.rb"]
  #t.warning = true
  #t.verbose = true
  t.test_files = FileList['spec/ds/redis_spec.rb']
end

Rake::TestTask.new 'ds_spec' => ['clear_screen'] do |t|
  libs = ["lib/ds/ds.rb"]
  #t.warning = true
  #t.verbose = true
  t.test_files = FileList['spec/ds/ds_spec.rb']
end
Rake::TestTask.new 'engine_spec' => ['clear_screen'] do |t|
  libs = ["lib/engine.rb"]
  #t.warning = true
  #t.verbose = true
  t.test_files = FileList['spec/engine_spec.rb']
end
