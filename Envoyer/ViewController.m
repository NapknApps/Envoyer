//
//  ViewController.m
//  Envoyer
//
//  Created by Zach Whelchel on 7/20/15.
//  Copyright (c) 2015 Napkn Apps. All rights reserved.
//

#import "ViewController.h"
#import "LetterStackTableViewCell.h"
#import "LetterStackView.h"
#import "LetterView.h"
#import "Letter.h"
#import "FirebaseHelper.h"
#import "DefaultsHelper.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, LetterStackViewDelegate, LetterStackViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *inboxTableView;
@property (strong, nonatomic) LetterStackTableViewCell *openedLetterStackTableViewCell;
@property (strong, nonatomic) LetterStackView *openedLetterStackView;
@property (strong, nonatomic) NSArray *letterStacks;
@property (strong, nonatomic) LetterView *composingLetterView;

@end

@implementation ViewController

@synthesize openedLetterStackTableViewCell = _openedLetterStackTableViewCell;
@synthesize openedLetterStackView = _openedLetterStackView;
@synthesize letterStacks = _letterStacks;
@synthesize composingLetterView = _composingLetterView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];

    
    
    
    
    
    // get all letters that are to me, that are "arrived"
    
    
    
    self.inboxTableView.hidden = YES;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadData)
                                                 name:@"AppDidBecomeActive"
                                               object:nil];
    
    
    /*
    NSArray *letterStack1 = [NSArray arrayWithObjects:
                             [[Letter alloc] initWithContent:@"The book series does not chronicle any one particular timeframe. Rather, it is set in many periods in the history of the world of Redwall, which entails Mossflower woods, surrounding islands, and a land called Southsward. Some of the books focus on characters who, in other volumes, are historical figures (e.g., Martin the Warrior's father, Luke, in The Legend of Luke). Typically, those books are set before the founding of Redwall Abbey. There is a timeline in the Redwall series, but it generally places the books in a completely different order than the order in which they were written. However, there were two phases when the novels were published in chronological order."],
                             [[Letter alloc] initWithContent:@"The book series does not chronicle any one particular timeframe. Rather, it is set in many periods in the history of the world of Redwall, which entails Mossflower woods, surrounding islands, and a land called Southsward. Some of the books focus on characters who, in other volumes, are historical figures (e.g., Martin the Warrior's father, Luke, in The Legend of Luke). Typically, those books are set before the founding of Redwall Abbey. There is a timeline in the Redwall series, but it generally places the books in a completely different order than the order in which they were written. However, there were two phases when the novels were published in chronological order. The book series does not chronicle any one particular timeframe. Rather, it is set in many periods in the history of the world of Redwall, which entails Mossflower woods, surrounding islands, and a land called Southsward. Some of the books focus on characters who, in other volumes, are historical figures (e.g., Martin the Warrior's father, Luke, in The Legend of Luke). Typically, those books are set before the founding of Redwall Abbey. There is a timeline in the Redwall series, but it generally places the books in a completely different order than the order in which they were written. However, there were two phases when the novels were published in chronological order. The book series does not chronicle any one particular timeframe. Rather, it is set in many periods in the history of the world of Redwall, which entails Mossflower woods, surrounding islands, and a land called Southsward. Some of the books focus on characters who, in other volumes, are historical figures (e.g., Martin the Warrior's father, Luke, in The Legend of Luke). Typically, those books are set before the founding of Redwall Abbey. There is a timeline in the Redwall series, but it generally places the books in a completely different order than the order in which they were written. However, there were two phases when the novels were published in chronological order."],
                             [[Letter alloc] initWithContent:@"The book series does not chronicle any one particular timeframe. Rather, it is set in many periods in the history of the world of Redwall, which entails Mossflower woods, surrounding islands, and a land called Southsward. Some of the books focus on characters who, in other volumes, are historical figures (e.g., Martin the Warrior's father, Luke, in The Legend of Luke). Typically, those books are set before the founding of Redwall Abbey. There is a timeline in the Redwall series, but it generally places the books in a completely different order than the order in which they were written. However, there were two phases when the novels were published in chronological order."],
                             [[Letter alloc] initWithContent:@"The book series does not chronicle any one particular timeframe. Rather, it is set in many periods in the history of the world of Redwall, which entails Mossflower woods, surrounding islands, and a land called Southsward. Some of the books focus on characters who, in other volumes, are historical figures (e.g., Martin the Warrior's father, Luke, in The Legend of Luke). Typically, those books are set before the founding of Redwall Abbey. There is a timeline in the Redwall series, but it generally places the books in a completely different order than the order in which they were written. However, there were two phases when the novels were published in chronological order. The book series does not chronicle any one particular timeframe. Rather, it is set in many periods in the history of the world of Redwall, which entails Mossflower woods, surrounding islands, and a land called Southsward. Some of the books focus on characters who, in other volumes, are historical figures (e.g., Martin the Warrior's father, Luke, in The Legend of Luke). Typically, those books are set before the founding of Redwall Abbey. There is a timeline in the Redwall series, but it generally places the books in a completely different order than the order in which they were written. However, there were two phases when the novels were published in chronological order. The book series does not chronicle any one particular timeframe. Rather, it is set in many periods in the history of the world of Redwall, which entails Mossflower woods, surrounding islands, and a land called Southsward. Some of the books focus on characters who, in other volumes, are historical figures (e.g., Martin the Warrior's father, Luke, in The Legend of Luke). Typically, those books are set before the founding of Redwall Abbey. There is a timeline in the Redwall series, but it generally places the books in a completely different order than the order in which they were written. However, there were two phases when the novels were published in chronological order. The book series does not chronicle any one particular timeframe. Rather, it is set in many periods in the history of the world of Redwall, which entails Mossflower woods, surrounding islands, and a land called Southsward. Some of the books focus on characters who, in other volumes, are historical figures (e.g., Martin the Warrior's father, Luke, in The Legend of Luke). Typically, those books are set before the founding of Redwall Abbey. There is a timeline in the Redwall series, but it generally places the books in a completely different order than the order in which they were written. However, there were two phases when the novels were published in chronological order. The book series does not chronicle any one particular timeframe. Rather, it is set in many periods in the history of the world of Redwall, which entails Mossflower woods, surrounding islands, and a land called Southsward. Some of the books focus on characters who, in other volumes, are historical figures (e.g., Martin the Warrior's father, Luke, in The Legend of Luke). Typically, those books are set before the founding of Redwall Abbey. There is a timeline in the Redwall series, but it generally places the books in a completely different order than the order in which they were written. However, there were two phases when the novels were published in chronological order."],
                             [[Letter alloc] initWithContent:@"The book series does not chronicle any one particular timeframe. Rather, it is set in many periods in the history of the world of Redwall, which entails Mossflower woods, surrounding islands, and a land called Southsward. Some of the books focus on characters who, in other volumes, are historical figures (e.g., Martin the Warrior's father, Luke, in The Legend of Luke). Typically, those books are set before the founding of Redwall Abbey. There is a timeline in the Redwall series, but it generally places the books in a completely different order than the order in which they were written. However, there were two phases when the novels were published in chronological order."],
                             [[Letter alloc] initWithContent:@"The book series does not chronicle any one particular timeframe. Rather, it is set in many periods in the history of the world of Redwall, which entails Mossflower woods, surrounding islands, and a land called Southsward. Some of the books focus on characters who, in other volumes, are historical figures (e.g., Martin the Warrior's father, Luke, in The Legend of Luke). Typically, those books are set before the founding of Redwall Abbey. There is a timeline in the Redwall series, but it generally places the books in a completely different order than the order in which they were written. However, there were two phases when the novels were published in chronological order."],
                             nil];
    
    NSArray *letterStack2 = [NSArray arrayWithObjects:
                             [[Letter alloc] initWithContent:@"The book series does not chronicle any one particular timeframe. Rather, it is set in many periods in the history of the world of Redwall, which entails Mossflower woods, surrounding islands, and a land called Southsward. Some of the books focus on characters who, in other volumes, are historical figures (e.g., Martin the Warrior's father, Luke, in The Legend of Luke). Typically, those books are set before the founding of Redwall Abbey. There is a timeline in the Redwall series, but it generally places the books in a completely different order than the order in which they were written. However, there were two phases when the novels were published in chronological order."],
                             [[Letter alloc] initWithContent:@"The book series does not chronicle any one particular timeframe. Rather, it is set in many periods in the history of the world of Redwall, which entails Mossflower woods, surrounding islands, and a land called Southsward. Some of the books focus on characters who, in other volumes, are historical figures (e.g., Martin the Warrior's father, Luke, in The Legend of Luke). Typically, those books are set before the founding of Redwall Abbey. There is a timeline in the Redwall series, but it generally places the books in a completely different order than the order in which they were written. However, there were two phases when the novels were published in chronological order."],
                             nil];

    NSArray *letterStack3 = [NSArray arrayWithObjects:
                             [[Letter alloc] initWithContent:@"The book series does not chronicle any one particular timeframe. Rather, it is set in many periods in the history of the world of Redwall, which entails Mossflower woods, surrounding islands, and a land called Southsward. Some of the books focus on characters who, in other volumes, are historical figures (e.g., Martin the Warrior's father, Luke, in The Legend of Luke). Typically, those books are set before the founding of Redwall Abbey. There is a timeline in the Redwall series, but it generally places the books in a completely different order than the order in which they were written. However, there were two phases when the novels were published in chronological order."],
                             nil];

    NSArray *letterStack4 = [NSArray arrayWithObjects:
                             [[Letter alloc] initWithContent:@"The book."],
                             [[Letter alloc] initWithContent:@"The book."],
                             [[Letter alloc] initWithContent:@"The book."],
                             [[Letter alloc] initWithContent:@"The book."],
                             [[Letter alloc] initWithContent:@"The book."],
                             [[Letter alloc] initWithContent:@"The book."],
                             [[Letter alloc] initWithContent:@"The book."],
                             [[Letter alloc] initWithContent:@"The book."],
                             [[Letter alloc] initWithContent:@"The book."],
                             [[Letter alloc] initWithContent:@"The book."],
                             nil];

    NSArray *letterStack5 = [NSArray arrayWithObjects:
                             [[Letter alloc] initWithContent:@"The book."],
                             [[Letter alloc] initWithContent:@"The book."],
                             nil];

    self.letterStacks = [NSArray arrayWithObjects:letterStack1, letterStack2, letterStack3, letterStack4, letterStack5, nil];
    */
    
}

