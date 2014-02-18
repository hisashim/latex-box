[
 "texlive-latex-recommended",
 "texlive-fonts-recommended",
 "texlive-latex-extra",
 "texlive-math-extra",
 "texlive-pictures",
 "texlive-pstricks",
].map{|pkg_name|
  package pkg_name do
    options "--no-install-recommends"
    action :install
  end
}
