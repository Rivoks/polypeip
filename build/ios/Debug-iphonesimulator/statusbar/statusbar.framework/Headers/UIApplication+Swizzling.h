#import <UIKit/UIKit.h>

/*
 * The only way found to recognize if statusbar changes visibility was to swizzle.
 * Replace this code if another method is found.
 */
@interface UIApplication (Swizzling)
@end
