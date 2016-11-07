# CSAppRate
##### Ask users to rate your app in App Store.

##### 询问用户去App Store评价你的应用

##### First you must set your <font color="#DC143C">AppID</font> which has setted in Apple App Store.

##### Use this method set the property of AppID:

```objective-c
[CSAppRate sharedInstance].appID = @"YOURAPPID";
```

##### Second you must set the property of scene which is a enum named CSRateScene, in this enum there's 2 types, CSRateInApp means rating in your app, CSRateInStore means rating your app by turning into Apple App Store.

##### Use this method set the property of scene:

```objective-c
[CSAppRate sharedInstance].scene = CSRateInApp;
```

##### You can use this method instead of twice setter method:

```objective-c
[CSAppRate setRaterAppID:@"YOURAPPID" scene:CSRateInApp];
```

##### Then you can use the app rater.

##### You can use iOS common alert through these codes:

```objective-c
CSAppRate *instance = [CSAppRate sharedInstance];

instance.title = @"Notice";
instance.message = @"Enjoy the App? Please rate it!";
instance.rate = @"Rate now";
instance.cancel = @"Next time";

[CSAppRate showRatingAlertIn:viewController];
```

##### It is a UIAlertView below iOS 8 and a UIAlertController above iOS 8.

##### Or you can use your custom UI, just use rating API:

```objective-c
[CSAppRate goToRateTheAppIn:viewController];
```

#### And now It supports iOS 10!