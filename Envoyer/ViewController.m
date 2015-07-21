//
//  ViewController.m
//  Envoyer
//
//  Created by Zach Whelchel on 7/20/15.
//  Copyright (c) 2015 Napkn Apps. All rights reserved.
//

#import "ViewController.h"
#import "LetterStackTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *inboxTableView;
@property (weak, nonatomic) IBOutlet UITableView *threadTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.inboxTableView) {
        return 5;
    }
    else if (tableView == self.threadTableView) {
        return 0;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.inboxTableView) {
        LetterStackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LetterStackTableViewCell"];
        return cell;
    }
    else if (tableView == self.threadTableView) {
        return nil;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(LetterStackTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.inboxTableView) {
        [cell.letterStackView setUpWithLetterCount:5];
    }
    else if (tableView == self.threadTableView) {
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.inboxTableView) {
        LetterStackTableViewCell *cell = (LetterStackTableViewCell *)[self.inboxTableView cellForRowAtIndexPath:indexPath];
        
        
        LetterStackView *letterStackView = cell.letterStackView;

        CGRect rectOfCellInTableView = [self.inboxTableView rectForRowAtIndexPath:[self.inboxTableView indexPathForCell:cell]];
        CGRect rectOfCellInSuperview = [self.inboxTableView convertRect:rectOfCellInTableView toView:[self.inboxTableView superview]];

        [self.view addSubview:letterStackView];
        
        letterStackView.center = CGPointMake(self.view.center.x, rectOfCellInSuperview.origin.y + (rectOfCellInSuperview.size.height / 2));
        
        cell.letterStackView = nil;

        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        [letterStackView animateOpeningThreadWithLetterHeight:self.view.frame.size.height - 40];

        [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.inboxTableView.alpha = 0.0;
            letterStackView.center = CGPointMake(self.view.center.x, self.view.frame.size.height - (letterStackView.frame.size.height / 2));

        } completion:^(BOOL finished) {
            
        }];

    }
    else if (tableView == self.threadTableView) {
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.inboxTableView) {

        for (LetterStackTableViewCell *cell in [self.inboxTableView visibleCells]) {
            
            CGRect rectOfCellInTableView = [self.inboxTableView rectForRowAtIndexPath:[self.inboxTableView indexPathForCell:cell]];
            CGRect rectOfCellInSuperview = [self.inboxTableView convertRect:rectOfCellInTableView toView:[self.inboxTableView superview]];
            
            float positionDownView = rectOfCellInSuperview.origin.y / self.view.frame.size.height;
            
            [cell.letterStackView adjustLetterStackWithPercentageDownView:positionDownView];
        }
    }
}

@end
