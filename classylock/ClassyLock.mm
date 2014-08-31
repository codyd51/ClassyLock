#import <Preferences/Preferences.h>
#import <Preferences/PSTableCell.h>
#define url(x) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:x]];

@interface ClassyLockListController: PSListController {
}
- (void)openPayPal;
@end

@implementation ClassyLockListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"ClassyLock" target:self] retain];
	}
	return _specifiers;
}

- (void)openPayPal {
    url(@"https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=PHQ8HBVC2MBY8");
}

@end
