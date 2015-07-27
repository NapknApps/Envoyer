//
//  LetterView.h
//  Envoyer
//
//  Created by Zach Whelchel on 7/22/15.
//  Copyright (c) 2015 Napkn Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LetterView : UIView

@property (nonatomic, strong) UILabel *fromLabel;
@property (nonatomic, strong) UITextField *fromTextField;
@property (nonatomic, strong) UITextView *contentTextView;

- (void)showFrontWithFromContent:(NSString *)fromContent animated:(BOOL)animated;
- (void)showBackWithContent:(NSString *)content animated:(BOOL)animated;
- (int)heightForContent:(NSString *)content;
- (int)heightForLetterForContent:(NSString *)content;

@end
