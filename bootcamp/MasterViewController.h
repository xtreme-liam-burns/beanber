//
//  MasterViewController.h
//  bootcamp
//
//  Created by DX085 on 13-05-06.
//  Copyright (c) 2013 DX085. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <ChildViewControllerDelegate> {
    NSMutableArray *tweets;
    NSDictionary *JSON;
    IBOutlet UIBarButtonItem *butt;
}
@property (strong, nonatomic) DetailViewController *detailViewController;

@property NSMutableArray *tweets;

@property (strong, nonatomic)  NSMutableString *hashtag;
@property (nonatomic)  NSInteger page;


- (void)fetchTweets;

@end