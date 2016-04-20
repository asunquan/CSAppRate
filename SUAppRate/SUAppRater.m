//
//  SUAppRate.m
//  SUAppRateDemo
//
//  Created by Suns孙泉 on 16/4/1.
//  Copyright © 2016年 cyou-inc.com. All rights reserved.
//

#import "SUAppRater.h"

#import <StoreKit/StoreKit.h>

/**
 *     iOS system version < 7.0 use this url
 */
static NSString *const SUiOSAppStoreURLFormat = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@&pageNumber=0&sortOrdering=2&mt=8";

/**
 *     iOS system version >= 7.0 use this url
 */
static NSString *const SUiOS7AppStoreURLFormat = @"itms-apps://itunes.apple.com/app/id%@";

@interface SUAppRater () <SKStoreProductViewControllerDelegate>

@end

@implementation SUAppRater

#pragma mark - single instance

static SUAppRater *_instance = nil;

+ (SUAppRater *)sharedInstance
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

- (void)setRaterAppID:(NSString *)appID scene:(SURateScene)scene
{
    self.appID = appID;
    self.scene = scene;
}

- (void)showRatingAlertIn:(id)viewController
{
    if ([self isAppIDSetted])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.title
                                                                       message:self.message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *rateAct = [UIAlertAction actionWithTitle:self.rate
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            
                                                            [self goToRateTheAppIn:viewController];
                                                            
                                                        }];
        
        UIAlertAction *cancelAct = [UIAlertAction actionWithTitle:self.cancel
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              
                                                          }];
        
        [alert addAction:rateAct];
        [alert addAction:cancelAct];
        
        [viewController presentViewController:alert
                                     animated:YES
                                   completion:nil];
    }
}

// Judge if the appID has setted or not

- (BOOL)isAppIDSetted
{
    if (self.appID.length == 0)
    {
        NSLog(@"You forget set appID");
        return NO;
    }
    return YES;
}

// Rate logic

- (void)goToRateTheAppIn:(UIViewController *)viewController
{
    if ([self isAppIDSetted])
    {
        if (self.scene == SURateInApp)
        {
            [self ratingInAppIn:viewController];
        }
        if (self.scene == SURateInStore)
        {
            [self ratingInAppStore];
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
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7.0)
    {
        NSString *openUrl = [NSString stringWithFormat:SUiOSAppStoreURLFormat, self.appID];
        NSLog(@"open url : %@", openUrl);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
    }
    else
    {
        NSString *openUrl = [NSString stringWithFormat:SUiOS7AppStoreURLFormat, self.appID];
        NSLog(@"open url : %@", openUrl);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
    }
}




































@end
