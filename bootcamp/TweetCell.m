//
//  TweetCell.m
//  bootcamp
//
//  Created by DX085 on 13-05-07.
//  Copyright (c) 2013 DX085. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) update {
    profileImage=self.profileImage;
    nameLabel=self.nameLabel;
    tweetLabel=self.tweetLabel;
}

@end
