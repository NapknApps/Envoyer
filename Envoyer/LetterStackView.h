//
//  LetterStackView.h
//  Envoyer
//
//  Created by Zach Whelchel on 7/20/15.
//  Copyright (c) 2015 Napkn Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LetterStackView : UIView

- (void)setUpWithLetterCount:(int)letterCount;
- (void)adjustLetterStackWithPercentageDownView:(float)percentageDownView;
- (void)animateOpeningThreadWithLetterHeight:(int)letterHeight;

@end
