//
//  ETSUPnPDevice.hpp
//  ETSPlatinum
//
//  Created by Nil on 16/12/20.
//

#ifndef ETSUPnPDevice_hpp
#define ETSUPnPDevice_hpp

#include <stdio.h>

#include "Platinum/PltDeviceHost.h"

class ETSUPnPDeviceDelegate
{
public:
    virtual ~ETSUPnPDeviceDelegate() {}
    
    // UPnPDeviceDelegate
    virtual NPT_Result OnActionInfo(PLT_ActionReference& action) = 0;
};

class ETSUPnPDevice : public PLT_DeviceHost
{
public:
    ETSUPnPDevice(const char* FriendlyName,
                          const char* UUID);
    // SetDelegate
    virtual void SetDelegate(ETSUPnPDeviceDelegate* delegate) { m_Delegate = delegate; }

    // SetupServices
    virtual NPT_Result SetupServices();
    
    // ActionCallBack
    virtual NPT_Result OnAction(PLT_ActionReference&          action,
                                const PLT_HttpRequestContext& context);
        
    // ActionDelegate
    virtual NPT_Result OnNextAction(PLT_ActionReference& action);
    
private:
    ETSUPnPDeviceDelegate* m_Delegate;
};

#endif /* ETSUPnPDevice_hpp */
