//
//  ViewController.m
//  CSAppRateDemo
//
//  Created by Suns孙泉 on 2016/11/7.
//  Copyright © 2016年 cyou-inc.com. All rights reserved.
//

#import "ViewController.h"

#import "CSAppRate.h"

@interface ViewController ()

@end

@implementation ViewController

{
    CSAppRate *instance;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    instance = [CSAppRate sharedInstance];
}

- (IBAction)rateInAppByDefaultUI:(id)sender
{
    instance.scene = CSRateInApp;
    instance.title = @"Notice";
    instance.message = @"Enjoy the App? Please rate it!";
    instance.rate = @"Rate now";
    instance.cancel = @"No thanks";
    
    [CSAppRate showRatingAlertIn:self];
}

- (IBAction)rateInStoreByDefaultUI:(id)sender
{
    instance.scene = CSRateInStore;
    instance.title = @"Notice";
    instance.message = @"Enjoy the App? Please rate it!";
    instance.rate = @"Rate now";
    instance.cancel = @"No thanks";
    
    [CSAppRate showRatingAlertIn:self];
}

- (IBAction)rateInApp:(id)sender
{
    instance.scene = CSRateInApp;
    
    [CSAppRate goToRateTheAppIn:self];
}

- (IBAction)rateInStore:(id)sender
{
    instance.scene = CSRateInStore;
    
    [CSAppRate goToRateTheAppIn:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
