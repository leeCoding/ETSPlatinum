//
//  AppDelegate.m
//  ETSPlatinum
//
//  Created by Nil on 16/12/20.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window.rootViewController = [ViewController new];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle

@end
