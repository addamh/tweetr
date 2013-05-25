//
//  ViewController.m
//  tweetr
//
//  Created by Addam Hardy on 5/20/13.
//
//

#import "ViewController.h"
#import "StatusCell.h"

static int TextFontSize = 12;
static int DetailLabelFontSize = 14;
static int Margin = 14;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    self.navigationItem.title = @"#RubyMotion";
    
    [self.view addSubview:_tableView];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self loadTimeline];
}

- (void) viewWillDisappear:(BOOL)animated
{

}

- (void) loadTimeline
{
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:@"https://search.twitter.com/search.json?q=%23rubymotion"]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark - NSURLConnection Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];

    NSArray *resultsObject = [res objectForKey:@"results"];
    
    _statuses = [[NSMutableArray alloc] initWithCapacity:[resultsObject count]];
    
    for (NSDictionary * dict in resultsObject){
        Tweet *tweet = [[Tweet alloc] init];
        [tweet initWithData:dict];
        [self.statuses addObject:tweet];
    }

    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_statuses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TweetCellIdentifier = @"TweetCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TweetCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:TweetCellIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",[self.statuses[indexPath.row] tweet]);
    cell.textLabel.text = [self.statuses[indexPath.row] username];
    cell.detailTextLabel.text = [self.statuses[indexPath.row] tweet];
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:TextFontSize];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    cell.detailTextLabel.numberOfLines = 0;
    CGRect frameRect = cell.frame;
    frameRect.origin.y = TextFontSize + 2 * Margin;
    cell.detailTextLabel.frame = frameRect;
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.detailTextLabel.textColor = [UIColor blackColor];
    
    cell.imageView.image = [UIImage imageNamed:@"avatarPlaceHolder"];
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[self.statuses[indexPath.row] avatar]]];
        if(imageData){
            dispatch_async( dispatch_get_main_queue(), ^{
                UIImage *avatar = [[UIImage alloc] initWithData:imageData];
                cell.imageView.image = avatar;
            });
        }
    });
    
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [StatusCell heightForCellWithTweet:(_statuses[indexPath.row])];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
