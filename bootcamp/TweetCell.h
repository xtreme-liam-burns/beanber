//
//  TweetCell.h
//  bootcamp
//
//  Created by DX085 on 13-05-07.
//  Copyright (c) 2013 DX085. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell {
    IBOutlet UIImageView *profileImage;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *tweetLabel;
}

@property UIImageView *profileImage;
@property UILabel *nameLabel;
@property UILabel *tweetLabel;
@property int index;
@property NSString * url;
@property BOOL visible;


-(void) update;
@end
