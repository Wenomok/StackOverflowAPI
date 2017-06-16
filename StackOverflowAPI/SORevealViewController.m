//
//  SORevealViewController.m
//  StackOverflowAPI
//
//  Created by Vladislav on 10.05.17.
//  Copyright © 2017 Vladislav. All rights reserved.
//

#import "SORevealViewController.h"

@interface SORevealViewController ()

@end

@implementation SORevealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - motions

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(motion == UIEventSubtypeMotionShake) {
        NSString *officeSoundPath = [[NSBundle mainBundle] pathForResource:@"office012" ofType:@"wav"];
        NSURL *officeSoundURL = [NSURL fileURLWithPath:officeSoundPath];
        SystemSoundID officeSound;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)officeSoundURL, &officeSound);
        AudioServicesPlaySystemSound(officeSound);
    }
}

@end
