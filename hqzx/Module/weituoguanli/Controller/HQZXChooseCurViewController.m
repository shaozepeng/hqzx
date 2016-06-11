//
//  HQZXChooseCurViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/9.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXChooseCurViewController.h"

@implementation HQZXChooseCurViewController{
    HQZXEmptyManager *hqzxEmptyManager;
    NSMutableArray *arys;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    self.title = LocatizedStirngForkey(@"JIAOYILIUSHUI");
    [self createTableView];
    
    arys = [NSMutableArray array];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:countryKey];
    NSDictionary* dicPorts = [NSDictionary dictionaryWithContentsOfFile:filename];
    if(dicPorts.count>0){
        NSDictionary *allDict =[dicPorts objectForKey:@"config"];
        NSArray *countrys = [allDict objectForKey:@"virtualcointype"];
        for(NSDictionary *countryDic in countrys){
            HQZXVirtualViewController *virtual = [[HQZXVirtualViewController alloc]init];
            virtual.virtual_id = StrValueFromDictionary(countryDic, @"id");
            virtual.virtual_name = StrValueFromDictionary(countryDic, @"name");
            virtual.virtual_logo = StrValueFromDictionary(countryDic, @"logo");
            [arys addObject:virtual];
        }
    }
    
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
    [self.myTableView registerClass:[HQZXChooseTableCell class] forCellReuseIdentifier:@"CustomHeaderOne"];
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
    return arys.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CustomHeaderOne";
    NSUInteger section = [indexPath section];

    HQZXChooseTableCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    HQZXVirtualViewController *btbData;
    if(arys.count>0){
        btbData = [arys objectAtIndex:section];
    }
    
    if(btbData){
        cell.imageUrl =btbData.virtual_logo;
        cell.name = btbData.virtual_name;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //push后cell选中效果消失,又动画
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HQZXVirtualViewController *btbData;
    if(arys.count>0){
        btbData = [arys objectAtIndex:indexPath.section];
    }
    HQZXEntrustManagementViewController *weituo=[[HQZXEntrustManagementViewController alloc]init];
    weituo.sysId = btbData.virtual_id;
    [rootNav pushViewController:weituo animated:YES];
}

@end
