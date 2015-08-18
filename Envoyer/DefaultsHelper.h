//
//  DefaultsHelper.h
//  NoMoJo
//
//  Created by Zach Whelchel on 7/16/15.
//  Copyright (c) 2015 Napkn Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DefaultsHelper : NSObject

+ (NSString *)userHandle;
+ (void)setUserHandle:(NSString *)userHandle;

+ (BOOL)introShown;
+ (void)setIntroShown;

@end
