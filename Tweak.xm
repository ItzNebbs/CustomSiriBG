#import "CSProvider.h"
#import "Tweak.h"

%hook SUICFlamesView
	%property (nonatomic, retain) UIImageView *customImage;
	- (id)init {
		if (kEnabled && kSmallSiri) {
			self = %orig;
			if (self) {
				flames = self;
			}
			return self;
		}
		return %orig;
	}
	- (void)setActiveFrame:(CGRect)arg1 {
		%orig;
		if (kEnabled && kSmallSiri) {
			if (!hasExpanded) {
				arg1 = CGRectMake(arg1.origin.x, arg1.origin.y - yChange, arg1.size.width, arg1.size.height);
			}
		}
	}
	- (void)layoutSubviews {
		%orig;
		if (kEnabled) {
			if (kAlwaysUse || hasExpanded) {
				UIImage *chosenImage = [UIImage imageWithData:kCustomImage];
				self.customImage = [[UIImageView alloc] initWithImage: chosenImage];
				self.customImage.frame = [UIScreen mainScreen].bounds;
				self.customImage.contentMode = UIViewContentModeScaleAspectFit;
				self.customImage.userInteractionEnabled = NO;
				self.customImage.alpha = 0;
				self.customImage.hidden = NO;
				[UIView animateWithDuration:0.4
					animations:^{
						self.customImage.alpha = 1;
					}
				];
				[self insertSubview:self.customImage atIndex:0];
			}
		}
	}
%end

%hook SBAssistantWindow
	- (void)becomeKeyWindow {
		%orig;
		if (kEnabled && kSmallSiri) {
			if (!hasExpanded) {
				CGFloat yF = isX ? 44 : 10;
				self.frame = CGRectMake(10, yF, kWidth - 20, 90);
				self.subviews[0].layer.cornerRadius = 15;
				self.subviews[0].clipsToBounds = YES;
				swipeUpGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeUp)];
				swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
				[self.subviews[0] addGestureRecognizer:swipeUpGesture];
				swipeDownGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeDown)];
				swipeDownGesture.direction = UISwipeGestureRecognizerDirectionDown;
				[self.subviews[0] addGestureRecognizer:swipeDownGesture];
			}
		}
	}
	- (void)dealloc {
		%orig;
		if (kEnabled && kSmallSiri) {
			hasExpanded = NO;
		}
	}
	%new
	- (void)closeSiriView {
		if (kEnabled && kSmallSiri) {
			if (!hasExpanded) {
				[UIView animateWithDuration:0.3f animations:^{
					self.subviews[0].center = CGPointMake(self.subviews[0].center.x, -90);
				} completion:^(BOOL finished) {
					[(SpringBoard *)[%c(UIApplication) sharedApplication] _simulateHomeButtonPress];
				}];
			}
		}
	}
	%new
	- (void)expandSiriView {
		if (kEnabled && kSmallSiri) {
			if (!hasExpanded) {
				[UIView animateWithDuration:0.5f animations:^{
					self.frame = CGRectMake(0, 0, kWidth, kHeight);
				} completion:^(BOOL finished) {
					for (UIView* v in status.subviews) {
						if ([v isMemberOfClass:[UIButton class]]) {
							v.frame = CGRectMake(0, 0, v.frame.size.width, v.frame.size.height);
						} else {
							v.frame = CGRectMake(v.frame.origin.x, v.frame.origin.y + yChange, v.frame.size.width, v.frame.size.height);
						}
					}
					self.subviews[0].layer.cornerRadius = 0;
					self.subviews[0].clipsToBounds = NO;
					helpButton.frame = CGRectMake(helpButton.frame.origin.x, helpButton.frame.origin.y + yChange, self.frame.size.width, helpButton.frame.size.height);
					flames.frame = CGRectMake(flames.frame.origin.x, flames.frame.origin.y + yChange, flames.frame.size.width, flames.frame.size.height);
					remote.hidden = NO;
					[sbSuperview addSubview:statusBar];
				}];
				hasExpanded = YES;
			}
		}
	}
	%new
	- (void)didSwipeUp {
		if (kEnabled && kSmallSiri) {
			[self closeSiriView];
		}
	}
	%new
	- (void)didSwipeDown {
		if (kEnabled && kSmallSiri) {
			[self expandSiriView];
		}
	}
