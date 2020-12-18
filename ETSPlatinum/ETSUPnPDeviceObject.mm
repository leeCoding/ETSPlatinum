//
//  ETSUPnPDeviceObject.m
//  ETSPlatinum
//
//  Created by Nil on 17/12/20.
//

#import "ETSUPnPDeviceObject.h"
#include "ETSUPnPDevice.hpp"
#import "ETSUPnPDeviceManager.h"
#import "XMLDictionary.h"

/** Delegate */
class ETSUPnPDeviceDelegateObject_Wrapper : public ETSUPnPDeviceDelegate {
    public:
    
    ETSUPnPDeviceDelegateObject_Wrapper(ETSUPnPDeviceObject* target):m_Target(target) {};
    
    NPT_Result OnActionInfo(PLT_ActionReference &action) {
        
        if (![m_Target.delegate respondsToSelector:@selector(onActionEvent:arguments:)]) {
            
            return NPT_FAILURE;
            
        }else {
            
            NSMutableDictionary *allDic = [NSMutableDictionary dictionary];
            
            NPT_Array<PLT_ArgumentDesc*> array = action->GetActionDesc().GetArgumentDescs();
            
            for (int i =0;i < array.GetItemCount();i++) {
                
                PLT_ArgumentDesc *arg = array[i];
                NPT_String argname = arg->GetName();
                
                NPT_String value;
                action->GetArgumentValue(argname, value);
                
                NSString *valueString = [NSString stringWithUTF8String:value];
                NSString *keyString = [NSString stringWithUTF8String:argname];
                [allDic setObject:valueString forKey:keyString];
                               
            }
                        
            PLT_ActionObject *actionObject = [[PLT_ActionObject alloc] initWithAction:action.AsPointer()];
            NPT_Result result = [m_Target.delegate onActionEvent:actionObject arguments:allDic.copy];
            return result;
        }

    }
    
private:
    ETSUPnPDeviceObject* m_Target;
};

@interface ETSUPnPDeviceObject ()
{
    ETSUPnPDeviceDelegateObject_Wrapper *_wrapper;
}

@end

@implementation ETSUPnPDeviceObject

- (instancetype)initWithFriendName:(NSString *)friendName UDIDString:(NSString *)udid {
    self = [super init];
    if (self) {
        
        char *friendNameChar    = (char*) [friendName cStringUsingEncoding:NSUTF8StringEncoding];
        char *udidChar          = (char*) [udid cStringUsingEncoding:NSUTF8StringEncoding];
        
        ETSUPnPDevice *device1 = new ETSUPnPDevice(friendNameChar, udidChar);
        PLT_DeviceHostReference device(device1);
        
        _wrapper = new ETSUPnPDeviceDelegateObject_Wrapper(self);
        device1->SetDelegate(_wrapper);
        
        [self setDevice:&device];
        
    }
    return self;
}

@end
