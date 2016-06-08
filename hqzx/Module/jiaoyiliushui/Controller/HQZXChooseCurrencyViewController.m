//
//  HQZXChooseCurrencyViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/5.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXChooseCurrencyViewController.h"

@implementation HQZXChooseCurrencyViewController{
    HQZXEmptyManager *hqzxEmptyManager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    self.title = LocatizedStirngForkey(@"JIAOYILIUSHUI");
    [self createTableView];
    HQZXEmptyData(self.myTableView, hqzxEmptyManager, nil);
}
-(void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_HEIGHT+8 , SCREEN_WIDTH, SCREEN_HEIGHT-TOP_HEIGHT - 8) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableView.dataSource = self;
    // 设置tableView的委托
    tableView.delegate = self;
    tableView.backgroundColor = UIColorFromRGB(0x0C1319);
    self.myTableView = tableView;
    
    [self.view addSubview:self.myTableView];
}
// 设置块的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_WIDTH/10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 17;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell=nil;
    NSUInteger section = [indexPath section];
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = UIColorFromRGB(0x0F151A);
    cell.textLabel.text=@"比特币(BTC)";
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.imageView.image=[UIImage imageNamed:@"icon_bibi_1"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //push后cell选中效果消失,又动画
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HQZXTransactionCurrencyViewController *liushui=[[HQZXTransactionCurrencyViewController alloc]init];
    [rootNav pushViewController:liushui animated:YES];
}
@end
