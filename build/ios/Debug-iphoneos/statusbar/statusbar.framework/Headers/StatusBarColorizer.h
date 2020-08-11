#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StatusBarColorizer : NSObject

+ (void)show;
+ (void)hide;
+ (void)color:(UIColor *)color;

@end
