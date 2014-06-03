//
//  NewObservationViewController.m
//  ImSmelling2
//
//  Created by Óscar Saboya Gómez on 24/04/14.
//  Copyright (c) 2014 OscarSaboya. All rights reserved.
//

#import "NewObservationViewController.h"


@interface NewObservationViewController ()



@end

@implementation NewObservationViewController


//Views
@synthesize Step1, Step2, Step3;

//ProgessViews
@synthesize ProgressView1, ProgressView2, ProgressView3;

//Pickers
@synthesize pckrOdourType;

//Sliders
@synthesize sldrOdourIntensity, sldrOdourDuration, sldrPleasantOdour, sldrCloud, sldrRain, sldrWind;

//Text Fields
@synthesize txtOtherOdour, txtOdourOrigin;

//Labels of sliders
@synthesize lblOdourIntensity, lblOdourDuration, lblPleasantOdour, lblCloud, lblRain, lblWind;

//Arrays for pickers
@synthesize odours;

//Buttons
@synthesize btnContinue1, btnContinue2, btnFinish3, btnBack2, btnBack3, hideBtnBack1;

//Progress bar values
float actualProgress1, actualProgress2, actualProgress3;

//Reference points
CGPoint originalCenter;

//Which is the visible view, 1, 2 or 3
int visibleView;


//For view animations (keyboard visible or hide)
NSTimeInterval animationDuration;
UIViewAnimationCurve animationCurve;
CGRect keyboardFrame;

NSDictionary *info;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Show Step 1, Hide Step 2 & 3
    [Step1 setHidden:NO];
    [Step2 setHidden:YES];
    [Step3 setHidden:YES];
    
    //Default Values of Progress Views
    ProgressView1.progress = 0.33;
    ProgressView2.progress = 0.33;
    ProgressView3.progress = 0.66;
    
    //Init Pickers with values,
    //depending on the language it choose a /Plists/*.plist or other,
    //defined in /SupportingFiles/Localizable.strings
    NSString *bundleOdourTypes = [[NSBundle mainBundle]pathForResource:NSLocalizedString(@"odourTypesLocalized", nil) ofType:@"plist"];

    odours = [[NSArray alloc]initWithContentsOfFile:bundleOdourTypes];
    
    //Default selected row in Pickers
    [self.pckrOdourType selectRow:2 inComponent:0 animated:NO];
    
    //Hide OtherOdour TextField
    [txtOtherOdour setHidden:YES];
    
    //Default view position, to edit when TextField is being edit
    originalCenter = [self.view center];
    
  
    //Check if keyboard is show to move up the view
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveUpView:) name:UIKeyboardWillShowNotification object:nil];
    
    //Check if keyboard is hide to move down the view
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveDownView:) name:UIKeyboardWillHideNotification object:nil];
    
    //Set default values of all components to store
    [self setDefaultValues];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//___________________________________________________________________________________________//

//Return the visible view
- (int) getVisibleView
{
    if (!Step1.isHidden)
    {
        return 1;
    }
    else if (!Step2.isHidden)
    {
        return 2;
    }
    else
    {
        return 3;
    }
}

//___________________________________________________________________________________________//

#pragma mark - Hide keyboard & Move View


//Hide keyboard when user press enter button in keyboard (of txtOtherOdour)
- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}


//Hide keyboard when background is pressed
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    visibleView = [self getVisibleView];
    
    switch (visibleView)
    {
        case 1://Step 1 view
            
            if ([txtOtherOdour isFirstResponder] && [touch view] != txtOtherOdour)
            {
                [txtOtherOdour resignFirstResponder];
            }
            break;
 
        case 2://Step 2 view
            
            if ([txtOdourOrigin isFirstResponder] && [touch view] != txtOdourOrigin)
            {
                [txtOdourOrigin resignFirstResponder];
            }
            break;

        default:
            break;
    }
    
    
    [super touchesBegan:touches withEvent:event];
}

//Create animation
- (void)animation
{
    [[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
}


- (void)moveUpView:(NSNotification *)notification
{
    
    info = [notification userInfo];
    
    [self animation];
    
    //Final position of the view
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - keyboardFrame.size.height + 49, self.view.frame.size.width, self.view.frame.size.height)];
    
    [UIView commitAnimations];
    


}

