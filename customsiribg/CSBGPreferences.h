#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <CepheiPrefs/HBRootListController.h>
#import <CepheiPrefs/HBAppearanceSettings.h>
#import <Cephei/HBPreferences.h>
#import <libimagepicker.h>
#import <spawn.h>

@interface CSBGPreferences : HBRootListController
	- (void)apply:(id)sender;
@end