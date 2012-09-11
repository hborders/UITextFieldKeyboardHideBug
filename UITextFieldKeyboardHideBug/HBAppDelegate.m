//
//  HBAppDelegate.m
//  UITextFieldKeyboardHideBug
//
//  Created by dev1 on 9/11/12.
//  Copyright (c) 2012 Heath Borders. All rights reserved.
//

#import "HBAppDelegate.h"

@interface HBAppDelegate () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField2;
@property (nonatomic, strong) UITextField *textField3;

@end

@implementation HBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    UIViewController *viewController = [UIViewController new];
    
    UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    textField1.borderStyle = UITextBorderStyleRoundedRect;
    textField1.delegate = self;
    textField1.text = @"Never Shows";
    [viewController.view addSubview:textField1];
    
    self.textField2 = [[UITextField alloc] initWithFrame:CGRectMake(200, 0, 200, 50)];
    self.textField2.borderStyle = UITextBorderStyleRoundedRect;
    self.textField2.delegate = self;
    self.textField2.text = @"Start";
    [viewController.view addSubview:self.textField2];

    self.textField3 = [[UITextField alloc] initWithFrame:CGRectMake(400, 0, 200, 50)];
    self.textField3.borderStyle = UITextBorderStyleRoundedRect;
    self.textField3.delegate = self;
    self.textField3.text = @"Doessn't Dismiss";
    [viewController.view addSubview:self.textField3];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(buttonTouchUpInside)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(600, 0, 150, 50);
    [button setTitle:@"Dismiss #3"
            forState:UIControlStateNormal];
    [viewController.view addSubview:button];

    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];

    return YES;
}

#pragma mark - UITextFieldDelegate

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"textFieldDidBeginEditing: %@", textField);
    NSLog(@"TextField: %@ isFirstResponder: %d", textField, [textField isFirstResponder]);
    if (textField != self.textField2) {
        [textField resignFirstResponder];
        NSLog(@"TextField: %@ isFirstResponder: %d", textField, [textField isFirstResponder]);
        NSLog(@"TextField2 isFirstResponder: %d", [textField isFirstResponder]);
    }
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"textFieldDidEndEditing: %@", textField);
}

#pragma mark - actions

- (void) buttonTouchUpInside {
    [self.textField3 resignFirstResponder];
}

@end
