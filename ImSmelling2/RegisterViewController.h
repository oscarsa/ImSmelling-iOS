//
//  RegisterViewController.h
//  ImSmelling2
//
//  Created by Óscar Saboya Gómez on 10/04/14.
//  Copyright (c) 2014 OscarSaboya. All rights reserved.
//

#import "ViewController.h"

@interface RegisterViewController : ViewController <UIPickerViewDataSource, UIPickerViewDelegate>


@property (nonatomic, strong) IBOutlet UIPickerView *pckrAge;
@property (nonatomic, strong) IBOutlet UIPickerView *pckrGenre;

@property (nonatomic, strong) NSArray *ages;
@property (nonatomic, strong) NSArray *genres;

- (IBAction)btnRegister:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnReg;


- (void) setDefaultValues;
- (void) log2stepRegister;

@end
