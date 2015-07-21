//
//  LetterStackView.m
//  Envoyer
//
//  Created by Zach Whelchel on 7/20/15.
//  Copyright (c) 2015 Napkn Apps. All rights reserved.
//

#import "LetterStackView.h"
#import "Helper.h"

const int SPACING_BETWEEN_LETTERS = 5;
const int MAX_LETTER_COUNT = 5;

@interface LetterStackView ()

@property (nonatomic, strong) NSMutableArray *letterViews;

@end

@implementation LetterStackView

- (NSMutableArray *)letterViews
{
    if (!_letterViews) {
        _letterViews = [NSMutableArray array];
    }
    return _letterViews;
}

- (void)setUpWithLetterCount:(int)letterCount
{
    for (UIView *letter in self.letterViews) {
        [letter removeFromSuperview];
    }
    self.letterViews = nil;
    
    self.clipsToBounds = NO;
    
    int firstLetterWidth = self.frame.size.width - 20;
    int firstLetterHeight = self.frame.size.height - 20 - ((MAX_LETTER_COUNT - 1) * SPACING_BETWEEN_LETTERS);
    float percentSmallerHiddenLetters = .0125;

    for (int i = 0; i < letterCount; i++) {
        
        float widthSmaller = (i * firstLetterWidth * percentSmallerHiddenLetters);
        float heightSmaller = (i * firstLetterWidth * percentSmallerHiddenLetters);

        UIView *letter = [[UIView alloc] initWithFrame:CGRectMake(10 + (widthSmaller / 2), 10 + heightSmaller + (SPACING_BETWEEN_LETTERS * i), firstLetterWidth - widthSmaller, firstLetterHeight - heightSmaller)];
        
        letter.backgroundColor = [UIColor colorWithWhite:.75 - (((i * 1.0) / letterCount) * .25) alpha:1.0];
        
        [self insertSubview:letter atIndex:0];
        
        //[self addSubview:letter];

        [self.letterViews addObject:letter];
    }
}

- (void)adjustLetterStackWithPercentageDownView:(float)percentageDownView
{
    if (percentageDownView > 1) {
        percentageDownView = 1;
    }
    else if (percentageDownView < 0) {
        percentageDownView = 0;
    }
    
    if (percentageDownView < .25) {
        percentageDownView = .25;
    }

    float lettersCount = (float)[self.letterViews count];

    int firstLetterWidth = self.frame.size.width - 20;
    int firstLetterHeight = self.frame.size.height - 20 - ((MAX_LETTER_COUNT - 1) * SPACING_BETWEEN_LETTERS);
    float percentSmallerHiddenLetters = .0125;
    float heightSmaller = ((lettersCount - 1) * firstLetterWidth * percentSmallerHiddenLetters);

    int lastLetterHeight = firstLetterHeight - heightSmaller;

    float maxMovement = (self.frame.size.height / 2) - ((self.frame.size.height - lastLetterHeight) / 2);
    maxMovement = 30;

    int i = 0;

    for (UIView *letter in self.letterViews) {
        
        float percentageMove = i / (lettersCount - 1);
        float heightSmaller = (i * firstLetterWidth * percentSmallerHiddenLetters);
        
        float movement = ((maxMovement * percentageMove) * percentageDownView);
        
        letter.center = CGPointMake(letter.center.x, self.center.y + 10 - (heightSmaller / 2) - movement);//);
        
        i++;
    }
}

@end
