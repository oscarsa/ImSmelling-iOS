//
//  SPOObservsAPIEngine.m
//  ImSmelling2
//
//  Created by Óscar Saboya Gómez on 05/06/14.
//  Copyright (c) 2014 OscarSaboya. All rights reserved.
//

#import "SPOObservsAPIEngine.h"
#import "AFNetworkActivityIndicatorManager.h"


static NSString * const SPOObservsAPIEngineBaseURL = @"http://odour.ibercivis.es/common/";


@implementation SPOObservsAPIEngine


+ (instancetype)sharedInstance {
    static SPOObservsAPIEngine *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Network activity indicator manager setup
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        
        // Session configuration setup
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:5 * 1024 * 1024     // 5MB memory cache
                                                          diskCapacity:20 * 1024 * 1024     // 20MB on disk cache
                                                              diskPath:nil];
        
        sessionConfiguration.URLCache = cache;
        
        // Initialize the session
        _sharedInstance = [[SPOObservsAPIEngine alloc] initWithBaseURL:[NSURL URLWithString:SPOObservsAPIEngineBaseURL] sessionConfiguration:sessionConfiguration];
    });
    
    return _sharedInstance;
}

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    if (!self) return nil;
    
    // Configuraciones adicionales de la sesión
    
    return self;
}


#pragma mark - Get observations
- (void)fetchObservsOnCompletion:(FetchObservsCompletionBlock)completionBlock
{
    NSString *path = @"list_places";
    
    [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
    {
        NSMutableArray *observations = [[NSMutableArray alloc] initWithCapacity:[responseObject count]];
        for (NSDictionary *JSONobservationData in responseObject)
        {
/*
I don't know how to use and import MTLJSONAdapter
AFNetworking2 Information:
 http://www.migueldiazrubio.com/2013/10/21/desarrollo-ios-7-introduccion-afnetworking-2/
 http://www.raywenderlich.com/59255/afnetworking-2-0-tutorial
 http://cocoadocs.org/docsets/AFNetworking/2.2.4/
            

            SPOObservsAPIEngine *observ = [MTLJSONAdapter modelOfClass:[SPObserv class] fromJSONDictionary:JSONobservationData error:nil];
            if (observ) [observations addObject:observ];
*/
        }
        
        completionBlock(observations, nil);
    }
      failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        completionBlock(nil, error);
    }];
}


@end
