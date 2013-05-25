//
//  Tweet.m
//  tweetr
//
//  Created by Addam Hardy on 5/20/13.
//
//

#import "Tweet.h"

@implementation Tweet

- (void)initWithData:(NSDictionary *)data
{
    self.tweet = [data objectForKey:@"text"];
    self.username = [data objectForKey:@"from_user_name"];
    self.avatar = [data objectForKey:@"profile_image_url"];
}

@end
