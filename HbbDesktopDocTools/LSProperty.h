//
//  LSProperty.h
//  HbbDesktopDocTools
//
//  Created by dev on 2018/7/17.
//  Copyright © 2018年 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSProperty : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *isNecessary;

@property (nonatomic, strong) NSString *tips;

@property (nonatomic, strong) NSString *remark;

@property (nonatomic, strong) NSString *defaultValue;

@end
