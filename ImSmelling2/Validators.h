//
//  Validators.h
//  ImSmelling2
//
//  Created by Óscar Saboya Gómez on 27/05/14.
//  Copyright (c) 2014 OscarSaboya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validators : NSObject

+(BOOL) isValidEmail:(NSString *)checkString;
+(BOOL) isValidPass:(NSString *)checkString;

@end
