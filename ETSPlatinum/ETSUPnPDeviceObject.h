//
//  ETSUPnPDeviceObject.h
//  ETSPlatinum
//
//  Created by Nil on 17/12/20.
//

#import <Foundation/Foundation.h>

#import <Neptune/Neptune.h>
#import <Platinum/Platinum.h>
#import <Platinum/PltUPnPObject.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ETSUPnPDeviceObjectDelegate;

@interface ETSUPnPDeviceObject : PLT_DeviceHostObject

@property(nonatomic,assign)id<ETSUPnPDeviceObjectDelegate>delegate;

/**
 UPnP Device init
 @parame friendName
 @parame udid
 */
- (instancetype)initWithFriendName:(NSString *)friendName UDIDString:(NSString *)udid;

@end

@protocol ETSUPnPDeviceObjectDelegate <NSObject>

/**
 UPnP Action Call Back
 @parame action
 @parame arguments
 */
- (NPT_Result)onActionEvent:(PLT_ActionObject *)action arguments:(NSDictionary *)arguments;

@end


NS_ASSUME_NONNULL_END
