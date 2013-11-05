//
//  UIImage+LaunchImage.m
//
//  Matt Mayer

#import "UIImage+LaunchImage.h"

@implementation UIImage (LaunchImage)
+(UIImage *)launchImage {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    BOOL phone =[UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPhone;
    BOOL landscape = UIInterfaceOrientationIsLandscape(orientation);
    NSString *os_version = [[UIDevice currentDevice] systemVersion];
    
    //check the ios7 key
    NSArray *ios7LaunchImages = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    if (ios7LaunchImages!=nil) {
        NSString *orientationString = @"Portrait";
        if (!phone && landscape) {
            orientationString = @"Landscape";
        }
        //filter down the array to just the matching elements
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"UILaunchImageMinimumOSVersion <= %@ AND UILaunchImageOrientation = %@ AND UILaunchImageSize = %@",os_version,orientationString,NSStringFromCGSize([UIApplication sharedApplication].keyWindow.bounds.size) ];
        NSArray *suitableLaunchImages = [ios7LaunchImages filteredArrayUsingPredicate:predicate];
        NSString *imageName = [[suitableLaunchImages firstObject] objectForKey:@"UILaunchImageName"];
        UIImage *image = [UIImage imageNamed:imageName];
        if (image!=nil) {
            return image;
        }
    }

    //check the pre-ios7 key
    NSString* baseName = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImageFile"];
    if (baseName!=nil) {
        
        if(phone) {
            BOOL fourinch = ([UIScreen mainScreen].bounds.size.height == 568.0);
            return fourinch ? [UIImage imageNamed:[NSString stringWithFormat:@"%@-568h",baseName]] : [UIImage imageNamed:baseName];
            
        } else {
            UIImage *image = nil;
            if(orientation == UIInterfaceOrientationPortraitUpsideDown) {
                image =[UIImage imageNamed:[NSString stringWithFormat:@"%@-PortraitUpsideDown",baseName]];
            } else if (orientation == UIInterfaceOrientationLandscapeLeft) {
                image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-LandscapeLeft",baseName]];
            } else if( orientation == UIInterfaceOrientationLandscapeRight) {
                image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-LandscapeRight",baseName]];
            }
            if (image!=nil) {
                return image;
            }
            
            return [UIImage imageNamed:[NSString stringWithFormat:(landscape?@"%@-Landscape":@"%@-Portrait"),baseName]];
            
        }
    }
    return nil;
}
@end