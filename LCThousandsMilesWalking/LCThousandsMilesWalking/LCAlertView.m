//
//  LCAlertView.m
//  LCThousandsMilesWalking
//
//  Created by 刘超 on 15/8/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "LCAlertView.h"

@implementation LCAlertView

//-(id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles addType:(LC_ALERT_TYPE)type{
//    if (self=[super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil]) {
//        if (type==LC_ALERT_INPUTBOX) {
//            
//        }
//    }
//    return self;
//}


-(id)initForLCAlertViewType:(LC_ALERTVIEW_TYPE)type{
    _type=type;
    if (type==LC_ALERTVIEW_NAME) {
        if (self=[super initWithTitle:@"请输入名字" message:nil delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil]) {
            // 基本输入框，显示实际输入的内容
            self.alertViewStyle = UIAlertViewStylePlainTextInput;
            // 用户名，密码登录框
            //    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
            // 密码形式的输入框，输入字符会显示为圆点
            //    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            
            //设置输入框的键盘类型
            UITextField *tf = [self textFieldAtIndex:0];
            tf.keyboardType = UIKeyboardTypeNumberPad;
            
            UITextField *tf2 = nil;
            if (self.alertViewStyle == UIAlertViewStyleLoginAndPasswordInput) {
                // 对于用户名密码类型的弹出框，还可以取另一个输入框
                tf2 = [self textFieldAtIndex:1];
                tf2.keyboardType = UIKeyboardTypeASCIICapable;
            }
            
            // 取得输入的值
            NSString* text = tf.text;
            NSLog(@"INPUT:%@", text);
            if (self.alertViewStyle == UIAlertViewStyleLoginAndPasswordInput) {
                // 对于两个输入框的
                NSString* text2 = tf2.text;
                NSLog(@"INPUT2:%@", text2);
            }
            
            
        }
        return self;
    }else if (type == LC_ALERTVIEW_HOBBIES){
        if (self=[super initWithTitle:@"兴趣爱好" message:nil delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil]) {
            // 基本输入框，显示实际输入的内容
            self.alertViewStyle = UIAlertViewStylePlainTextInput;
            // 用户名，密码登录框
            //    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
            // 密码形式的输入框，输入字符会显示为圆点
            //    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            
            //设置输入框的键盘类型
            UITextField *tf = [self textFieldAtIndex:0];
            tf.keyboardType = UIKeyboardTypeNumberPad;
            
            UITextField *tf2 = nil;
            if (self.alertViewStyle == UIAlertViewStyleLoginAndPasswordInput) {
                // 对于用户名密码类型的弹出框，还可以取另一个输入框
                tf2 = [self textFieldAtIndex:1];
                tf2.keyboardType = UIKeyboardTypeASCIICapable;
            }
            
            // 取得输入的值
            NSString* text = tf.text;
            NSLog(@"INPUT:%@", text);
            if (self.alertViewStyle == UIAlertViewStyleLoginAndPasswordInput) {
                // 对于两个输入框的
                NSString* text2 = tf2.text;
                NSLog(@"INPUT2:%@", text2);
            }
            
            
        }
        return self;
    }else if (type==LC_ALERTVIEW_NICKNAME){
        if (self=[super initWithTitle:@"昵称" message:nil delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil]) {
            // 基本输入框，显示实际输入的内容
            self.alertViewStyle = UIAlertViewStylePlainTextInput;
            // 用户名，密码登录框
            //    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
            // 密码形式的输入框，输入字符会显示为圆点
            //    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            
            //设置输入框的键盘类型
            UITextField *tf = [self textFieldAtIndex:0];
            tf.keyboardType = UIKeyboardTypeNumberPad;
            
            UITextField *tf2 = nil;
            if (self.alertViewStyle == UIAlertViewStyleLoginAndPasswordInput) {
                // 对于用户名密码类型的弹出框，还可以取另一个输入框
                tf2 = [self textFieldAtIndex:1];
                tf2.keyboardType = UIKeyboardTypeASCIICapable;
            }
            
            // 取得输入的值
            NSString* text = tf.text;
            NSLog(@"INPUT:%@", text);
            if (self.alertViewStyle == UIAlertViewStyleLoginAndPasswordInput) {
                // 对于两个输入框的
                NSString* text2 = tf2.text;
                NSLog(@"INPUT2:%@", text2);
            }
        }
        return self;
    }else if (type==LC_ALERTVIEW_RADIUS){
        if (self=[super initWithTitle:@"请输入半径值" message:nil delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil]) {
            // 基本输入框，显示实际输入的内容
            self.alertViewStyle = UIAlertViewStylePlainTextInput;
            // 用户名，密码登录框
            //    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
            // 密码形式的输入框，输入字符会显示为圆点
            //    alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
            
            //设置输入框的键盘类型
            UITextField *tf = [self textFieldAtIndex:0];
            tf.keyboardType = UIKeyboardTypeNumberPad;
            
            UITextField *tf2 = nil;
            if (self.alertViewStyle == UIAlertViewStyleLoginAndPasswordInput) {
                // 对于用户名密码类型的弹出框，还可以取另一个输入框
                tf2 = [self textFieldAtIndex:1];
                tf2.keyboardType = UIKeyboardTypeASCIICapable;
            }
            
            // 取得输入的值
            NSString* text = tf.text;
            NSLog(@"INPUT:%@", text);
            if (self.alertViewStyle == UIAlertViewStyleLoginAndPasswordInput) {
                // 对于两个输入框的
                NSString* text2 = tf2.text;
                NSLog(@"INPUT2:%@", text2);
            }
            
            
        }
        return self;
    }
    return nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];     // 当override父类的方法时，要注意一下是否需要调用父类的该方法
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (_type==LC_ALERTVIEW_NAME) {
        if (buttonIndex==1) {
            UITextField *textField=[alertView textFieldAtIndex:0];
            _clickOkBlock(textField.text,LC_ALERTVIEW_NAME);
        }
        
    }else if (_type==LC_ALERTVIEW_HOBBIES ){
        UITextField *textField=[alertView textFieldAtIndex:0];
        _clickOkBlock(textField.text,LC_ALERTVIEW_HOBBIES);
        
    }else if (_type==LC_ALERTVIEW_NICKNAME){
        UITextField *textField=[alertView textFieldAtIndex:0];
        _clickOkBlock(textField.text,LC_ALERTVIEW_NICKNAME);
    }else if (_type==LC_ALERTVIEW_RADIUS){
        UITextField *textField=[alertView textFieldAtIndex:0];
        _clickOkBlock(textField.text,LC_ALERTVIEW_RADIUS);
    }
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
