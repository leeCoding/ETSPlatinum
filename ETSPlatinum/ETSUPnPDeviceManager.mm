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

// UPnP Service keys
#define kWCUpnpKeyModuleName    @"ModuleName"
#define kWCUpnpKeyAPIName       @"APIName"
#define kWCUpnpKeyParameter     @"Parameter"
#define kWCUpnpKeyOption        @"Option"
#define kWCUpnpKeyResult        @"Result"

//UPnP Service Module Name
#define kWCMNScreenShare        @"ScreenShare"
#define kWCMNQuiz               @"Quiz"
#define kWCMNDeviceManager      @"DeviceManager"
#define kWCMNFileTransfer       @"FileTransfer"
#define kWCMNStudent            @"Student"

//3.DeviceManager
#define kWCAPINGetInformation   @"GetInformation"
#define kWCAPINSetInformation   @"SetInformation"
#define kWCAPINSetGroup         @"SetGroup"
#define kWCAPINGetGroup         @"GetGroup"
#define kWCAPINCancelGroup      @"CancelGroup"
#define kWCAPINLockScreen       @"LockScreen"
#define kWCAPINUnlockScreen     @"UnlockScreen"
#define kWCAPINInitialize       @"Initialize"
#define kWCAPINLaunchApp        @"LaunchApp"
#define kWCAPINShutdown         @"Shutdown"
#define kWCAPINShowMessage      @"ShowMessage"
#define kWCAPINGoHome           @"GoHome"
#define kWCAPINGetLog           @"GetLog"
#define kWCAPINSetEnvironment   @"SetEnvironment" //这个命令是当每次教室端登录会调用
#define kWXAPINGetPerformance   @"GetPerformance"


@interface ETSUPnPDeviceManager ()
<
    ETSUPnPDeviceObjectDelegate
>

@property(nonatomic,strong)PLT_UPnPObject *upnpObject; ///<  控制设备
@property(nonatomic,strong)PLT_ActionObject *action;

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

    NSString *moduleName = arguments[kWCUpnpKeyModuleName];
    NSString *apiName = arguments[kWCUpnpKeyAPIName];
    NSString *xmlString = arguments[kWCUpnpKeyParameter];
    NSDictionary *xmlDic = [NSDictionary dictionaryWithXMLString:xmlString];
    
    NSLog(@" moduleName %@ apiName = %@ parameter = %@ parameterString = %@",moduleName,apiName,xmlDic,xmlString);
    
    _action = action;
    
    if ([moduleName isEqualToString:kWCMNDeviceManager]) {
        
        if ([apiName isEqualToString:kWCAPINGetInformation]) {
            
            [self reply];
        }
        
    }
        
    return NPT_SUCCESS;
}

- (void)reply {
    
    NSString *result = @"<root><return>0</return><uid>027001712001</uid><name>李丽01</name><classitem><id>002</id><class>七（12）班</class><grade>七年级</grade></classitem><avatarurl>https://enable-d30.obs.cn-south-1.myhuaweicloud.com/2020/i/x/o/359A7D438BBD4A94ADE8029935E2C81A/0DCDC153C1F34D61A405379E1D1A75EC.png</avatarurl><device><lockstatus>0</lockstatus></device></root>";
    [_action setValue:result forArgument:@"Result"];
}



@end
