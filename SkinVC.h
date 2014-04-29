//
//  SkinVC.h
//  AlistairStead
//
//  Created by Alistair Stead on 12/04/2014.
//  Copyright (c) 2014 Alistair Stead. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkinVC : UIViewController

@property (strong) IBOutlet UIPageControl *saPageControl;
@property (strong) IBOutlet UIScrollView *saScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *saImage1;
@property (strong, nonatomic) IBOutlet UIImageView *saImage2;
@property (strong, nonatomic) IBOutlet UIImageView *saImage3;
@property (strong, nonatomic) IBOutlet UIImageView *saImage4;
@property (strong, nonatomic) IBOutlet UIImageView *saImage5;
@property (strong, nonatomic) IBOutlet UIImageView *saImage6;

-(IBAction)saPageViewChanged:(id)sender;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end
