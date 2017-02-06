//
//  ViewController.m
//  NSTViewWarmuper
//
//  Created by Timur Bernikowich on 2/6/17.
//  Copyright © 2017 Timur Bernikovich. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"

typedef UIViewController * (^ControllerConfigurationCreationBlock)();

@interface ControllerConfiguration : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) ControllerConfigurationCreationBlock creationBlock;

+ (instancetype)objectWithTitle:(NSString *)title creationBlock:(ControllerConfigurationCreationBlock)block;

@end

@implementation ControllerConfiguration

+ (instancetype)objectWithTitle:(NSString *)title creationBlock:(ControllerConfigurationCreationBlock)block
{
    ControllerConfiguration *object = [self new];
    object.title = title;
    object.creationBlock = block;
    return object;
}

@end

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray<ControllerConfiguration *> *configurationArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    [self.view addSubview:self.tableView];
    
    NSMutableArray<ControllerConfiguration *> *array = [NSMutableArray new];
    [array addObject:[ControllerConfiguration objectWithTitle:@"UIWebView" creationBlock:^UIViewController *{
        WebViewController *controller = [WebViewController new];
        controller.webKit = NO;
        controller.warmup = NO;
        return controller;
    }]];
    [array addObject:[ControllerConfiguration objectWithTitle:@"UIWebView + Warmuper" creationBlock:^UIViewController *{
        WebViewController *controller = [WebViewController new];
        controller.webKit = NO;
        controller.warmup = YES;
        return controller;
    }]];
    [array addObject:[ControllerConfiguration objectWithTitle:@"WKWebView" creationBlock:^UIViewController *{
        WebViewController *controller = [WebViewController new];
        controller.webKit = YES;
        controller.warmup = NO;
        return controller;
    }]];
    [array addObject:[ControllerConfiguration objectWithTitle:@"WKWebView + Warmuper" creationBlock:^UIViewController *{
        WebViewController *controller = [WebViewController new];
        controller.webKit = YES;
        controller.warmup = YES;
        return controller;
    }]];
    self.configurationArray = array;
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.configurationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    cell.textLabel.text = self.configurationArray[indexPath.row].title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:self.configurationArray[indexPath.row].creationBlock() animated:YES];
}

@end
