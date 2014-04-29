//
//  DrawBridgeViewController.m
//  AlistairStead
//
//  Created by Alistair Stead on 11/04/2014.
//  Copyright (c) 2014 Alistair Stead. All rights reserved.
//

#import "DrawBridgeVC.h"

@interface DrawBridgeVC ()

@end

@implementation DrawBridgeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    
    
    [self.dbImage1 removeFromSuperview];
    [self.dbImage2 removeFromSuperview];
    [self.dbImage3 removeFromSuperview];
    [self.dbImage1 setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.dbImage2 setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.dbImage3 setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    // Do any additional setup after loading the view.
    int w = self.dbScrollView.bounds.size.width;
    int h = self.dbScrollView.bounds.size.height;

    
    [self.dbScrollView setContentSize:CGSizeMake(3 * w, h)];
    [self.dbScrollView setPagingEnabled:YES];
    
    [self.dbImage1 setFrame:CGRectMake(0, 0, w, h)];
    [self.dbImage2 setFrame:CGRectMake(w, 0, w, h)];
    [self.dbImage3 setFrame:CGRectMake(w * 2, 0, w, h)];
    [self.dbScrollView setShowsHorizontalScrollIndicator:false];
    
    
    [self.dbScrollView addSubview:self.dbImage1];
    [self.dbScrollView addSubview:self.dbImage2];
    [self.dbScrollView addSubview:self.dbImage3];
    
    [self.myUITextView setText:@"My Ph.D. work aims to improve novice programming environments by allowing novices to easily transition from \"syntax-free\" visual language environments like Scratch, to real world text-based languages.\n\n DrawBridge is a bi-directional programming environment that lets novices program in visual and text languages simultaneously"];
    
    [self.dbScrollView setNeedsDisplay];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)dbPageControlValueChanged:(id)sender
{
    int page = (int)self.dbPageControl.currentPage;
    [self.dbScrollView setContentOffset:CGPointMake(page * self.dbScrollView.bounds.size.width, 0) animated:true];
    NSLog(@"Page: %ld", (long)self.dbPageControl.currentPage);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.dbScrollView.frame.size.width;
    int page = floor((self.dbScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.dbPageControl.currentPage = page;
    
}


-(IBAction) githubButtonPressed:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/alistairstead3408/drawbridge"]];
}



@end
