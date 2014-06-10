//
//  SPOObservsAPIEngine.h
//  ImSmelling2
//
//  Created by Óscar Saboya Gómez on 05/06/14.
//  Copyright (c) 2014 OscarSaboya. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void (^FetchObservsCompletionBlock)(NSArray *notes, NSError *error);

@interface SPOObservsAPIEngine : AFHTTPSessionManager

+ (instancetype)sharedInstance;


#pragma mark - Obtención de notas
- (void)fetchObservsOnCompletion:(FetchObservsCompletionBlock)completionBlock;


@end

#import "SPOObservsAPIEngine.h"