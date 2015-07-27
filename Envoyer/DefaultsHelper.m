//
//  DefaultsHelper.m
//  NoMoJo
//
//  Created by Zach Whelchel on 7/16/15.
//  Copyright (c) 2015 Napkn Apps. All rights reserved.
//

#import "DefaultsHelper.h"

#define kUserTwitterHandle @"kUserTwitterHandle"
#define kIntroShown @"kIntroShown"

@implementation DefaultsHelper

+ (NSString *)userTwitterHandle
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserTwitterHandle];
}

+ (void)setUserTwitterHandle:(NSString *)userTwitterHandle
{
    [[NSUserDefaults standardUserDefaults] setObject:userTwitterHandle forKey:kUserTwitterHandle];
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
