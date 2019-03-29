//
//  QTViewController.m
//  QueryTools
//
//  Created by pianxian on 03/29/2019.
//  Copyright (c) 2019 pianxian. All rights reserved.
//

#import "QTViewController.h"
#import <QTAlertView.h>
#import <QTTipsView.h>
@interface QTViewController ()

@end

@implementation QTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[QTAlertView sharedMask] show:[QTTipsView sharTipsView] withType:0];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