- (void)moveDownView:(NSNotification *)notification
{
    info = [notification userInfo];
    
    [self animation];
    
    //Final position of the view
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + keyboardFrame.size.height - 49, self.view.frame.size.width, self.view.frame.size.height)];
    
    [UIView commitAnimations];

}





//___________________________________________________________________________________________//


#pragma mark - Buttons that show & hide views


- (IBAction)btnToStep2:(id)sender
{
    
    //Set height and width of continue button frame
    CGRect buttonFrame = btnContinue2.frame;
    buttonFrame.size = CGSizeMake(320, 46);
    btnContinue2.frame = buttonFrame;
    
    //Set center position of the buttons where the animation will start
    CGPoint btnContinueCenter = CGPointMake(160, btnContinue2.center.y);
    CGPoint btnBackCenter = CGPointMake(-38.5, btnBack2.center.y);
    
    btnContinue2.center = btnContinueCenter;
    btnBack2.center = btnBackCenter;
    
    //Hide and show views
    [Step1 setHidden:YES];
    [Step2 setHidden:NO];
    [Step3 setHidden:YES];
    
    
    //Set default progressbar progress, and call to the method that animates the progress bar (toStep2)
    ProgressView2.progress = 0.33;
    [self performSelectorOnMainThread:@selector(toStep2) withObject:nil waitUntilDone:NO];
    
    //Call to the method that animates continue and back buttons
    [self moveButtonContinue];

    //Dismiss keyboard
    [self.view endEditing:YES];
}

- (IBAction)btnToStep3:(id)sender
{
    
    //Hide and show views
    [Step1 setHidden:YES];
    [Step2 setHidden:YES];
    [Step3 setHidden:NO];
    
    //Set default progressbar progress, and call to the method that animates the progress bar (toStep3)
    ProgressView3.progress = 0.66;
    [self performSelectorOnMainThread:@selector(toStep3) withObject:nil waitUntilDone:NO];
    
    //Dismiss keyboard
    [self.view endEditing:YES];
    
    //Save text of text fields
    [self saveTextFields];
}

- (IBAction)btnFinish:(id)sender
{
    //Print in the log all information about the new observation
    [self logNewObservation];
}

- (IBAction)btnBackTo1:(id)sender
{
    
    //Set height and width of continue button frame
    CGRect buttonFrame = btnContinue1.frame;
    buttonFrame.size = CGSizeMake(243, 46);
    btnContinue1.frame = buttonFrame;
    
    //Set center position of the buttons where the animation will start
    CGPoint btnContinueCenter = CGPointMake(198, btnContinue1.center.y);
    CGPoint btnBackCenter = CGPointMake(38.5, btnContinue1.center.y);
    
    btnContinue1.center = btnContinueCenter;
    hideBtnBack1.center = btnBackCenter;
    
    //Hide and show views
    [Step1 setHidden:NO];
    [Step2 setHidden:YES];
    [Step3 setHidden:YES];
    
    //Set default progressbar progress, and call to the method that animates the progress bar (backToStep1)
    ProgressView1.progress = 0.66;
    [self performSelectorOnMainThread:@selector(backToStep1) withObject:nil waitUntilDone:NO];
    
    //Call to the method that animates continue and back buttons
    [self moveButtonBack];
    
    //Dismiss keyboard
    [self.view endEditing:YES];
}

- (IBAction)btnBackTo2:(id)sender
{
    
    //Hide and show views
    [Step1 setHidden:YES];
    [Step2 setHidden:NO];
    [Step3 setHidden:YES];
    
    //Set default progressbar progress, and call to the method that animates the progress bar (backToStep2)
    ProgressView2.progress = 1;
    [self performSelectorOnMainThread:@selector(backToStep2) withObject:nil waitUntilDone:NO];
    
    //Dismiss keyboard
    [self.view endEditing:YES];
}


//___________________________________________________________________________________________//


#pragma mark - Progess Bars

//Move Back Progress Bar 1 (View 1)
- (void) backToStep1
{
    actualProgress1 = [ProgressView1 progress];

    
    if(actualProgress1 >0.33)
    {
        ProgressView1.progress = actualProgress1 - 0.01;
        [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(backToStep1) userInfo:nil repeats:NO];
    }

}

