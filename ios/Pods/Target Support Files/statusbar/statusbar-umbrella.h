#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "StatusBarColorizer.h"
#import "StatusbarPlugin.h"
#import "UIApplication+Swizzling.h"

FOUNDATION_EXPORT double statusbarVersionNumber;
FOUNDATION_EXPORT const unsigned char statusbarVersionString[];

