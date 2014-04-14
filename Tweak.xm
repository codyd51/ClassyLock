#import "Weather.h"
#import "CustUIImage.mm"
#import "ClassyHelper.mm"
#import <CoreText/CoreText.h>
#import <CoreData/CoreData.h>
#define kSettingsPath [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.phillipt.classylock.plist"]
#define kIsEnabled [[[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"enabled"] boolValue]
#define kDarkMode [[[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"darkMode"] boolValue]
#define kChangeWall [[[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"changeWall"] boolValue]
#define kRefreshTime [[[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"refreshTime"] floatValue]
#define kShouldShowTemp [[[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"showTemp"] boolValue]
#define kShouldShowCondition [[[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"showCondition"] boolValue]
#define kShouldShowTime [[[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"showTime"] boolValue]
#define kFreezing [[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"freezing"]
#define kCold [[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"cold"]
#define kWarm [[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"warm"]
#define kBurning [[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"burning"]
#define kFuckString [[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"fuckString"]
#define kShitString [[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"shitString"]
#define kSmallFreezing [[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"smallFreezing"]
#define kSmallCold [[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"smallCold"]
#define kSmallWarm [[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"smallWarm"]
#define kSmallBurning [[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"smallBurning"]
#define kFreezingBound [[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"freezingBound"]
#define kColdBound [[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"coldBound"]
#define kWarmBound [[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"warmBound"]
#define kBurningBound [[NSDictionary dictionaryWithContentsOfFile:kSettingsPath] objectForKey:@"burningBound"]

int HEIGHT = 420;
UILabel *newTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 310, HEIGHT)];
UILabel *curseLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 310, HEIGHT)];
UILabel *fuckLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 310, HEIGHT)];
UILabel *shitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 310, HEIGHT)];
UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 310, HEIGHT)];
UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 310, HEIGHT)];
UILabel *wearLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 310, HEIGHT)];
NSMutableDictionary *prefs = nil;
long currCode = nil;
NSString *temp = nil;
NSString *theCode = [NSString stringWithFormat:@"%ld", currCode];
NSString *result = nil;
NSTimer *timer = nil;
int value = [temp intValue];

void loadPreferences() {

    prefs = [NSMutableDictionary dictionaryWithContentsOfFile:kSettingsPath];

    NSLog(@"ClassyLock--%@", [prefs description]);

    CGFloat refreshTime;
    if (kRefreshTime != nil) {
        refreshTime = kRefreshTime;
    }
    else {
        refreshTime = 300.0;
    }
    NSTimeInterval refreshInterval = refreshTime;

    if([timer isValid]) [timer invalidate];
    if (kIsEnabled) {

    timer = [NSTimer scheduledTimerWithTimeInterval:refreshInterval target:[ClassyHelper sharedInstance] selector:@selector(refreshWeather) userInfo:nil repeats:YES];
    NSLog(@"ClassyLock--timer initialized");
    NSLog(@"ClassyLock--%f", refreshInterval);
    }
    if (!kIsEnabled) {

        [timer invalidate];
        timer = nil;

    }

}

%hook SBLockScreenView

