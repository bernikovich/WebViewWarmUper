//
//  WebViewController.m
//  NSTViewWarmuper
//
//  Created by Timur Bernikowich on 2/6/17.
//  Copyright © 2017 Timur Bernikovich. All rights reserved.
//

#import "WebViewController.h"
#import "NSTViewWarmuper.h"

@interface WebViewController () <WKNavigationDelegate, UIWebViewDelegate>

@property (nonatomic) UIWebView *UIWebView;
@property (nonatomic) WKWebView *WKWebView;

@property (nonatomic) NSTimeInterval loadHTMLStart;

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.webKit) {
        if (self.warmup) {
            self.WKWebView = [[NSTWKWebViewWarmuper sharedViewWarmuper] dequeueWarmupedWKWebView];
        } else {
            WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
            self.WKWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        }
        self.WKWebView.scrollView.scrollEnabled = NO;
        self.WKWebView.frame = self.view.bounds;
        self.WKWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.WKWebView.navigationDelegate = self;
        [self.view addSubview:self.WKWebView];
    } else {
        if (self.warmup) {
            self.UIWebView = [[NSTUIWebViewWarmuper sharedViewWarmuper] dequeueWarmupedUIWebView];
        } else {
            self.UIWebView = [UIWebView new];
        }
        self.UIWebView.scrollView.scrollEnabled = NO;
        self.UIWebView.frame = self.view.bounds;
        self.UIWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.UIWebView.delegate = self;
        [self.view addSubview:self.UIWebView];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"some1" ofType:@"html" inDirectory:@""];
    NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    self.loadHTMLStart = CACurrentMediaTime();
    if (self.webKit) {
        [self.WKWebView loadHTMLString:contents baseURL:nil];
    } else {
        [self.UIWebView loadHTMLString:contents baseURL:nil];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self update];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self update];
}

- (void)update
{
    NSTimeInterval delta = CACurrentMediaTime() - self.loadHTMLStart;
    NSLog(@"END: %f, TIME: %f", CACurrentMediaTime(), delta);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%f", delta] style:UIBarButtonItemStylePlain target:self action:@selector(update)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)dealloc
{
    self.WKWebView.navigationDelegate = nil;
    self.UIWebView.delegate = nil;
}

@end
