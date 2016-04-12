//
//  ViewController.m
//  CoreSpotLightDemo
//
//  Created by 鞠鹏 on 16/4/12.
//  Copyright © 2016年 JuPeng. All rights reserved.
//

#import "ViewController.h"
#import <CoreSpotlight/CoreSpotlight.h>
@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    [self createMetaData];

}

- (void)createMetaData{
    
    
    /**
     *  创建索引所需的元数据
     */
    CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc]initWithItemContentType:@"contact"];
    attributeSet.title = @"英雄";
    attributeSet.contentDescription = @"我的常用英雄";
    attributeSet.keywords = @[@"机械先驱",@"维克托",@"三只手"];
    attributeSet.thumbnailData = UIImagePNGRepresentation([UIImage imageNamed:@"Victor"]);
    
    
    /**
     *  创建索引
     */
    CSSearchableItem *searchableItem = [[CSSearchableItem alloc]initWithUniqueIdentifier:@"199304120326" domainIdentifier:@"jupeng19930518@163.com" attributeSet:attributeSet];

    searchableItem.expirationDate = [NSDate dateWithTimeIntervalSinceNow:3600];

    /**
     *  uniqueIdentifier：在应用程序中这个值是惟一的，由于这个可以以用于索引的更新、删除索引是唯一的，推荐使用uuid或者是搜索的条目的主键
     *  domainIdentifier:domainIdentifier:一个可选的标识符，用来表示item的域(domain)或者所有者，这个可能用一个账户的邮箱作为identifier来索引数据，并且当账户删除的时候可以根据这个来删除数据，一般情况下domainIdentifier应该是这种格式.并且不能包含时间
     
     *  expirationDate:过期的日期，默认过期的日期是一个月
     */
    
    /**
     *  将索引加入到CoreSpotlight
     */
    [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:@[searchableItem] completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",[error localizedDescription]);
        }
    }];
}


- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler {
    if([userActivity.activityType isEqualToString:CSSearchableItemActionType]) {
        NSString *uniqueIdentifier = userActivity.userInfo[CSSearchableItemActivityIdentifier];
        //这里根据这个uniqueIdentifier可以跳转到详细信息页面
        return YES;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
