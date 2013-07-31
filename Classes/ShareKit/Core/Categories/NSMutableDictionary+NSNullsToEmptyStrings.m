//
//  NSMutableDictionary+NSNullsToEmptyStrings.m
//  ShareKit
//
//  Created by Vilem Kurz on 23.1.2012.
//  Copyright (c) 2012 Cocoa Miners. All rights reserved.
//

#import "NSMutableDictionary+NSNullsToEmptyStrings.h"

@implementation NSMutableDictionary (NSNullsToEmptyStrings)

- (void)convertNSNullsToEmptyStrings {
    
    NSArray *responseObjectKeys = [self allKeys];
    
    for (NSString *key in responseObjectKeys) {
        
        id object = [self objectForKey:key];        
        if (object == [NSNull null]) {
            [self removeObjectForKey:key];
        }
        else if ([object isKindOfClass:[NSMutableDictionary class]]) {
            [object convertNSNullsToEmptyStrings];
        }
        else if ([object isKindOfClass:[NSMutableArray class]]) {
            NSMutableArray *objsToRemove = [[NSMutableArray alloc] init];
            for (id obj in object) {
                if (obj == [NSNull null]) {
                    [objsToRemove addObject:obj];
                }
                else if ([obj isKindOfClass:[NSMutableDictionary class]]) {
                    [obj convertNSNullsToEmptyStrings];
                }
            }
            [object removeObjectsInArray:objsToRemove];
        }
    }
}

@end