- (void)glintyAnimationDidStart {

if (kIsEnabled) {

	if (kChangeWall) {
		if (!kDarkMode) {
			backImage = [CustUIImage imageWithColor:[UIColor whiteColor]];
		}

		else if (kDarkMode) {
			backImage = [CustUIImage imageWithColor:[UIColor blackColor]];
		}

		// Getting the _lockscreenWallpaperView ivar
		SBWallpaperController* wpc = [%c(SBWallpaperController) sharedInstance];
		SPCurrentLockscreenWallpaper = MSHookIvar<SBFStaticWallpaperView*>(wpc, "_lockscreenWallpaperView");

		UIImageView* content = (UIImageView*)[SPCurrentLockscreenWallpaper contentView];

		[SPCurrentLockscreenWallpaper setValue:backImage forKey:@"_image"];
		[content setImage:backImage];
	}

    UIView *wind = MSHookIvar<UIView *>(self, "_foregroundView");

    [newBack removeFromSuperview];
    [newTime removeFromSuperview];
    [curseLabel removeFromSuperview];
    [fuckLabel removeFromSuperview];
    [shitLabel removeFromSuperview];
    [tempLabel removeFromSuperview];
    [resultLabel removeFromSuperview];
    [wearLabel removeFromSuperview];

    NSString *temp = [[[WeatherPreferences sharedPreferences] localWeatherCity] temperature];
    int value = [temp intValue];
    long currCode = [[[WeatherPreferences sharedPreferences] localWeatherCity] conditionCode];
    NSString *theCode = [NSString stringWithFormat:@"%ld", currCode];

	switch ([theCode intValue]) {

        case 0:
            result = @"Something is probably wrong with ClassyLock";
            break;
        case 1:
            result = @"Storm";
            break;
        case 2:
            result = @"Hurricane";
            break;
        case 3:
            result = @"Thunderstorm";
            break;
        case 4:
            result = @"Thunderstorm";
            break;
        case 5:
            result = @"Snow";
            break;
        case 6:
            result = @"Sleet";
            break;
        case 7:
            result = @"Sleet";
            break;
        case 8:
            result = @"Rain";
            break;
        case 9:
            result = @"Drizzle";
            break;
        case 10:
            result = @"Rain";
            break;
        case 11:
            result = @"Showers";
            break;
        case 12:
            result = @"Showers";
            break;
        case 13:
            result = @"Snow Flurries";
            break;
        case 14:
            result = @"Snow Showers";
            break;
        case 15:
            result = @"Snow";
            break;
        case 16:
            result = @"Snow";
            break;
        case 17:
            result = @"Hail";
            break;
        case 18:
            result = @"Sleet";
            break;
        case 19:
            result = @"Dust";
            break;
        case 20:
            result = @"Fog";
            break;
        case 21:
            result = @"Haze";
            break;
        case 22:
            result = @"Smoke";
            break;
        case 23:
            result = @"Blustery";
            break;
        case 24:
            result = @"Wind";
            break;
        case 25:
            result = @"Cold";
            break;
        case 26:
            result = @"Cloudy";
            break;
        case 27:
            result = @"Cloudy";
            break;
        case 28:
            result = @"Cloudy";
            break;
        case 29:
            result = @"Cloudy";
            break;
        case 30:
            result = @"Cloudy";
            break;
        case 31:
            result = @"Clear";
            break;
        case 32:
            result = @"Sunny";
            break;
        case 33:
            result = @"Fair";
            break;
        case 34:
            result = @"Fair";
            break;
        case 35:
            result = @"Hail";
            break;
        case 36:
            result = @"Hot";
            break;
        case 37:
            result = @"Thunderstorm";
            break;
        case 38:
            result = @"Thunderstorm";
            break;
        case 39:
            result = @"Thunderstorm";
            break;
        case 40:
            result = @"Showers";
            break;
        case 41:
            result = @"Snowy";
            break;
        case 42:
            result = @"Snowy";
            break;
        case 43:
            result = @"Snowy";
            break;
        case 44:
            result = @"Cloudy";
            break;
        case 45:
            result = @"Thunderstorm";
            break;
        case 46:
            result = @"Snowy";
            break;
        case 47:
            result = @"Thunderstorm";
            break;
        case 3200:
            result = @"Not Available";
            break;
        default:
            result = @"Not Available";
            break;

    }

    NSString *unit = nil;
    if (![[WeatherPreferences sharedPreferences] isCelsius]) {

        //Convert to Fahrenheit
        unit = @"F";
        value = value*9;
        value = value/5;
        value = value+32;
        NSString *fahren = [NSString stringWithFormat:@"%d", value];
        temp = fahren;
        NSLog(@"ClassyLock--converted to Fahrenheit");

    }
    //If celsius, return C
    else {

        unit = @"C";
        NSLog(@"ClassyLock--stayed in Celsius");

    }

	NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
	[DateFormatter setDateFormat:@"hh:mm"];
	NSLog(@"ClassyLock--%@",[DateFormatter stringFromDate:[NSDate date]]);

	newTime.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:80];
	curseLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:70];
	fuckLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:70];
	shitLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:70];
	tempLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:50];
	resultLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:40];
	wearLabel.font = [UIFont fontWithName:@"ClearSans-Bold" size:15];

	newTime.adjustsFontSizeToFitWidth = YES;
	curseLabel.adjustsFontSizeToFitWidth = YES;
	fuckLabel.adjustsFontSizeToFitWidth = YES;
	shitLabel.adjustsFontSizeToFitWidth = YES;
	tempLabel.adjustsFontSizeToFitWidth = YES;
	resultLabel.adjustsFontSizeToFitWidth = YES;
	wearLabel.adjustsFontSizeToFitWidth = YES;

	if (!kDarkMode){
		[newTime setTextColor:[UIColor blackColor]];
		[fuckLabel setTextColor:[UIColor blackColor]];
		[shitLabel setTextColor:[UIColor blackColor]];
		[tempLabel setTextColor:[UIColor blackColor]];
		[resultLabel setTextColor:[UIColor blackColor]];
		[wearLabel setTextColor:[UIColor blackColor]];
	}
	else if (kDarkMode) {
		[newTime setTextColor:[UIColor whiteColor]];
		[fuckLabel setTextColor:[UIColor whiteColor]];
		[shitLabel setTextColor:[UIColor whiteColor]];
		[tempLabel setTextColor:[UIColor whiteColor]];
		[resultLabel setTextColor:[UIColor whiteColor]];
		[wearLabel setTextColor:[UIColor whiteColor]];
	}

	newTime.numberOfLines = 1;
	curseLabel.numberOfLines = 1;
	fuckLabel.numberOfLines = 1;
	shitLabel.numberOfLines = 1;
	tempLabel.numberOfLines = 1;
	resultLabel.numberOfLines = 1;
	wearLabel.numberOfLines = 1;

	[newTime setCenter:wind.center];
	[curseLabel setCenter:wind.center];
	[fuckLabel setCenter:wind.center];
	[shitLabel setCenter:wind.center];
	[tempLabel setCenter:wind.center];
	[resultLabel setCenter:wind.center];
	[wearLabel setCenter:wind.center];

	newTime.textAlignment = NSTextAlignmentCenter;
	curseLabel.textAlignment = NSTextAlignmentLeft;
	fuckLabel.textAlignment = NSTextAlignmentLeft;
	shitLabel.textAlignment = NSTextAlignmentLeft;
	tempLabel.textAlignment = NSTextAlignmentCenter;
	resultLabel.textAlignment = NSTextAlignmentCenter;
	wearLabel.textAlignment = NSTextAlignmentLeft;

	newTime.text = [NSString stringWithFormat:@"%@", [DateFormatter stringFromDate:[NSDate date]]];
	if (kShouldShowTime) {
        [wind addSubview:newTime];
    }

	if ([temp intValue] <= 10 && ([kFreezing isEqual:@""] || kFreezing==nil)) {
		curseLabel.text = [NSString stringWithFormat:@"Fucking freezing,"];
		[curseLabel setTextColor:[UIColor colorWithRed:0.0/255.0 green:40.0/255.0 blue:225.0/255.0 alpha:1]];
		NSLog(@"ClassyLock-%@", temp);
	}
	else if ([temp intValue] <= 10 && (![kFreezing isEqual:@""] && kFreezing!=nil)) {
		curseLabel.text = kFreezing;
		[curseLabel setTextColor:[UIColor colorWithRed:0.0/255.0 green:40.0/255.0 blue:225.0/255.0 alpha:1]];
		NSLog(@"ClassyLock-%@", temp);
	}
	if ([temp intValue] > 10 && [temp intValue] <= 65 && ([kCold isEqual:@""] || kCold==nil)) {
		curseLabel.text= [NSString stringWithFormat:@"Cold as"];
		[curseLabel setTextColor:[UIColor colorWithRed:0.0/255.0 green:75.0/255.0 blue:150.0/255.0 alpha:1]];
		NSLog(@"ClassyLock-%@", temp);
	}
	else if ([temp intValue] > 10 && [temp intValue] <= 65 && (![kCold isEqual:@""] && kCold!=nil)) {
		curseLabel.text = kCold;
		[curseLabel setTextColor:[UIColor colorWithRed:0.0/255.0 green:75.0/255.0 blue:150.0/255.0 alpha:1]];
		NSLog(@"ClassyLock-%@", temp);
	}
	if ([temp intValue] > 65 && [temp intValue] <= 85 && ([kWarm isEqual:@""] || kWarm==nil)) {
		curseLabel.text= [NSString stringWithFormat:@"Warm as"];
		[curseLabel setTextColor:[UIColor colorWithRed:255/255.0 green:150.0/255.0 blue:0.0/255.0 alpha:1]];
		NSLog(@"ClassyLock-%@", temp);
	}
	else if ([temp intValue] > 65 && [temp intValue] <= 85 && (![kWarm isEqual:@""] && kWarm!=nil)) {
		curseLabel.text = kWarm;
		[curseLabel setTextColor:[UIColor colorWithRed:255/255.0 green:150.0/255.0 blue:0.0/255.0 alpha:1]];
		NSLog(@"ClassyLock-%@", temp);
	}
	if ([temp intValue] > 85 && ([kBurning isEqual:@""] || kBurning==nil)){
		curseLabel.text= [NSString stringWithFormat:@"Fucking burning,"];
		[curseLabel setTextColor:[UIColor colorWithRed:225.0/255.0 green:40.0/255.0 blue:0.0/255.0 alpha:1]];
		NSLog(@"ClassyLock-%@", temp);
	}
	else if ([temp intValue] > 85 && ([kBurning isEqual:@""] && kBurning!=nil)) {
		curseLabel.text = kBurning;
		[curseLabel setTextColor:[UIColor colorWithRed:225.0/255.0 green:40.0/255.0 blue:0.0/255.0 alpha:1]];
		NSLog(@"ClassyLock-%@", temp);
	}
	[wind addSubview:curseLabel];

	if ([kFuckString isEqual:@""] || kFuckString==nil) {
		fuckLabel.text = [NSString stringWithFormat:@"fucking"];
	}
	else if (![kFuckString isEqual:@""] && kFuckString!=nil) {
		fuckLabel.text = kFuckString;
	}
	[wind addSubview:fuckLabel];

	if ([kShitString isEqual:@""] || kShitString==nil) {
		shitLabel.text = [NSString stringWithFormat:@"shit."];
	}
	else if (![kShitString isEqual:@""] && kShitString!=nil) {
		shitLabel.text = kShitString;
	}
	[wind addSubview:shitLabel];

	tempLabel.text = [NSString stringWithFormat:@"%@° %@", temp, unit];
	if (kShouldShowTemp) {
        [wind addSubview:tempLabel];
    }

	resultLabel.text = [NSString stringWithFormat:@"%@", result];
	if (kShouldShowCondition) {
        [wind addSubview:resultLabel];
    }

	if (value <= 10 && ([kSmallFreezing isEqual:@""] || kSmallFreezing==nil)) {
		wearLabel.text = [NSString stringWithFormat:@"Fuck you, nature."];
	}
	else if (value <= 10 && (![kSmallFreezing isEqual:@""] && kSmallFreezing!=nil)) {
		wearLabel.text = kSmallFreezing;
	}
	if (value > 10 && value <= 65 && ([kSmallCold isEqual:@""] || kSmallCold==nil)) {
		wearLabel.text= [NSString stringWithFormat:@"Pack a coat, fuckers."];
	}
	else if (value > 10 && value <= 65 && (![kSmallCold isEqual:@""] && kSmallCold!=nil)) {
		wearLabel.text = kSmallCold;
	}
	if (value > 65 && value <= 85 && ([kSmallWarm isEqual:@""] || kSmallWarm==nil)) {
		wearLabel.text= [NSString stringWithFormat:@"Time to go outside for once!"];
	}
	else if (value > 65 && value <= 85 && (![kSmallWarm isEqual:@""] && kSmallWarm!=nil)) {
		wearLabel.text = kSmallWarm;
	}
	if (value > 85 && ([kSmallBurning isEqual:@""] || kSmallBurning==nil)){
		wearLabel.text= [NSString stringWithFormat:@"Wear shorts or some shit."];
	}
	else if (value > 85 && ([kSmallBurning isEqual:@""] && kSmallBurning!=nil)) {
		wearLabel.text = kSmallBurning;
	}
	[wind addSubview:wearLabel];

	newTime.center = CGPointMake(wind.center.x, wind.center.y-(HEIGHT/5.16363636));
	curseLabel.center = CGPointMake(wind.center.x+5, wind.center.y+(HEIGHT/7.1));
	fuckLabel.center = CGPointMake(wind.center.x+5, wind.center.y+(HEIGHT/3.78666667));
	shitLabel.center = CGPointMake(wind.center.x+5, wind.center.y+(HEIGHT/2.7047619));
	tempLabel.center = CGPointMake(wind.center.x, wind.center.y-(HEIGHT/2.46956522));
	resultLabel.center = CGPointMake(wind.center.x, wind.center.y-(HEIGHT/3.07027027));
	wearLabel.center = CGPointMake(wind.center.x+10, wind.center.y+(HEIGHT/2.18461538));

    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(getSwipe)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipe setDelaysTouchesBegan:YES];
    [wind addGestureRecognizer:swipe];

}

