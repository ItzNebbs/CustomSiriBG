#import <Foundation/Foundation.h>
#import <UIKit/UIControl.h>
#import <libimagepicker.h>
#import <UIKit/UIKit.h>

#define prefs [CSProvider sharedProvider]

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define isX (kHeight >= 812)

static bool kEnabled;
static bool kAlwaysUse;
static bool kSmallSiri;
static bool hasExpanded = NO;

static NSData *kCustomImage = nil;
static CGFloat yChange = 0;

static UISwipeGestureRecognizer *swipeUpGesture;
static UISwipeGestureRecognizer *swipeDownGesture;
static SiriUISiriStatusView *status;
static SiriUIHelpButton *helpButton;
static SUICFlamesView *flames;
static _UIRemoteView *remote;
static UIView *statusBar;
static UIView *sbSuperview;

@interface SUICFlamesView : UIView
	@property (nonatomic, retain) UIImageView *customImage;
@end

@interface UIView (ss)
	- (id)_viewControllerForAncestor;
@end

@interface SBAssistantWindow : UIWindow
	- (void)didSwipeUp;
	- (void)didSwipeDown;
	- (void)expandSiriView;
	- (void)closeSiriView;
@end

@interface UIStatusBar : UIView
	@property (nonatomic, retain) UIColor *foregroundColor;
@end

@interface _UIStatusBar : UIView
	@property (nonatomic, retain) UIColor *foregroundColor;
@end

@interface _UIRemoteView : UIView
@end

@interface MTLumaDodgePillView : UIView
@end

@interface SiriUISiriStatusView : UIView
@end

@interface SpringBoard
	- (void)_simulateHomeButtonPress;
@end

@interface SiriUIHelpButton : UIView
@end
