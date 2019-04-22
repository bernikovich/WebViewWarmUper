# WebViewWarmUper

`WebViewWarmUper` warm-ups `WKWebView` and `UIWebView` for faster first load.
Download sample project to test it. You can create issue or pull requests if you have any proposals.

## Installation

### CocoaPods

CocoaPods is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate `WebViewWarmUper` into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'WebViewWarmUper'
```

### Manually

You can simply copy source files from `Classes` folder (`WebViewWarmuper.swift`) to your project.

## Usage

### Standard

First you should call prepare method, it should be called some time before you want to show your web view. In test app we call this method in `func application(_ application: didFinishLaunchingWithOptions: )`.

```swift
WKWebViewWarmUper.shared.prepare()
```
