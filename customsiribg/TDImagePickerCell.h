#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
@import MobileCoreServices;
@import Photos;

@interface UIImage(TDIP)
	+ (id)imageAtPath:(id)arg1;
@end

@interface TDImagePickerCell : PSTableCell <UINavigationControllerDelegate, UIImagePickerControllerDelegate> { UIViewController* listController; UIImageView* previewImage; }
	@property (nonatomic, retain) NSString* key;
	@property (nonatomic, retain) NSString* defaults;
	@property (nonatomic, retain) NSString* postNotification;
	@property (nonatomic) BOOL usesJPEG;
	@property (nonatomic) BOOL usesGIF;
	@property (nonatomic) CGFloat compressionQuality;
	@property (nonatomic) BOOL allowsVideos;
	@property (nonatomic, retain) NSString* videoPath;
	- (id)initWithStyle:(long long)arg1 reuseIdentifier:(id)arg2 specifier:(id)arg3;
	- (void)chooseImage;
@end

@interface NSUserDefaults (TDIP)
	- (id)objectForKey:(id)arg1 inDomain:(id)arg2;
	- (void)setObject:(id)arg1 forKey:(id)arg2 inDomain:(id)arg3;
@end

@interface PHAsset (TDIP)
	@property (nonatomic,readonly) BOOL isVideo;
@end