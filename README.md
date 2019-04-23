# WebViewWarmUper

`WKWebView` inititalization and first load are very slow. `WebViewWarmUper` warm-ups `WKWebView` and `UIWebView` for faster first load. Download sample project to test it. You can create issue or pull requests if you have any proposals.

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
import WebViewWarmUper

WKWebViewWarmUper.shared.prepare()
```

Then, when you need new web view instance:

```swift
import WebViewWarmUper

let webView = WKWebViewWarmUper.shared.dequeue()
```

### Advanced (custom WKWebViewConfiguration)

```swift
let customWarmUper = WKWebViewWarmUper { () -> WKWebView in
  let configuration = WKWebViewConfiguration()
  // Setup configuration.
  return WKWebView(frame: .zero, configuration: configuration)
}
// Some time after.
let webView = customWarmUper.dequeue()
```

## Legacy

The latest version written in Objective-C is `1.x`.

## Performance

Comparison from Example application. We compare `func loadHTMLString(_:baseURL:)`, but WebViewWarmUper will decrease time you spend on initialization too! Environment: iPhone XR, iOS 12.2.
NOTE: Looks like system caches UIWebView instances between runs. First run after install UIWebView loads page 0.2481s, 0.3811s, 0.3841s (`Resource.articleWithCss`).

### Resource.articleWithCss

| Run |     | WKWebView + Warm-Up | Simple WKWebView | UIWebView + Warm-Up | Simple UIWebView |
| --- | --- | ------------------- | ---------------- | ------------------- | ---------------- |
| 1   |     | 0.0331              | 0.0549           | 0.0382              | 0.0462           |
| 2   |     | 0.0316              | 0.0886           | 0.0338              | 0.0332           |
| 3   |     | 0.0255              | 0.0563           | 0.0307              | 0.0340           |
| 4   |     | 0.0388              | 0.0498           | 0.0364              | 0.0292           |
| 5   |     | 0.0304              | 0.0368           | 0.0369              | 0.0310           |
|     |     |                     |                  |                     |                  |
| Ave |     | 0.0319              | 0.0573           | 0.0352              | 0.0347           |
| Dif |     | -45% load time      | -                | ~ equal load time   | -                |

### Resource.articleWithWidgetAndCss

| Run |     | WKWebView + Warm-Up | Simple WKWebView | UIWebView + Warm-Up | Simple UIWebView |
| --- | --- | ------------------- | ---------------- | ------------------- | ---------------- |
| 1   |     | 0.0473              | 0.0624           | 0.5280              | 1.6593           |
| 2   |     | 0.0370              | 0.0804           | 0.0423              | 0.0384           |
| 3   |     | 0.0361              | 0.0672           | 0.0393              | 0.0376           |
| 4   |     | 0.0438              | 0.0610           | 0.0405              | 0.0400           |
| 5   |     | 0.0391              | 0.0646           | 0.0447              | 0.0379           |
|     |     |                     |                  |                     |                  |
| Ave |     | 0.0407              | 0.0671           | 0.1390              | 0.3626           |
| Dif |     | -40% load time      | -                | ~= (1st is random)  | -                |

## License

`WebViewWarmUper` is released under the MIT license. See `LICENSE` for details.
