//
//  YMViewController.m
//  YMTextFieldDemo
//
//  Created by Merck on 4/28/14.
//  Copyright (c) 2014 Merck. All rights reserved.
//

#import "YMViewController.h"
#import "YMTextField/YMTextField.h"

@interface YMViewController ()

@property (nonatomic, strong) YMTextField *accountTextField;
@property (nonatomic, strong) YMTextField *passwordTextField;

@end

@implementation YMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.accountTextField = [[YMTextField alloc] initWithFrame:CGRectMake(60, 100, 200, 48) title:@"Account"];
    [self.view addSubview:_accountTextField];
    
    self.passwordTextField = [[YMTextField alloc] initWithFrame:CGRectMake(60, 200, 200, 48) title:@"Password"];
    [self.view addSubview:_passwordTextField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
