//#import <Preferences/Preferences.h>
//Tired of having header issues? Just forward-declare stuff!
@interface PSListController : NSObject { //Good enough
	id _specifiers;
}

- (id)loadSpecifiersFromPlistName:(NSString *)name target:(id)target;

@end
@interface DarkBoardPrefsListController: PSListController

@end

@implementation DarkBoardPrefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"DarkBoardPrefs" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
