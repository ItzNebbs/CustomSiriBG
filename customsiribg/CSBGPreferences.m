#include "CSBGPreferences.h"

@implementation CSBGPreferences
	- (instancetype)init {
		self = [super init];
		if (self) {
			HBAppearanceSettings *appearanceSettings = [[HBAppearanceSettings alloc] init];
			appearanceSettings.tintColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:1];
			appearanceSettings.tableViewCellSeparatorColor = [UIColor colorWithWhite:0 alpha:0];
			self.hb_appearanceSettings = appearanceSettings;
			UIBarButtonItem* applyChanges = [[UIBarButtonItem alloc]  initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(apply:)];
    		[self.navigationItem setRightBarButtonItem:applyChanges];
		}
		return self;
	}
	- (NSArray *)specifiers {
		if (!_specifiers) {
			_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
		}
		return _specifiers;
	}
	- (void)viewWillAppear:(BOOL)animated {
		[super viewWillAppear:animated];
		CGRect frame = self.table.bounds;
		frame.origin.y = -frame.size.height;
		[self.navigationController.navigationController.navigationBar setShadowImage: [UIImage new]];
		self.navigationController.navigationController.navigationBar.translucent = YES;
	}
	- (void)apply:(id)sender {
		pid_t pid;
		const char* args[] = {"killall", "backboardd", NULL};
		posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
	}
@end