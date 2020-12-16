//
//  XCPasteBoardAlert.m
//  XCAlertPasteBoard
//
//  Created by 范献超 on 2020/7/8.
//  Copyright © 2020 范献超. All rights reserved.
//

#import "XCTwoPasteBoardAlert.h"

@interface XCTwoPasteBoardAlert ()
@property (weak, nonatomic) IBOutlet UIView *alertView;

@end

@implementation XCTwoPasteBoardAlert

+ (XCTwoPasteBoardAlert *)loadAlertWithMessage:(NSString *)message {
    NSArray * xibArray = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil];
    XCTwoPasteBoardAlert *alertView = (XCTwoPasteBoardAlert *)xibArray[0];
    alertView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    alertView.contentLabel.text = message;
    return alertView;
}

- (void)show {
    for (UIView *subView in UIApplication.sharedApplication.keyWindow.subviews) {
        if ([subView isKindOfClass:[XCTwoPasteBoardAlert class]]) {
            [subView removeFromSuperview];
        }
    }
    [UIApplication.sharedApplication.keyWindow addSubview:self];
    
    [self shakeToShow:self.alertView];
}

#pragma mark - 动画
- (void)shakeToShow:(UIView*)aView
{
    CGFloat kAnimationDuration = 0.1f;
    CAGradientLayer *contentLayer = (CAGradientLayer *)aView.layer;
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1)];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.duration = kAnimationDuration;
    scaleAnimation.cumulative = NO;
    scaleAnimation.repeatCount = 1;
    [scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [contentLayer addAnimation: scaleAnimation forKey:@"myScale"];
    
    CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showViewAnn.fromValue = [NSNumber numberWithFloat:0.0];
    showViewAnn.toValue = [NSNumber numberWithFloat:1.0];
    showViewAnn.duration = kAnimationDuration;
    showViewAnn.fillMode = kCAFillModeForwards;
    showViewAnn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    showViewAnn.removedOnCompletion = NO;
    //        showViewAnn.delegate = self;
    [contentLayer addAnimation:showViewAnn forKey:@"myShow"];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = kAnimationDuration;
    group.removedOnCompletion = NO;
    group.repeatCount = 1;
    group.fillMode = kCAFillModeForwards;
    [group setAnimations:@[scaleAnimation,showViewAnn]];
    
    [contentLayer addAnimation:group forKey:@"animationOpacity"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2]; // 此种写法避免子view受父view透明色影响
    self.contentLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
    [self.contentLabel addGestureRecognizer:labelTapGestureRecognizer];
}

-(void)labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    
    UILabel *label = (UILabel*)recognizer.view;
    NSLog(@"%@被点击了",label.text);
    
    //系统级别
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = label.text;
    
    NSLog(@"复制成功");
}

- (IBAction)cancelAction {
    [self removeFromSuperview];
    if (self.clickBlock) {
        self.clickBlock(0);
    }
}


- (IBAction)sureAction {
    [self removeFromSuperview];
    if (self.clickBlock) {
        self.clickBlock(1);
    }
}



@end