- (void)reloadData
{
    Firebase *ref = [[FirebaseHelper baseFirebaseReference] childByAppendingPath:[NSString stringWithFormat:@"messages/%@", [FirebaseHelper userUID]]];
    [ref observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        // Should get all of the messages to me. Need to sanitize them for the one's that I should have received.
        NSMutableArray *messages = [NSMutableArray array];

        if (snapshot.value == [NSNull null]) {
            // The value is null
        }
        else {
            NSArray *alKeys = [snapshot.value allKeys];
            for (NSString *key in alKeys) {
                NSArray *alKeys2 = [snapshot.value valueForKey:key];
                
                NSMutableArray *messagesFromSender = [NSMutableArray array];

                for (NSString *key2 in alKeys2) {
                    NSDictionary *message = [[snapshot.value valueForKey:key] valueForKey:key2];
                    
                    
                    if ([message valueForKey:@"receiveDate"]) {
                        NSDate *receiveDate = [NSDate dateWithTimeIntervalSince1970:[[message valueForKey:@"receiveDate"] intValue]];
                        
                        if ([receiveDate timeIntervalSinceNow] < 0.0) {
                            // Date has passed
                            
                            Letter *letter = [[Letter alloc] initWithContent:[message valueForKey:@"content"] receiver:[message valueForKey:@"receiver"] sender:[message valueForKey:@"sender"] senderUID:[message valueForKey:@"senderUID"] receiveDate:[message valueForKey:@"receiveDate"] fbID:key2 origionalReceiveDate:[message valueForKey:@"origionalReceiveDate"]];
                            
                            [messagesFromSender addObject:letter];

                        }

                        
                    }
                    
                    
                }
                
                if (messagesFromSender.count > 0) {
                    
                    
                    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"origionalReceiveDate"
                                                                                 ascending:NO];
                    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
                    NSArray *sortedArray = [messagesFromSender sortedArrayUsingDescriptors:sortDescriptors];

                    
                    
                    [messages addObject:sortedArray];
                }

            }
        }

        self.letterStacks = messages;
        
        // All messages that should have been received. Now show them and need to save a bit more so able to update them and such.
        NSLog(@"-------");
        NSLog(@"%@", messages);
        NSLog(@"-------");

        [self.inboxTableView reloadData];
        
    }];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // To reset manually when testing:
    //[[FirebaseHelper baseFirebaseReference] unauth];
    
    self.title = [DefaultsHelper userHandle];
    
    self.inboxTableView.hidden = YES;

    
    if (![DefaultsHelper introShown]) {
        [self performSegueWithIdentifier:@"Intro" sender:self];
    }
    else if (![FirebaseHelper userIsLoggedIn]) {
        [self performSegueWithIdentifier:@"Account" sender:self];
    }
    else {
        self.inboxTableView.hidden = NO;

        [self reloadData];
        
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSelectedWithPrefilTo:)];
        self.navigationItem.rightBarButtonItem = addButton;

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)letterStackViewDidCloseThread:(LetterStackView *)letterStackView withUsernameToSendTo:(NSString *)usernameToSendTo
{
    [self addSelectedWithPrefilTo:usernameToSendTo];
}

