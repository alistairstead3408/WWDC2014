//
//  SoundCodrViewController.h
//  AlistairStead
//
//  Created by Alistair Stead on 11/04/2014.
//  Copyright (c) 2014 Alistair Stead. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface SoundCodrVC : UIViewController

@property (strong) IBOutlet UIView *myUIView;
@property (strong) IBOutlet UITextView *myUITextView;

@property (strong,nonatomic) MPMoviePlayerController *player;

@end
