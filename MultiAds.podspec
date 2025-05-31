#
# Be sure to run `pod lib lint MultiAds.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MultiAds'
  s.version          = '1.0.0'
  s.summary          = 'a custom in-house Swift plugin designed to seamlessly integrate and manage multiple ad networks under a unified interface'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/CoderRb123/MultiAds'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CoderRb123' => '44895678+CoderRb123@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/CoderRb123/MultiAds.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '16.0'

  s.source_files = 'MultiAds/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MultiAds' => ['MultiAds/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SwiftyJSON', '~> 5.0.2'
  s.dependency 'IPAPI', '~> 3.0.0'
  s.dependency 'KeychainSwift', '~> 20.0.0'
end
