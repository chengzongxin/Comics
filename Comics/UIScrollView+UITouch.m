//
//  UIScrollView+UITouch.m
//  Comics
//
//  Created by Jason on 2018/6/1.
//  Copyright © 2018年 Jason. All rights reserved.
//

#import "UIScrollView+UITouch.h"

@implementation UIScrollView (UITouch)
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 选其一即可
    [super touchesBegan:touches withEvent:event];
//    [[self nextResponder] touchesBegan:touches withEvent:event];
}
@end
