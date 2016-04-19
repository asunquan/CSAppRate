# SUAppRate
Ask users to rate your app in App Store. 询问用户去App Store评价你的应用


First you must set your AppID which has setted in Apple App Store.

Use this method set the property of AppID:

[[SUAppRater sharedInstance] setAppID:@"824104400"];


Second you must set the property of scene which is a enum named SURateScene, in this enum there's 2 types, SURateInApp means rating in your app, SURateInStore means rating your app by turning into Apple App Store.

Use this method set the property of scene:

[[SUAppRater sharedInstance] setScene:SURateInApp];


Then you can use the app rater.

You can use iOS common alert through these codes:

SUAppRater *rater = [SUAppRater sharedInstance];
rater.title = @"Notice";
rater.message = @"Enjoy the App? Please rate it!";
rater.rate = @"Rate now";
rater.cancel = @"Next time";
[rater showRatingAlertIn:self];


Or you can use your custom UI, just use rating API:

[rater goToRateTheAppIn:self];