//
//  LoginViewController.m
//  TwitterDemo
//
//  Created by Bob Leano on 1/29/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onLoginButton:(id)sender {
    BDBOAuth1SessionManager *manager = [[BDBOAuth1SessionManager alloc] initWithBaseURL:[NSURL URLWithString: @"https://api.twitter.com"] consumerKey:@"geqayCv0xeIIBmRmr6DcIpWt1" consumerSecret:@"SCoHYUvLwW1ugOGw4s5bDMh1fBs3vRreH9ad1uscMBCG7oGPlq"];
    [manager deauthorize];
    [manager
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
