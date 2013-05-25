//
//  StatusCell.m
//  tweetr
//
//  Created by Addam Hardy on 5/20/13.
//
//

#import "StatusCell.h"

@implementation StatusCell

static int TextFontSize = 12;
static int DetailLabelFontSize = 14;
static int Margin = 14;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(10, Margin, 48, 48);
    
}

+(CGFloat)heightForCellWithTweet:(Tweet *)tweet
{
    UITableViewCell *calculationCell = [[StatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StatusCellCalculationCell"];
    
    int detailLabelOffsetY = TextFontSize + 2 * Margin;
    
    int appWidth = UIScreen.mainScreen.applicationFrame.size.width;
    int labelWidth = (appWidth - calculationCell.imageView.frame.size.width) - 4 * Margin;
    CGSize constraint = CGSizeMake(labelWidth, 20000);
    
    CGFloat detailLabelHeight = [[tweet tweet] sizeWithFont:[UIFont systemFontOfSize:DetailLabelFontSize] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping].height;
    
    return MAX(44 + 2 * Margin, detailLabelHeight + detailLabelOffsetY);
}

@end
