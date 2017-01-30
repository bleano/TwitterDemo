//
//  TwitterClient.m
//  TwitterDemo
//
//  Created by Bob Leano on 1/29/17.
//  Copyright © 2017 Y.CORP.YAHOO.COM\leano. All rights reserved.
//

#import "TwitterClient.h"


@implementation TwitterClient
static TwitterClient *sharedInstance = nil;
+ (TwitterClient *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super alloc] initWithBaseURL:[NSURL URLWithString: @"https://api.twitter.com"] consumerKey:@"geqayCv0xeIIBmRmr6DcIpWt1" consumerSecret:@"SCoHYUvLwW1ugOGw4s5bDMh1fBs3vRreH9ad1uscMBCG7oGPlq"];
    }
    return sharedInstance;
}

@end
