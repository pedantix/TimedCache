# Be sure to run `pod lib lint TimedCache.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TimedCache'
  s.version          = '1.0.1'
  s.summary          = 'Yet another caching library.'
  s.description      = <<-DESC
This package is a protcol oriented cache implementation with a centrailized feature of expiration. Expiration is optional by definition of the protocol, but not the original intention. The only included implemenation is DictionaryCache, which is in fact thread safe.
                       DESC

  s.homepage         = 'https://github.com/pedantix/TimedCache'
  s.license          = { :type => 'BSD', :file => 'LICENSE.md' }
  s.author           = { 'Shaun Hubbard' => 'shaunhubbard2013@icloud.com' }
  s.source           = {
    :git => 'https://github.com/pedantix/TimedCache.git',
    :tag => s.version.to_s
  }
  s.source_files = "Sources/**/*"
  s.ios.deployment_target = '11.0'
  s.osx.deployment_target  = '10.13'
  s.swift_version = '4.1'
end
