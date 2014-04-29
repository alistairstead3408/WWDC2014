//
//  Projects.h
//  AlistairStead
//
//  Created by Alistair Stead on 11/04/2014.
//  Copyright (c) 2014 Alistair Stead. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcademicVC : UIViewController

- (IBAction)done:(UIStoryboardSegue *)segue;


@property (strong) IBOutlet UIScrollView *myScrollView;
@property (strong) IBOutlet UIView *myUIView;

@end
