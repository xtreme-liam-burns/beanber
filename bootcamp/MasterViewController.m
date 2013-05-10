//
//  MasterViewController.m
//  bootcamp
//
//  Created by DX085 on 13-05-06.
//  Copyright (c) 2013 DX085. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "AsyncImageView.h"

#import "TweetCell.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@property NSMutableArray * tweetArray;
@property BOOL donescroll;

@end



@implementation MasterViewController


- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}
int first=0;
- (void)viewDidLoad
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleAsyncImageLoadDidFinish:)
                                                 name:@"AsyncImageLoadDidFinish"
                                               object:nil];
    self.donescroll =  YES;
    self.tweetArray = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    [self fetchTweets];
    if(first==0){
        self.hashtag=@"bieber";
        self.page=1;
        first++;
    }
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self->butt;

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSInteger row = [[self tableView].indexPathForSelectedRow row];
        NSDictionary *tweet = [tweets objectAtIndex:row];
        
        DetailViewController *detailController = segue.destinationViewController;
        detailController.detailItem = tweet;
    }
    if ([[segue identifier] isEqualToString:@"showEntry"]) {
        ViewController *detailController = segue.destinationViewController;
        detailController.delegate = self;
    }
}

- (void)fetchTweets
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *string=@"https://search.twitter.com/search.json?rpp=15&q=%23";
        NSString *url = [[[string stringByAppendingString:self.hashtag] stringByAppendingString:@"&page="] stringByAppendingString:[NSString stringWithFormat:@"%d",self.page]];
        NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString:url]];
        
        NSError* error;
        

        JSON = [NSJSONSerialization JSONObjectWithData:data
                                                 options:kNilOptions
                                                   error:&error];
        
        NSArray *temp=[JSON objectForKey:@"results"];
        if(!tweets) {
            tweets=[[NSMutableArray alloc] initWithArray:temp];
        }
        else {
            [tweets addObjectsFromArray:temp];
        }
        
       // tweets = [JSON objectForKey:@"results"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tweets.count;
}

int indexer=0;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int tmp=indexPath.row;
    static NSString *CellIdentifier = @"TweetCell";
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *tweet = [tweets objectAtIndex:indexPath.row];
    NSString *text = [tweet objectForKey:@"text"];
    NSString *name = [tweet objectForKey:@"from_user"];
    cell.index=indexer;

    cell.url=[tweet objectForKey:@"profile_image_url"];
    AsyncImageView *temp = ((AsyncImageView *)cell.imageView);
    temp.imageURL = [NSURL URLWithString:cell.url];
    cell.tweetLabel.text = text;
    cell.nameLabel.text = [NSString stringWithFormat:@"by %@", name];
    cell.visible = NO;
    [cell update];

    [self.tweetArray insertObject:cell atIndex:indexPath.row];
    indexer++;
    return cell;

}

- (void)childViewControllerDidFinish:(NSString*)text {
    self.hashtag=text;
    tweets=nil;
    self.page=1;
    self.tweetArray=nil;
    [self fetchTweets];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)handleAsyncImageLoadDidFinish:(NSNotification *)note  {
    [self.tableView reloadData];

}

-(BOOL)isRowVisible:(TweetCell*)cell {
    NSArray *indexes = [self.tableView indexPathsForVisibleRows];
    for (NSIndexPath *index in indexes) {
        if (index.row == cell.index) {
            return YES;
        }
    }
    
    return NO;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView_
{
    CGFloat actualPosition = scrollView_.contentOffset.y;
    CGFloat contentHeight = scrollView_.contentSize.height-450-5*self.page;
    if (actualPosition >= contentHeight) {
        if(self.donescroll) {
            self.donescroll=NO;
            self.page++;
            [self fetchTweets];
        }
    }
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView_ {
    self.donescroll = YES;
}
@end
