Pod::Spec.new do |s|
  s.name             = 'PHBStackLayout'
  s.version          = '1.0.1'
  s.summary          = 'A declarative layout μFramework built on UIStackView'
  s.description      = <<-DESC
UIStackView allows developers to build auto-layout UIs without needing to set up constraints -- a powerful way of building layouts, which unfortunately requires a certain amount of boilerplate code. This framework exposes the convenience of that approach, but reduces the required boilerplate by wrapping it in a declarative syntax.
                       DESC
  s.homepage         = 'https://github.com/phlippieb/PHBStackLayout'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'phlippieb' => 'phlippie.bosman@gmail.com' }
  s.source           = { :git => 'https://github.com/phlippieb/PHBStackLayout.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.source_files = 'PHBStackLayout/Source/**/*.swift'
  s.dependency 'PHBNonInteractableViews', '~> 1.0'
end
