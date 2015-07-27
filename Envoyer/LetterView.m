//
//  LetterView.m
//  Envoyer
//
//  Created by Zach Whelchel on 7/22/15.
//  Copyright (c) 2015 Napkn Apps. All rights reserved.
//

#import "LetterView.h"

const int PADDING_TOP_FOR_TEXT_VIEW = 70;

@implementation LetterView

@synthesize fromLabel = _fromLabel;
@synthesize contentTextView = _contentTextView;

-  (id)initWithFrame:(CGRect)aRect
{
    self = [super initWithFrame:aRect];
    
    if (self)
    {
        self.fromLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 40)];
        [self.fromLabel setFont:[UIFont fontWithName:@"TalkingtotheMoon" size:24]];
        [self.fromLabel setTextColor:[UIColor darkGrayColor]];
        
        self.fromTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, 250, 40)];
        [self.fromTextField setFont:[UIFont fontWithName:@"TalkingtotheMoon" size:24]];
        [self.fromTextField setTextColor:[UIColor darkGrayColor]];
        

        
        self.contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(12, 50, self.superview.frame.size.width - 44, 0)];
        self.contentTextView.editable = NO;
        self.contentTextView.userInteractionEnabled = NO;
        self.contentTextView.backgroundColor = [UIColor clearColor];
        [self.contentTextView setFont:[UIFont fontWithName:@"TalkingtotheMoon" size:20]];
        self.contentTextView.textColor = [UIColor darkGrayColor];
        
        [self addSubview:self.fromLabel];
        [self addSubview:self.fromTextField];
        [self addSubview:self.contentTextView];

    }
    
    return self;
}


- (void)showFrontWithFromContent:(NSString *)fromContent animated:(BOOL)animated
{
    self.fromLabel.hidden = NO;
    self.contentTextView.hidden = YES;
    self.fromTextField.hidden = YES;
    
    [self.fromLabel setText:fromContent];

}

- (void)showBackWithContent:(NSString *)content animated:(BOOL)animated
{
    self.fromLabel.hidden = NO;
    self.contentTextView.hidden = NO;
    self.fromTextField.hidden = YES;
    
    self.contentTextView.frame = CGRectMake(12, PADDING_TOP_FOR_TEXT_VIEW, self.superview.frame.size.width - 44, [self heightForContent:content]);
    [self.contentTextView setText:content];

}

- (int)heightForContent:(NSString *)content
{
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.superview.frame.size.width - 44, 100000)];
    [textView setFont:[UIFont fontWithName:@"TalkingtotheMoon" size:20]];
    [textView setText:content];
    [textView sizeToFit];
    return textView.frame.size.height > 200 ? textView.frame.size.height : 200;
}

- (int)heightForLetterForContent:(NSString *)content
{
    return [self heightForContent:content] + PADDING_TOP_FOR_TEXT_VIEW + 10;
}

@end
