#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint deepwallkids_flutter_plugin.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'deepwallkids_flutter_plugin'
  s.version          = '1.0.0'
  s.summary          = 'DeepWallKids Flutter plugin.'
  s.description      = <<-DESC
DeepWallKids Flutter plugin.
                       DESC
  s.homepage         = 'https://www.deepwall.com/'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'DeepWall' => 'https://deepwall.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'DeepWallKids', '2.3.0'
  s.static_framework = true
  s.platform = :ios, '10.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
