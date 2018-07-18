//
//  AppDelegate.h
//  HbbDesktopDocTools
//
//  Created by dev on 2018/7/17.
//  Copyright © 2018年 dev. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>


///应用唯一编号  必须:是   示例值:410201518433026
@property (nonatomic, strong) NSString *AppID;
///应用密钥  必须:是   示例值:3320153225100
@property (nonatomic, strong) NSString *Secret;
///货宝宝企业号  必须:是   示例值:881000000001
@property (nonatomic, strong) NSString *EntID;
///企业名称  必须:是   示例值:货宝宝网络科技有限公司
@property (nonatomic, strong) NSString *EntName;
///货宝宝个人号  必须:是   示例值:888996096717
@property (nonatomic, strong) NSString *UserID;
///真实姓名  必须:是   示例值:张三
@property (nonatomic, strong) NSString *UserName;
///业务流水号  必须:是   示例值:00000001
@property (nonatomic, strong) NSString *BSN;
///32  必须:是   示例值:c4ca4238a0b923820dcc509a6f75849b
@property (nonatomic, strong) NSString *Sign;
///本地单据号  必须:是   示例值:20180313101010
@property (nonatomic, strong) NSString *LocalSheetID;
///单据类型：  必须:是   示例值:CustExpenseSheet
@property (nonatomic, strong) NSString *SheetType;
///伙伴编号  必须:是   示例值:881000000009
@property (nonatomic, strong) NSString *PnID;
///内部编号  必须:是   示例值:0
@property (nonatomic, strong) NSString *PnCode;
///伙伴名称  必须:是   示例值:散客
@property (nonatomic, strong) NSString *PnName;
///伙伴关联企业号  必须:否
@property (nonatomic, strong) NSString *PnLinkEntID;
///伙伴图片  必须:是   示例值:PnImg.jpg
@property (nonatomic, strong) NSString *PnImg;
///分支机构编号  必须:否
@property (nonatomic, strong) NSString *BranchID;
///分支机构名称  必须:否
@property (nonatomic, strong) NSString *BranchName;
///单据日期（  必须:是   示例值:2018-03-22
@property (nonatomic, strong) NSDate *SheetDate;
///经手人货宝宝个人号  必须:是   示例值:888996096717
@property (nonatomic, strong) NSString *FollowUserID;
///经手人货宝宝员工编号  必须:否   示例值:13800000000
@property (nonatomic, strong) NSString *FollowUserCode;
///经手人货宝宝个人名称  必须:是   示例值:张三
@property (nonatomic, strong) NSString *FollowUserName;
///经手人部门编号  必须:是   示例值:414485140
@property (nonatomic, strong) NSString *DepID;
///经手人部门内部编号  必须:否   示例值:0003
@property (nonatomic, strong) NSString *DepCode;
///经手人部门名称  必须:是   示例值:六楼
@property (nonatomic, strong) NSString *DepName;
///付款账户编号  必须:是   示例值:881000000001223
@property (nonatomic, strong) NSString *PayAcctId;
///付款账户外部编号  必须:是   示例值:1223
@property (nonatomic, strong) NSString *PayAcctCode;
///付款账户名  必须:是   示例值:现金
@property (nonatomic, strong) NSString *PayAcctName;
///费用金额  必须:是   示例值:2000
@property (nonatomic, strong) NSDecimalNumber *Amo;
///费用凭证图片  必须:否
@property (nonatomic, strong) NSString *ExpenseImg;
///单据备注  必须:否
@property (nonatomic, strong) NSString *Remark;


@end

