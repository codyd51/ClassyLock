#import "CustUIImage.h"

UIImage* backImage = [[UIImage alloc] init];
UIImageView* newBack = [[UIImageView alloc] init];

@implementation CustUIImage
+(UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 100.0f, 100.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}
@end

@protocol SBFWallpaperViewInternalObserver <NSObject>
-(void)wallpaperViewDidInvalidateBlurs:(id)arg1;
@end

@interface SBFWallpaperView : NSObject
@property(nonatomic) id<SBFWallpaperViewInternalObserver> internalObserver;
@property(retain, nonatomic) UIView* contentView;
-(id)wallpaperImage;
-(void)_notifyBlursInvalidated;
-(void)_notifyGeometryInvalidated;
@end

@interface SBFStaticWallpaperView : SBFWallpaperView
@end

static SBFWallpaperView* SPCurrentLockscreenWallpaper = nil;