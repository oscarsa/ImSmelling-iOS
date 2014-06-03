//
//  APIEngine.h
//  ImSmelling2
//
//  Created by Óscar Saboya Gómez on 08/05/14.
//  Copyright (c) 2014 OscarSaboya. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface APIEngine : AFHTTPSessionManager

+ (instancetype)sharedInstance;

@end
