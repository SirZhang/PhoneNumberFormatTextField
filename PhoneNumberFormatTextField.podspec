Pod::Spec.new do |s|
  s.name             = "PhoneNumberFormatTextField"
  s.version          = "1.0.0"
  s.summary          = "Formatting phone numbers to 344 form."
  s.homepage         = "https://github.com/wangzz/WZMarqueeView"
  s.license          = 'MIT'
  s.author           = { "zhangyuan" => "354584909@qq.com" }
  s.source           = { :git => "https://github.com/SirZhang/PhoneNumberFormatTextField.git", :tag => s.version.to_s }
  s.platform         = :ios, '11.0'
  s.requires_arc     = true
  s.source_files     = 'PhoneNumberFormatTextField/*'
  s.frameworks       = 'Foundation', 'UIKit'
end
