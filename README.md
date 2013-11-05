#UIImage+MMLaunchImage


Adds a category to UIImage which returns the current launch image 'Default.png' for an iOS app by parsing the Info.plist.

* Can deal with iOS7 and iOS6 style launch images
* Deals with different orientations
* Deals with iPhone and iPad idioms
* Handy if you are using an image catalog and don't know the real image names for your launch image
* Useful for displaying after launch, to create a fade into your app or waiting for an interstitial

## Installation:

Using Cocoapods:
````
pod 'UIImage+MMLaunchImage'
````

## Usage:

````objective-c
#import <UIImage+MMLaunchImage/UIImage+MMLaunchImage.h>

UIImage *launchImage = [UIImage launchImage];
UIWindow *window = [UIApplication sharedApplication].keyWindow;
UIImageView *splash = [[UIImageView alloc] initWithImage:launchImage];
[window addSubview:splash];

````

