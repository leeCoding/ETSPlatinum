//
//  ViewController.m
//  ETSPlatinum
//
//  Created by Nil on 16/12/20.
//

#import "ViewController.h"
#import "ETSUPnPDeviceManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"开始" forState:0];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(startBtnEvent) forControlEvents:UIControlEventTouchUpInside];

    btn.backgroundColor = UIColor.grayColor;
    btn.frame = CGRectMake(0, 30, 100, 100);
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [stopBtn setTitle:@"停止" forState:0];
    [stopBtn addTarget:self action:@selector(stopBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
    stopBtn.backgroundColor = UIColor.grayColor;
    stopBtn.frame = CGRectMake(0, 140, 100, 100);

    
    
}

- (void)startBtnEvent {
    
    [[ETSUPnPDeviceManager shareManager] addHostDevice];
}

- (void)stopBtnEvent {

    [[ETSUPnPDeviceManager shareManager] stopDevice];
    
}

@end
