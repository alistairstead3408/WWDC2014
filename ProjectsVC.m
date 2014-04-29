//
//  SecondViewController.m
//  WWDC
//
//  Created by Alistair Stead on 08/04/2014.
//  Copyright (c) 2014 Alistair Stead. All rights reserved.
//

#import "ProjectsVC.h"

@interface ProjectsVC ()

@end

@implementation ProjectsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	
}

- (void) viewDidAppear:(BOOL)animated
{
    // Do any additional setup after loading the view, typically from a nib.
    
    self.myScrollView.contentSize = self.myUIView.bounds.size;
    self.myScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.myUIView.translatesAutoresizingMaskIntoConstraints = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
