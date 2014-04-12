#import "ClassyHelper.h"

@implementation ClassyHelper
+ (instancetype)sharedInstance {
    static dispatch_once_t once = nil;
    static id sharedInstance = nil;
    
    // This, as the name says, will only ever execute once (the first time this method is called)
    // so initialize our instance here
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    // return the shared instance
    return sharedInstance;
}

- (void)refreshWeather {

    if ([[WeatherPreferences sharedPreferences] isCelsius] == FALSE) {
        
         //update
        [[[WeatherPreferences sharedPreferences] localWeatherCity] update];
        //BOOL _autoUpdate;
        //[City _autoUpdate] = TRUE;
        //int _updateInterval;
        //- (void)update;
        //[City update];
        //turn on celsius
         [[WeatherPreferences sharedPreferences] setCelsius:TRUE];
        //turn back off
        [[WeatherPreferences sharedPreferences] setCelsius:FALSE];
        
        NSLog(@"ClassyLock--Weather updated--Celsius false");
        
    }
    
     else if ([[WeatherPreferences sharedPreferences] isCelsius] == TRUE) {
        
        //update
        [[[WeatherPreferences sharedPreferences] localWeatherCity] update];
        //turn off celsius
        [[WeatherPreferences sharedPreferences] setCelsius:FALSE];
        //turn back on
        [[WeatherPreferences sharedPreferences] setCelsius:TRUE];
        
        NSLog(@"ClassyLock--Weather updated--Celsius true");
        
    }

}
@end