- (IBAction)addSelectedWithPrefilTo:(NSString *)prefilTo
{
    
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Send"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(sendSelected)];
    self.navigationItem.rightBarButtonItem = sendButton;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Cancel"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(cancelSelected)];
    self.navigationItem.leftBarButtonItem = cancelButton;

    self.title = nil;

    
    
    [UIView animateWithDuration:.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.inboxTableView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        
        self.composingLetterView = [[LetterView alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width - 20, self.view.frame.size.height)];
        
        [self.composingLetterView showBackWithContent:@"" animated:NO];
        
        self.composingLetterView.fromLabel.hidden = YES;
        self.composingLetterView.fromTextField.hidden = NO;
        
        self.composingLetterView.fromTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.composingLetterView.fromTextField.autocorrectionType = UITextAutocorrectionTypeNo;

        self.composingLetterView.fromTextField.placeholder = @"To: (friend's username)";
        

        if ([prefilTo isKindOfClass:[NSString class]]) {
            [self.composingLetterView.fromTextField setText:prefilTo];
        }
        
//        self.composingLetterView.contentTextView.backgroundColor = [UIColor redColor];
        
        self.composingLetterView.contentTextView.userInteractionEnabled = YES;
        self.composingLetterView.contentTextView.editable = YES;
        self.composingLetterView.contentTextView.hidden = NO;
        
        self.composingLetterView.backgroundColor = [UIColor colorWithWhite:.9 alpha:1.0];
        
        [self.view addSubview:self.composingLetterView];
        self.composingLetterView.center = CGPointMake(self.composingLetterView.center.x, self.composingLetterView.center.y + self.view.frame.size.height - 40);
        
        [UIView animateWithDuration:.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.composingLetterView.center = CGPointMake(self.composingLetterView.center.x, self.view.center.y - 66);
            
        } completion:^(BOOL finished) {
            
            [self.composingLetterView.contentTextView becomeFirstResponder];

        }];

        
    }];
}

