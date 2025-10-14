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

import ohos.labels.*
import ohos.business_exception.BusinessException
import ohos.ffi.*

import std.collection.*

const SUCCESS_CODE: Int32 = 0

/**
* Enumerates event types.
*
*/
@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public enum EventType {
    /**
     * Fault event.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    Fault
    /**
     * Statistic event.
     *
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    Statistic
    /**
     * Security event.
     *
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    Security
    /**
     * Behavior event.
     *
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    Behavior
    | ...

    /**
     * get the corresponding mapping value.
     *
     * @throws { BusinessException } 11105001 - Parameter error.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public func getValue(): UInt32 {
        match (this) {
            case Fault => 1
            case Statistic => 2
            case Security => 3
            case Behavior => 4
            case _ => throw BusinessException(11105001, "Parameter error.")
        }
    }

    static func parse(val: UInt32): EventType {
        match (val) {
            case 1 => Fault
            case 2 => Statistic
            case 3 => Security
            case 4 => Behavior
            case _ => throw BusinessException(11105001, "Parameter error.")
        }
    }
}

/**
* Enumerates EventValueType types.
*/
@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public enum EventValueType <: ToString {
    /**
     * IntValue event.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    IntValue(Int32)
    /**
     * FloatValue event.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    FloatValue(Float64)
    /**
     * StringValue event.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    StringValue(String)
    /**
     * BoolValue event.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    BoolValue(Bool)
    /**
     * ArrString event.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    ArrString(Array<String>)
    /**
     * ArrI32 event.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    ArrI32(Array<Int32>)
    /**
     * ArrBool event.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    ArrBool(Array<Bool>)
    /**
     * ArrF64 event.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    ArrF64(Array<Float64>)
    /**
     * Int64Value event.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    Int64Value(Int64)
    /**
     * ArrInt64 event.
     */
    | @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    ArrInt64(Array<Int64>)
    | ...

    /**
     * get the corresponding mapping value.
     *
     * @throws { BusinessException } 11105001 - Parameter error.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public func toString(): String {
        match (this) {
            case IntValue(v) => v.toString()
            case FloatValue(v) => v.toString()
            case StringValue(v) => v.toString()
            case BoolValue(v) => v.toString()
            case ArrString(v) => v.toString()
            case ArrI32(v) => v.toString()
            case ArrBool(v) => v.toString()
            case ArrF64(v) => v.toString()
            case Int64Value(v) => v.toString()
            case ArrInt64(v) => v.toString()
            case _ => throw BusinessException(11105001, "Parameter error.")
        }
    }
}

/**
* Provides domain name constants.
*
*/
@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class Domain {
    /**
     * System domain.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static const OS = "OS"
}

/**
* Provides event name constants, including system event name constants and application event name constants. 
* The application event name constants are optional custom event names reserved when you call Write for 
* application event logging.
*
*/
@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class Event {
    /**
     * User login event. This is a reserved application event name constant.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static const USER_LOGIN = "hiappevent.user_login"
    /**
     * User logout event. This is a reserved application event name constant.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static const USER_LOGOUT = "hiappevent.user_logout"
    /**
     * Distributed service startup event. This is a reserved application event name constant.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static const DISTRIBUTED_SERVICE_START = "hiappevent.distributed_service_start"
    /**
     * Application crash event. This is a system event name constant.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static const APP_CRASH = "APP_CRASH"
    /**
     * Application freeze event. This is a system event name constant.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static const APP_FREEZE = "APP_FREEZE"
}

/**
* Provides parameter name constants.
*
*/
@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class Param {
    /**
     * Custom user ID.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static const USER_ID = "user_id"
    /**
     * Distributed service name.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static const DISTRIBUTED_SERVICE_NAME = "ds_name"
    /**
     * Distributed service instance ID.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static const DISTRIBUTED_SERVICE_INSTANCE_ID = "ds_instance_id"
}

class Parameters {
    let key: String
    let value: EventValueType

    init(key: String, value: EventValueType) {
        this.key = key
        this.value = value
    }

    init(ret: CParameters) {
        this.key = ret.keyName.toString()
        this.value = readValueType(ret.valueType, ret.value, ret.size)
    }
}

/**
* Defines parameters of the event information.
*
*/
@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class AppEventInfo {
    /**
     * Event domain. The value is a string of up to 32 characters, including digits (0 to 9), letters (a to z), and 
     * underscores (_). It must start with a letter and cannot end with an underscore (_).
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var domain: String
    /**
     * Event name. The value is string that contains a maximum of 48 characters, including digits (0 to 9), letters 
     * (a to z), underscore (_), and dollar sign ($). It must start with a letter or dollar sign ($) and end with a 
     * digit or letter.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var name: String
    /**
     * Event type.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var eventType: EventType
    /**
     * Event parameter object, which consists of a parameter name and a parameter value. In system events, the fields 
     * contained in params are defined by system. For details about the fields, you can see the overviews of system 
     * events, for example, Crash Event Overview. For application events, you need to define the parameters of the 
     * Write API. The specifications are as follows:
     * <br>- A parameter name is a string that contains a maximum of 32 characters, including digits (0 to 9), letters 
     * (a to z), underscore (_), and dollar sign ($). It must start with a letter or dollar sign ($) and end with a 
     * digit or letter. For example, testName and $123_name.
     * <br>- The parameter value can be a string, number, boolean, or array. The string type parameter can contain a 
     * maximum of 8 x 1024 characters. If the length exceeds the limit, the parameter and its name will be discarded. 
     * The value of the number type parameter must be within the range of Number.MIN_SAFE_INTEGER to 
     * Number.MAX_SAFE_INTEGER. If the value exceeds the range, an uncertain value may be generated. The element type 
     * in the array type parameter can only be string, number, or boolean. The number of elements must be less than 
     * 100. If this limit is exceeded, excess elements will be discarded.
     * <br>- The maximum number of parameters is 32. If this limit is exceeded, excess parameters will be discarded.
     *
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var params: HashMap<String, EventValueType>

    /**
     * AppEventInfo constructor.
     *
     * @param { String } domain - Indicates the event domain.
     * @param { String } name - Indicates the event name.
     * @param { EventType } event - Indicates the event type.
     * @param { HashMap<String, EventValueType> } params - Indicates the Event parameter object.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public init(domain: String, name: String, event: EventType, params: HashMap<String, EventValueType>) {
        this.domain = domain
        this.name = name
        this.eventType = event
        this.params = params
    }

    init(ret: CAppEventInfo) {
        this.domain = ret.domain.toString()
        this.name = ret.name.toString()
        this.eventType = EventType.parse(ret.event)
        this.params = readCArrParams(ret.params)
    }

    func toCAppEventInfo(): CAppEventInfo {
        var info = CAppEventInfo(
            CString(CPointer<UInt8>()),
            CString(CPointer<UInt8>()),
            eventType.getValue(),
            CArrParameters(CPointer<CParameters>(), 0)
        )
        try {
            unsafe {
                info.domain = LibC.mallocCString(domain)
                info.name = LibC.mallocCString(name)
                
                let paramsArr = params.toArray()
                let eventParams = Array<Parameters>(params.size) {
                    i => Parameters(paramsArr[i][0], paramsArr[i][1])
                }
                info.params = toCArrParameters(eventParams)
            }
        } catch (e: Exception) {
            info.free()
            throw e
        }
        return info
    }
}

func toCArrParameters(params: Array<Parameters>): CArrParameters {
    let constructor = {p: Parameters => CParameters(p)}
    let ptr = unsafe { cjArr2CArr<Parameters, CParameters>(params, constructor) {p: CParameters => p.free()} }
    return CArrParameters(ptr, params.size)
}

/**
* Provides configuration options for application event logging.
*
*/
@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class ConfigOption {
    /**
     * Whether to enable the event logging function. The default value is false. 
     * If this parameter is set to true, the logging function is disabled. Otherwise, the logging function is 
     * enabled.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var disable: Bool
    /**
     * Quota for the directory that stores event logging files. The default value is 10M. 
     * <br>It is recommended that the quota be less than or equal to 10 MB. Otherwise, the API efficiency may be 
     * affected. If the directory size exceeds the specified quota when application event logging is performed, event 
     * logging files in the directory will be cleared one by one based on the generation time to ensure that directory 
     * size does not exceed the quota.
     * <br>The quota value must meet the following requirements:
     * <br>- The quota value consists of only digits and a unit (which can be one of [b|k|kb|m|mb|g|gb|t|tb], which are 
     * case insensitive.)
     * <br>- The quota value must start with a digit. You can determine whether to pass the unit. If the unit is left 
     * empty, b (that is, byte) is used by default.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var maxStorage: String

    /**
     * ConfigOption constructor.
     *
     * @param { Bool } disable - Indicates whether to enable the event logging function. The default value is false.
     * @param { String } name - Indicates the quota for the directory that stores event logging files. The default
     * value is "10M".
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public init(disable!: Bool = false, maxStorage!: String = "10M") {
        this.disable = disable
        this.maxStorage = maxStorage
    }
}

/**
* Event description configuration that can be reported by the data processor.
*
*/
@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class AppEventReportConfig {
    /**
     * Event domain. The value is a string that contains a maximum of 32 characters, including digits (0 to 9), letters 
     * (a to z), and underscore (_). It must start with a letter and cannot end with an underscore (_). The default 
     * value is an empty string.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var domain: String
    /**
     * Event name. The value is string that contains a maximum of 48 characters, including digits (0 to 9), letters 
     * (a to z), underscore (_), and dollar sign ($). It must start with a letter or dollar sign ($) and end with a 
     * digit or letter. The default value is an empty string.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var name: String
    /**
     * Whether to report events in real time. The value true indicates that events are reported in real time, and the 
     * value false indicates the opposite. The default value is false.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var isRealTime: Bool

    /**
     * AppEventReportConfig constructor.
     *
     * @param { String } domain - Indicates event domain. The default value is "".
     * @param { String } name - Indicates the event name. The default value is "".
     * @param { Bool } isRealTime - Indicates whether to report events in real time. The default value is false.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public init(domain!: String = "", name!: String = "", isRealTime!: Bool = false) {
        this.domain = domain
        this.name = name
        this.isRealTime = isRealTime
    }
}

/**
* Defines a data processor for reporting and managing events. You can customize processor configurations as required.
*
*/
@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class Processor {
    /**
     * Name of a data processor. The value is string that contains a maximum of 256 characters, including digits (0 to 
     * 9), letters (a to z), underscore (_), and dollar sign ($). It must not start with a digit.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var name: String
    /**
     * Whether to enable the debug mode. The default value is false. The value true means to enable the debugging mode, 
     * and the value false means the opposite.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var debugMode: Bool
    /**
     * Server location information. It is left empty by default. The length of the input string cannot exceed 8 KB. If 
     * the length exceeds 8 KB, the default value is used.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var routeInfo: String
    /**
     * Application ID. It is left empty by default. The length of the input string cannot exceed 8 KB. If the length 
     * exceeds 8 KB, the default value is used.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var appId: String
    /**
     * Whether to report an event when the data processor starts. The default value is false. The value true means to 
     * report events, and the value false means the opposite.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var onStartReport: Bool
    /**
     * Whether to report an event when an application switches to the background. The default value is false. The value 
     * true means to report events, and the value false means the opposite.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var onBackgroundReport: Bool
    /**
     * Interval for event reporting, in seconds. The input value must be greater than or equal to 0. If the input value 
     * is less than 0, the default value 0 is used and periodic reporting is not performed.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var periodReport: Int32
    /**
     * Event reporting threshold. When the number of events reaches the threshold, an event is reported. The value must 
     * be greater than 0 and less than 1000. If the value is not within the range, the default value 0 is used and no 
     * events are reported.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var batchReport: Int32
    /**
     * Name array of user IDs that can be reported by the data processor. name corresponds to the name parameter of the 
     * setUserId API. The default value is an empty array.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var userIds: Array<String>
    /**
     * Name array of user properties that can be reported by the data processor. name corresponds to the name parameter 
     * of the setUserProperty API. The default value is an empty array.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var userProperties: Array<String>
    /**
     * Event description configuration array that can be reported by the data processor. The default value is an empty 
     * array.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var eventConfigs: Array<AppEventReportConfig>

    /**
     * Processor constructor.
     *
     * @param { String } name - Indicates name of a data processor.
     * @param { Bool } debugMode - Indicates whether to enable the debug mode. The default value is false.
     * @param { String } routeInfo - Indicates server location information. The default value is "".
     * @param { String } appId - Indicates Application ID. The default value is "".
     * @param { Bool } onStartReport - Indicates whether to report an event when the data processor starts. The default
     * value is false.
     * @param { Bool } onBackgroundReport - Indicates whether to report an event when an application switches to the
     * background. The default value is false.
     * @param { Int32 } periodReport - Indicates interval for event reporting, in seconds. The default value is 0.
     * @param { Int32 } batchReport - Indicates event reporting threshold. The default value is 0.
     * @param { Array<String> } userIds - Indicates name array of user IDs that can be reported by the data processor.
     * The default value is [].
     * @param { Array<String> } userProperties - Indicates name array of user properties that can be reported by the
     * data processor. The default value is [].
     * @param { Array<AppEventReportConfig> } eventConfigs - Indicates event description configuration array that can
     * be reported by the data processor. The default value is [].
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public init(name: String, debugMode!: Bool = false, routeInfo!: String = "", appId!: String = "",
        onStartReport!: Bool = false, onBackgroundReport!: Bool = false, periodReport!: Int32 = 0,
        batchReport!: Int32 = 0, userIds!: Array<String> = [], userProperties!: Array<String> = [],
        eventConfigs!: Array<AppEventReportConfig> = []) {
        this.name = name
        this.debugMode = debugMode
        this.routeInfo = routeInfo
        this.appId = appId
        this.onStartReport = onStartReport
        this.onBackgroundReport = onBackgroundReport
        this.periodReport = periodReport
        this.batchReport = batchReport
        this.userIds = userIds
        this.userProperties = userProperties
        this.eventConfigs = eventConfigs
    }
}

/**
* Defines parameters of an AppEventPackage object. This API is used to obtain detail information about an event 
* package, which is obtained using the takeNext API.
*
*/
@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class AppEventPackage {
    /**
     * Event package ID, which is named from 0 in ascending order.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var packageId: Int32
    /**
     * Number of events in the event package.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var row: Int32
    /**
     * Event size of the event package, in bytes.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var size: Int32
    /**
     * Event data in the event package.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var data: Array<String>

    init(packageId: Int32, row: Int32, size: Int32, data: Array<String>) {
        this.packageId = packageId
        this.row = row
        this.size = size
        this.data = data
    }
}

/**
* Defines the triggering condition parameters of the onTrigger callback of a Watcher.
*
*/
@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class TriggerCondition {
    /**
     * Total number of events that trigger callback. The value is a positive integer. The default value is 0, 
     * indicating that no callback is triggered. If this parameter is set to a negative value, the default 
     * value is used.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var row: Int32
    /**
     * Total size of events that trigger callback. The value is a positive integer, in bytes. The default value is 0, 
     * indicating that no callback is triggered. If this parameter is set to a negative value, the default value is 
     * used.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var size: Int32
    /**
     * Timeout interval for triggering callback. The value is a positive integer, in unit of 30s. The default value is 
     * 0, indicating that no callback is triggered. If this parameter is set to a negative value, the default value is 
     * used.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var timeOut: Int32

    /**
     * TriggerCondition constructor.
     *
     * @param { Int32 } row - Indicates total number of events that trigger callback. The default value is 0.
     * @param { Int32 } size - Indicates total size of events that trigger callback. The default value is 0.
     * @param { Int32 } timeOut - Indicates timeout interval for triggering callback. The default value is 0.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public init(row!: Int32 = 0, size!: Int32 = 0, timeOut!: Int32 = 0) {
        this.row = row
        this.size = size
        this.timeOut = timeOut
    }
}

/**
* Defines parameters of subscription filtering conditions of a Watcher. This API is used to set event filtering 
* conditions in the event watcher to ensure that only the events that meet the filtering conditions are subscribed 
* to.
*
*/
@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class AppEventFilter {
    /**
     * Event domain, which can be the system event domain (hiAppEvent.domain.OS) or the event domain of the custom 
     * event information (AppEventInfo) passed through the Write API.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var domain: String
    /**
     * Event types. If this parameter is not set, events are not filtered by default.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var eventTypes: Array<EventType>
    /**
     * Names of the events to be subscribed. If this parameter is not set, events are not filtered by default.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var names: Array<String>

    /**
     * AppEventFilter constructor.
     *
     * @param { String } domain - Indicates event domain.
     * @param { Array<EventType> } eventTypes - Indicates event types. The default value is [].
     * @param { Array<String> } names - Indicates names of the events to be subscribed. The default value is [].
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public init(domain: String, eventTypes!: Array<EventType> = [], names!: Array<String> = []) {
        this.domain = domain
        this.eventTypes = eventTypes
        this.names = names
    }
}

/**
* Defines parameters of the event group returned by a subscription. This API can be used to obtain detail 
* information about an event group, which is often used in the onReceive callback of Watcher.
*
*/
@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class AppEventGroup {
    /**
     * Event name.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var name: String
    /**
     * Event object group.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var appEventInfos: Array<AppEventInfo>

    init(name: String, appEventInfos: Array<AppEventInfo>) {
        this.name = name
        this.appEventInfos = appEventInfos
    }

    init(ret: CAppEventGroup) {
        this.name = ret.name.toString()
        this.appEventInfos = readCArrAppEventInfos(ret.appEventInfos)
    }
}

/**
 * Defines parameters for a Watcher object. This API is used to configure and manage event watchers to subscribe to 
 * and process specified events.
 *
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class Watcher {
    /**
     * Unique name of a watcher. The value contains a maximum of 32 characters, including digits (0 to 9), letters 
     * (a to z), underscore (_). It must start with a letter and end with a digit or letter. For example, testName1 
     * and crash_Watcher.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var name: String
    /**
     * Subscription callback triggering condition. This parameter takes effect only when it is passed together with 
     * onTrigger. If this parameter is not set, the onTrigger callback is not triggered by default.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var triggerCondition: TriggerCondition
    /**
     * Subscription filtering condition. This parameter is passed only when subscription events need to be filtered. 
     * If this parameter is not set, events are not filtered by default.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var appEventFilters: Array<AppEventFilter>
    /**
     * Subscription callback. This parameter takes effect only when it is passed together with triggerCondition. 
     * The input arguments are described as follows: 
     * <br>curRow: total number of subscription events when the callback is triggered.
     * <br>curSize: total size of subscribed events when the callback is triggered, in bytes.
     * <br>holder: subscription data holder, which can be used to process subscribed events.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var onTrigger: Option<(Int32, Int32, AppEventPackageHolder) -> Unit>
    /**
     * Real-time subscription callback. Only this callback function is triggered if it is passed together with 
     * onTrigger. The input arguments are described as follows: 
     * <br>domain: domain name.
     * <br>appEventGroups: event group.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var onReceive: Option<(String, Array<AppEventGroup>) -> Unit>

    /**
     * Watcher constructor.
     *
     * @param { String } name - Indicates unique name of a watcher.
     * @param { TriggerCondition } triggerCondition - Indicates subscription callback triggering condition.
     * @param { Array<AppEventFilter> } appEventFilters - Indicates subscription filtering condition. The default value
     * is [].
     * @param { Option<(Int32, Int32, AppEventPackageHolder) -> Unit> } onTrigger - Indicates subscription callback.
     * The default value is None.
     * @param { Option<(String, Array<AppEventGroup>) -> Unit> } onReceive - Indicates Real-time subscription callback.
     * The default value is None.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public init(name: String, triggerCondition!: TriggerCondition = TriggerCondition(),
        appEventFilters!: Array<AppEventFilter> = [],
        onTrigger!: Option<(Int32, Int32, AppEventPackageHolder) -> Unit> = None,
        onReceive!: Option<(String, Array<AppEventGroup>) -> Unit> = None) {
        this.name = name
        this.triggerCondition = triggerCondition
        this.appEventFilters = appEventFilters
        this.onTrigger = onTrigger
        this.onReceive = onReceive
    }
}

func readCArrCAppEventGroup(appEventGroups: CArrCAppEventGroup): Array<AppEventGroup> {
    let result = ArrayList<AppEventGroup>()
    if (appEventGroups.head.isNotNull()) {
        for (i in 0..appEventGroups.size) {
            unsafe { result.add(AppEventGroup(appEventGroups.head.read(i))) }
        }
    }
    return result.toArray()
}

func readCArrAppEventInfos(ret: CArrAppEventInfo): Array<AppEventInfo> {
    let result = ArrayList<AppEventInfo>()
    if (ret.head.isNotNull()) {
        for (i in 0..ret.size) {
            unsafe { result.add(AppEventInfo(ret.head.read(i))) }
        }
    }
    return result.toArray()
}

func readCArrParams(ret: CArrParameters): HashMap<String, EventValueType> {
    let result = HashMap<String, EventValueType>()
    if (ret.head.isNotNull()) {
        for (i in 0..ret.size) {
            unsafe { result.add(Parameters(ret.head.read(i)).key, Parameters(ret.head.read(i)).value) }
        }
    }
    return result  
}

func readValueType(valueType: UInt8, value: CPointer<Unit>, size: Int64): EventValueType {
    unsafe {
        match (valueType) {
            case 0 =>
                if (value.isNull()) {
                    throw IllegalMemoryException("Out of Memory!")
                }
                var res = CPointer<Int32>(value).read()
                return IntValue(res)
            case 1 =>
                if (value.isNull()) {
                    throw IllegalMemoryException("Out of Memory!")
                }
                var res = CPointer<Float64>(value).read()
                return FloatValue(res)
            case 2 =>
                if (value.isNull()) {
                    return StringValue("")
                }
                var res = CString(CPointer<UInt8>(value))
                return StringValue(res.toString())
            case 3 =>
                if (value.isNull()) {
                    throw IllegalMemoryException("Out of Memory!")
                }
                var res = CPointer<Bool>(value).read()
                return BoolValue(res)
            case 4 =>
                var res = ArrayList<Int32>()
                if (value.isNull()) {
                    return ArrI32(res.toArray())
                }
                for (i in 0..size) {
                    res.add(CPointer<Int32>(value).read(i))
                }
                return ArrI32(res.toArray())
            case 5 =>
                var res = ArrayList<Float64>()
                if (value.isNull()) {
                    return ArrF64(res.toArray())
                }
                for (i in 0..size) {
                    res.add(CPointer<Float64>(value).read(i))
                }
                return ArrF64(res.toArray())
            case 6 =>
                var res = ArrayList<String>()
                if (value.isNull()) {
                    return ArrString(res.toArray())
                }
                let data = (CPointer<CString>(value))
                for (i in 0..size) {
                    res.add(data.read(i).toString())
                }
                return ArrString(res.toArray())
            case 7 =>
                var res = ArrayList<Bool>()
                if (value.isNull()) {
                    return ArrBool(res.toArray())
                }
                for (i in 0..size) {
                    res.add(CPointer<Bool>(value).read(i))
                }
                return ArrBool(res.toArray())
            case 8 =>
                if (value.isNull()) {
                    throw IllegalMemoryException("Out of Memory!")
                }
                var res = CPointer<Int64>(value).read()
                return Int64Value(res)
            case 9 =>
                var res = ArrayList<Int64>()
                if (value.isNull()) {
                    throw IllegalMemoryException("Out of Memory!")
                }
                for (i in 0..size) {
                    res.add(CPointer<Int64>(value).read(i))
                }
                return ArrInt64(res.toArray())
            case _ => throw BusinessException(11105001, "Parameter error.")
        }
    }
}