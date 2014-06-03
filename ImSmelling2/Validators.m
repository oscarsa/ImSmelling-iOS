//
//  Validators.m
//  ImSmelling2
//
//  Created by Óscar Saboya Gómez on 27/05/14.
//  Copyright (c) 2014 OscarSaboya. All rights reserved.
//

#import "Validators.h"

@implementation Validators

// Validate email, discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
+(BOOL) isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

// Validate password length, 6 characters
+(BOOL) isValidPass:(NSString *)checkString
{
    if (checkString.length >5)
        return TRUE;
    else
        return FALSE;
}


@end
