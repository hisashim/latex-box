URL_BASE = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/"
BASE_BOXES = {
  "opscode-debian-7.2.0" =>
  "opscode_debian-7.2.0_chef-provisionerless.box",
  "opscode-debian-7.4.0" =>
  "opscode_debian-7.4_chef-provisionerless.box",
  "opscode-debian-7.6.0" =>
  "opscode_debian-7.6_chef-provisionerless.box",
}
BASE = ENV['BASE'] || "opscode-debian-7.6.0"
RELEASE = ENV['RELEASE'] || "latex-box-7.6.0"
DATETIME ||= `date -u '+%Y%m%dT%H%M'`.chomp
SNAPSHOT = ENV['SNAPSHOT']  || [RELEASE, DATETIME].join('-')

BASE_BOX = BASE_BOXES[BASE]
BASE_OVF = File.expand_path("~/.vagrant.d/boxes/#{BASE}/virtualbox/box.ovf")
RELEASE_BOX = "#{RELEASE}.box"
SNAPSHOT_BOX = "#{SNAPSHOT}.box"

task :default => [RELEASE_BOX]

file BASE_BOX do |t|
  sh "curl -O #{URL_BASE + t.name}"
end

file BASE_OVF => [BASE_BOX] do |t|
  sh "vagrant box add #{BASE} #{t.prerequisites.first}"
end

task :vagrant_up => [BASE_OVF] do |t|
  sh "BASE=#{BASE} vagrant up; true"
end

desc "Package a new box (#{RELEASE}) using base box (#{BASE})"
file RELEASE_BOX => [:vagrant_up] do |t|
  sh "BASE=#{BASE} vagrant package --output #{t.name}; true"
end

desc "Package a new box (#{SNAPSHOT}) using base box (#{BASE})"
file SNAPSHOT_BOX => [:vagrant_up] do |t|
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
    rake #=> #{RELEASE_BOX}
    rake BASE=opscode-debian-x.x.x RELEASE=latex-box-x.x.x
  EOS
end
