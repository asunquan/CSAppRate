//
//  SUAppRate.h
//  SUAppRateDemo
//
//  Created by Suns孙泉 on 16/4/1.
//  Copyright © 2016年 cyou-inc.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *     Rating Scene Enum
 */
typedef NS_ENUM(NSUInteger, SURateScene) {
    /**
     *     Rating in App
     */
    SURateInApp,
    /**
     *     Rating by turning into App Store
     */
    SURateInStore
};

@interface SUAppRater : NSObject

/**
 *     Create single instance
 *
 *     @return single instance
 */
+ (SUAppRater *)sharedInstance;

/**
 *     Show Rating AlertView
 */
- (void)showRatingAlertIn:(UIViewController *)viewController;

#pragma mark - Must be setted

/**
 *     The AppID which is in App Store
 */
@property (nonatomic, copy, readwrite) NSString *appID;

/**
 *     Rating Scene
 */
@property (nonatomic, assign) SURateScene scene;

#pragma mark - Use iOS alertView

/**
 *     The title of alertView
 */
@property (nonatomic, copy, readwrite) NSString *title;

/**
 *     The message of alertView
 */
@property (nonatomic, copy, readwrite) NSString *message;

/**
 *     The title of rate button
 */
@property (nonatomic, copy, readwrite) NSString *rate;

/**
 *     The title of cacel button
 */
@property (nonatomic, copy, readwrite) NSString *cancel;

#pragma mark - Only use API

/**
 *     Go to rate the App
 *
 *     @param viewController (UIViewController *) rating in app needed
 */
- (void)goToRateTheAppIn:(UIViewController *)viewController;


@end
