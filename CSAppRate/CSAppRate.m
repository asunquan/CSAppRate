//
//  CSAppRate.m
//  CSAppRateDemo
//
//  Created by Suns孙泉 on 2016/11/7.
//  Copyright © 2016年 cyou-inc.com. All rights reserved.
//

#import "CSAppRate.h"

#import <StoreKit/StoreKit.h>

#define SYSTEMVERSION       [UIDevice currentDevice].systemVersion.floatValue

/**
 *     iOS system version < 7.0 use this url
 */
static NSString *const CSiOSAppStoreURLFormat = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@&pageNumber=0&sortOrdering=2&mt=8";

/**
 *     iOS system version >= 7.0 use this url
 */
static NSString *const CSiOS7AppStoreURLFormat = @"itms-apps://itunes.apple.com/app/id%@";

@interface CSAppRate () <SKStoreProductViewControllerDelegate, UIAlertViewDelegate>

@end

@implementation CSAppRate

{
    UIViewController *customVC;
}

#pragma mark - single instance

static CSAppRate *_instance = nil;

+ (CSAppRate *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self class] new];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

#pragma mark -

+ (void)setRaterAppID:(NSString *)appID scene:(CSRateScene)scene
{
    _instance = [self sharedInstance];
    
    _instance.appID = appID;
    _instance.scene = scene;
}

+ (void)showRatingAlertIn:(id)viewController
{
    _instance = [self sharedInstance];
    
    _instance->customVC = (UIViewController *)viewController;
    
    if (![self isAppIDSetted])
        return;
    
    if (SYSTEMVERSION < 8.0f)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_instance.title
                                                        message:_instance.message
                                                       delegate:self
                                              cancelButtonTitle:_instance.cancel
                                              otherButtonTitles:_instance.rate, nil];
        
        [alert show];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:_instance.title
                                                                       message:_instance.message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *rateAct = [UIAlertAction actionWithTitle:_instance.rate
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            
                                                            [self goToRateTheAppIn:viewController];
                                                            
                                                        }];
        
        UIAlertAction *cancelAct = [UIAlertAction actionWithTitle:_instance.cancel
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil];
        
        [alert addAction:rateAct];
        [alert addAction:cancelAct];
        
        [viewController presentViewController:alert
                                     animated:YES
                                   completion:nil];
    }
}

#pragma UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [CSAppRate goToRateTheAppIn:_instance->customVC];
    }
}

// Judge if the appID has setted or not

+ (BOOL)isAppIDSetted
{
    _instance = [self sharedInstance];
    if (_instance.appID.length == 0)
    {
        NSLog(@"You forget set appID");
        return NO;
    }
    return YES;
}

// Rate logic

+ (void)goToRateTheAppIn:(UIViewController *)viewController
{
    if ([self isAppIDSetted])
    {
        if (_instance.scene == CSRateInApp)
        {
            [_instance ratingInAppIn:viewController];
        }
        if (_instance.scene == CSRateInStore)
        {
            [_instance ratingInAppStore];
        }
    }
}

- (void)ratingInAppIn:(UIViewController *)viewController
{
    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = self;
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:self.appID forKey:SKStoreProductParameterITunesItemIdentifier];
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error)
     {
         if (result)
         {
             [viewController presentViewController:storeProductVC animated:YES completion:nil];
         }
     }];
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)ratingInAppStore
{
    NSString *openFormat = SYSTEMVERSION < 7.0 ? CSiOSAppStoreURLFormat : CSiOS7AppStoreURLFormat;
    NSString *openString = [NSString stringWithFormat:openFormat, self.appID];
    NSURL *openURL = [NSURL URLWithString:openString];
    
    if (SYSTEMVERSION < 10.0f)
    {
        [[UIApplication sharedApplication] openURL:openURL];
    }
    else
    {
        [[UIApplication sharedApplication] openURL:openURL
                                           options:@{}
                                 completionHandler:nil];
    }
}


@end
