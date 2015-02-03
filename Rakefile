# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :docker do
  task :push do
    sh 'fig build'
    sh 'docker tag -f parkmap_web gcr.io/maginest/parkmap'
    sha = `git rev-parse HEAD`.chop
    sh "docker tag -f parkmap_web gcr.io/maginest:#{sha}"
    sh "docker push eiel/parkmap gcr.io/maginest/parkmap:#{sha}"
  end
end
