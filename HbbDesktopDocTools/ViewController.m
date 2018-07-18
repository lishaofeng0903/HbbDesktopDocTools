//
//  ViewController.m
//  HbbDesktopDocTools
//
//  Created by dev on 2018/7/17.
//  Copyright © 2018年 dev. All rights reserved.
//

#import "ViewController.h"
#import "TFHpple.h"
#import "LSProperty.h"

@interface ViewController ()

@property (unsafe_unretained) IBOutlet NSTextView *textView;

@property (assign) NSRect rect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}
- (IBAction)pasteButtonDidClick:(NSButton *)sender {
    NSPasteboard *paste = [NSPasteboard generalPasteboard];
    if ([paste canReadItemWithDataConformingToTypes:@[NSPasteboardTypeHTML]]) {
        NSData *data = [paste dataForType:NSPasteboardTypeHTML];
        NSMutableArray <LSProperty *> *propertys = [self getPropertysWithData:data];
        
        NSString *str = [self transformWithPropertys:propertys];
        
        self.textView.string = str;
    }else{
        self.textView.string = @"识别不到";
    }
}

- (IBAction)copyButtonDidClick:(NSButton *)sender {
    NSPasteboard *paste = [NSPasteboard generalPasteboard];
    
    [paste declareTypes:[NSArray arrayWithObject: NSStringPboardType] owner:nil];
    [paste setString:self.textView.string forType: NSStringPboardType];
}



- (NSString *)transformWithPropertys:(NSMutableArray <LSProperty *> *)propertys{
    NSMutableString *finalPropertyString = [[NSMutableString alloc] init];
    for (LSProperty *lsProperty in propertys) {
        NSMutableString *propertyString = [[NSMutableString alloc] init];

        NSString *remark = [self isStringEmpty:lsProperty.remark]?@"":[NSString stringWithFormat:@"%@ ",lsProperty.remark];
        NSString *isNecessary = [self isStringEmpty:lsProperty.isNecessary]?@"":[NSString stringWithFormat:@" 必须:%@  ",lsProperty.isNecessary];
        NSString *tips = [self isStringEmpty:lsProperty.tips]?@"":[NSString stringWithFormat:@" 示例值:%@  ",lsProperty.tips];
        NSString *defaultValue = [self isStringEmpty:lsProperty.defaultValue]?@"":[NSString stringWithFormat:@" 默认值:%@",lsProperty.defaultValue];
        
        NSString *mark = [NSString stringWithFormat:@"\n///%@%@%@%@\n",remark,isNecessary,tips,defaultValue];
        [propertyString appendString:mark];
        
        NSString *type = [self getType:lsProperty];
        NSString *property = [NSString stringWithFormat:@"@property (nonatomic, strong) %@%@;",type,lsProperty.name];
        [propertyString appendString:property];
        
        [finalPropertyString appendString:propertyString];
    }
    
    [finalPropertyString appendString:@"\n"];
    
    return finalPropertyString;
}

- (NSString *)getType:(LSProperty *)property{
    NSString *transformType = @"";
    
    NSString *orilType = [property.type lowercaseString];
    if ([orilType containsString:@"varchar"]) {
        transformType = @"NSString";
    }else if ([orilType containsString:@"int"]){
        transformType = @"NSNumber";
    }else if ([orilType containsString:@"decimal"]){
        transformType = @"NSDecimalNumber";
    }else if ([orilType containsString:@"date"]){
        transformType = @"NSDate";
    }
    
    return [NSString stringWithFormat:@"%@ *",transformType];
}

//- (NSString *)getModifierWithProperty:(LSProperty *)property{
//    NSMutableString *modifierString = [[NSMutableString alloc] init];
//    NSString *modifier = @"";
//    NSString *type = [property.type lowercaseString];
//    if ([type containsString:@"varchar"] || [type containsString:@"datetime"] || [type containsString:@"decimal"]) {
//        modifier = @"strong";
//    }
//}

- (NSMutableArray <LSProperty *> *)getPropertysWithData:(NSData *)data{
    TFHpple *document = [[TFHpple alloc] initWithHTMLData:data];
    
    NSArray <TFHppleElement *> *tables = [document searchWithXPathQuery:@"//table"];
    TFHppleElement *table = [tables firstObject];
    TFHppleElement *tbody = [[table children] firstObject];
    NSArray <TFHppleElement *> *trs = [tbody children];
    
    NSMutableArray *keyArray = [[NSMutableArray alloc] init];
    NSMutableArray <LSProperty *> *propertys = [[NSMutableArray alloc] init];
    for (TFHppleElement *tr in trs) {
        //如果不是第一行
        if (tr != [trs firstObject]) {
            LSProperty *property = [[LSProperty alloc] init];
            NSArray <TFHppleElement *> *tds = [tr children];
            for (int i = 0; i < keyArray.count; i++) {
                NSArray <TFHppleElement *> *spanArray = [tds[i] searchWithXPathQuery:@"//span"];
                NSMutableString *contentString = [[NSMutableString alloc] init];
                for (TFHppleElement *span in spanArray) {
                    [contentString appendString:span.content];
                }
                [property setValue:contentString forKey:keyArray[i]];
            }
            [propertys addObject:property];
        }else{
            NSArray <TFHppleElement *> *firstTds = [tr children];
            for (int i = 0; i < firstTds.count; i++) {
                TFHppleElement *ele = [[firstTds[i] searchWithXPathQuery:@"//span"] firstObject];
                NSString *content = ele.content;
                if ([content isEqualToString:@"名称"]) {
                    [keyArray addObject:@"name"];
                }else if ([content isEqualToString:@"类型"]){
                    [keyArray addObject:@"type"];
                }else if ([content isEqualToString:@"必须"]){
                    [keyArray addObject:@"isNecessary"];
                }else if ([content isEqualToString:@"示例值"]){
                    [keyArray addObject:@"tips"];
                }else if ([content isEqualToString:@"默认值"]){
                    [keyArray addObject:@"defaultValue"];
                }else if ([content isEqualToString:@"描述"]){
                    [keyArray addObject:@"remark"];
                }
            }
        }
    }
    return propertys;
}


- (BOOL)isFirstTr:(TFHppleElement *)element{
    NSString *class = element.attributes[@"class"];
    if ([self isStringEmpty:class] == NO && [class isEqualToString:@"firstRow"]) {
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)isStringEmpty:(NSString *)str{
    if (str == nil) {
        return YES;
    }else if (str.length == 0){
        return YES;
    }else if ([str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        return YES;
    }else{
        return NO;
    }
}


@end
