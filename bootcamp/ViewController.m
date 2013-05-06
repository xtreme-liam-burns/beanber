//
//  ViewController.m
//  bootcamp
//
//  Created by DX085 on 13-05-06.
//  Copyright (c) 2013 DX085. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clicked:(id)sender {
    if ((UIButton *)sender == butt) {
        // you have clicked button 1
        NSString *name = text.text;
        if ([self.delegate respondsToSelector:@selector(childViewControllerDidFinish:)]) {
            [self.delegate childViewControllerDidFinish:name];
        }
        //ß[self.parentViewController
    }
}

@end
