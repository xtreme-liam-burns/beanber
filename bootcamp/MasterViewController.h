//
//  MasterViewController.h
//  bootcamp
//
//  Created by DX085 on 13-05-06.
//  Copyright (c) 2013 DX085. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController {
    NSArray *tweets;
    NSDictionary *JSON;
}
@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic)  NSMutableString *hashtag;


- (void)fetchTweets;

@end