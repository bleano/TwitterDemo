//
//  LoginViewController.m
//  TwitterDemo
//
//  Created by Bob Leano on 1/29/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "User.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIView *getTwitterDetails;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    TwitterClient *twitterClient = [TwitterClient sharedInstance];
    if(twitterClient != nil){
        self.loginButton.enabled = NO;
    }
}

//- (void)viewDidAppear:(BOOL)animated {
//    NSLog(@"view did appear");
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    NSLog(@"view will disappear");
//}
//
//- (void)viewDidDisappear:(BOOL)animated {
//    NSLog(@"view did disappear");
//}

       
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onGetTwitterDetails:(id)sender {
    TwitterClient *twitterClient = [TwitterClient sharedInstance];
    [twitterClient
     GET:@"1.1/account/verify_credentials.json"
     parameters:nil
     progress:nil
     success:^(NSURLSessionDataTask *task, id responseObject) {
         User *user = [[User alloc] initWithDictionary: responseObject];
         NSLog(@"user: %@", user.twitterScreenName);
     }
     failure:^(NSURLSessionTask *task, NSError *error) {
         NSLog(@"Error: %@", error.localizedDescription);
     }];
    [twitterClient
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

- (IBAction)onLoginButton:(id)sender {
    TwitterClient *twitterClient = [TwitterClient sharedInstance];
    [twitterClient deauthorize];
    [twitterClient
                                        fetchRequestTokenWithPath:@"oauth/request_token"
                                        method:@"GET"
                                        callbackURL:[NSURL URLWithString:@"twitterdemo://oauth"]
                                        scope:nil
                                        success:^(BDBOAuth1Credential *requestToken) {
                                            NSString *authURL = [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token];
                                             NSLog(@"requestToken.token: %@", requestToken.token);
                                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authURL]];
                                        }
                                        failure:^(NSError *error) {
                                            NSLog(@"Error: %@", error.localizedDescription);
                                        }
                                        ];
}

@end