else if (!kIsEnabled) {

	[newBack removeFromSuperview];
    [newTime removeFromSuperview];
    [curseLabel removeFromSuperview];
    [fuckLabel removeFromSuperview];
    [shitLabel removeFromSuperview];
    [tempLabel removeFromSuperview];
    [resultLabel removeFromSuperview];
    [wearLabel removeFromSuperview];

}

%orig;

}

- (void)glintyAnimationDidStop {
    [newBack removeFromSuperview];
    [newTime removeFromSuperview];
    [curseLabel removeFromSuperview];
    [fuckLabel removeFromSuperview];
    [shitLabel removeFromSuperview];
    [tempLabel removeFromSuperview];
    [resultLabel removeFromSuperview];
    [wearLabel removeFromSuperview];
    %orig;
}

-(void)setCustomSlideToUnlockText:(id)arg1 {

    if (kIsEnabled) {
        arg1 = @"";
    }

    %orig(arg1);

}

- (void)setTopGrabberHidden:(BOOL)arg1 forRequester:(id)arg2 {

	if (kIsEnabled) {
		arg1 = TRUE;
		%orig(arg1, arg2);
	}

	else if (!kIsEnabled) {
        %orig(arg1, arg2);
    }
}

- (BOOL)isTopGrabberHidden {

	if (kIsEnabled) {
		return TRUE;
	}

	else if (!kIsEnabled) {
        return %orig;
    }

    return %orig;

}

