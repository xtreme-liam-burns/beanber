//
//  ViewController.h
//  bootcamp
//
//  Created by DX085 on 13-05-06.
//  Copyright (c) 2013 DX085. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChildViewControllerDelegate;


@interface ViewController : UIViewController {
    IBOutlet UITextField *text;
    IBOutlet UIButton *butt;
    
}
@property (nonatomic, weak) id<ChildViewControllerDelegate> delegate;

-(IBAction)clicked:(id)sender;

@end
@protocol ChildViewControllerDelegate <NSObject>

- (void)childViewControllerDidFinish:(ViewController*)viewController;

@end
