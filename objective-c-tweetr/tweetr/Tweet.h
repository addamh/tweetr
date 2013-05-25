//
//  Tweet.h
//  tweetr
//
//  Created by Addam Hardy on 5/20/13.
//
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *tweet;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *avatar;

- (void)initWithData:(NSDictionary *)data;

@end
