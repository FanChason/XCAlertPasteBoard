//
//  XCPasteBoardAlert.h
//  XCAlertPasteBoard
//
//  Created by 范献超 on 2020/7/8.
//  Copyright © 2020 范献超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^XCTwoPasteBoardAlertClickBlock)(NSInteger index);

@interface XCTwoPasteBoardAlert : UIView

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic, copy) XCTwoPasteBoardAlertClickBlock clickBlock;
+ (XCTwoPasteBoardAlert *)loadAlertWithMessage:(NSString *)message;
- (void)show;
@end
