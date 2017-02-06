# NSTViewWarmuper

NSTViewWampuper warmups WKWebView/UIWebView for faster first load.

1. [Why is it needed to warmup WebView](#why-is-it-needed-to-warmup-webview)
2. [Requirements](#requirements)
3. [Integration](#integration)
4. [Usage](#usage)
   - [Initialization](#initialization)
   - [Subscript](#subscript)
   - [Optional getter](#optional-getter)
   - [Non-optional getter](#non-optional-getter)

## Why is it needed to warmup WebView?

Objective-C is not very strict about types, but even without strictness we cannot save time because we have to check types ourselves for safety.

Take the Twitter API for example. Say we want to retrieve a user's "name" value of some tweet in Objective-C (according to Twitter's API https://dev.twitter.com/docs/api/1.1/get/statuses/home_timeline).

The code would look like this:

```objective-c
NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
NSString *user = dictionary[@"user"];
// Now we got the username
// But is it NSString for sure?
```

We got the username in 2 lines, but will JSON always be NSDictionary? Can API send `null` as value for `user` key? To be safe we need to add some lines:

```objective-c
NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
if (![dictionary isKindOfClass:[NSDictionary class]]) {
	// Print the error
}
NSString *user = dictionary[@"user"];
if (![user isKindOfClass:[NSString class]]) {
 	// Print the error
}
// There's our username
```

It's simple, but it boilerplate for sure!

With NSTEasyJSON all you have to do is:

```objective-c
NSTEasyJSON *JSON = [NSTEasyJSON withData:dataFromNetworking];
NSString *userName = JSON[0]["user"]["name"].string;
// Now you got your value
```

And don't worry about the NSNull, out of bounds or other unexpected things. It's done for you automatically.

## Requirements

- iOS 7.0+ | macOS 10.10+ | tvOS 9.0+ | watchOS 2.0+
- Xcode 7

## Integration

#### CocoaPods (iOS 7+, OS X 10.9+)

You can use [CocoaPods](http://cocoapods.org/) to install `NSTEasyJSON` by adding it to your `Podfile`:

```ruby
platform :ios, '7.0'

target 'MyApp' do
	pod 'NSTEasyJSON'
end
```

#### Manually (iOS 7+, OS X 10.9+)

To use this library in your project manually you may:  

1. for Projects, just drag NSTEasyJSON.{h,m} to the project tree
2. for Workspaces, include the whole NSTEasyJSON.xcodeproj

## Usage

#### Initialization

```objective-c
#import "NSTEasyJSON.h"
```

```objective-c
NSTEasyJSON *JSON = [NSTEasyJSON withData:dataFromNetworking];
```

```objective-c
NSTEasyJSON *JSON = [NSTEasyJSON withObject:jsonObjectArrayOrMaybeDictionary];
```

#### Subscript

```objective-c
// Getting a double from a JSON Array
double name = JSON[0].doubleValue;
```

```objective-c
// Getting a string from a JSON Dictionary
NSString *name = json["name"].stringValue;
```

#### Optional getter

```objective-c
// NSNumber
NSNumber *number = JSON[@"user"][@"favourites_count"].number;
```

```objective-c
// NSString
NSString *string = JSON[@"user"][@"name"].string;
...
```

#### Non-optional getter

Non-optional getters are named `xxxValue`

```objective-c
// If not a Number or nil, return 0
NSNumber *number = JSON[@"user"][@"favourites_count"].numberValue;
```

```objective-c
// If not a String or nil, return ""
NSString *string = JSON[@"user"][@"name"].stringValue;
```

```objective-c
// If not an Array or nil, return @[]
NSArray *list = JSON[@"list"].arrayValue;
```

```objective-c
// If not a Dictionary or nil, return @{}
NSDictionary *dictionary = JSON[@"user"].dictionaryValue;
```
