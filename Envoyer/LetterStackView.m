//
//  LetterStackView.m
//  Envoyer
//
//  Created by Zach Whelchel on 7/20/15.
//  Copyright (c) 2015 Napkn Apps. All rights reserved.
//

#import "LetterStackView.h"
#import "LetterView.h"
#import "Helper.h"
#import "DefaultsHelper.h"

const int SPACING_BETWEEN_LETTERS = 5;
const int MAX_LETTER_COUNT = 5;

@interface LetterStackView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *letterViews;

@property (nonatomic, strong) NSMutableArray *extraLetterViews;


@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSNumber *percentageDownView;

@end

@implementation LetterStackView

@synthesize delegate = _delegate;
@synthesize dataSource = _dataSource;
@synthesize percentageDownView = _percentageDownView;
@synthesize letterViews = _letterViews;
@synthesize extraLetterViews = _extraLetterViews;

- (NSMutableArray *)letterViews
{
    if (!_letterViews) {
        _letterViews = [NSMutableArray array];
    }
    return _letterViews;
}

- (NSMutableArray *)extraLetterViews
{
    if (!_extraLetterViews) {
        _extraLetterViews = [NSMutableArray array];
    }
    return _extraLetterViews;
}

- (void)setUpWithLetterCount:(int)letterCount
{
    if (letterCount > MAX_LETTER_COUNT) {
        letterCount = MAX_LETTER_COUNT;
    }
    
    for (LetterView *letterView in self.letterViews) {
        [letterView removeFromSuperview];
    }
    self.letterViews = nil;
    
    self.clipsToBounds = NO;
    self.backgroundColor = [UIColor clearColor];

    int firstLetterWidth = self.frame.size.width - 20;
    int firstLetterHeight = self.frame.size.height - 20 - ((MAX_LETTER_COUNT - 1) * SPACING_BETWEEN_LETTERS);
    float percentSmallerHiddenLetters = .0125;

    for (int i = 0; i < letterCount; i++) {
        
        float widthSmaller = (i * firstLetterWidth * percentSmallerHiddenLetters);
        float heightSmaller = (i * firstLetterWidth * percentSmallerHiddenLetters);
        
        LetterView *letterView = [[LetterView alloc] initWithFrame:CGRectMake(10 + (widthSmaller / 2), 10 + heightSmaller + (SPACING_BETWEEN_LETTERS * i), firstLetterWidth - widthSmaller, firstLetterHeight - heightSmaller)];
        
        letterView.backgroundColor = [UIColor colorWithWhite:.9 - (((i * 1.0) / letterCount) * .25) alpha:1.0];
        
//        letterView.layer.shadowColor = [[UIColor blackColor] CGColor];
//        letterView.layer.shadowOffset = CGSizeMake(1, 1);
//        letterView.layer.shadowOpacity = .4;
        
        Letter *letter = [self.dataSource letterForIndex:i forLetterStackView:self];
        [letterView showFrontWithFromContent:[NSString stringWithFormat:@"From: %@", letter.sender] animated:NO];
        
        [self insertSubview:letterView atIndex:0];
        [self.letterViews addObject:letterView];
    }
}

- (float)firstLetterWidth
{
    return self.frame.size.width - 20;
}

- (float)firstLetterHeight
{
    return self.frame.size.height - 20 - ((MAX_LETTER_COUNT - 1) * SPACING_BETWEEN_LETTERS);
}

- (float)percentSmallerHiddenLetters
{
    return .0125;
}

- (int)lettersCount
{
    return (int)[self.letterViews count];
}

- (float)heightSmaller
{
    return (([self lettersCount] - 1.0) * [self firstLetterWidth] * [self percentSmallerHiddenLetters]);
}

- (float)maxMovement
{
    return 30;
}

- (int)lastLetterHeight
{
    return [self firstLetterHeight] - [self heightSmaller];
}

- (CGPoint)centerForLetterAtIndex:(int)index withPercentageDownView:(float)percentageDownView
{
    float percentageMove = index / (MAX_LETTER_COUNT - 1.0);

    float heightSmaller = (index * [self firstLetterWidth] * [self percentSmallerHiddenLetters]);
    
    float movement = (([self maxMovement] * percentageMove) * percentageDownView);
    
    return CGPointMake(self.center.x, (self.frame.size.height / 2) + 10 - (heightSmaller / 2) - movement);
}

