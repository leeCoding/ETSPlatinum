//
//  ETSUPnPDevice.m
//  ETSPlatinum
//
//  Created by Nil on 16/12/20.
//

#import "ETSUPnPDeviceManager.h"
#import <Platinum/Platinum.h>
#import <Platinum/PltUPnPObject.h>
#include "ETSUPnPDevice.hpp"
#import "ETSUPnPDeviceObject.h"
#import "XMLDictionary.h"

@interface ETSUPnPDeviceManager ()
<
    ETSUPnPDeviceObjectDelegate
>

@property(nonatomic,strong)PLT_UPnPObject *upnpObject;  ///<  控制设备
@property(nonatomic,strong)PLT_ActionObject *action;    ///<  动作对象

@end

@implementation ETSUPnPDeviceManager

+ (ETSUPnPDeviceManager *)shareManager {
    
    static ETSUPnPDeviceManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[self alloc]init];
        
    });
    return manager;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _upnpObject = [[PLT_UPnPObject alloc] init];
    }
    return self;
}

- (void)addHostDevice {
    
    ETSUPnPDeviceObject *deviceObject = [[ETSUPnPDeviceObject alloc]initWithFriendName:@"WiClass:林肖02" UDIDString:@"271827381273"];
    deviceObject.delegate = self;
    
    [_upnpObject addDevice:deviceObject];
    
    NPT_Result result =[_upnpObject start];
    if (result) {
        
        NSLog(@"启动失败");
        
    }else {
        
        NSLog(@"启动成功");
    }

}

- (void)stopDevice {
    
    if ([_upnpObject isRunning]) {
        
        NPT_Result result = [_upnpObject stop];
        NSLog(@"停止 %d",result);
    }
}

- (NPT_Result)onActionEvent:(PLT_ActionObject *)action arguments:(NSDictionary *)arguments {


    NSLog(@" arguments %@",arguments);
    
    _action = action;
    
    [self reply];
        
    return NPT_SUCCESS;
}

- (void)reply {
    
    
    [_action setValue:@"ReplyContent" forArgument:@"Result"];
}



@end
