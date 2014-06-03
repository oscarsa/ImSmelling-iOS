//
//  NewObservationViewController.h
//  ImSmelling2
//
//  Created by Óscar Saboya Gómez on 24/04/14.
//  Copyright (c) 2014 OscarSaboya. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NewObservationViewController : UIViewController


- (int) getVisibleView;


//View movement when keyboard is show

- (IBAction)textFieldReturn:(id)sender;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)moveUpView:(NSNotification *)note;
- (void)moveDownView:(NSNotification *)note;

- (void)animation;




//New observation - Step 1

@property (nonatomic, strong) NSArray *odours;


@property (strong, nonatomic) IBOutlet UIView *Step1;
- (IBAction)btnToStep2:(id)sender;
@property (strong, nonatomic) IBOutlet UIProgressView *ProgressView1;

@property (strong, nonatomic) IBOutlet UIPickerView *pckrOdourType;

@property (strong, nonatomic) IBOutlet UISlider *sldrOdourIntensity;
@property (strong, nonatomic) IBOutlet UILabel *lblOdourIntensity;
@property (strong, nonatomic) IBOutlet UITextField *txtOtherOdour;

@property (strong, nonatomic) IBOutlet UIButton *btnContinue1;

@property (strong, nonatomic) IBOutlet UIButton *hideBtnBack1;




//New observation - Step 2

@property (strong, nonatomic) IBOutlet UIView *Step2;
- (IBAction)btnToStep3:(id)sender;
@property (strong, nonatomic) IBOutlet UIProgressView *ProgressView2;
- (IBAction)btnBackTo1:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblPleasantOdour;
@property (strong, nonatomic) IBOutlet UISlider *sldrPleasantOdour;
@property (strong, nonatomic) IBOutlet UITextField *txtOdourOrigin;
@property (strong, nonatomic) IBOutlet UILabel *lblOdourDuration;
@property (strong, nonatomic) IBOutlet UISlider *sldrOdourDuration;

@property (strong, nonatomic) IBOutlet UIButton *btnContinue2;

@property (strong, nonatomic) IBOutlet UIButton *btnBack2;


//New observation - Step 3

@property (strong, nonatomic) IBOutlet UIView *Step3;
- (IBAction)btnBackTo2:(id)sender;
- (IBAction)btnFinish:(id)sender;
@property (strong, nonatomic) IBOutlet UIProgressView *ProgressView3;
@property (strong, nonatomic) IBOutlet UILabel *lblCloud;
@property (strong, nonatomic) IBOutlet UISlider *sldrCloud;
@property (strong, nonatomic) IBOutlet UILabel *lblRain;
@property (strong, nonatomic) IBOutlet UISlider *sldrRain;
@property (strong, nonatomic) IBOutlet UILabel *lblWind;
@property (strong, nonatomic) IBOutlet UISlider *sldrWind;


@property (strong, nonatomic) IBOutlet UITabBarItem *tabBarNewObservation;

@property (strong, nonatomic) IBOutlet UIButton *btnFinish3;
@property (strong, nonatomic) IBOutlet UIButton *btnBack3;


//Save new observation values
- (void) setDefaultValues;
- (void) saveTextFields;
- (void) logNewObservation;

@end