//Move Back Progress Bar 2 (View 2)
- (void) backToStep2
{
    actualProgress2 = [ProgressView2 progress];
    
    
    if(actualProgress2 >0.66)
    {
        ProgressView2.progress = actualProgress2 - 0.01;
        [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(backToStep2) userInfo:nil repeats:NO];
    }
    
    
    
}

//Move Progress Bar 2 (View 2)
-(void) toStep2
{
    actualProgress2 = [ProgressView2 progress];

    if(actualProgress2 <=0.66)
    {
        ProgressView2.progress = actualProgress2 + 0.01;
        [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(toStep2) userInfo:nil repeats:NO];
    }

    
}

//Move Progress Bar 3 (View 3)
-(void) toStep3
{
    actualProgress3 = [ProgressView3 progress];
    
    if(actualProgress3 <=1)
    {
        ProgressView3.progress = actualProgress3 + 0.01;
        [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(toStep3) userInfo:nil repeats:NO];
    }
}


//___________________________________________________________________________________________//


#pragma mark - UIPickerView Datasource & Delegate Methods

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
        return [odours count];
}



- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = odours[row];
    
    //Attributed String used instead of String to change the text colour to white
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //Action when one row is selected
    
    if([self.pckrOdourType selectedRowInComponent:0] == 4 )
    {
        //Show 'Other Odour' text field
        [txtOtherOdour setHidden:NO];
    }
    else
    {
        //Hide 'Other Odour' text field
        [txtOtherOdour setHidden:YES];
        
        //Hide keyboard
        [txtOtherOdour resignFirstResponder];
        
    }
    
    //Save the number of the selected row
    odourType = [self.pckrOdourType selectedRowInComponent:0];
    
}




//___________________________________________________________________________________________//


#pragma mark - Slider Methods

