//
//  LetterStackView.h
//  Envoyer
//
//  Created by Zach Whelchel on 7/20/15.
//  Copyright (c) 2015 Napkn Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Letter.h"

@class LetterStackView;

@protocol LetterStackViewDelegate

@required

- (void)letterStackViewDidCloseThread:(LetterStackView *)letterStackView;
- (void)letterStackViewDidCloseThread:(LetterStackView *)letterStackView withTwitterNameToSendTo:(NSString *)twitterNameToSendTo;

@end

@protocol LetterStackViewDataSource

@required

- (Letter *)letterForIndex:(int)index forLetterStackView:(LetterStackView *)letterStackView;
- (int)letterCountForLetterStackView:(LetterStackView *)letterStackView;

@end


@interface LetterStackView : UIView

@property (nonatomic, weak) id <LetterStackViewDelegate> delegate;
@property (nonatomic, weak) id <LetterStackViewDataSource> dataSource;

- (void)setUpWithLetterCount:(int)letterCount;
- (void)adjustLetterStackWithPercentageDownView:(float)percentageDownView;
- (void)animateOpeningThread;

@end