- (void)adjustLetterStackWithPercentageDownView:(float)percentageDownView
{
    if (percentageDownView > 1) {
        percentageDownView = 1;
    }
    else if (percentageDownView < .25) {
        percentageDownView = .25;
    }
    
    self.percentageDownView = [NSNumber numberWithFloat:percentageDownView];

    int i = 0;

    for (LetterView *letterView in self.letterViews) {
        
        letterView.center = [self centerForLetterAtIndex:i withPercentageDownView:percentageDownView];
        
        i++;
    }
}

- (void)animateOpeningThread
{
    
    int i = 0;
    for (LetterView *letterView in self.letterViews) {
        letterView.clipsToBounds = YES;
        Letter *letter = [self.dataSource letterForIndex:i forLetterStackView:self];
        [letterView showBackWithContent:letter.content animated:NO];
        i++;
    }
    
    [UIView animateWithDuration:0.7 delay:.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        int i = 0;
        int totalLetterHeight = 0;

        for (LetterView *letterView in self.letterViews) {
            
            Letter *letter = [self.dataSource letterForIndex:i forLetterStackView:self];
            float letterHeight = [letterView heightForLetterForContent:letter.content];
            
            letterView.frame = CGRectMake(10, self.frame.size.height - letterHeight - 10 - totalLetterHeight - 60, [self firstLetterWidth], letterHeight);
            
            letterView.backgroundColor = [UIColor colorWithWhite:.9 alpha:1.0];

            
            i++;
            totalLetterHeight+=letterHeight + 10;
        }
        
    } completion:^(BOOL finished) {
        
        self.frame = self.superview.frame;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        self.scrollView.backgroundColor = [UIColor clearColor];
        self.scrollView.delegate = self;
        self.scrollView.alwaysBounceVertical = YES;
        
        [self addSubview:self.scrollView];
        
        
        
        int totalHeight = 0;

        int extraLettersCount = [self.dataSource letterCountForLetterStackView:self] - [self.letterViews count];
        
        self.extraLetterViews = nil;

        int j = 0;
        if (extraLettersCount > 0) {
            
            
            Letter *letter = [self.dataSource letterForIndex:j + MAX_LETTER_COUNT forLetterStackView:self];
            
            
            
            
            LetterView *letterView = [[LetterView alloc] initWithFrame:CGRectMake(10, 22 + 10 + totalHeight - 60, [self firstLetterWidth], 10000)];
            
            // fix weird resizing issue

            
            [self.scrollView addSubview:letterView];

            [letterView showFrontWithFromContent:[NSString stringWithFormat:@"From: %@", letter.sender] animated:NO];
            [letterView showBackWithContent:letter.content animated:NO];

            // fix weird resizing issue
            //letterView.contentTextView.frame = CGRectMake(12, 50, self.frame.size.width - 44, 0);

            float letterHeight = [letterView heightForLetterForContent:letter.content];
//
            // fix weird resizing issue
            letterView.frame = CGRectMake(10, 22 + 10 + totalHeight, [self firstLetterWidth], letterHeight);
            

            
//            letterView.contentTextView.center = CGPointMake(letterView.center.x, letterView.contentTextView.center.y);
            
            //letterView.contentTextView.backgroundColor = [UIColor redColor];
            
            letterView.backgroundColor = [UIColor colorWithWhite:.9 alpha:1.0];
            
            

            [self.extraLetterViews addObject:letterView];
            
            

            j++;
            totalHeight += (letterHeight + 10);
        }

        
        int i = (int)self.letterViews.count;


        for (LetterView *letterView in [self.letterViews reverseObjectEnumerator]) {
            [self.scrollView addSubview:letterView];
            
            Letter *letter = [self.dataSource letterForIndex:i - 1 forLetterStackView:self];
            float letterHeight = [letterView heightForLetterForContent:letter.content];
            
            letterView.frame = CGRectMake(10, 22 + 10 + totalHeight, [self firstLetterWidth], letterHeight);
            i--;
            totalHeight += (letterHeight + 10);
        }
        
        
        
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, totalHeight + 30, 50, 50)];
//        btn.backgroundColor = [UIColor blueColor];
        [self.scrollView addSubview:btn];
        [btn addTarget:self action:@selector(animateClosingThread) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"x.png"] forState:UIControlStateNormal];

        
        UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, totalHeight + 30, 50, 50)];