- (void)keyboardWasShown:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    self.composingLetterView.contentTextView.frame = CGRectMake(12, 80, self.composingLetterView.frame.size.width - 24, self.composingLetterView.frame.size.height -  keyboardSize.height - 80);
}


- (void)cancelSelected
{

    [UIView animateWithDuration:.3 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.composingLetterView.alpha = 0.0;
        self.inboxTableView.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
        [self.composingLetterView removeFromSuperview];
        self.composingLetterView = nil;
        
        [self.composingLetterView.contentTextView resignFirstResponder];
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSelectedWithPrefilTo:)];
        self.navigationItem.rightBarButtonItem = addButton;
        
        self.navigationItem.leftBarButtonItem = nil;
        
        self.title = [DefaultsHelper userHandle];

    }];

}

- (void)sendSelected
{
    
    // look for the userid of the twitter name I find in a querry and then set the to user id to be that, set the arrive date to be 3 days from now.

    if ([FirebaseHelper userIsLoggedIn]) {
        
        
        if (self.composingLetterView.contentTextView.text.length > 10) {
            NSString *senderHandle = [DefaultsHelper userHandle];
            NSString *receiverHandle = self.composingLetterView.fromTextField.text;
            
            Firebase *ref = [[FirebaseHelper baseFirebaseReference] childByAppendingPath:@"user-handles"];
            
            [[[ref queryOrderedByChild:@"user_handle"] queryEqualToValue:receiverHandle] observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
                
                 if (snapshot.value == [NSNull null]) {
                     // The value is null
                     
                     
                     UIAlertController *alertController = [UIAlertController
                                                           alertControllerWithTitle:@"No User Found"
                                                           message:@"Perhaps you entered your friend's Envoyer username incorrectly."
                                                           preferredStyle:UIAlertControllerStyleAlert];
                     
                     UIAlertAction *cancelAction = [UIAlertAction
                                                    actionWithTitle:@"OK"
                                                    style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction *action)
                                                    {
                                                        
                                                    }];
                     
                     [alertController addAction:cancelAction];
                     [self presentViewController:alertController animated:YES completion:nil];
                     
                     
                 }
                 else {
                     
                     NSString *uidSendingTo = [[snapshot.value valueForKey:[[snapshot.value allKeys] firstObject]] valueForKey:@"uid"];
                     
                     if (uidSendingTo.length > 0) {
                         
                         
                         
                         NSDate *dateToReceive = [[NSDate date] dateByAddingTimeInterval:60 * 60 * 24 * 3];
//                         NSDate *dateToReceive = [[NSDate date] dateByAddingTimeInterval:0];

                         
                         Firebase *ref = [[FirebaseHelper baseFirebaseReference] childByAppendingPath:[NSString stringWithFormat:@"messages/%@/%@", uidSendingTo, [FirebaseHelper userUID]]];
                         
                         ref = [ref childByAutoId];
                         
                         NSDictionary *info = @{
                                                @"sender": senderHandle,
                                                @"senderUID": [FirebaseHelper userUID],
                                                @"receiver": receiverHandle,
                                                @"content": self.composingLetterView.contentTextView.text,
                                                @"receiveDate": [NSNumber numberWithInt:[dateToReceive timeIntervalSince1970]],
                                                @"origionalReceiveDate": [NSNumber numberWithInt:[dateToReceive timeIntervalSince1970]]
                                                };
                         
                         [ref setValue:info];
                         
                         for (NSArray *letterStack in self.letterStacks) {
                             for (Letter *letter in letterStack) {
                                 
                                 if ([letter.senderUID isEqualToString:uidSendingTo] || [letter.receiver isEqualToString:receiverHandle]) {
                                     
                                     // ok so we posess a letter that is from the send we are sending to so send it back also...
                                     // and delete it from ours
                                     
                                     [[[FirebaseHelper baseFirebaseReference] childByAppendingPath:[NSString stringWithFormat:@"messages/%@/%@/%@", [FirebaseHelper userUID], uidSendingTo, letter.fbID]] setValue:nil];
                                     
                                     NSDictionary *info = @{
                                                            @"sender": letter.sender,
                                                            @"senderUID": letter.senderUID,
                                                            @"receiver": letter.receiver,
                                                            @"content": letter.content,
                                                            @"receiveDate": [NSNumber numberWithInt:[dateToReceive timeIntervalSince1970]],
                                                            @"origionalReceiveDate": letter.origionalReceiveDate
                                                            };
                                     
                                     [[[[FirebaseHelper baseFirebaseReference] childByAppendingPath:[NSString stringWithFormat:@"messages/%@/%@/", uidSendingTo, [FirebaseHelper userUID]]] childByAutoId] setValue:info];
                                     
                                 }
                             }
                         }
                     }
                     
                     
                     [UIView animateWithDuration:.3 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
                         self.composingLetterView.center = CGPointMake(self.composingLetterView.center.x, self.view.center.y - self.view.frame.size.height);
                         
                         self.inboxTableView.alpha = 1.0;
                         
                     } completion:^(BOOL finished) {
                         
                         [self.composingLetterView removeFromSuperview];
                         self.composingLetterView = nil;
                         
                         [self.composingLetterView.contentTextView resignFirstResponder];
                         UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSelectedWithPrefilTo:)];
                         self.navigationItem.rightBarButtonItem = addButton;
                         
                         self.navigationItem.leftBarButtonItem = nil;
                         
                         self.title = [DefaultsHelper userHandle];

                     }];
                     
                     
                     
                 }
                 
                 [self reloadData];

                 
             } withCancelBlock:^(NSError *error) {
                 
                 
                 NSLog(@"error: %@", error);
                 
             }];

            
            
            
            
    
        }
        else {
            
            
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Too Short"
                                                  message:@"Letters need to be of substantial length."
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleCancel
                                           handler:^(UIAlertAction *action)
                                           {
                                               
                                           }];
            
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];

            
        }
        
        
        
        
    }

    
    
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.inboxTableView) {
        return self.letterStacks.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.inboxTableView) {
        LetterStackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LetterStackTableViewCell"];
        return cell;
    }
    return nil;
}

