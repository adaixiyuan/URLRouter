#
#  Be sure to run `pod spec lint URLRouter.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "URLRouter"
  s.version      = “1.0.0”
  s.platform     = :ios, "8.0"
  s.summary      = "A short description of URLRouter."
  s.homepage     = "http://192.168.30.6/ios_components/BFPageController"
  s.license      = "MIT"
  s.author       = { "quanyan" => "heng.luo@quncaotech.com" }
  s.source       = { :git => "http://192.168.30.6/ios_components/BFPageController.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

end
