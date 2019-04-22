Pod::Spec.new do |spec|
  spec.name          = "WebViewWarmUper"
  spec.version       = "2.0.0"
  spec.summary       = "Boost WKWebView loading speed"
  spec.homepage      = "https://github.com/bernikovich/WebViewWarmUper"
  spec.license       = { :type => "MIT" }
  spec.author        = { "Timur Bernikovich" => "bernikowich@icloud.com" }
  spec.platform      = :ios, "10.0"
  spec.swift_version = "5.0"
  spec.framework     = "UIKit"
  spec.source        = { :git => "https://github.com/bernikovich/WebViewWarmUper.git", :tag => spec.version.to_s }
  spec.source_files  = "WebViewWarmUper/Classes/*.swift"
  spec.module_name   = "WebViewWarmUper"
end
