//
//  APIEngine.m
//  ImSmelling2
//
//  Created by Óscar Saboya Gómez on 08/05/14.
//  Copyright (c) 2014 OscarSaboya. All rights reserved.
//

#import "APIEngine.h"
#import <AFNetworkActivityIndicatorManager.h>

static NSString * const APIEngineBaseURL = @"http://155.210.135.150:22105";

@implementation APIEngine

+ (instancetype)sharedInstance
{
    static APIEngine *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
    {
        
        // Network activity indicator manager setup
        [[AFNetworkActivityIndicatorManager sharedManager]  setEnabled:YES];
        
        
        // Session configuration setup
        NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024 // 10MB memory cache
                                                          diskCapacity:20 * 1024 * 1024 // 20MB on disk cache
                                                              diskPath:nil];
        
        sessionConfiguration.URLCache = cache;
//      sessionConfiguration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
        
        //Initialize the session
        _sharedInstance = [[APIEngine alloc] initWithBaseURL:[NSURL URLWithString:APIEngineBaseURL] sessionConfiguration:sessionConfiguration];
    });
    
    return _sharedInstance;
}

@end