- (IBAction)sliderChanged:(id)sender
{
    
//Odour Intensity
    
    if (sender == sldrOdourIntensity)
    {
        if (sldrOdourIntensity.value<0.17)
        {
            //Store value 1
            self.lblOdourIntensity.text = NSLocalizedString(@"VERY_FAINT_ODOUR", nil);
            odourIntensity =1;
        }
        else if (sldrOdourIntensity.value<0.34)
        {
            //Store value 2
           self.lblOdourIntensity.text = NSLocalizedString(@"FAINT_ODOUR", nil);
            odourIntensity =2;
        }
        else if (sldrOdourIntensity.value<0.5)
        {
            //Store value 3
            self.lblOdourIntensity.text = NSLocalizedString(@"MODERATE_ODOUR", nil);
            odourIntensity =3;
        }
        else if (sldrOdourIntensity.value<0.67)
        {
            //Store value 4
            self.lblOdourIntensity.text = NSLocalizedString(@"STRONG_ODOUR", nil);
            odourIntensity =4;
        }
        else if (sldrOdourIntensity.value<0.84)
        {
            //Store value 5
            self.lblOdourIntensity.text = NSLocalizedString(@"VERY_STRONG_ODOUR", nil);
            odourIntensity =5;
        }
        else
        {
            //Store value 6
            self.lblOdourIntensity.text = NSLocalizedString(@"FORTISSIMO_ODOUR", nil);
            odourIntensity =6;
        }

    }
    
//Odour Duration
    
    else if (sender == sldrOdourDuration)
    {
        if (sldrOdourDuration.value<0.34)
        {
            self.lblOdourDuration.text = NSLocalizedString(@"LESS_1_MINUTE", nil);
            
            //Store value 0
            odourDuration = 0;
            
        }
        else if (sldrOdourDuration.value<0.67)
        {
            self.lblOdourDuration.text = NSLocalizedString(@"BETWEEN_1_AND_10_MINUTES", nil);
            
            //Store value 1
            odourDuration = 1;
        }
        else
        {
            self.lblOdourDuration.text = NSLocalizedString(@"MORE_10_MINUTES", nil);
            
            //Store value 2
            odourDuration = 2;
        }

    }
    
//Pleasant Odour
    
    else if (sender == sldrPleasantOdour)
    {
        if (sldrPleasantOdour.value<0.21)
        {
            //Pleasant -4 & -3
            if (sldrPleasantOdour.value<0.11)
            {
                //Store value -4
                pleasantOdour = -4;
            }
            else
            {
                //Store value -3
                pleasantOdour = -3;
            }
            
            self.lblPleasantOdour.text = NSLocalizedString(@"INSUPPORTABLE_ODOUR", nil);
        
        }
        else if (sldrPleasantOdour.value<0.41)
        {
            //Pleasant -2 & -1
            if (sldrPleasantOdour.value<0.31)
            {
                //Store value -2
                pleasantOdour = -2;
            }
            else
            {
                //Store value -1
                pleasantOdour = -1;
            }
            
            self.lblPleasantOdour.text = NSLocalizedString(@"VERY_BAD_ODOUR", nil);
        }
        else if (sldrPleasantOdour.value<0.61)
        {
            //Pleasant 0
            
            //Store value 0
            self.lblPleasantOdour.text = NSLocalizedString(@"ANNOYING_ODOUR", nil);
            
            pleasantOdour = 0;
            
        }
        else if (sldrPleasantOdour.value<0.81)
        {
            //Pleasant 1 & 2
            if (sldrPleasantOdour.value<0.71)
            {
                //Store value 1
                pleasantOdour = 1;
            }
            else
            {
                //Store value 2
                pleasantOdour = 2;
            }
            self.lblPleasantOdour.text = NSLocalizedString(@"GOOD_ODOUR", nil);
        }
        else
        {
            //Pleasant 3 & 4
            if (sldrPleasantOdour.value<0.91)
            {
                //Store value 3
                pleasantOdour = 3;
            }
            else
            {
                //Store value 4
                pleasantOdour = 4;
            }
            self.lblPleasantOdour.text = NSLocalizedString(@"WONDERFUL_ODOUR", nil);
        }
    }
    
//Weather - Cloud
    
    else if (sender == sldrCloud)
    {
        if (sldrCloud.value<0.21)
        {
            //Clouds 0 & 1
            if (sldrCloud.value<0.11)
            {
                //Store value 0
                clouds = 0;
            }
            else
            {
                //Store value 1
                clouds = 1;
            }
            
            self.lblCloud.text = NSLocalizedString(@"SUNNY", nil);
            
        }
        else if (sldrCloud.value<0.41)
        {
            //Clouds 2 & 3
            if (sldrCloud.value<0.31)
            {
                //Store value 2
                clouds = 2;
            }
            else
            {
                //Store value 3
                clouds = 3;
            }
            
            self.lblCloud.text = NSLocalizedString(@"VERY_FEW_CLOUDS", nil);
        }
        else if (sldrCloud.value<0.61)
        {
            //Clouds 4
            
            //Store value 4
            self.lblCloud.text = NSLocalizedString(@"SLIGHTLY_CLOUDY", nil);
            
            clouds = 4;
        }
        else if (sldrCloud.value<0.81)
        {
            //Clouds 5 & 6
            if (sldrPleasantOdour.value<0.71)
            {
                //Store value 5
                clouds = 5;
            }
            else
            {
                //Store value 6
                clouds = 6;
            }
            self.lblCloud.text = NSLocalizedString(@"VERY_CLOUDY", nil);
        }
        else
        {
            //Clouds 7 & 8
            if (sldrCloud.value<0.91)
            {
                //Store value 7
                clouds = 7;
            }
            else
            {
                //Store value 8
                clouds = 8;
            }
            self.lblCloud.text = NSLocalizedString(@"COMPLETELY_CLOUDY", nil);
        }
    }
    
//Weather - Rain
    
    else if (sender == sldrRain)
    {
        if (sldrRain.value<0.17)
        {
            //Store value 0
            self.lblRain.text = NSLocalizedString(@"RAINLESS", nil);
            rain = 0;
        }
        else if (sldrRain.value<0.34)
        {
            //Store value 1
            self.lblRain.text = NSLocalizedString(@"FOGGY", nil);
            rain = 1;
        }
        else if (sldrRain.value<0.51)
        {
            //Store value 2
            self.lblRain.text = NSLocalizedString(@"DRIZZLE", nil);
            rain = 2;
        }
        else if (sldrRain.value<0.67)
        {
            //Store value 3
            self.lblRain.text = NSLocalizedString(@"RAIN", nil);
            rain = 3;
        }
        else if (sldrRain.value<0.84)
        {
            //Store value 4
            self.lblRain.text = NSLocalizedString(@"HEAVY_RAIN", nil);
            rain = 4;
        }
        else
        {
            //Store value 5
            self.lblRain.text = NSLocalizedString(@"HUGE_DOWNPOUR", nil);
            rain = 5;
        }
    }
    
//Weather - Wind

    else if (sender == sldrWind)
    {
        if (sldrWind.value<0.21)
        {
            //Store value 0
            self.lblWind.text = NSLocalizedString(@"WINDLESS", nil);
            wind = 0;
            
        }
        else if (sldrWind.value<0.41)
        {
            //Store value 1
            self.lblWind.text = NSLocalizedString(@"BREEZE", nil);
            wind = 1;
        }
        else if (sldrWind.value<0.61)
        {
            //Store value 2
            self.lblWind.text = NSLocalizedString(@"MODERATE_WIND", nil);
            wind = 2;
        }
        else if (sldrWind.value<0.81)
        {
            //Store value 3
            self.lblWind.text = NSLocalizedString(@"STRONG_WIND", nil);
            wind = 3;
        }
        else
        {
            //Store value 4
            self.lblWind.text = NSLocalizedString(@"GALE", nil);
            wind = 4;
        }

    }
 
    
}

