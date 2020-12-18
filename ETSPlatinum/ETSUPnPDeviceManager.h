//
//  ETSUPnPDevice.h
//  ETSPlatinum
//
//  Created by Nil on 16/12/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETSUPnPDeviceManager : NSObject

+ (ETSUPnPDeviceManager *)shareManager;

- (void)addHostDevice;

- (void)stopDevice;

- (void)reply;
@end

NS_ASSUME_NONNULL_END
