Pod::Spec.new do |s|
  s.name         = 'YYWebImage'
  s.summary      = 'Asynchronous image loading framework.'
  s.version      = '1.0.4'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'ibireme' => 'ibireme@gmail.com' }
  s.social_media_url = 'http://blog.ibireme.com'
  s.homepage     = 'https://github.com/ibireme/YYWebImage'
  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.source       = { :git => 'https://github.com/ibireme/YYWebImage.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'YYWebImage/*.{h,m}', 'YYWebImage/Categories/*.{h,m}'
  s.public_header_files = 'YYWebImage/*.{h}', 'YYWebImage/Categories/*.{h}'
  s.private_header_files = 'YYWebImage/Categories/_*.{h}'
  s.frameworks = 'UIKit', 'CoreFoundation', 'QuartzCore', 'AssetsLibrary', 'ImageIO', 'Accelerate', 'MobileCoreServices'
  
  s.dependency 'YYImage'
  s.dependency 'YYCache'
  
end
