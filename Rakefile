URL_BASE = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/"
BOXES = {
  "opscode-debian-7.2.0" =>
  "opscode_debian-7.2.0_chef-provisionerless.box",
  "opscode-debian-7.4.0" =>
  "opscode_debian-7.4_chef-provisionerless.box",
}
BASE = ENV['BASE'] || "opscode-debian-7.4.0"
NEW  = ENV['NEW']  || "latex-box-7.4.0"

BASE_BOX = BOXES[BASE]
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

desc "Destroy running VM and remove base box"
task :clean do |t|
  sh "BASE=#{BASE} vagrant destroy --force; true"
  sh "BASE=#{BASE} vagrant box remove #{BASE}; true"
end

desc "Delete all downloaded/produced box files, in addition to clean"
task :clobber => [:clean] do |t|
  rm "*.box"
end

desc "Display help messages"
task :help do |t|
  puts <<-EOS.gsub(/^  /m,'')
  LaTeX Box Builder: Build LaTeX-ready Vagrant box

  Usage: rake [VAR=VALUE]

  Examples:
    rake #=> #{NEW_BOX}
    rake BASE=opscode-debian-x.x.x NEW=latex-box-x.x.x
  EOS
end
