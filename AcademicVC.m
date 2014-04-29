//
//  Projects.m
//  AlistairStead
//
//  Created by Alistair Stead on 11/04/2014.
//  Copyright (c) 2014 Alistair Stead. All rights reserved.
//

#import "AcademicVC.h"

@interface AcademicVC ()

@end

@implementation AcademicVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animate{
    
    self.myScrollView.contentSize = self.myUIView.bounds.size;
//    [self.myScrollView setContentSize:self.myUIView.frame];
//    [self.myScrollView setFrame:CGRectMake(0, 65, self.myScrollView.bounds.size.width, self.myScrollView.bounds.size.height)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(UIStoryboardSegue *)segue
{
    
    NSLog(@"Popping back to this view controller!");
}


@end
