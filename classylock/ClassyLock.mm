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

@interface TestCell : PSTableCell {
    UILabel* _label;
}
@end

@implementation TestCell
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
//-(id)initWithFrame:(CGRect)frame specifier:(id)specifier {
- (id)initWithSpecifier:(PSSpecifier *)specifier {
    //if ((self = [super initWithStyle:style reuseIdentifier:identifier])) {
    //if ((self = [super initWithFrame:frame specifier:specifier])) {
    if (self = [super initWithSpecifier:specifier]) {
        // Do your stuff, for example:
        // _label = [[UILabel alloc] init...];

        // ...

        // [self addSubview:_label];

        CGRect frame = [self frame];
 
        _label = [[UILabel alloc] initWithFrame:frame];
        //[_label setLineBreakMode:UILineBreakModeWordWrap];
        //[_label setNumberOfLines:0];
        //[_label setText:@"You can use attributed text to make this prettier."];
        _label.text = [NSString stringWithFormat:@"Fucking freezing,"];
        //[_label setBackgroundColor:[UIColor clearColor]];
        //[_label setShadowColor:[UIColor whiteColor]];
        //[_label setShadowOffset:CGSizeMake(0,1)];
        //[_label setTextAlignment:UITextAlignmentCenter];
        [_label setUserInteractionEnabled:NO];
 
        [self addSubview:_label];
        [_label release];
    }
    return self;
}
@end
//vim:ft=objc
