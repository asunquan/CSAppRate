//
//  ViewController.m
//  SUAppRateDemo
//
//  Created by Suns孙泉 on 16/4/1.
//  Copyright © 2016年 cyou-inc.com. All rights reserved.
//

#import "ViewController.h"

#import "SUAppRater.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)rating:(id)sender
{
    SUAppRater *rater = [SUAppRater sharedInstance];
    rater.title = @"Notice";
    rater.message = @"Enjoy the App? Please rate it!";
    rater.rate = @"Rate now";
    rater.cancel = @"Next time";
    [rater showRatingAlertIn:self];

    /** Use cutom UI
    [rater goToRateTheAppIn:self];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
