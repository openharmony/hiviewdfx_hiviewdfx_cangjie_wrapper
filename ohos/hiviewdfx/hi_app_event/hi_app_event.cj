/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// The Cangjie API is in Beta. For details on its capabilities and limitations, please refer to the README file.

package ohos.hiviewdfx.hi_app_event

import ohos.ffi.{RetDataBool, RetDataCString, RetDataI64}
import ohos.business_exception.BusinessException
import ohos.labels.APILevel

foreign func FfiOHOSHiAppEventConfigure(config: CConfigOption): Int32

foreign func FfiOHOSHiAppEventWrite(params: CAppEventInfo): Int32

foreign func FfiOHOSHiAppEventAddProcessor(processor: CProcessor): RetDataBool

foreign func FfiOHOSHiAppEventRemoveProcessor(id: Int64): Int32

foreign func FfiOHOSHiAppEventSetUserId(name: CString, value: CString): Int32

foreign func FfiOHOSHiAppEventGetUserId(name: CString): RetDataCString

foreign func FfiOHOSHiAppEventSetUserProperty(name: CString, value: CString): Int32

foreign func FfiOHOSHiAppEventgetUserProperty(name: CString): RetDataCString

foreign func FfiOHOSHiAppEventclearData(): Unit

foreign func FfiOHOSHiAppEventAddWatcher(Watcher: RetWatcher): RetDataI64

foreign func FfiOHOSHiAppEventRemoveWatcher(watcher: RetWatcher): Int32

