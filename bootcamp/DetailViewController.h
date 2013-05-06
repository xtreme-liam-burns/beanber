//
//  DetailViewController.h
//  bootcamp
//
//  Created by DX085 on 13-05-06.
//  Copyright (c) 2013 DX085. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailViewController : UIViewController <UISplitViewControllerDelegate> {
    IBOutlet UIImageView *profileImage;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *tweetLabel;
}
@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
