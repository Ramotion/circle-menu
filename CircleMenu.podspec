Pod::Spec.new do |s|
  s.name         = 'CircleMenu'
  s.version      = '0.0.5'
  s.summary      = 'Amazing animation with buttons'
  s.homepage     = 'https://github.com/Ramotion/circle-menu'
  s.license      = 'MIT'
  s.authors = { 'Juri Vasylenko' => 'juri.v@ramotion.com' }
  s.ios.deployment_target = '8.0'
  s.source       = { :git => 'https://github.com/Ramotion/circle-menu.git', :tag => s.version.to_s }
  s.source_files  = 'CircleMenuLib/**/*.swift'
  s.requires_arc = true
end
