/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

package ohos.hiviewdfx.hi_app_event

import ohos.labels.APILevel
import std.collection.HashMap
import ohos.ffi.RemoteDataLite
import ohos.business_exception.BusinessException

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
    |
    /**
     * FloatValue event.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ] 
    FloatValue(Float64)
    |
    /**
     * StringValue event.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ] 
    StringValue(String)
    |
    /**
     * BoolValue event.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ] 
    BoolValue(Bool)
    |
    /**
     * ArrString event.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ] 
    ArrString(Array<String>)
    |
    /**
     * ArrInt32 event.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ] 
    ArrInt32(Array<Int32>)
    |
    /**
     * ArrBool event.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ] 
    ArrBool(Array<Bool>)
    |
    /**
     * ArrFloat64 event.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ] 
    ArrFloat64(Array<Float64>)
    |
    /**
     * Int64Value event.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ] 
    Int64Value(Int64)
    |
    /**
     * ArrInt64 event.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ] 
    ArrInt64(Array<Int64>)
    | ...

    /**
     * get the corresponding mapping value.
     *
     * @returns { String } return the corresponding mapping value.
     * @throws { BusinessException } 11105001 - Parameter error.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent",
        throwexception: true
    ]
    public func toString(): String {
        match (this) {
            case IntValue(v) => v.toString()
            case FloatValue(v) => v.toString()
            case StringValue(v) => v.toString()
            case BoolValue(v) => v.toString()
            case ArrString(v) => v.toString()
            case ArrInt32(v) => v.toString()
            case ArrBool(v) => v.toString()
            case ArrFloat64(v) => v.toString()
            case Int64Value(v) => v.toString()
            case ArrInt64(v) => v.toString()
            case _ => throw BusinessException(11105001, "Parameter error.")
        }
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public enum EventType {
    /**
     * Fault event.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    Fault
    |
    /**
     * Statistic event.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    Statistic
    |
    /**
     * Security event.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    Security
    |
    /**
     * Behavior event.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    Behavior
    | ...

}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class Param {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static const USER_ID = "user_id"

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static const DISTRIBUTED_SERVICE_NAME = "ds_name"

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static const DISTRIBUTED_SERVICE_INSTANCE_ID = "ds_instance_id"
    
    init() {
        super()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class AppEventInfo {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var domain: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var name: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var eventType: EventType

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var params: HashMap<String, EventValueType>

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public init(domain: String, name: String, event: EventType, params: HashMap<String, EventValueType>) {
        super()
        this.domain = String()
        this.name = String()
        this.eventType = event
        this.params = params
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class ConfigOption {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var disable: Bool

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var maxStorage: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public init(disable!: Bool = false, maxStorage!: String = "10M") {
        super()
        this.disable = true
        this.maxStorage = String()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class AppEventReportConfig {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var domain: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var name: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var isRealTime: Bool

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public init(domain!: String = "", name!: String = "", isRealTime!: Bool = false) {
        super()
        this.domain = String()
        this.name = String()
        this.isRealTime = true
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class Processor {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var name: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var debugMode: Bool

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var routeInfo: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var appId: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var onStartReport: Bool

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var onBackgroundReport: Bool

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var periodReport: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var batchReport: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var userIds: Array<String>

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var userProperties: Array<String>

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var eventConfigs: Array<AppEventReportConfig>

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public init(name: String, debugMode!: Bool = false, routeInfo!: String = "", appId!: String = "",
        onStartReport!: Bool = false, onBackgroundReport!: Bool = false, periodReport!: Int32 = 0,
        batchReport!: Int32 = 0, userIds!: Array<String> = [], userProperties!: Array<String> = [],
        eventConfigs!: Array<AppEventReportConfig> = []) {
        super()
        this.name = String()
        this.debugMode = true
        this.routeInfo = String()
        this.appId = String()
        this.onStartReport = true
        this.onBackgroundReport = true
        this.periodReport = 0
        this.batchReport = 0
        this.userIds = Array()
        this.userProperties = Array()
        this.eventConfigs = Array()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class AppEventPackage {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var packageId: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var row: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var size: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var data: Array<String>
    
    public init() {
        super()
        this.packageId = 0
        this.row = 0
        this.size = 0
        this.data = Array()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class AppEventPackageHolder <: RemoteDataLite {


    /**
     * Constructs an AppEventPackageHolder instance. You can call addWatcher to add an event watcher, and then 
     * associate the AppEventPackageHolder instance with the watcher added in the application based on the watcher name.
     *
     * @param { String } watcherName - Name of the event watcher added through addWatcher. If no watcher is added, no 
     * data is displayed by default.
     * @throws { BusinessException } 11105001 - Parameter error.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent",
        throwexception: true
    ]
    public init(watcherName: String) {

    }

    /**
     * Sets the threshold for the data size of the event package obtained each time.
     *
     * @param { Int32 } size - Data size threshold, in bytes. The value range is [0, $2^{31}$-1]. If the value is out of 
     * the range, an exception is thrown.
     * @throws { BusinessException } 11104001 - Invalid size value.
     * @throws { BusinessException } 11105001 - Invalid parameter error.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent",
        throwexception: true
    ]
    public func setSize(size: Int32): Unit {

    }

    /**
     * Obtains the subscription event.
     * The system obtains the subscription event data based on the data size threshold specified by setSize or the 
     * number of data records specified by setRow. By default, one subscription event data record is obtained. When all 
     * subscription event data is obtained, null is returned.
     * When setRow and setSize are called at the same time, only setRow takes effect.
     * @throws { BusinessException } 11105001 - Invalid parameter error.
     *
     * @returns { Option<AppEventPackage> } Event package object. If all subscription event data has been retrieved, None is 
     * returned.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public func takeNext(): Option<AppEventPackage> {
        var eventPackage = AppEventPackage()
        return Some(eventPackage)
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class TriggerCondition {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var row: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var size: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var timeOut: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public init(row!: Int32 = 0, size!: Int32 = 0, timeOut!: Int32 = 0) {
        super()
        this.row = 0
        this.size = 0
        this.timeOut = 0
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class AppEventFilter {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var domain: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var eventTypes: Array<EventType>

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var names: Array<String>

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public init(domain: String, eventTypes!: Array<EventType> = [], names!: Array<String> = []) {
        super()
        this.domain = String()
        this.eventTypes = eventTypes
        this.names = Array()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class AppEventGroup {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var name: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var appEventInfos: Array<AppEventInfo>
    
    public init() {
        super()
        this.name = String()
        this.appEventInfos = Array()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class Watcher {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var name: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var triggerCondition: TriggerCondition

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var appEventFilters: Array<AppEventFilter>

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var onTrigger: Option<(Int32, Int32, AppEventPackageHolder) -> Unit>

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public var onReceive: Option<(String, Array<AppEventGroup>) -> Unit>

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public init(name: String, triggerCondition!: TriggerCondition = TriggerCondition(),
        appEventFilters!: Array<AppEventFilter> = [],
        onTrigger!: Option<(Int32, Int32, AppEventPackageHolder) -> Unit> = None,
        onReceive!: Option<(String, Array<AppEventGroup>) -> Unit> = None) {
        super()
        this.name = String()
        this.triggerCondition = TriggerCondition(
            row: 0,
            size: 0,
            timeOut: 0
        )
        this.appEventFilters = Array()
        this.onTrigger = onTrigger
        this.onReceive = None
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class HiAppEvent {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent",
        throwexception: true,
        workerthread: true
    ]
    public static func write(info: AppEventInfo): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent",
        throwexception: true
    ]
    public static func configure(config: ConfigOption): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static func addProcessor(processor: Processor): Int64 {
        return 0
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static func removeProcessor(id: Int64): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static func setUserId(name: String, value: String): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static func getUserId(name: String): String {
        return String()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static func setUserProperty(name: String, value: String): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static func getUserProperty(name: String): String {
        return String()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public static func clearData(): Unit {
        return ()
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent",
        throwexception: true
    ]
    public static func addWatcher(watcher: Watcher): Option<AppEventPackageHolder> {
        return None
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent",
        throwexception: true
    ]
    public static func removeWatcher(watcher: Watcher): Unit {
        return ()
    }
    
    init() {
        super()
    }
}
