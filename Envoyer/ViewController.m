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

@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LetterStackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LetterStackTableViewCell"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(LetterStackTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell.letterStackView setUpWithLetterCount:5];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (LetterStackTableViewCell *cell in [self.tableView visibleCells]) {
        
        // Get the cell's position on the screen.
        
        CGRect rectOfCellInTableView = [self.tableView rectForRowAtIndexPath:[self.tableView indexPathForCell:cell]];
        CGRect rectOfCellInSuperview = [self.tableView convertRect:rectOfCellInTableView toView:[self.tableView superview]];
        
        float positionDownView = rectOfCellInSuperview.origin.y / self.view.frame.size.height;
        
        [cell.letterStackView adjustLetterStackWithPercentageDownView:positionDownView];
    }
}

@end
