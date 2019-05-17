#import <Foundation/Foundation.h>
#import <Cephei/HBPreferences.h>
#import <UIKit/UIControl.h>
#import <libimagepicker.h>
#import <UIKit/UIKit.h>

@interface SUICFlamesView : UIView
	@property (nonatomic, retain) UIImageView *customImage;
@end

static bool kEnabled = false;
static NSData *kCustomImage = nil;