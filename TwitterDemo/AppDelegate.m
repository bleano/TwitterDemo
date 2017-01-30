//
//  AppDelegate.m
//  TwitterDemo
//
//  Created by Bob Leano on 1/29/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import "AppDelegate.h"
#import <BDBOAuth1Manager/BDBOAuth1SessionManager.h>
#import "User.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    NSLog(@"openURL %@", url);
    BDBOAuth1Credential *credential = [BDBOAuth1Credential credentialWithQueryString: url.query];
    BDBOAuth1SessionManager *manager = [[BDBOAuth1SessionManager alloc] initWithBaseURL:[NSURL URLWithString: @"https://api.twitter.com"] consumerKey:@"geqayCv0xeIIBmRmr6DcIpWt1" consumerSecret:@"SCoHYUvLwW1ugOGw4s5bDMh1fBs3vRreH9ad1uscMBCG7oGPlq"];
    [manager
        fetchAccessTokenWithPath:@"oauth/access_token"
        method:@"POST"
        requestToken:credential
        success:^(BDBOAuth1Credential *requestToken) {
            NSLog(@"requestToken: %@", requestToken.token);
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:manager forKey:@"BDBOAuth1SessionManager"];
            [manager
             GET:@"1.1/account/verify_credentials.json"
             parameters:nil
             progress:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 User *user = [[User alloc] initWithDictionary: responseObject];
             }
             failure:^(NSURLSessionTask *task, NSError *error) {
                 NSLog(@"Error: %@", error.localizedDescription);
             }];
            [manager
             GET:@"1.1/statuses/home_timeline.json"
             parameters:nil
             progress:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSLog(@"home_timeline.json: %@", responseObject);
             }
             failure:^(NSURLSessionTask *task, NSError *error) {
                 NSLog(@"Error: %@", error.localizedDescription);
             }];
        }
        failure:^(NSError *error) {
            NSLog(@"Error: %@", error.localizedDescription);
        }];
    

    return YES;
}


@end
