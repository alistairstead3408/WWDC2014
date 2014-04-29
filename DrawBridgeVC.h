//
//  DrawBridgeViewController.h
//  AlistairStead
//
//  Created by Alistair Stead on 11/04/2014.
//  Copyright (c) 2014 Alistair Stead. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawBridgeVC : UIViewController

@property (strong) IBOutlet UITextView *myUITextView;

@property (strong, nonatomic) IBOutlet UIScrollView *dbScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *dbImage1;
@property (strong, nonatomic) IBOutlet UIImageView *dbImage2;
@property (strong, nonatomic) IBOutlet UIImageView *dbImage3;

@property (strong, nonatomic) IBOutlet UIPageControl *dbPageControl;

@property (strong, nonatomic) IBOutlet UIButton *githubButton;

-(IBAction)dbPageControlValueChanged:(id)sender;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

-(IBAction) githubButtonPressed:(id)sender;

@end
