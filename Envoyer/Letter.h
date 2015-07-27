//
//  Letter.h
//  Envoyer
//
//  Created by Zach Whelchel on 7/21/15.
//  Copyright (c) 2015 Napkn Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Letter : NSObject

@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *receiver;
@property (nonatomic, retain) NSString *sender;
@property (nonatomic, retain) NSString *senderUID;
@property (nonatomic, retain) NSNumber *receiveDate;
@property (nonatomic, retain) NSString *fbID;
@property (nonatomic, retain) NSNumber *origionalReceiveDate;

- (id)initWithContent:(NSString *)content receiver:(NSString *)receiver sender:(NSString *)sender senderUID:(NSString *)senderUID receiveDate:(NSNumber *)receiveDate fbID:(NSString *)fbID origionalReceiveDate:(NSNumber *)origionalReceiveDate;

@end
