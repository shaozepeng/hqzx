//
//  HQZXTransactionCurrencyViewController.m
//  hqzx
//
//  Created by 泽鹏邵 on 16/6/4.
//  Copyright © 2016年 泽鹏邵. All rights reserved.
//

#import "HQZXTransactionCurrencyViewController.h"

@implementation HQZXTransactionCurrencyViewController{
    UIScrollView *_scroll;
    HQZXEmptyManager *hqzxEmptyManager;
    UIScrollView *_scrollTwo;
    HQZXEmptyManager *hqzxTwoEmptyManager;
    UIScrollView *_accscroll;
    HQZXEmptyManager *hqzxEmptyManagers;
    UIScrollView *_accscrollTwo;
    HQZXEmptyManager *hqzxTwoEmptyManagers;
    UIView *buyView;
    UIView *buyTwoView;
    UIView *sellView;
    UIView *sellTwoView;
    NSString *nextId;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [[UIView alloc] init]];
    self.view.backgroundColor = UIColorFromRGB(0x0C1319);
    self.title = LocatizedStirngForkey(@"JIAOYILIUSHUI");
    
    _datas = [NSMutableArray array];
    
    [self clickButton];
    
    [self createScrollView];
    [self createTwoScrollView];
    [self createAccScrollView];
    [self createTwoAccScrollView];
    [self createTableTwoView];
    [self createTableView];
    [self createSellTableTwoView];
    [self createSellTableView];
    [self createAccTableTwoView];
    [self createAccTableView];
    [self createOutAccTableTwoView];
    [self createOutAccTableView];
    [self.myAccTableView.mj_header beginRefreshing];
    HQZXEmptyData(self.myAccTableView, hqzxEmptyManager, nil);
    HQZXEmptyData(self.mySecAccTableView, hqzxTwoEmptyManager, nil);
    HQZXEmptyData(self.myAccDataTableView, hqzxEmptyManagers, nil);
    HQZXEmptyData(self.mySecAccDataTableView, hqzxTwoEmptyManagers, nil);
}
- (void) moreWithCompletion:(Bool_Block) completion stateVer:(NSString*)type uitable:(UITableView*)table{
    [[NetHttpClient sharedHTTPClient] request: @"/coins_entrust_record.json" parameters: @{@"types":type,@"next_id":nextId?nextId:@"0", @"symbol": _sysId,@"auth_key":[HQZXUserModel sharedInstance].currentUser.auth_key} completion:^(id obj) {
        if (obj==nil) {
            [self.view makeToast:LocatizedStirngForkey(@"LIANJIEFUWUQISHIBAI") duration: 0.5 position: CSToastPositionCenter];
            if (completion) {
                completion(YES);
            }
            return;
        }
        NSString *errorCode = StrValueFromDictionary(obj, ApiKey_ErrorCode);
        if (![@"0" isEqualToString: errorCode]) {
            [self.view makeToast: [obj objectForKey:@"message"] duration: 0.5 position: CSToastPositionCenter];
            if (completion) {
                completion(YES);
            }
            return;
        }
        NSString *nextIdServer = StrValueFromDictionary(obj, @"next_id");
        NSArray *dataArray = [obj objectForKey: @"record_list"];
        
        if (nextIdServer != nil) {
            nextId = nextIdServer;
        }
        
        if(dataArray!=nil && dataArray.count>0){
            [_datas addObjectsFromArray: dataArray];
        }
        
        [table reloadData];
        if (completion) {
            if (nextIdServer) {
                completion(YES);
            } else {
                completion(NO);
            }
        }
    }];
}
- (void) refData:(Void_Block) completion stateVer:(NSString*)type uitable:(UITableView*)table{
    [[NetHttpClient sharedHTTPClient] request: @"/coins_trade_record.json" parameters:@{@"types":type,@"next_id":@"0", @"symbol": _sysId,@"auth_key":[HQZXUserModel sharedInstance].currentUser.auth_key} completion:^(id obj) {
        if (obj==nil) {
            [self.view makeToast: LocatizedStirngForkey(@"LIANJIEFUWUQISHIBAI") duration: 0.5 position: CSToastPositionCenter];
            if (completion) {
                completion();
            }
            return;
        }
        NSString *errorCode = StrValueFromDictionary(obj, ApiKey_ErrorCode);
        if (![@"0" isEqualToString: errorCode]) {
            [self.view makeToast: [obj objectForKey:@"message"] duration: 0.5 position: CSToastPositionCenter];
            if (completion) {
                completion();
            }
            return;
        }
        
        NSString *nextIdServer = StrValueFromDictionary(obj, @"next_id");
        
        if (nextIdServer != nil) {
            nextId = nextIdServer;
        }
        
        [_datas removeAllObjects];
        if ([obj objectForKey: @"record_list"] == nil) {
            
        } else {
            [_datas addObjectsFromArray: [obj objectForKey: @"record_list"]];
            //1 竞标中 2中标
        }
        [table reloadData];
        if (completion) {
            completion();
        }
    }];
}
-(void)clickButton{
    float bsHight = (SCREEN_WIDTH-6)/4;
    //买入
    buyView = [[UIView alloc] initWithFrame: CGRectMake(0, TOP_HEIGHT+8, bsHight, SCREEN_WIDTH/10)];
    buyView.backgroundColor = UIColorFromRGB(0x192834);
    [self.view addSubview:buyView];
    
    buyView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buyGe:)];
    [buyView addGestureRecognizer:tapGesture];
    
    UILabel *buylable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    buylable.text = LocatizedStirngForkey(@"MAIRU");
    buylable.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    buylable.textColor = [UIColor whiteColor];
    [buyView addSubview: buylable];
    [buylable sizeToFit];
    [buylable setX:(buyView.width-buylable.width)/2];
    [buylable setY:(buyView.height-buylable.height)/2];
    
    
    UIView *buyhenglineoneView = [[UIView alloc] initWithFrame: CGRectMake(0, TOP_HEIGHT+7, bsHight, 1)];
    buyhenglineoneView.backgroundColor = UIColorFromRGB(0x141D25);
    [self.view addSubview:buyhenglineoneView];
    
    UIView *buylineoneView = [[UIView alloc] initWithFrame: CGRectMake(buyView.maxX, buyView.y, 1, SCREEN_WIDTH/10)];
    buylineoneView.backgroundColor = UIColorFromRGB(0x141D25);
    [self.view addSubview:buylineoneView];
    
    UIView *buylinetwoView = [[UIView alloc] initWithFrame: CGRectMake(buylineoneView.maxX, buyView.y, 1, SCREEN_WIDTH/10)];
    buylinetwoView.backgroundColor = UIColorFromRGB(0x0D1318);
    [self.view addSubview:buylinetwoView];
    //卖出
    sellView = [[UIView alloc] initWithFrame: CGRectMake(buylinetwoView.maxX, buyView.y, bsHight, SCREEN_WIDTH/10)];
    sellView.backgroundColor = UIColorFromRGB(0x0F151A);
    [self.view addSubview:sellView];
    
    sellView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buytwoGe:)];
    [sellView addGestureRecognizer:tapGesture2];
    
    UILabel *selllable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    selllable.text = LocatizedStirngForkey(@"MAICHU");
    selllable.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    selllable.textColor = [UIColor whiteColor];
    [sellView addSubview: selllable];
    [selllable sizeToFit];
    [selllable setX:(sellView.width-selllable.width)/2];
    [selllable setY:(sellView.height-selllable.height)/2];
    
    UIView *buyhenglinetwoView = [[UIView alloc] initWithFrame: CGRectMake(buylinetwoView.maxX, TOP_HEIGHT+7, bsHight, 1)];
    buyhenglinetwoView.backgroundColor = UIColorFromRGB(0x141D25);
    [self.view addSubview:buyhenglinetwoView];
    
    UIView *selllineoneView = [[UIView alloc] initWithFrame: CGRectMake(sellView.maxX, sellView.y, 1, SCREEN_WIDTH/10)];
    buylineoneView.backgroundColor = UIColorFromRGB(0x141D25);
    [self.view addSubview:buylineoneView];
    
    UIView *selllinetwoView = [[UIView alloc] initWithFrame: CGRectMake(selllineoneView.maxX, buyView.y, 1, SCREEN_WIDTH/10)];
    buylinetwoView.backgroundColor = UIColorFromRGB(0x0D1318);
    [self.view addSubview:buylinetwoView];
    //转入
    buyTwoView = [[UIView alloc] initWithFrame: CGRectMake(selllinetwoView.maxX, sellView.y, bsHight, SCREEN_WIDTH/10)];
    buyTwoView.backgroundColor = UIColorFromRGB(0x0F151A);
    [self.view addSubview:buyTwoView];
    
    buyTwoView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture3=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sellGe:)];
    [buyTwoView addGestureRecognizer:tapGesture3];
    
    UILabel *buyTwolable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    buyTwolable.text = LocatizedStirngForkey(@"ZHUANRU");
    buyTwolable.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    NSString *language = [USER_DEFAULT objectForKey:kUserLanguage];
    if([language isEqualToString:@"en"]){
        buyTwolable.font = [UIFont systemFontOfSize: TRANSACTIONFONT];
    }
    buyTwolable.textColor = [UIColor whiteColor];
    [buyTwoView addSubview: buyTwolable];
    [buyTwolable sizeToFit];
    [buyTwolable setX:(buyTwoView.width-buyTwolable.width)/2];
    [buyTwolable setY:(buyTwoView.height-buyTwolable.height)/2];
    
    UIView *buytwohenglinetwoView = [[UIView alloc] initWithFrame: CGRectMake(selllinetwoView.maxX, TOP_HEIGHT+7, bsHight, 1)];
    buytwohenglinetwoView.backgroundColor = UIColorFromRGB(0x141D25);
    [self.view addSubview:buytwohenglinetwoView];
    
    UIView *selltwolineoneView = [[UIView alloc] initWithFrame: CGRectMake(buyTwoView.maxX, buyTwoView.y, 1, SCREEN_WIDTH/10)];
    selltwolineoneView.backgroundColor = UIColorFromRGB(0x141D25);
    [self.view addSubview:selltwolineoneView];
    
    UIView *selltwolinetwoView = [[UIView alloc] initWithFrame: CGRectMake(selltwolineoneView.maxX, buyTwoView.y, 1, SCREEN_WIDTH/10)];
    selltwolinetwoView.backgroundColor = UIColorFromRGB(0x0D1318);
    [self.view addSubview:selltwolinetwoView];
    
    //转出
    sellTwoView = [[UIView alloc] initWithFrame: CGRectMake(selltwolinetwoView.maxX, buyTwoView.y, bsHight, SCREEN_WIDTH/10)];
    sellTwoView.backgroundColor = UIColorFromRGB(0x0F151A);
    [self.view addSubview:sellTwoView];
    
    sellTwoView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture4=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selltwoGe:)];
    [sellTwoView addGestureRecognizer:tapGesture4];
    
    UILabel *selltwolable = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 1)];
    selltwolable.text = LocatizedStirngForkey(@"ZHUANCHU");
    selltwolable.font = [UIFont systemFontOfSize: TRANSACTIONFTHREE];
    selltwolable.textColor = [UIColor whiteColor];
    [sellTwoView addSubview: selltwolable];
    [selltwolable sizeToFit];
    [selltwolable setX:(sellTwoView.width-selltwolable.width)/2];
    [selltwolable setY:(sellTwoView.height-selltwolable.height)/2];
    
    UIView *buysshenglinetwoView = [[UIView alloc] initWithFrame: CGRectMake(selltwolinetwoView.maxX, TOP_HEIGHT+7, bsHight, 1)];
    buysshenglinetwoView.backgroundColor = UIColorFromRGB(0x141D25);
    [self.view addSubview:buysshenglinetwoView];
}
//买入
-(void)createScrollView{
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TOP_HEIGHT+SCREEN_WIDTH/10+16, SCREEN_WIDTH, SCREEN_HEIGHT-TOP_HEIGHT-SCREEN_WIDTH/10-16) ];
    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH*1.6, SCREEN_HEIGHT-TOP_HEIGHT-SCREEN_WIDTH/10-16);
    //    _scroll.showsHorizontalScrollIndicator = NO;
    //    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.bounces = NO;
    _scroll.delegate = self;
    _scroll.backgroundColor = UIColorFromRGB(0x0F151B);
    //设置边框，形成表格
    _scroll.layer.borderWidth = .5f;
    _scroll.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.view addSubview:_scroll];
    _scroll.hidden = NO;
}
//卖出
-(void)createTwoScrollView{
    _scrollTwo = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TOP_HEIGHT+SCREEN_WIDTH/10+16, SCREEN_WIDTH, SCREEN_HEIGHT-TOP_HEIGHT-SCREEN_WIDTH/10-16) ];
    _scrollTwo.contentSize = CGSizeMake(SCREEN_WIDTH*1.6, SCREEN_HEIGHT-TOP_HEIGHT-SCREEN_WIDTH/10-16);
    //    _scroll.showsHorizontalScrollIndicator = NO;
    //    _scroll.showsVerticalScrollIndicator = NO;
    _scrollTwo.bounces = NO;
    _scrollTwo.delegate = self;
    _scrollTwo.backgroundColor = UIColorFromRGB(0x0F151B);
    //设置边框，形成表格
    _scrollTwo.layer.borderWidth = .5f;
    _scrollTwo.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.view addSubview:_scrollTwo];
    _scrollTwo.hidden = YES;
}
//转入
-(void)createAccScrollView{
    _accscroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TOP_HEIGHT+SCREEN_WIDTH/10+16, SCREEN_WIDTH, SCREEN_HEIGHT-TOP_HEIGHT-SCREEN_WIDTH/10-16) ];
    _accscroll.contentSize = CGSizeMake(SCREEN_WIDTH*1.6, SCREEN_HEIGHT-TOP_HEIGHT-SCREEN_WIDTH/10-16);
    //    _scroll.showsHorizontalScrollIndicator = NO;
    //    _scroll.showsVerticalScrollIndicator = NO;
    _accscroll.bounces = NO;
    _accscroll.delegate = self;
    _accscroll.backgroundColor = UIColorFromRGB(0x0F151B);
    //设置边框，形成表格
    _accscroll.layer.borderWidth = .5f;
    _accscroll.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.view addSubview:_accscroll];
    _accscroll.hidden = YES;
}
//转出
-(void)createTwoAccScrollView{
    _accscrollTwo = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TOP_HEIGHT+SCREEN_WIDTH/10+16, SCREEN_WIDTH, SCREEN_HEIGHT-TOP_HEIGHT-SCREEN_WIDTH/10-16) ];
    _accscrollTwo.contentSize = CGSizeMake(SCREEN_WIDTH*1.6, SCREEN_HEIGHT-TOP_HEIGHT-SCREEN_WIDTH/10-16);
    //    _scroll.showsHorizontalScrollIndicator = NO;
    //    _scroll.showsVerticalScrollIndicator = NO;
    _accscrollTwo.bounces = NO;
    _accscrollTwo.delegate = self;
    _accscrollTwo.backgroundColor = UIColorFromRGB(0x0F151B);
    //设置边框，形成表格
    _accscrollTwo.layer.borderWidth = .5f;
    _accscrollTwo.layer.borderColor = [UIColor blackColor].CGColor;
    
    [self.view addSubview:_accscrollTwo];
    _accscrollTwo.hidden = YES;
}
//买入
-(void)createTableTwoView{
    UITableView *tableTwoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH*1.6, SCREEN_WIDTH/8) style:UITableViewStyleGrouped];
    tableTwoView.scrollEnabled = NO;
    tableTwoView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableTwoView.dataSource = self;
    // 设置tableView的委托
    tableTwoView.delegate = self;
    tableTwoView.backgroundColor = UIColorFromRGB(0x0F151A);
    self.myAccTwoTableView = tableTwoView;
    [self.myAccTwoTableView registerClass:[HQZXTransactionTableCell class] forCellReuseIdentifier:@"CustomHeaderOne"];
    [_scroll addSubview:self.myAccTwoTableView];
}
-(void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.myAccTwoTableView.maxY , SCREEN_WIDTH*1.6, SCREEN_HEIGHT-TOP_HEIGHT - SCREEN_WIDTH/8) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableView.dataSource = self;
    // 设置tableView的委托
    tableView.delegate = self;
    tableView.backgroundColor = UIColorFromRGB(0x0F151A);
    self.myAccTableView = tableView;
    
    [self.myAccTableView registerClass:[HQZXDataTranTableCell class] forCellReuseIdentifier:@"CustomHeaderTwo"];
    [_scroll addSubview:self.myAccTableView];
    WEAK_SELF
    self.myAccTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself refData:^{
            [weakself.myAccTableView.mj_header endRefreshing];
            [weakself.myAccTableView.mj_footer resetNoMoreData];
        } stateVer:@"1" uitable:self.myAccTableView];
    }];
    self.myAccTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if([nextId isEqualToString:@"0"]==NO){
            [weakself moreWithCompletion:^(BOOL value) {
                [weakself.myAccTableView.mj_footer endRefreshing];
                if (value) {
                    [weakself.myAccTableView.mj_footer resetNoMoreData];
                } else {
                    [weakself.myAccTableView.mj_footer endRefreshingWithNoMoreData];
                }
            } stateVer:@"1" uitable:self.myAccTableView];
        }else{
            [weakself.myAccTableView.mj_footer endRefreshingWithNoMoreData];
            [weakself.view makeToast:@"全部加载完毕" duration:1 position:CSToastPositionCenter];
        }
    }];
}
//卖出
-(void)createSellTableTwoView{
    UITableView *tableSellTwoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH*1.6, SCREEN_WIDTH/8) style:UITableViewStyleGrouped];
    tableSellTwoView.scrollEnabled = NO;
    tableSellTwoView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableSellTwoView.dataSource = self;
    // 设置tableView的委托
    tableSellTwoView.delegate = self;
    tableSellTwoView.backgroundColor = UIColorFromRGB(0x0F151A);
    self.mySecAccTwoTableView = tableSellTwoView;
    [self.mySecAccTwoTableView registerClass:[HQZXTransactionTableCell class] forCellReuseIdentifier:@"CustomHeaderOne"];
    [_scrollTwo addSubview:self.mySecAccTwoTableView];
}
-(void)createSellTableView{
    UITableView *tableSellView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.myAccTwoTableView.maxY , SCREEN_WIDTH*1.6, SCREEN_HEIGHT-TOP_HEIGHT - SCREEN_WIDTH/8) style:UITableViewStyleGrouped];
    tableSellView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableSellView.dataSource = self;
    // 设置tableView的委托
    tableSellView.delegate = self;
    tableSellView.backgroundColor = UIColorFromRGB(0x0F151A);
    self.mySecAccTableView = tableSellView;
    
    [self.mySecAccTableView registerClass:[HQZXDataTranTableCell class] forCellReuseIdentifier:@"CustomHeaderTwo"];
    [_scrollTwo addSubview:self.mySecAccTableView];
    WEAK_SELF
    self.mySecAccTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself refData:^{
            [weakself.mySecAccTableView.mj_header endRefreshing];
            [weakself.mySecAccTableView.mj_footer resetNoMoreData];
        } stateVer:@"2" uitable:self.mySecAccTableView];
    }];
    self.mySecAccTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if([nextId isEqualToString:@"0"]==NO){
            [weakself moreWithCompletion:^(BOOL value) {
                [weakself.mySecAccTableView.mj_footer endRefreshing];
                if (value) {
                    [weakself.mySecAccTableView.mj_footer resetNoMoreData];
                } else {
                    [weakself.mySecAccTableView.mj_footer endRefreshingWithNoMoreData];
                }
            } stateVer:@"2" uitable:self.mySecAccTableView];
        }else{
            [weakself.mySecAccTableView.mj_footer endRefreshingWithNoMoreData];
            [weakself.view makeToast:@"全部加载完毕" duration:1 position:CSToastPositionCenter];
        }
    }];
    
}
//转入
-(void)createAccTableTwoView{
    UITableView *tableAccTwoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH*1.6, SCREEN_WIDTH/8) style:UITableViewStyleGrouped];
    tableAccTwoView.scrollEnabled = NO;
    tableAccTwoView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableAccTwoView.dataSource = self;
    // 设置tableView的委托
    tableAccTwoView.delegate = self;
    tableAccTwoView.backgroundColor = UIColorFromRGB(0x0F151A);
    self.myAccDataTwoTableView = tableAccTwoView;
    [self.myAccDataTwoTableView registerClass:[HQZXTransactionTableCell class] forCellReuseIdentifier:@"CustomAccHeaderOne"];
    [_accscroll addSubview:self.myAccDataTwoTableView];
}
-(void)createAccTableView{
    UITableView *tableAccView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.myAccDataTwoTableView.maxY , SCREEN_WIDTH*1.6, SCREEN_HEIGHT-TOP_HEIGHT - SCREEN_WIDTH/8) style:UITableViewStyleGrouped];
    tableAccView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableAccView.dataSource = self;
    // 设置tableView的委托
    tableAccView.delegate = self;
    tableAccView.backgroundColor = UIColorFromRGB(0x0F151A);
    self.myAccDataTableView = tableAccView;
    
    [self.myAccDataTableView registerClass:[HQZXDataTranTableCell class] forCellReuseIdentifier:@"CustomAccHeaderTwo"];
    [_accscroll addSubview:self.myAccDataTableView];
    WEAK_SELF
    self.myAccDataTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself refData:^{
            [weakself.myAccDataTableView.mj_header endRefreshing];
            [weakself.myAccDataTableView.mj_footer resetNoMoreData];
        } stateVer:@"3" uitable:self.myAccDataTableView];
    }];
    self.myAccDataTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if([nextId isEqualToString:@"0"]==NO){
            [weakself moreWithCompletion:^(BOOL value) {
                [weakself.myAccDataTableView.mj_footer endRefreshing];
                if (value) {
                    [weakself.myAccDataTableView.mj_footer resetNoMoreData];
                } else {
                    [weakself.myAccDataTableView.mj_footer endRefreshingWithNoMoreData];
                }
            } stateVer:@"3" uitable:self.myAccDataTableView];
        }else{
            [weakself.myAccDataTableView.mj_footer endRefreshingWithNoMoreData];
            [weakself.view makeToast:@"全部加载完毕" duration:1 position:CSToastPositionCenter];
        }
    }];
}
//转出
-(void)createOutAccTableTwoView{
    UITableView *tableOutAccTwoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH*1.6, SCREEN_WIDTH/8) style:UITableViewStyleGrouped];
    tableOutAccTwoView.scrollEnabled = NO;
    tableOutAccTwoView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableOutAccTwoView.dataSource = self;
    // 设置tableView的委托
    tableOutAccTwoView.delegate = self;
    tableOutAccTwoView.backgroundColor = UIColorFromRGB(0x0F151A);
    self.mySecAccDataTwoTableView = tableOutAccTwoView;
    [self.mySecAccDataTwoTableView registerClass:[HQZXTransactionTableCell class] forCellReuseIdentifier:@"CustomAccHeaderOne"];
    [_accscrollTwo addSubview:self.mySecAccDataTwoTableView];
}
-(void)createOutAccTableView{
    UITableView *tableOutAccView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.myAccDataTwoTableView.maxY , SCREEN_WIDTH*1.6, SCREEN_HEIGHT-TOP_HEIGHT - SCREEN_WIDTH/8) style:UITableViewStyleGrouped];
    tableOutAccView.separatorStyle = UITableViewCellSelectionStyleNone;
    // 设置tableView的数据源
    tableOutAccView.dataSource = self;
    // 设置tableView的委托
    tableOutAccView.delegate = self;
    tableOutAccView.backgroundColor = UIColorFromRGB(0x0F151A);
    self.mySecAccDataTableView = tableOutAccView;
    
    [self.mySecAccDataTableView registerClass:[HQZXDataTranTableCell class] forCellReuseIdentifier:@"CustomAccHeaderTwo"];
    [_accscrollTwo addSubview:self.mySecAccDataTableView];
    WEAK_SELF
    self.mySecAccDataTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself refData:^{
            [weakself.mySecAccDataTableView.mj_header endRefreshing];
            [weakself.mySecAccDataTableView.mj_footer resetNoMoreData];
        } stateVer:@"4" uitable:self.mySecAccDataTableView];
    }];
    self.mySecAccDataTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if([nextId isEqualToString:@"0"]==NO){
            [weakself moreWithCompletion:^(BOOL value) {
                [weakself.mySecAccDataTableView.mj_footer endRefreshing];
                if (value) {
                    [weakself.mySecAccDataTableView.mj_footer resetNoMoreData];
                } else {
                    [weakself.mySecAccDataTableView.mj_footer endRefreshingWithNoMoreData];
                }
            } stateVer:@"4" uitable:self.mySecAccDataTableView];
        }else{
            [weakself.mySecAccDataTableView.mj_footer endRefreshingWithNoMoreData];
            [weakself.view makeToast:@"全部加载完毕" duration:1 position:CSToastPositionCenter];
        }
    }];
    
}
// 设置块的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_WIDTH/8;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([tableView isEqual:self.myAccTableView]){
        return _datas.count;
    }else if([tableView isEqual:self.myAccTwoTableView]){
        return 1;
    }else if([tableView isEqual:self.mySecAccTableView]){
        return _datas.count;
    }else if([tableView isEqual:self.mySecAccTwoTableView]){
        return 1;
    }else if([tableView isEqual:self.myAccDataTableView]){
        return _datas.count;
    }else if([tableView isEqual:self.myAccDataTwoTableView]){
        return 1;
    }else if([tableView isEqual:self.mySecAccDataTableView]){
        return _datas.count;
    }else if([tableView isEqual:self.mySecAccDataTwoTableView]){
        return 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=nil;
    NSUInteger section = [indexPath section];
    if([tableView isEqual:self.myAccTableView]){
        cell =[tableView dequeueReusableCellWithIdentifier:@"CustomHeaderTwo"];
        id btbData;
        if(_datas.count>0){
            btbData = [_datas objectAtIndex:section];
        }
        HQZXDataTranTableCell *cellen = (HQZXDataTranTableCell*) cell;
        if(btbData){
            cellen.state = @"1";
            cellen.time = StrValueFromDictionary(btbData, @"time");
            cellen.volume = StrValueFromDictionary(btbData, @"volume");
            cellen.money = StrValueFromDictionary(btbData, @"dealmoney");
            cellen.price = StrValueFromDictionary(btbData, @"price");
            cellen.fee = StrValueFromDictionary(btbData, @"fee");
        }
    }else if([tableView isEqual:self.myAccTwoTableView]){
        cell =[tableView dequeueReusableCellWithIdentifier:@"CustomHeaderOne"];
    }else if([tableView isEqual:self.mySecAccTableView]){
        cell =[tableView dequeueReusableCellWithIdentifier:@"CustomHeaderTwo"];
        id btbData;
        if(_datas.count>0){
            btbData = [_datas objectAtIndex:section];
        }
        HQZXDataTranTableCell *cellen = (HQZXDataTranTableCell*) cell;
        if(btbData){
            cellen.state = @"2";
            cellen.time = StrValueFromDictionary(btbData, @"time");
            cellen.volume = StrValueFromDictionary(btbData, @"volume");
            cellen.money = StrValueFromDictionary(btbData, @"dealmoney");
            cellen.price = StrValueFromDictionary(btbData, @"price");
            cellen.fee = StrValueFromDictionary(btbData, @"fee");
        }
    }else if([tableView isEqual:self.mySecAccTwoTableView]){
        cell =[tableView dequeueReusableCellWithIdentifier:@"CustomHeaderOne"];
    }else if([tableView isEqual:self.myAccDataTableView]){
        cell =[tableView dequeueReusableCellWithIdentifier:@"CustomAccHeaderTwo"];
        id btbData;
        if(_datas.count>0){
            btbData = [_datas objectAtIndex:section];
        }
        HQZXDataTranTableCell *cellen = (HQZXDataTranTableCell*) cell;
        if(btbData){
            cellen.state = @"3";
            cellen.time = StrValueFromDictionary(btbData, @"time");
            cellen.volume = StrValueFromDictionary(btbData, @"volume");
            cellen.money = StrValueFromDictionary(btbData, @"money");
            cellen.price = StrValueFromDictionary(btbData, @"price");
            cellen.fee = StrValueFromDictionary(btbData, @"fee");
        }
    }else if([tableView isEqual:self.myAccDataTwoTableView]){
        cell =[tableView dequeueReusableCellWithIdentifier:@"CustomAccHeaderOne"];
    }else if([tableView isEqual:self.mySecAccDataTableView]){
        cell =[tableView dequeueReusableCellWithIdentifier:@"CustomAccHeaderTwo"];
        id btbData;
        if(_datas.count>0){
            btbData = [_datas objectAtIndex:section];
        }
        HQZXDataTranTableCell *cellen = (HQZXDataTranTableCell*) cell;
        if(btbData){
            cellen.state = @"4";
            cellen.time = StrValueFromDictionary(btbData, @"time");
            cellen.volume = StrValueFromDictionary(btbData, @"volume");
            cellen.money = StrValueFromDictionary(btbData, @"money");
            cellen.price = StrValueFromDictionary(btbData, @"price");
            cellen.fee = StrValueFromDictionary(btbData, @"fee");
        }
    }else if([tableView isEqual:self.mySecAccDataTwoTableView]){
        cell =[tableView dequeueReusableCellWithIdentifier:@"CustomAccHeaderOne"];
    }
    
    //    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if(cell==nil){
    //        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    //    }
    //    cell.backgroundColor = UIColorFromRGB(0x0F151A);
    //    cell.textLabel.text = @"sdkahskfhaks";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //push后cell选中效果消失,又动画
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)buyGe:(UITapGestureRecognizer *)gesture {
    buyView.backgroundColor = UIColorFromRGB(0x192834);
    sellView.backgroundColor = UIColorFromRGB(0x0F151A);
    buyTwoView.backgroundColor = UIColorFromRGB(0x0F151A);
    sellTwoView.backgroundColor = UIColorFromRGB(0x0F151A);
    _scroll.hidden = NO;
    _scrollTwo.hidden = YES;
    _accscroll.hidden = YES;
    _accscrollTwo.hidden = YES;
    [self.myAccTableView.mj_header beginRefreshing];
    
    
}
- (void)buytwoGe:(UITapGestureRecognizer *)gesture {
    buyView.backgroundColor = UIColorFromRGB(0x0F151A);
    sellView.backgroundColor = UIColorFromRGB(0x192834);
    buyTwoView.backgroundColor = UIColorFromRGB(0x0F151A);
    sellTwoView.backgroundColor = UIColorFromRGB(0x0F151A);
    _scroll.hidden = YES;
    _scrollTwo.hidden = NO;
    _accscroll.hidden = YES;
    _accscrollTwo.hidden = YES;
    [self.mySecAccTableView.mj_header beginRefreshing];
    
    
}
- (void)sellGe:(UITapGestureRecognizer *)gesture {
    buyView.backgroundColor = UIColorFromRGB(0x0F151A);
    sellView.backgroundColor = UIColorFromRGB(0x0F151A);
    buyTwoView.backgroundColor = UIColorFromRGB(0x192834);
    sellTwoView.backgroundColor = UIColorFromRGB(0x0F151A);
    _scroll.hidden = YES;
    _scrollTwo.hidden = YES;
    _accscroll.hidden = NO;
    _accscrollTwo.hidden = YES;
    [self.myAccDataTableView.mj_header beginRefreshing];
    
}

- (void)selltwoGe:(UITapGestureRecognizer *)gesture {
    buyView.backgroundColor = UIColorFromRGB(0x0F151A);
    sellView.backgroundColor = UIColorFromRGB(0x0F151A);
    buyTwoView.backgroundColor = UIColorFromRGB(0x0F151A);
    sellTwoView.backgroundColor = UIColorFromRGB(0x192834);
    _scroll.hidden = YES;
    _scrollTwo.hidden = YES;
    _accscroll.hidden = YES;
    _accscrollTwo.hidden = NO;
    [self.mySecAccDataTableView.mj_header beginRefreshing];
}
@end
