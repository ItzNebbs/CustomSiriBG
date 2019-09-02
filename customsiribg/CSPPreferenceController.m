#include "CSPPreferenceController.h"

@implementation CSPPreferenceController
	- (void)viewDidLoad {
		[super viewDidLoad];
		UIBarButtonItem* applyBtn = [[UIBarButtonItem alloc]  initWithTitle:@"Apply" style:UIBarButtonItemStylePlain target:self action:@selector(apply:)];
		[self.navigationItem setRightBarButtonItem:applyBtn];
	}
	- (void)apply:(id)sender {
		UIAlertController *ApplyChanges = [
			UIAlertController alertControllerWithTitle:@"Apply Changes?"
			message:@"Are you sure you want to apply changes?"
			preferredStyle:UIAlertControllerStyleAlert
		];
		UIAlertAction *noApply = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil];
		UIAlertAction *yesApply = [
			UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
				pid_t pid;
				const char* args[] = {"killall", "backboardd", NULL};
				posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
			}
		];
		[ApplyChanges addAction:noApply];
		[ApplyChanges addAction:yesApply];
		[self presentViewController:ApplyChanges animated: YES completion: nil];
	}
@end