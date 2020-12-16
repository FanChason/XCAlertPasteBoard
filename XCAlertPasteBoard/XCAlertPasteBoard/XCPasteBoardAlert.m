//
//  XCPasteBoardAlert.m
//  XCAlertPasteBoard
//
//  Created by 范献超 on 2020/7/8.
//  Copyright © 2020 范献超. All rights reserved.
//

#import "XCPasteBoardAlert.h"



@implementation XCPasteBoardAlert

+ (XCPasteBoardAlert *)loadAlertWithMessage:(NSString *)message {
    NSArray * xibArray = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil];
    XCPasteBoardAlert *alertView = (XCPasteBoardAlert *)xibArray[0];
    alertView.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    alertView.contentLabel.text = message;
    return alertView;
}

- (void)show {
    for (UIView *subView in UIApplication.sharedApplication.keyWindow.subviews) {
        if ([subView isKindOfClass:[XCPasteBoardAlert class]]) {
            [subView removeFromSuperview];
        }
    }
    [UIApplication.sharedApplication.keyWindow addSubview:self]; 
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2]; // 此种写法避免子view受父view透明色影响
    self.contentLabel.userInteractionEnabled=YES;
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

- (IBAction)sureAction {
    [self removeFromSuperview];
}

@end
