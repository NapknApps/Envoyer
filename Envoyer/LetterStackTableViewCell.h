//
//  LetterStackTableViewCell.h
//  Envoyer
//
//  Created by Zach Whelchel on 7/20/15.
//  Copyright (c) 2015 Napkn Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LetterStackView.h"

@interface LetterStackTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet LetterStackView *letterStackView;

@end