//        btn2.backgroundColor = [UIColor redColor];
        [btn2 addTarget:self action:@selector(automateReply) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setImage:[UIImage imageNamed:@"712-reply.png"] forState:UIControlStateNormal];

        [self.scrollView addSubview:btn2];

        NSLog(@"-%i", [self.dataSource letterCountForLetterStackView:self]);
        NSLog(@"_%i", [self.letterViews count]);

        
        
        
        
        [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, totalHeight + 10 + 22 + 60)];
        
        float anticipatedContentHeight = totalHeight + 10 + 22 - self.scrollView.frame.size.height;
        
        [self.scrollView setContentOffset:CGPointMake(0, anticipatedContentHeight + 60)];
    }];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height + 150) {

        // During all these transitions need to make things not interactable.
        
        [self animateClosingThread];
    }
    else if (scrollView.contentOffset.y < -150) {

        [self animateClosingThread];
    }
}


- (void)automateReply
{
    [self animateClosingThread];
    
    [self performSelector:@selector(notifyOfReply) withObject:nil afterDelay:1.0];

}

- (void)notifyOfReply
{
    
    Letter *letter = [self.dataSource letterForIndex:0 forLetterStackView:self];
    
    NSString *to;
    
    if ([[DefaultsHelper userHandle] isEqualToString:letter.sender]) {
        to = letter.receiver;
    }
    else {
        to = letter.sender;
    }
    
    [self.delegate letterStackViewDidCloseThread:self withUsernameToSendTo:to];
}


- (void)animateClosingThread
{
    NSMutableArray *centersArray = [NSMutableArray array];
    
    
    [UIView animateWithDuration:0.1 delay:.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        
        for (LetterView *letterView in self.extraLetterViews) {
            letterView.alpha = 0.0;
        }
        
    } completion:^(BOOL finished) {
        
//        for (LetterView *letterView in self.extraLetterViews) {
//            [letterView removeFromSuperview];
//        }
//        self.extraLetterViews = nil;

    }];

    
    
    int k = 0;
    for (LetterView *letterView in self.letterViews) {
        
        CGRect rectOfLetterInScrollView = letterView.frame;
        CGRect rectOfCellInSuperview = [self.scrollView convertRect:rectOfLetterInScrollView toView:self];
        
        [centersArray addObject:[NSNumber numberWithInt:rectOfCellInSuperview.origin.y + (rectOfCellInSuperview.size.height / 2)]];
        
        [self insertSubview:letterView atIndex:0];
        
        
        Letter *letter = [self.dataSource letterForIndex:k forLetterStackView:self];
        [letterView showFrontWithFromContent:[NSString stringWithFormat:@"From: %@", letter.sender] animated:NO];
        
        k++;
    }
    
    [self.scrollView removeFromSuperview];
    
    int normalHeight = 240;
    
    self.frame = CGRectMake(0, self.superview.frame.size.height - normalHeight, self.superview.frame.size.width, normalHeight);
    
    int i = 0;
    for (LetterView *letterView in self.letterViews) {
        letterView.center = CGPointMake(self.center.x, [[centersArray objectAtIndex:i] intValue] - (self.superview.frame.size.height - normalHeight));
        i++;
    }

    [self.delegate letterStackViewDidCloseThread:self];
    
    [UIView animateWithDuration:.7 delay:.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        
        
        
        
        
        int i = 0;
        for (LetterView *letterView in self.letterViews) {
            
            float widthSmaller = (i * [self firstLetterWidth] * [self percentSmallerHiddenLetters]);
            float heightSmaller = (i * [self firstLetterWidth] * [self percentSmallerHiddenLetters]);
            
            letterView.frame = CGRectMake(10 + (widthSmaller / 2), 10 + heightSmaller + (SPACING_BETWEEN_LETTERS * i), [self firstLetterWidth] - widthSmaller, [self firstLetterHeight] - heightSmaller);
            
            letterView.center = [self centerForLetterAtIndex:i withPercentageDownView:[self.percentageDownView floatValue]];
            
            letterView.backgroundColor = [UIColor colorWithWhite:.9 - (((i * 1.0) / [self lettersCount]) * .25) alpha:1.0];

            
            i++;
        }
                
    } completion:^(BOOL finished) {
        
    }];
    
}


@end
