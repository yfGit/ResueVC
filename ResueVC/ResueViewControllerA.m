
//
//  ResueViewControllerA.m
//  ResueVC
//
//  Created by Wolf on 16/2/17.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import "ResueViewControllerA.h"

@interface ResueViewControllerA ()
{}
@property (nonatomic, strong) UILabel *label;

@end

@implementation ResueViewControllerA

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"ResueA";
    self.view.backgroundColor = [UIColor colorWithRed:0.7625 green:0.8897 blue:0.8294 alpha:1.0];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 500, 100, 30)];
    _label.center = self.view.center;
    _label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_label];
}
- (void)setYPage:(NSNumber *)yPage
{
    [super setYPage:yPage];
    _label.text = [NSString stringWithFormat:@"%ld",yPage.integerValue];
}


- (NSString *)yIdentifierID
{
    return @"ResueA";
}

- (void)reloadView
{
    NSLog(@"%s",__func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.navigationController) {
        ResueViewControllerA *vc = [[ResueViewControllerA alloc] init];
        vc.view.backgroundColor = [UIColor colorWithRed:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1];
        [self.navigationController pushViewController: vc animated:YES];
    }
}

@end
