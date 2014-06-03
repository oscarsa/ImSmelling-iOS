//
//  FirstRegisterViewController.h
//  ImSmelling2
//
//  Created by Óscar Saboya Gómez on 11/04/14.
//  Copyright (c) 2014 OscarSaboya. All rights reserved.
//

#import "ViewController.h"

@interface FirstRegisterViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextField *txtUser;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPass;
@property (weak, nonatomic) IBOutlet UITextField *txtCheckPass;
- (IBAction)btnContRegister:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnContinue;
@property (strong, nonatomic) IBOutlet UIView *viewFirstRegister;

- (void) setDefaultValues;
- (void) saveTextFields;
- (void) log1stepRegister;

//Right or wrong email labels
@property (strong, nonatomic) IBOutlet UILabel *rightMarkEmail;
@property (strong, nonatomic) IBOutlet UILabel *wrongMarkEmail;

//Right or wrong pass labels
@property (strong, nonatomic) IBOutlet UILabel *wrongMarkPass;
@property (strong, nonatomic) IBOutlet UILabel *rightMarkPass;

//Right or wrong pass check labels
@property (strong, nonatomic) IBOutlet UILabel *wrongMarkCheckPass;
@property (strong, nonatomic) IBOutlet UILabel *rightMarkCheckPass;


@end