%end

%hook UIStatusBar
	- (void)didMoveToWindow {
		%orig;
		if (kEnabled && kSmallSiri) {
			if ([[self window] isMemberOfClass:objc_getClass("SBAssistantWindow")] && !hasExpanded) {
				statusBar = self;
				sbSuperview = self.superview;
				[self removeFromSuperview];
			}
		}
	}
%end

%hook _UIStatusBar
	- (void)didMoveToWindow {
		%orig;
		if (kEnabled && kSmallSiri) {
			if ([[self window] isMemberOfClass:objc_getClass("SBAssistantWindow")] && !hasExpanded) {
				statusBar = self;
				sbSuperview = self.superview;
				[self removeFromSuperview];
			}
		}
	}
%end

inline CGRect worldFrameOfView(UIView* aView) {
	return [[aView superview] convertRect:aView.frame toView:nil];
}

%hook SiriUISiriStatusView
	- (id)init {
		if (kEnabled && kSmallSiri) {
			self = %orig;
			if (self) {
				status = self;
			}
			return self;
		}
		return %orig;
	}
	- (void)layoutSubviews {
		%orig;
		if (kEnabled && kSmallSiri) {
			if (!hasExpanded) {
				for (UIView* v in self.subviews) {
					if ([v isMemberOfClass:[UIButton class]]) {
						yChange = worldFrameOfView(v).origin.y;
						yChange -= (self.frame.size.height - v.frame.size.height);
						v.frame = CGRectMake(0, yChange * -1, v.frame.size.width, v.frame.size.height);
						for (UIView* b in self.subviews) {
							if (![b isMemberOfClass:[UIButton class]]) {
								b.frame = CGRectMake(b.frame.origin.x, b.frame.origin.y - yChange, b.frame.size.width, b.frame.size.height);
								break;
							}
						}
						break;
					}
				}
			}
		}
	}
%end

%hook SiriUIHelpButton
	- (id)init {
		if (kEnabled && kSmallSiri) {
			self = %orig;
			if (self) {
				helpButton = self;
			}
			return self;
		}
		return %orig;
	}
	- (void)setFrame:(CGRect)arg1 {
		%orig;
		if (kEnabled && kSmallSiri) {
			if (!hasExpanded) {
				arg1 = CGRectMake(arg1.origin.x, arg1.origin.y - yChange, arg1.size.width, arg1.size.height);
			}
		}
	}
%end

%hook MTLumaDodgePillView
	- (void)didMoveToWindow {
		%orig;
		if (kEnabled && kSmallSiri) {
			if ([[[UIApplication sharedApplication] keyWindow] isMemberOfClass:objc_getClass("SBAssistantWindow")] && !hasExpanded) {
				[self removeFromSuperview];
			}
		}
	}
%end

%hook _UIRemoteView
	- (void)didMoveToSuperview {
		%orig;
		if (kEnabled && kSmallSiri) {
			if ([[self _viewControllerForAncestor] isMemberOfClass:objc_getClass("AFUISiriRemoteViewController")] && !hasExpanded) {
				remote = self;
				self.hidden = YES;
			}
		}
	}
%end

%ctor {
	kEnabled = [prefs boolForKey:@"kEnabled"];
	kSmallSiri = [prefs boolForKey:@"kSmallSiri"];
	kAlwaysUse = [prefs boolForKey:@"kAlwaysUse"];
	kCustomImage = [prefs objectForKey:@"kCustomImage"];
}
