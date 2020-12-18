//
//  ETSUPnPDevice.cpp
//  ETSPlatinum
//
//  Created by Nil on 16/12/20.
//

#include "ETSUPnPDevice.hpp"
#include "Neptune/Neptune.h"
#include "Platinum/Platinum.h"
#include "Platinum/PltService.h"
#include "Platinum/PltMediaRenderer.h"

ETSUPnPDevice::ETSUPnPDevice(const char* FriendlyName,const char* UUID) :
    PLT_DeviceHost("/", UUID, "urn:www-wistron-com:device:ControlServer:1", FriendlyName,false,0,false),
    m_Delegate(NULL)
{
    m_Manufacturer = "Enable ETS Techonology Corporation";
    m_ManufacturerURL = "http://www.enable-ets.com";
    m_ModelDescription = "WiClass CS";
    m_ModelName = "WiClass CS";
    m_ModelNumber = "3.00";
    m_SerialNumber = "0000001";

}

NPT_Result
ETSUPnPDevice::SetupServices()
{
    NPT_Reference<PLT_Service> service;
    {
        
        service = new PLT_Service(this,"urn:www-wistron-com:service:AutoConfig:1","urn:www-wistron-com:serviceId:AutoConfig","","");
        service->SetControlURL("/AutoConfig_control");
        service->SetSCPDURL("/AutoConfig_Description.xml");
        service->SetEventSubURL("/AutoConfig_event");
        
        const char  *xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\
        <scpd xmlns=\"urn:www-wistron-com:service-1-0\">\
        <specVersion>\
        <major>1</major>\
        <minor>0</minor>\
        </specVersion>\
        \
        <actionList>\
        <action>\
        <name>InvokeAPI</name>\
        \
        <argumentList>\
        <argument>\
        <name>ModuleName</name>\
        <direction>in</direction>\
        <relatedStateVariable>A_ARG_TYPE_ModuleName</relatedStateVariable>\
        </argument>\
        \
        <argument>\
        <name>APIName</name>\
        <direction>in</direction>\
        <relatedStateVariable>A_ARG_TYPE_APIName</relatedStateVariable>\
        </argument>\
        \
        <argument>\
        <name>Parameter</name>\
        <direction>in</direction>\
        <relatedStateVariable>A_ARG_TYPE_Parameter</relatedStateVariable>\
        </argument>\
        \
        <argument>\
        <name>Option</name>\
        <direction>in</direction>\
        <relatedStateVariable>A_ARG_TYPE_Option</relatedStateVariable>\
        </argument>\
        \
        <argument>\
        <name>Result</name>\
        <direction>out</direction>\
        <relatedStateVariable>A_ARG_TYPE_Result</relatedStateVariable>\
        </argument>\
        </argumentList>\
        </action>\
        </actionList>\
        \
        <serviceStateTable>\
        <stateVariable sendEvents=\"no\">\
        <name>A_ARG_TYPE_ModuleName</name>\
        <dataType>string</dataType>\
        </stateVariable>\
        \
        <stateVariable sendEvents=\"no\">\
        <name>A_ARG_TYPE_APIName</name>\
        <dataType>string</dataType>\
        </stateVariable>\
        \
        <stateVariable sendEvents=\"no\">\
        <name>A_ARG_TYPE_Parameter</name>\
        <dataType>string</dataType>\
        </stateVariable>\
        \
        <stateVariable sendEvents=\"no\">\
        <name>A_ARG_TYPE_Option</name>\
        <dataType>string</dataType>\
        </stateVariable>\
        \
        <stateVariable sendEvents=\"no\">\
        <name>A_ARG_TYPE_Result</name>\
        <dataType>string</dataType>\
        </stateVariable>\
        \
        <stateVariable sendEvents=\"yes\">\
        <name>Event</name>\
        <dataType>string</dataType>\
        </stateVariable>\
        </serviceStateTable>\
        </scpd>";
        
        NPT_CHECK_FATAL(service->SetSCPDXML((const char*) xml));
        NPT_CHECK_FATAL(AddService(service.AsPointer()));
        
        service.Detach();
        service = NULL;
    }
    
    return NPT_SUCCESS;
}

NPT_Result
ETSUPnPDevice::OnAction(PLT_ActionReference&          action,
                        const PLT_HttpRequestContext& context)
{
    /*
    NPT_String name = action->GetActionDesc().GetName();
    NPT_Array<PLT_ArgumentDesc*> array = action->GetActionDesc().GetArgumentDescs();
    
    for (int i =0;i < array.GetItemCount();i++) {
        
        PLT_ArgumentDesc *arg = array[i];
        NPT_String argname = arg->GetName();
        
        NPT_String value;
        action->GetArgumentValue(argname, value);
        
        printf("Key =%s \r\n Value = %s\r\n",(const char*)argname,(const char*)value);
    }
    
    NPT_String serviceType = action->GetActionDesc().GetService()->GetServiceType();
    NPT_String serviceName = action->GetActionDesc().GetService()->GetServiceName();
    NPT_String serviceID = action->GetActionDesc().GetService()->GetServiceID();
    //action->SetArgumentValue("answer", "123123");
    
    if (NPT_FAILED(action->SetArgumentValue("Result", "<root><return>0</return></root>"))){
        return NPT_FAILURE;
    }
    */
    
    return OnNextAction(action);
    
    return NPT_SUCCESS;
}

NPT_Result
ETSUPnPDevice::OnNextAction(PLT_ActionReference& action)
{
    if (m_Delegate) {
        return m_Delegate->OnActionInfo(action);
    }
    return NPT_ERROR_NOT_IMPLEMENTED;
}


