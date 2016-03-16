//
//  YQUserResult.m
//  sinaWeibo8
//
//  Created by apple on 16/3/15.
//  Copyright © 2016年 Qifeng Yan. All rights reserved.
//

#import "YQUserResult.h"

@implementation YQUserResult


- (int)messageCount {
    return _cmt + _dm + _mention_cmt + _mention_status;
}

- (int)totalCount {
    return self.messageCount + _follower + _status;
}

@end
