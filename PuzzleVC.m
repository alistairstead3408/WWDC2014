//
//  Puzzle.m
//  WWDC
//
//  Created by Alistair Stead on 08/04/2014.
//  Copyright (c) 2014 Alistair Stead. All rights reserved.
//

#import "QuartzView.h"
#import "PuzzleVC.h"

@interface PuzzleVC ()

@end

@implementation PuzzleVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

   
//    
    [self.quartzContainer setTranslatesAutoresizingMaskIntoConstraints:YES];
//    [self.quartzContainer removeFromSuperview];
    [self.quartzContainer setFrame:CGRectMake(0, 30, self.view.bounds.size.width, self.view.bounds.size.height - 260)];
//    [self.view addSubview:self.quartzContainer];
    self.quartzView = [[QuartzView alloc] initWithFrame:self.quartzContainer.bounds];
    [self.quartzContainer addSubview:self.quartzView];
    
    [self.view setNeedsDisplay];
    NSLog(@"Bounds: %f %f %f %f", self.quartzContainer.bounds.origin.x, self.quartzContainer.bounds.origin.y, self.quartzContainer.bounds.size.width, self.quartzContainer.bounds.size.height);


    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shuffleButtonPress:(id)sender
{
    [self.quartzView.grid shuffleGrid];
    [self.quartzView setNeedsDisplay];
    
}
- (IBAction)submitButtonPress:(id)sender
{
    UIAlertView *message;
    if(!self.quartzView.grid.hasShuffled){
        message = [[UIAlertView alloc] initWithTitle:@"Puzzle Submission!"
                                             message:@"You haven't shuffled yet!"
                                            delegate:nil
                                   cancelButtonTitle:@"ok"
                                   otherButtonTitles:nil];
    }
    else if(self.quartzView.grid.hasShuffled){
        
        //Do the check
        BOOL isCorrect = true;
        NSMutableArray *grid = self.quartzView.grid.actualGrid;
        int expectedIndex = 0;
        
        for(NSMutableArray *row in grid){
            for(Tile *t in row){
                expectedIndex ++;
                if([t tileID] != expectedIndex){
                    isCorrect = false;
                }
            }
        }
        
        if(isCorrect){
            message = [[UIAlertView alloc] initWithTitle:@"Puzzle Submission!"
                                                 message:@"You correctly completed the puzzle!"
                                                delegate:nil
                                       cancelButtonTitle:@"Cool!"
                                       otherButtonTitles:nil];
        }
        else{
            message = [[UIAlertView alloc] initWithTitle:@"Puzzle Submission!"
                                                 message:@"The puzzle is not yet correct!"
                                                delegate:nil
                                       cancelButtonTitle:@":("
                                        otherButtonTitles:nil];
        }
    }
    
    [message show];
    
    
}

- (IBAction) githubButtonPress:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/alistairstead3408"]];
}

- (IBAction) linkedinButtonPress:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://uk.linkedin.com/in/alistairstead1/"]];
}

- (IBAction) twitterButtonPress:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/alistairstead46"]];
}

- (IBAction) contactButtonPress:(id)sender
{
    NSLog(@"contact button press");
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, nil);
    
    __block BOOL accessGranted = NO;
    
    if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else { // we're on iOS 5 or older
        accessGranted = YES;
    }
    
    
    if (accessGranted) {
        NSLog(@"Access granted");
        // Do whatever you need with thePeople...
        CFStringRef name = CFSTR("Alistair Graham Stead");
        
        CFArrayRef existingPeople = ABAddressBookCopyPeopleWithName(addressBook, name);
        
        if(CFArrayGetCount(existingPeople) > 0){
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Contacts"
                                                              message:@"This contact has already been added!"
                                                             delegate:nil
                                                    cancelButtonTitle:@"ok"
                                                    otherButtonTitles:nil];
            [message show];
        }
        else{
            ABRecordRef newPerson = ABPersonCreate();
            ABRecordSetValue(newPerson, kABPersonFirstNameProperty, @"Alistair", nil);
            ABRecordSetValue(newPerson, kABPersonMiddleNameProperty, @"Graham", nil);
            ABRecordSetValue(newPerson, kABPersonLastNameProperty, @"Stead", nil);
            ABRecordSetValue(newPerson, kABPersonJobTitleProperty, @"WWDC Student Candidate", nil);
            ABMutableMultiValueRef multiEmail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
            ABMultiValueAddValueAndLabel(multiEmail, @"alistair.stead@gmail.com", kABWorkLabel, NULL);
            ABMultiValueAddValueAndLabel(multiEmail, @"ags46@cam.ac.uk", kABWorkLabel, NULL);
            ABRecordSetValue(newPerson, kABPersonEmailProperty, multiEmail, NULL);
            CFRelease(multiEmail);
        
            ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        
            ABMultiValueAddValueAndLabel(multiPhone, @"+447809157530", kABPersonPhoneMobileLabel, NULL);
            ABRecordSetValue(newPerson, kABPersonPhoneProperty, multiPhone, NULL);
            CFRelease(multiPhone);
        
            ABAddressBookAddRecord(addressBook, newPerson, nil);
        
            ABAddressBookSave(addressBook, nil);
        
            NSLog(@"Contact Added");
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Contacts"
                                                 message:@"Contact Added!"
                                                delegate:nil
                                       cancelButtonTitle:@"ok"
                                       otherButtonTitles:nil];
            [message show];
        }
    }
}

@end
