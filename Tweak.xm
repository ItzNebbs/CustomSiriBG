#import "Tweak.h"

%hook SUICFlamesView
	%property (nonatomic, retain) UIImageView *customImage;
	-(void)layoutSubviews {
		%orig;
		if (kEnabled) {
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
%end

%ctor {
	HBPreferences *file = [[HBPreferences alloc] initWithIdentifier:@"fun.tylerd3v.customsiribg"];
	kEnabled = [([file objectForKey:@"kEnabled"] ?: @(NO)) boolValue];
	kCustomImage = [file objectForKey:@"kCustomImage"];
}