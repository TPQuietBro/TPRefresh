

Pod::Spec.new do |s|


  s.name         = "tprefresh"
  s.version      = "0.0.1"
  s.summary      = "A short description of tprefresh."

  s.description  = "refresh"

  s.homepage     = "https://github.com/TPQuietBro/TPRefresh"

  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author       = { "tangpeng" => "tangpeng@cc-pg.cn" }

  s.source       = { :git => "https://github.com/TPQuietBro/TPRefresh.git", :tag => "#{s.version}" }

  s.source_files  = "TPRefreshBase", "TPRefreshBase/**/*.{h,m}"

  s.requires_arc = true

end
