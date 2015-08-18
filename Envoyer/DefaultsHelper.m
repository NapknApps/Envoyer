//
//  DefaultsHelper.m
//  NoMoJo
//
//  Created by Zach Whelchel on 7/16/15.
//  Copyright (c) 2015 Napkn Apps. All rights reserved.
//

#import "DefaultsHelper.h"

#define kUserHandle @"kUserHandle"
#define kIntroShown @"kIntroShown"

@implementation DefaultsHelper

+ (NSString *)userHandle
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserHandle];
}

+ (void)setUserHandle:(NSString *)userHandle
{
    [[NSUserDefaults standardUserDefaults] setObject:userHandle forKey:kUserHandle];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)introShown
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIntroShown];
}

+ (void)setIntroShown
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIntroShown];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
