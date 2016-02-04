//
//  MDSPullAnimationView.h
//  MDSPullUpToMore
//
//  Created by 杨淳引 on 16/2/3.
//  Copyright © 2016年 shayneyeorg. All rights reserved.
//

#define RGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define kAppTextCoclor RGB(50,50,50)

#import <UIKit/UIKit.h>

@interface MDSPullAnimationView : UIView

@property (nonatomic,assign) BOOL hidesWhenStopped;

- (void)startAnimation;
- (void)stopAnimation;

@end
