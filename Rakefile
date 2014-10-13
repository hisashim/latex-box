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
PUBLISH_URL = ENV['PUBLISH_URL'] || 'publish_url'
PUBLISH_SCRIPT = ENV['PUBLISH_SCRIPT']

BASE_BOX = BASE_BOXES[BASE]
BASE_OVF = File.expand_path("~/.vagrant.d/boxes/#{BASE}/virtualbox/box.ovf")
RELEASE_BOX = "#{RELEASE}.box"
SNAPSHOT_BOX = "#{SNAPSHOT}.box"

rule /#{BASE_BOXES.values.map{|b| Regexp.escape(b)}.join('|')}/ do |t|
  sh "curl -O #{URL_BASE + t.name}"
end

rule /#{[RELEASE_BOX, SNAPSHOT_BOX].map{|b| Regexp.escape(b)}.join('|')}/ =>
  BASE_OVF do |t|
  sh "BASE=#{BASE} vagrant up; true"
  sh "BASE=#{BASE} vagrant package --output #{t.name}; true"
end

file BASE_OVF => BASE_BOX do |t|
  sh "vagrant box add #{BASE} #{t.prerequisites.first}"
end

desc "#{:release} (default)"
task :default => :release

desc "Package a new box (#{RELEASE}) using base box (#{BASE})"
task :release => RELEASE_BOX

desc "Package a new box (#{SNAPSHOT}) using base box (#{BASE})"
task :snapshot => SNAPSHOT_BOX

desc "Publish boxes to sites (URLs in #{PUBLISH_URL})"
task :publish => PUBLISH_URL do |t|
  urlfile = t.prerequisites.first
  artifacts = FileList["*.box"] - BASE_BOXES.values
  unless artifacts.empty?
    if PUBLISH_SCRIPT
      sh PUBLISH_SCRIPT, urlfile, artifacts.join(' ')
    else
      sh "cat #{urlfile} | xargs -n 1 -I{}" +
        " curl #{artifacts.map{|a| '--upload ' + a}.join(' ')} {}"
    end
  end
end

desc "Destroy running VM, unregister base box, and delete generated box file"
task :clean do |t|
  sh "BASE=#{BASE} vagrant destroy --force; true"
  sh "BASE=#{BASE} vagrant box remove #{BASE}; true"
  rm_f [RELEASE_BOX, "#{RELEASE}*.box"]
end

desc "Delete all downloaded box files, in addition to clean"
task :clobber => :clean do |t|
  rm_f BASE_BOXES.values
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