/**
 * Provides the event logging function for applications to log the fault, statistical, security,
 * and user behavior events reported during running. Based on event information,
 * you will be able to analyze the running status of applications.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class HiAppEvent {
    /**
     * Writes events of the AppEventInfo type. The event object written by 
     * calling this API is a custom object. To avoid conflicts with system events, you are not advised to write it to 
     * system events (system event name constants defined in Event). The events written by this API can be subscribed to 
     * through (addWatcher).
     *
     * @param { AppEventInfo } info - Application event object. You are advised to avoid the conflict between the custom 
     * event name and the system event name constant defined in Event.
     * @throws { BusinessException } 11100001 - Function is disabled. Possible caused by the param disable in ConfigOption is true.
     * @throws { BusinessException } 11101001 - Invalid event domain.Possible causes: 1. Contain invalid characters;
     * 2. Length is invalid.
     * @throws { BusinessException } 11101002 - Invalid event name. Possible causes: 1. Contain invalid characters;
     * 2. Length is invalid.
     * @throws { BusinessException } 11101003 - Invalid number of event parameters. Possible caused by the number of parameters
     * is over 32.
     * @throws { BusinessException } 11101004 - Invalid string length of the event parameter.
     * @throws { BusinessException } 11101005 - Invalid event parameter name. Possible causes: 1. Contain invalid characters;
     * 2. Length is invalid.
     * @throws { BusinessException } 11101006 - Invalid array length of a event parameter.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent",
        throwexception: true,
        workerthread: true
    ]
    public static func write(info: AppEventInfo): Unit {
        let cinfo = info.toCAppEventInfo()
        let code = unsafe { FfiOHOSHiAppEventWrite(cinfo) }
        cinfo.free()
        if (code != SUCCESS_CODE) {
            HI_APP_EVENT_LOG.error(getErrorInfo(code))
            throw BusinessException(code, getErrorInfo(code))
        }
        return
    }

    /**
     * Configures the application event logging function, such as setting the logging switch and directory storage
     * quota.
     *
     * @param { ConfigOption } config - Configuration items for application event logging.
     * @throws { BusinessException } 11103001 - Invalid max storage quota value. Possible caused by incorrectly formatted.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent",
        throwexception: true
    ]
    public static func configure(config: ConfigOption): Unit {
        let retConfig = CConfigOption(config)
        let code = unsafe { FfiOHOSHiAppEventConfigure(retConfig) }
        retConfig.free()
        if (code != SUCCESS_CODE) {
            HI_APP_EVENT_LOG.error(getErrorInfo(code))
            throw BusinessException(code, getErrorInfo(code))
        }
        return
    }

    /**
     * Adds a data processor to migrate event data to the cloud. You can preset the implementation of the processor on 
     * the device and set its properties based on its constraints.
     * The configuration information of Processor must be provided by the data processor. Yet, as no data processor 
     * is preset in the device for interaction for the moment, migrating events to the cloud is unavailable.
     *
     * @param { Processor } processor - Data processor.
     * @returns { Int64 } ID of the data processor of the reported event, which uniquely identifies the data processor 
     * and can be used to remove the data processor. If the operation fails, -1 is returned. If the operation is 
     * successful, a value greater than 0 is returned.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static func addProcessor(processor: Processor): Int64 {
        let cProcessor = CProcessor(processor)
        let res = unsafe { FfiOHOSHiAppEventAddProcessor(cProcessor) }
        cProcessor.free()
        if (!res.data) {
            HI_APP_EVENT_LOG.error(getErrorInfo(res.code))
            throw BusinessException(res.code, getErrorInfo(res.code))
        }
        return Int64(res.code)
    }

    /**
     * Removes the data processor of a reported event.
     *
     * @param { Int64 } id - ID of a data processor. The value must be greater than 0. The value is obtained by calling 
     * addProcessor.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static func removeProcessor(id: Int64): Unit {
        let res = unsafe { FfiOHOSHiAppEventRemoveProcessor(id) }
        if (res != SUCCESS_CODE) {
            HI_APP_EVENT_LOG.error(getErrorInfo(res))
            throw BusinessException(res, getErrorInfo(res))
        }
        return
    }

    /**
     * Sets a user ID, which is used for association when a Processor is configured.
     *
     * @param { String } name - Key of a user ID. The value is string that contains a maximum of 256 characters, including 
     * digits (0 to 9), letters (a to z), underscore (_), and dollar sign ($). It must not start with a digit.
     * @param { String } value - Value of a user ID. It can contain a maximum of 256 characters. If the value is null or 
     * left empty, the user ID is cleared.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static func setUserId(name: String, value: String): Unit {
        unsafe {
            try (
                cname = LibC.mallocCString(name).asResource(),
                cvalue = LibC.mallocCString(value).asResource()
            ) {
                let res = FfiOHOSHiAppEventSetUserId(cname.value, cvalue.value)
                if (res != SUCCESS_CODE) {
                    HI_APP_EVENT_LOG.error(getErrorInfo(res))
                    throw BusinessException(res, getErrorInfo(res))
                }
            }
        }
        return
    }

    /**
     * Obtains the value set through setUserId.
     *
     * @param { String } name - Key of a user ID. The value is string that contains a maximum of 256 characters, including 
     * digits (0 to 9), letters (a to z), underscore (_), and dollar sign ($). It must not start with a digit.
     * @returns { String } Value of a user ID. If no user ID is found, an empty string is returned.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static func getUserId(name: String): String {
        unsafe {
            let cname = LibC.mallocCString(name)
            let res = FfiOHOSHiAppEventGetUserId(cname)
            LibC.free(cname)
            if (res.code != SUCCESS_CODE) {
                LibC.free(res.data)
                HI_APP_EVENT_LOG.error(getErrorInfo(res.code))
                throw BusinessException(res.code, getErrorInfo(res.code))
            }
            let userId = res.data.toString()
            LibC.free(res.data)
            return userId
        }
    }

    /**
     * Sets a user property, which is used for association when a Processor is configured.
     *
     * @param { String } name - Key of a user property. The value is string that contains a maximum of 256 characters, 
     * including digits (0 to 9), letters (a to z), underscore (_), and dollar sign ($). It must not start with a digit.
     * @param { String } value - Value of a user property. It can contain a maximum of 1024 characters. If the value is 
     * null or left empty, the user property is cleared.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static func setUserProperty(name: String, value: String): Unit {
        unsafe {
            try (
                cname = LibC.mallocCString(name).asResource(),
                cvalue = LibC.mallocCString(value).asResource()
            ) {
                let res = FfiOHOSHiAppEventSetUserProperty(cname.value, cvalue.value)
                if (res != SUCCESS_CODE) {
                    HI_APP_EVENT_LOG.error(getErrorInfo(res))
                    throw BusinessException(res, getErrorInfo(res))
                }
                return
            }
        }
    }

    /**
     * Obtains the value set through setUserProperty.
     *
     * @param { String } name - name Key of a user property. The value is string that contains a maximum of 256 characters, 
     * including digits (0 to 9), letters (a to z), underscore (_), and dollar sign ($). It must not start with a digit.
     * @returns { String } Value of a user property. If no user ID is found, an empty string is returned.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static func getUserProperty(name: String): String {
        unsafe {
            let cname = LibC.mallocCString(name)
            let res = FfiOHOSHiAppEventgetUserProperty(cname)
            LibC.free(cname)
            if (res.code != SUCCESS_CODE) {
                LibC.free(res.data)
                HI_APP_EVENT_LOG.error(getErrorInfo(res.code))
                throw BusinessException(res.code, getErrorInfo(res.code))
            }
            let userProperty = res.data.toString()
            LibC.free(res.data)
            return userProperty
        }
    }

    /**
     * Clears local logging data of the application.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static func clearData(): Unit {
        unsafe { FfiOHOSHiAppEventclearData() }
    }

    /**
     * Adds an event watcher. You can use the callback of the event watcher to subscribe to events.
     *
     * @param { Watcher } watcher - Event watcher.
     * @returns { Option<AppEventPackageHolder> } Subscription data holder. If the subscription fails, Option<AppEventPackageHolder>.None is returned.
     * @throws { BusinessException } 11102001 - Invalid watcher name. Possible causes: 1. Contain invalid characters;
     * 2. Length is invalid.
     * @throws { BusinessException } 11102002 - Invalid filtering event domain. Possible causes: 1. Contain invalid characters;
     * 2. Length is invalid.
     * @throws { BusinessException } 11102003 - Invalid row value. Possible caused by the row value is less than zero.
     * @throws { BusinessException } 11102004 - Invalid size value. Possible caused by the size value is less than zero.
     * @throws { BusinessException } 11102005 - Invalid timeout value. Possible caused by the timeout value is less than zero.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent",
        throwexception: true
    ]
    public static func addWatcher(watcher: Watcher): Option<AppEventPackageHolder> {
        let retWatcher = unsafe { RetWatcher(watcher) }
        let res = unsafe { FfiOHOSHiAppEventAddWatcher(retWatcher) }
        unsafe { retWatcher.free() }
        if (res.data == -1) {
            return None
        }
        match {
            case res.code == SUCCESS_CODE => return Some(AppEventPackageHolder(res.data))
            case _ =>
                HI_APP_EVENT_LOG.error(getErrorInfo(res.code))
                throw BusinessException(res.code, getErrorInfo(res.code))
        }
    }

    /**
     * Removes an event watcher.
     *
     * @param { Watcher } watcher - Event watcher.
     * @throws { BusinessException } 11102001 - Invalid watcher name. Possible causes: 1. Contain invalid characters;
     * 2. Length is invalid.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent",
        throwexception: true
    ]
    public static func removeWatcher(watcher: Watcher): Unit {
        let retWatcher = unsafe { RetWatcher(watcher) }
        let code = unsafe { FfiOHOSHiAppEventRemoveWatcher(retWatcher) }
        unsafe { retWatcher.free() }
        match {
            case code == SUCCESS_CODE => return
            case _ =>
                HI_APP_EVENT_LOG.error(getErrorInfo(code))
                throw BusinessException(code, getErrorInfo(code))
        }
    }
}