- (Letter *)letterForIndex:(int)index forLetterStackView:(LetterStackView *)letterStackView
{
    return [[self.letterStacks objectAtIndex:letterStackView.tag] objectAtIndex:index];
}

- (int)letterCountForLetterStackView:(LetterStackView *)letterStackView
{
    return [[self.letterStacks objectAtIndex:letterStackView.tag] count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(LetterStackTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.inboxTableView) {
        
        NSArray *letterStack = [self.letterStacks objectAtIndex:indexPath.row];

        cell.letterStackView.dataSource = self;
        cell.letterStackView.delegate = self;

        
        cell.letterStackView.tag = indexPath.row;
        
        [cell.letterStackView setUpWithLetterCount:(int)[letterStack count]];

        
        
        CGRect rectOfCellInTableView = [self.inboxTableView rectForRowAtIndexPath:indexPath];
        CGRect rectOfCellInSuperview = [self.inboxTableView convertRect:rectOfCellInTableView toView:[self.inboxTableView superview]];
        float positionDownView = rectOfCellInSuperview.origin.y / self.view.frame.size.height;
        [cell.letterStackView adjustLetterStackWithPercentageDownView:positionDownView];

        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.inboxTableView) {
        LetterStackTableViewCell *cell = (LetterStackTableViewCell *)[self.inboxTableView cellForRowAtIndexPath:indexPath];
        
        LetterStackView *letterStackView = cell.letterStackView;
        
//        letterStackView.delegate = self;
        
        self.openedLetterStackTableViewCell = cell;
        self.openedLetterStackView = letterStackView;
        
        CGRect rectOfCellInTableView = [self.inboxTableView rectForRowAtIndexPath:[self.inboxTableView indexPathForCell:cell]];
        CGRect rectOfCellInSuperview = [self.inboxTableView convertRect:rectOfCellInTableView toView:[self.inboxTableView superview]];

        [self.view addSubview:letterStackView];
        
        letterStackView.center = CGPointMake(self.view.center.x, rectOfCellInSuperview.origin.y + (rectOfCellInSuperview.size.height / 2));
        
        cell.letterStackView = nil;

        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        [letterStackView animateOpeningThread];

        [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.inboxTableView.alpha = 0.0;
            
            //letterStackView.frame = self.view.frame;
            
            letterStackView.center = CGPointMake(self.view.center.x, self.view.frame.size.height - (letterStackView.frame.size.height / 2));

        } completion:^(BOOL finished) {
            
        }];

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

- (void)letterStackViewDidCloseThread:(LetterStackView *)letterStackView
{
    float origionalZ = self.openedLetterStackView.layer.zPosition;
    
    self.openedLetterStackView.layer.zPosition = 1000;
    
    [UIView animateWithDuration:.8 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.inboxTableView.alpha = 1.0;
        
        CGRect rectOfCellInTableView = [self.inboxTableView rectForRowAtIndexPath:[self.inboxTableView indexPathForCell:self.openedLetterStackTableViewCell]];
        CGRect rectOfCellInSuperview = [self.inboxTableView convertRect:rectOfCellInTableView toView:[self.inboxTableView superview]];
        
        self.openedLetterStackView.center = CGPointMake(self.view.center.x, rectOfCellInSuperview.origin.y + (rectOfCellInSuperview.size.height / 2));
        
    } completion:^(BOOL finished) {
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];

        self.openedLetterStackTableViewCell.letterStackView = self.openedLetterStackView;
        [self.openedLetterStackTableViewCell addSubview:self.openedLetterStackView];
        
        self.openedLetterStackView.frame = self.openedLetterStackTableViewCell.contentView.frame;
        self.openedLetterStackView.layer.zPosition = origionalZ;

//        self.openedLetterStackView.delegate = nil;
        
        self.openedLetterStackTableViewCell = nil;
        self.openedLetterStackView = nil;
        
    }];
}

@end
