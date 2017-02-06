//
//  NSTViewWarmuper.h
//  NSTViewWarmuper
//
//  Created by Timur Bernikowich on 2/6/17.
//  Copyright © 2017 Timur Bernikovich. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NSTWarmupable <NSObject>

- (void)nst_warmup;

@end

typedef __nullable id<NSTWarmupable> (^NSTWarmupableViewCreationBlock)();

@interface NSTViewWarmuper : NSObject

- (nullable instancetype)initWithViewCreationBlock:(nonnull NSTWarmupableViewCreationBlock)block initialViewsCount:(NSUInteger)initialViewsCount NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)init NS_UNAVAILABLE;

@property (nonatomic, nonnull) NSTWarmupableViewCreationBlock creationBlock;
@property (nonatomic) NSUInteger initialViewsCount;

- (void)prepare;

- (nullable id<NSTWarmupable>)dequeueWarmupedView;

@end

@import WebKit;

@interface NSTWKWebViewWarmuper : NSTViewWarmuper

+ (nonnull instancetype)sharedViewWarmuper;

- (nullable WKWebView *)dequeueWarmupedWKWebView;

@end

@interface NSTUIWebViewWarmuper : NSTViewWarmuper

+ (nonnull instancetype)sharedViewWarmuper;

- (nullable UIWebView *)dequeueWarmupedUIWebView;

@end