//___________________________________________________________________________________________//

#pragma mark - Buttons animations

//Move to the next view / Buttons movement
- (void) moveButtonContinue
{
    //New center of the buttons
    CGPoint newContinueCenter = CGPointMake(198, btnContinue2.center.y);
    CGPoint newBackCenter = CGPointMake( 38.5, btnBack2.center.y);
    
    //Animation
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    btnBack2.center = newBackCenter;
    btnContinue2.center = newContinueCenter;
    [UIView commitAnimations];

    
}

//Move to the previous view / Buttons movement
- (void) moveButtonBack
{
    //New center of the buttons
    CGPoint newContinueCenter = CGPointMake(160, btnContinue1.center.y);
    CGPoint newBackCenter = CGPointMake( -38.5, hideBtnBack1.center.y);
    
    //Animation
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    hideBtnBack1.center = newBackCenter;
    btnContinue1.center = newContinueCenter;
    [UIView commitAnimations];
    
    
}


//___________________________________________________________________________________________//

//Change status bar colour to white
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//___________________________________________________________________________________________//

#pragma mark - Store all observation data


//Step 1
int odourType;
NSString *otherOdourType;
int odourIntensity;

//Step 2
int odourDuration;
int pleasantOdour;
NSString *odourComesFrom;

//Step 3
int clouds;
int rain;
int wind;

- (void) setDefaultValues
{
    //Step 1
    odourType = 2;
    otherOdourType = @"";
    odourIntensity = 3;
    
    //Step 2
    odourDuration = 1;
    pleasantOdour = 0;
    odourComesFrom = @"";
    
    //Step 3
    clouds = 4;
    rain = 2;
    wind = 2;
}

- (void) saveTextFields
{
    otherOdourType = [txtOtherOdour text];
    odourComesFrom = [txtOdourOrigin text];
}

- (void) logNewObservation
{
    NSLog(@"-------------------------");
    NSLog(@"     NEW OBSERVATION     ");
    NSLog(@"-------------------------");

    
    NSLog(@"Odour Type: %i", odourType);
    
    if (odourType == 4)
    {
        NSLog(@"Other Odour Type: %@", otherOdourType);
    }
   
    NSLog(@"Odour Intensity: %i", odourIntensity);
    
    NSLog(@"Pleasant Odour: %i", pleasantOdour);
    
    NSLog(@"Odour Comes From: %@", odourComesFrom);
    
    NSLog(@"Odour Duration: %i", odourDuration);
    
    NSLog(@"Clouds: %i", clouds);
    
    NSLog(@"Rain: %i", rain);
    
    NSLog(@"Wind: %i", wind);
}


@end






















