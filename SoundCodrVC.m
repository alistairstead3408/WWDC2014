//
//  SoundCodrViewController.m
//  AlistairStead
//
//  Created by Alistair Stead on 11/04/2014.
//  Copyright (c) 2014 Alistair Stead. All rights reserved.
//

#import "SoundCodrVC.h"


@interface SoundCodrVC ()

@end

@implementation SoundCodrVC

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
    

    
    NSString*thePath=[[NSBundle mainBundle] pathForResource:@"soundcodr" ofType:@"m4v"];
    NSURL*theurl=[NSURL fileURLWithPath:thePath];
    
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:theurl];
    
    self.player.movieSourceType    = MPMovieSourceTypeFile;
    self.player.view.frame = CGRectMake(0, 68, 320, 200);
    self.player.shouldAutoplay=YES;
    self.player.controlStyle = MPMovieControlStyleNone;
    [self.player play];
    [self.player setRepeatMode: MPMovieRepeatModeOne];
    [self.myUIView addSubview:self.player.view];
    
    [self.myUITextView setText:@"SoundCodr is an app that uses machine learning, computer vision and a new block programming language to enable users to create their own musical notation.\n\n 1. Choose which colours to use. \n\n 2. Hold the phone’s camera over example colours\n\n 3. Make rules telling the phone what sounds to play when events trigger.\n\n 4. Perform the music by scanning the phone’s camera over blobs in “performance” mode."];
    
    [self.myUITextView setShowsVerticalScrollIndicator:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