- (void)setBottomGrabberHidden:(BOOL)arg1 forRequester:(id)arg2 {

	if (kIsEnabled) {
		arg1 = TRUE;
		%orig(arg1, arg2);
	}

	else if (!kIsEnabled) {
        %orig(arg1, arg2);
    }
}

- (BOOL)isBottomGrabberHidden {

	if (kIsEnabled) {
		return TRUE;
	}

	else if (!kIsEnabled) {
        return %orig;
    }

    return %orig;

}

- (void)setCameraGrabberHidden:(BOOL)arg1 forRequester:(id)arg2 {

	if (kIsEnabled) {
		arg1 = TRUE;
		%orig(arg1, arg2);
	}

	else if (!kIsEnabled) {
        %orig(arg1, arg2);
    }
}

%end

%hook SBLockScreenViewController

- (BOOL)_shouldShowDate {

    if (kIsEnabled) {
        return FALSE;
    }

   else if (!kIsEnabled) {
        return %orig;
    }

    return %orig;

}

- (float)_effectiveOpacityForVisibleDateView {

    if (kIsEnabled) {
        return 0.0;
    }

    else if (!kIsEnabled) {
        return %orig;
    }

    return %orig;

}

- (void)lockScreenView:(id)arg1 didScrollToPage:(int)arg2 {

if (kIsEnabled) {

	if (arg2 != 1) {

		[newBack removeFromSuperview];
		[newTime removeFromSuperview];
		[curseLabel removeFromSuperview];
		[fuckLabel removeFromSuperview];
		[shitLabel removeFromSuperview];
		[tempLabel removeFromSuperview];
		[resultLabel removeFromSuperview];
		[wearLabel removeFromSuperview];

	}

}

else if (!kIsEnabled) {

	[newBack removeFromSuperview];
    [newTime removeFromSuperview];
    [curseLabel removeFromSuperview];
    [fuckLabel removeFromSuperview];
    [shitLabel removeFromSuperview];
    [tempLabel removeFromSuperview];
    [resultLabel removeFromSuperview];
    [wearLabel removeFromSuperview];

}

%orig;

}

