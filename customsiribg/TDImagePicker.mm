#import "TDImagePicker.h"

UIImage *TDIPParseImage(NSData *imageDataFromPrefs) {
	return [UIImage imageWithData:imageDataFromPrefs];
}