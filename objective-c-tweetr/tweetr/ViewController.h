//
//  ViewController.h
//  tweetr
//
//  Created by Addam Hardy on 5/20/13.
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *statuses;
@property (nonatomic, strong) NSMutableData *responseData;

@end
