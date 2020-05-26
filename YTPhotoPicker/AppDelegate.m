//
//  AppDelegate.m
//  YTPhotoPicker
//
//  Created by TonyAng on 2020/5/22.
//  Copyright © 2020 TonyAng. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    ViewController *vc = [[ViewController alloc] init];
     UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
     self.window.rootViewController = nav;
    return YES;
}


@end
