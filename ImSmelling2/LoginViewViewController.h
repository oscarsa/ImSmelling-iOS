//
//  LoginViewViewController.h
//  ImSmelling2
//
//  Created by Óscar Saboya Gómez on 08/04/14.
//  Copyright (c) 2014 OscarSaboya. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface LoginViewViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtEmailLogin;
@property (weak, nonatomic) IBOutlet UITextField *txtPassLogin;

- (IBAction)btnLogin:(id)sender;
- (IBAction)btnRegister:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnLoginOut;
@property (strong, nonatomic) IBOutlet UIButton *btnRegisterOut;

- (void) setDefaultValues;
- (void) saveTextFields;
- (void) logLogin;



@end
