//
//  NSTViewWarmuper.m
//  NSTViewWarmuper
//
//  Created by Timur Bernikowich on 2/6/17.
//  Copyright © 2017 Timur Bernikovich. All rights reserved.
//

#import "NSTViewWarmuper.h"

@interface NSTViewWarmuper ()

@property (nonatomic) NSMutableArray<id<NSTWarmupable>> *preloadedViews;

@end

@implementation NSTViewWarmuper

- (nullable instancetype)initWithViewCreationBlock:(nonnull NSTWarmupableViewCreationBlock)block initialViewsCount:(NSUInteger)initialViewsCount
{
    NSParameterAssert(block);
    
    self = [super init];
    if (self) {
        self.creationBlock = block;
        self.initialViewsCount = initialViewsCount;
        self.preloadedViews = [NSMutableArray new];
        [self warmupViewsIfNeeded];
    }
    return self;
}

- (void)prepare
{
    // Actually does nothing, only initialization must be called.
    [self warmupViewsIfNeeded];
}

- (void)warmupViewsIfNeeded
{
    while (self.preloadedViews.count < self.initialViewsCount) {
        id<NSTWarmupable> preloadedView = [self createPreloadedView];
        if (preloadedView) {
            [self.preloadedViews addObject:preloadedView];
        } else {
            break;
        }
    }
}

- (nullable id<NSTWarmupable>)createPreloadedView
{
    id<NSTWarmupable> warmupableView = self.creationBlock();
    [warmupableView nst_warmup];
    return warmupableView;
}

- (nullable id<NSTWarmupable>)dequeueWarmupedView
{
    if (!self.preloadedViews.count) {
        return [self createPreloadedView];
    } else {
        id<NSTWarmupable> preloadedView = self.preloadedViews.firstObject;
        [self.preloadedViews removeObject:preloadedView];
        [self warmupViewsIfNeeded];
        return preloadedView;
    }
}

@end

@interface WKWebView (NSTWarmupable) <NSTWarmupable>

@end

@implementation WKWebView (NSTWarmupable)

- (void)nst_warmup
{
    [self loadHTMLString:@"" baseURL:nil];
}

@end

@implementation NSTWKWebViewWarmuper

+ (nonnull instancetype)sharedViewWarmuper
{
    static dispatch_once_t p = 0;
    static id sharedInstance;
    dispatch_once(&p, ^{
        sharedInstance = [[self alloc] initWithViewCreationBlock:^id<NSTWarmupable> _Nullable{
            return [[WKWebView alloc] initWithFrame:CGRectZero configuration:[WKWebViewConfiguration new]];
        } initialViewsCount:5];
    });
    return sharedInstance;
}

- (nullable WKWebView *)dequeueWarmupedWKWebView
{
    return (WKWebView *)[self dequeueWarmupedView];
}

@end

@interface UIWebView (NSTWarmupable) <NSTWarmupable>

@end

@implementation UIWebView (NSTWarmupable)

- (void)nst_warmup
{
    [self loadHTMLString:@"" baseURL:nil];
}

@end

@implementation NSTUIWebViewWarmuper

+ (nonnull instancetype)sharedViewWarmuper
{
    static dispatch_once_t p = 0;
    static id sharedInstance;
    dispatch_once(&p, ^{
        sharedInstance = [[self alloc] initWithViewCreationBlock:^id<NSTWarmupable> _Nullable{
            return [UIWebView new];
        } initialViewsCount:5];
    });
    return sharedInstance;
}

- (nullable UIWebView *)dequeueWarmupedUIWebView
{
    return (UIWebView *)[self dequeueWarmupedView];
}

@end
