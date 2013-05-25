//
//  StatusCell.h
//  tweetr
//
//  Created by Addam Hardy on 5/20/13.
//
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface StatusCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imageView;

+(CGFloat)heightForCellWithTweet:(Tweet *)tweet;

@end
