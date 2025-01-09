//
//  CPTemplateApplicationScene.h
//  TDS Video
//
//  Created by Thomas Dye on 05/08/2024.
//



#ifndef CPTemplateApplicationScene_h
#define CPTemplateApplicationScene_h


@import CarPlay;
#import <objc/runtime.h>
#import <Foundation/Foundation.h>

@interface CPTemplateApplicationScene (Swizzle)

// Public method to check if the car window should be created
- (BOOL)_shouldCreateCarWindow;

@end

@interface CPInterfaceController (Swizzle)

// Public method to check if the car window should be created
@property (nonnull, nonatomic, strong, readonly) CPWindow *windowProvider;

@end


#endif /* CPTemplateApplicationScene_h */
