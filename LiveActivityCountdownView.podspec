require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'

Pod::Spec.new do |s|
  s.name         = "LiveActivityCountdownView"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "14.0" }
  s.source       = { :git => "https://github.com/technology-studio/live-activity-countdown-react-native.git", :tag => "#{s.version}" }

  s.source_files = "ios-view/**/*.{h,m,mm,swift}"
  s.swift_version = '5.0'
  s.frameworks = "WidgetKit", "ActivityKit", "SwiftUI"
end
