//
//  ResueViewControllerB.m
//  ResueVC
//
//  Created by Wolf on 16/2/18.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import "ResueViewControllerB.h"
#import "ResueViewControllerA.h"


@interface ResueViewControllerB ()

@property (weak, nonatomic) IBOutlet UILabel *instantsLable;

@property (nonatomic, strong) UILabel *label;
@end

@implementation ResueViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ResueB";
    // Do any additional setup after loading the view from its nib.
    _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 500, 100, 30)];
    _label.center = self.view.center;
    _label.backgroundColor = [UIColor colorWithRed:0.5056 green:1.0 blue:0.0859 alpha:1.0];
    [self.view addSubview:_label];
}


- (void)setYPage:(NSNumber *)yPage
{
    [super setYPage:yPage];
    _label.text = [NSString stringWithFormat:@"%ld",yPage.integerValue];
}


- (NSString *)yIdentifierID
{
    return @"ResueB";
}


- (void)reloadView
{
    NSLog(@"%s",__func__);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.navigationController) {
        ResueViewControllerB *vc = [[ResueViewControllerB alloc] init];
        vc.view.backgroundColor = [UIColor colorWithRed:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1];
        [self.navigationController pushViewController: vc animated:YES];
    }
}
@end
