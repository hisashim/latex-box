[
 "lacheck",
].map{|pkg_name|
  package pkg_name do
    options "--no-install-recommends"
    action :install
  end
}
