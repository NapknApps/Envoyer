//
//  Letter.m
//  Envoyer
//
//  Created by Zach Whelchel on 7/21/15.
//  Copyright (c) 2015 Napkn Apps. All rights reserved.
//

#import "Letter.h"

@implementation Letter

@synthesize content = _content;
@synthesize receiver = _receiver;
@synthesize sender = _sender;
@synthesize senderUID = _senderUID;
@synthesize receiveDate = _receiveDate;
@synthesize fbID = _fbID;

- (id)initWithContent:(NSString *)content receiver:(NSString *)receiver sender:(NSString *)sender senderUID:(NSString *)senderUID receiveDate:(NSNumber *)receiveDate fbID:(NSString *)fbID origionalReceiveDate:(NSNumber *)origionalReceiveDate;
{
    self = [super init];
    if (self) {
        self.content = content;
        self.receiver = receiver;
        self.sender = sender;
        self.senderUID = senderUID;
        self.receiveDate = receiveDate;
        self.fbID = fbID;
        self.origionalReceiveDate = origionalReceiveDate;
    }
    return self;
}

@end
