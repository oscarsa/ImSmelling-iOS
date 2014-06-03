//
//  API.h
//  ImSmelling2
//
//  Created by Óscar Saboya Gómez on 08/05/14.
//  Copyright (c) 2014 OscarSaboya. All rights reserved.
//

#import "AFHTTPSessionManager.h"


typedef void (^FetchObservationsCompletionBlock)(NSArray *observations, NSError *error);

@interface API : AFHTTPSessionManager

+ (instancetype)sharedInstance;


#pragma mark - Get observations
- (void)fetchObservationsOnCompletion:(FetchObservationsCompletionBlock)completionBlock;

@end
