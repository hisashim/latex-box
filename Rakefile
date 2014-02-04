URL_BASE = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/"
BASE = ENV['BASE'] || "opscode-debian-7.4.0"
NEW  = ENV['NEW']  || "latex-box-7.4.0"

BASE_BOX = "opscode_debian-7.2.0_chef-provisionerless.box"
BASE_OVF = File.expand_path("~/.vagrant.d/boxes/#{BASE}/virtualbox/box.ovf")
NEW_BOX = "#{NEW}.box"

task :default => [NEW_BOX]

file BASE_BOX do |t|
  sh "curl -O #{URL_BASE + t.name}"
end

file BASE_OVF => [BASE_BOX] do |t|
  sh "vagrant box add #{BASE} #{t.prerequisites.first}"
end

task :vagrant_up => [BASE_OVF] do |t|
  sh "BASE=#{BASE} vagrant up; true"
end

desc "Create and package a new box using base box (#{BASE})"
file NEW_BOX => [:vagrant_up] do |t|
  sh "BASE=#{BASE} vagrant package --output #{t.name}; true"
end
