//
//  IndustryVC.m
//  AlistairStead
//
//  Created by Alistair Stead on 12/04/2014.
//  Copyright (c) 2014 Alistair Stead. All rights reserved.
//

#import "IndustryVC.h"

@interface IndustryVC ()

@end

@implementation IndustryVC

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
    self.myScrollView.contentSize = self.myUIView.bounds.size;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.saImage1 removeFromSuperview];
    [self.saImage2 removeFromSuperview];
    [self.saImage3 removeFromSuperview];
    [self.saImage4 removeFromSuperview];
    [self.saImage5 removeFromSuperview];
    [self.saImage6 removeFromSuperview];
    [self.saImage1 setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.saImage2 setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.saImage3 setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.saImage4 setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.saImage5 setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.saImage6 setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    [self.myScrollView setContentSize:CGSizeMake(self.myUIView.bounds.size.width, self.myUIView.bounds.size.height - 111)];
    // Do any additional setup after loading the view.
    int w = self.saScrollView.bounds.size.width;
    int h = self.saScrollView.bounds.size.height;
    

    [self.saScrollView setContentSize:CGSizeMake(6 * w, h)];
    [self.saScrollView setPagingEnabled:YES];
    
    [self.saImage1 setFrame:CGRectMake(0, 0, w, h)];
    [self.saImage2 setFrame:CGRectMake(w, 0, w, h)];
    [self.saImage3 setFrame:CGRectMake(w * 2, 0, w, h)];
    [self.saImage4 setFrame:CGRectMake(w * 3, 0, w, h)];
    [self.saImage5 setFrame:CGRectMake(w * 4, 0, w, h)];
    [self.saImage6 setFrame:CGRectMake(w * 5, 0, w, h)];
    [self.saScrollView setShowsHorizontalScrollIndicator:false];
    
    [self.saScrollView addSubview:self.saImage1];
    [self.saScrollView addSubview:self.saImage2];
    [self.saScrollView addSubview:self.saImage3];
    [self.saScrollView addSubview:self.saImage4];
    [self.saScrollView addSubview:self.saImage5];
    [self.saScrollView addSubview:self.saImage6];
    
    [self.saScrollView setNeedsDisplay];
}

-(IBAction)saPageViewChanged:(id)sender
{
    
    int page = (int)self.saPageControl.currentPage;
    [self.saScrollView setContentOffset:CGPointMake(page * self.saScrollView.bounds.size.width, 0) animated:true];
    NSLog(@"Page: %ld", (long)self.saPageControl.currentPage);
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.saScrollView.frame.size.width;
    int page = floor((self.saScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.saPageControl.currentPage = page;
}


@end
