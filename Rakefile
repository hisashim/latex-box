URL_BASE = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/"
BASE_BOX = "opscode_debian-7.2.0_chef-provisionerless.box"

task :default => [BASE_BOX]

file BASE_BOX do |t|
  sh "curl -O #{URL_BASE + t.name}"
end
