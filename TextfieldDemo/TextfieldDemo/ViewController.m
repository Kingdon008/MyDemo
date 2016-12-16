//
//  ViewController.m
//  TextfieldDemo
//
//  Created by herodon on 2016/12/15.
//  Copyright © 2016年 dujie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (assign, nonatomic)  BOOL hideInner;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //简历通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.bottomSpace.constant=-50;
}
- (IBAction)clickAction:(id)sender {
    [self.textField becomeFirstResponder];
}
-(void)keyboardWillChangeFrameNotification:(NSNotification *)note{

    //获取键盘的饿frame
    CGRect frmae = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //让TextFiled的底部约束间距为屏幕高度减去键盘顶部的y值即可
    //注意 这里不要使其等于键盘的高度，因为高度时死的，会导致键盘下去后，TextField并未下去的结果。
    self.bottomSpace.constant = [UIScreen mainScreen].bounds.size.height - frmae.origin.y;
    
    //获取键盘的动画时间，使TextField与键盘的形态一致
    CGFloat interval = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //设置Text的动画
    [UIView animateWithDuration:interval animations:^{
        
        //注意这里不是改变值，之前已经改变值了，
        //在这里需要做的事强制布局
        [self.view layoutIfNeeded];
        
    }];
    
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    self.bottomSpace.constant=-50;
}


@end
