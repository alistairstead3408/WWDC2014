//
//  Puzzle.h
//  WWDC
//
//  Created by Alistair Stead on 08/04/2014.
//  Copyright (c) 2014 Alistair Stead. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

@interface PuzzleVC : UIViewController

@property (strong) IBOutlet UIView *quartzContainer;
@property (strong) IBOutlet UIView *infoContainer;
@property (strong) IBOutlet UIImageView *splitImageView;

@property (strong) QuartzView *quartzView;

@property (strong) IBOutlet UIButton *shuffleButton;
@property (strong) IBOutlet UIButton *submitButton;

@property (strong) IBOutlet UIButton *githubButton;
@property (strong) IBOutlet UIButton *linkedinButton;
@property (strong) IBOutlet UIButton *twitterButton;
@property (strong) IBOutlet UIButton *contactButton;

- (IBAction)shuffleButtonPress:(id)sender;
- (IBAction)submitButtonPress:(id)sender;
- (IBAction)githubButtonPress:(id)sender;
- (IBAction)linkedinButtonPress:(id)sender;
- (IBAction)twitterButtonPress:(id)sender;
- (IBAction)contactButtonPress:(id)sender;


@end
