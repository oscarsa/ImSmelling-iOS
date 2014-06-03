//
//  FirstRegisterViewController.m
//  ImSmelling2
//
//  Created by Óscar Saboya Gómez on 11/04/14.
//  Copyright (c) 2014 OscarSaboya. All rights reserved.
//

#import "FirstRegisterViewController.h"
#import "Validators.h"
#import "RegisterViewController.h"

@interface FirstRegisterViewController ()

@end

@implementation FirstRegisterViewController

@synthesize txtUser, txtEmail, txtPass, txtCheckPass;

@synthesize btnContinue;

@synthesize rightMarkEmail, wrongMarkEmail;
@synthesize rightMarkPass, wrongMarkPass;
@synthesize rightMarkCheckPass, wrongMarkCheckPass;




//For view animations (keyboard visible or hide)
NSTimeInterval animationDuration;
UIViewAnimationCurve animationCurve;
CGRect keyboardFrame;

NSDictionary *info;


//Reference points
CGPoint originalCenter;

@synthesize viewFirstRegister;




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
    
    //Default view position, to edit when TextField is being edit
    originalCenter = [viewFirstRegister center];
    
    //Set default values of text fields to store
    [self setDefaultValues];
    
    //Check if keyboard is show to move up the view
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveUpView:) name:UIKeyboardWillShowNotification object:nil];
    
    //Check if keyboard is hide to move down the view
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveDownView:) name:UIKeyboardWillHideNotification object:nil];
    
    //Check if a text field begin editing
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moveUpView:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    
    
    
    //Button corner radius
    btnContinue.layer.cornerRadius = 22;
    
    
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


//Change status bar colour to white
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


//___________________________________________________________________________________________//

#pragma mark - Hide keyboard & Move View


//Hide keyboard when user press enter button in keyboard
- (IBAction)textFieldReturn:(id)sender
{
    //If user select first txtField & press Next, the next txtField is selected
    //If the txtField selected is the last one, it hide the keyboard
    if(sender == txtUser)
    {
        [txtEmail becomeFirstResponder];
    }
    else if(sender == txtEmail)
    {
        [txtPass becomeFirstResponder];
    }
    else if (sender == txtPass)
    {
        [txtCheckPass becomeFirstResponder];
    }
    else if (sender == txtCheckPass)
    {
        [sender resignFirstResponder];
       // [self moveDownView]; ****************************************************************
    }
    

}


//Hide keyboard when background is pressed
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];


    if ([txtUser isFirstResponder] && [touch view] != txtUser)
    {
        [txtUser resignFirstResponder];
    }

            
    if ([txtEmail isFirstResponder] && [touch view] != txtEmail)
    {
        [txtEmail resignFirstResponder];
    }
    
    if ([txtPass isFirstResponder] && [touch view] != txtPass)
    {
        [txtPass resignFirstResponder];
    }
    
    if ([txtCheckPass isFirstResponder] && [touch view] != txtCheckPass)
    {
        [txtCheckPass resignFirstResponder];
    }
    
    
}

//Return false if view is up, true if it is in its original position
- (BOOL) isViewInOriginalCenter
{
    if(CGPointEqualToPoint(originalCenter, viewFirstRegister.center))
    {
        return true;
    }
    else
    {
        return false;
    }
}

/***********************************************************************
- (void) moveUpView
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.20];
    
     viewFirstRegister.center = CGPointMake(viewFirstRegister.center.x, viewFirstRegister.center.y-65);
    
    [UIView commitAnimations];
}


- (void) moveDownView
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.20];
    
    
    viewFirstRegister.center = CGPointMake(originalCenter.x, originalCenter.y);
    
    
    [UIView commitAnimations];
}
************************************************************************/

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
    
    if (([txtPass isFirstResponder] || [txtCheckPass isFirstResponder]) && [self isViewInOriginalCenter])
    {
        [self animation];
        
        //Final position of the view
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - keyboardFrame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
        
        [UIView commitAnimations];
    }
    
  
    
}

- (void)moveDownView:(NSNotification *)notification
{
    info = [notification userInfo];
    
    [self animation];
    
    if (![self isViewInOriginalCenter])
    {
        //Final position of the view
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + keyboardFrame.size.height , self.view.frame.size.width, self.view.frame.size.height)];
        
        [UIView commitAnimations];
    }
    

    
}

//___________________________________________________________________________________________//

#pragma mark - Store all observation data

NSString *user;
NSString *email;
NSString *pass;

- (void) setDefaultValues
{
    user = @"";
    email = @"";
    pass = @"";
}

- (void) saveTextFields
{
    user = [txtUser text];
    email = [txtEmail text];
    pass = [txtPass text];

}

- (void) log1stepRegister
{
    NSLog(@"-------------------------");
    NSLog(@"     1ºSTEP REGISTER     ");
    NSLog(@"-------------------------");
    
    NSLog(@"User: %@", user);
    
    NSLog(@"Email: %@", email);
    
    NSLog(@"Pass: %@", pass);
    
 }


//___________________________________________________________________________________________//



- (IBAction)btnContRegister:(id)sender
{
    
    [self saveTextFields];
    
    if ([self checkEmail:email] == FALSE || [self checkPass:pass] == FALSE || ![txtPass.text isEqualToString:txtCheckPass.text])
    {
        //EMAIL
        if ([self checkEmail:email] == FALSE)
        {
            [rightMarkEmail setHidden:TRUE];
            [wrongMarkEmail setHidden:FALSE];
        }
        else
        {
            [rightMarkEmail setHidden:FALSE];
            [wrongMarkEmail setHidden:TRUE];
        }
        
        //PASSWORD
        if ([self checkPass:pass] == FALSE)
        {
            [rightMarkPass setHidden:TRUE];
            [wrongMarkPass setHidden:FALSE];
            [wrongMarkCheckPass setHidden:FALSE];
        }
        else
        {
            [rightMarkPass setHidden:FALSE];
            [wrongMarkPass setHidden:TRUE];
        
            //CHECK PASSWORD
            if (![txtPass.text isEqualToString:txtCheckPass.text])
            {
                [rightMarkCheckPass setHidden:TRUE];
                [wrongMarkCheckPass setHidden:FALSE];
            }
            else
            {
                [rightMarkCheckPass setHidden:FALSE];
                [wrongMarkCheckPass setHidden:TRUE];
            }
        }
    }
    else
    {
        [rightMarkEmail setHidden:FALSE];
        [wrongMarkEmail setHidden:TRUE];
        
        [rightMarkPass setHidden:FALSE];
        [wrongMarkPass setHidden:TRUE];
        
        [rightMarkCheckPass setHidden:FALSE];
        [wrongMarkCheckPass setHidden:TRUE];
        
        [self log1stepRegister];
        
        
        //Change to 2ºStep register view controller
        //If we want to go to the 2ºStep view controller only when textfields are correct,
        //we can't use segue in the storyboard, it shoud be done programmatically
        NSString *storyboardName = @"Main_iPhone";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
        [self presentViewController:vc animated:NO completion:nil];
        
        
    }
     
}

//___________________________________________________________________________________________//
#pragma mark - Validate fields

- (BOOL)checkEmail:(NSString *)email
{
    BOOL validEmail = [Validators isValidEmail:email];
    NSLog(@"¿Email OK?: %d",validEmail);
    
    return validEmail;
}

- (BOOL)checkPass:(NSString *)pass
{
    BOOL validPass = [Validators isValidPass:pass];
    NSLog(@"¿Pass OK?: %d",validPass);
    
    return validPass;
}

@end