%end

%hook SBFGlintyStringView

-(int)chevronStyle {

    if (kIsEnabled) {
    	return 0;
    }

    else if (!kIsEnabled) {
        return %orig;
    }

    return %orig;

}

 -(void)setChevronStyle:(int) style {


	if (kIsEnabled) {
		style = 0;
		%orig(style);
	}

	else if (!kIsEnabled) {
        %orig(style);
    }

}

%end

%ctor {

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    (CFNotificationCallback)loadPreferences,
                                    CFSTR("com.phillipt.classylock/preferencechanged"),
                                    NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);

    loadPreferences();

    if ([[UIScreen mainScreen] bounds].size.height == 568) {
    	//iphone 4 inch screen (5, 5c, 5s)
    	HEIGHT = 568;
	}

    %init();

    NSData* fontData = [NSData dataWithContentsOfFile:@"/Library/ClassyLockFonts/ClearSans-Bold.ttf"];
	CFErrorRef error;
	CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)fontData);
	CGFontRef font = CGFontCreateWithDataProvider(provider);
	if (!CTFontManagerRegisterGraphicsFont(font, &error)) {
		CFStringRef errorDescription = CFErrorCopyDescription(error);
		CFRelease(errorDescription);
	}
	CFRelease(font);
	CFRelease(provider);

}
