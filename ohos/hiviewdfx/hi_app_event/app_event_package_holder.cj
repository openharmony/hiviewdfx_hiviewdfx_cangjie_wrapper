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

import ohos.ffi.{RemoteDataLite, releaseFFIData, CArrString}
import ohos.labels.APILevel
import ohos.business_exception.BusinessException

import std.collection.ArrayList

foreign func FfiOHOSHiAppEventConstructor(cWatcherName: CString): Int64

foreign func FfiOHOSHiAppEventSetSize(id: Int64, size: Int32): Int32

foreign func FfiOHOSHiAppEventTakeNext(id: Int64): ReTakeNext

/**
* Defines a subscription data holder for processing event information.
*
*/
@!APILevel[
    since: "22",
    syscap: "SystemCapability.HiviewDFX.HiAppEvent"
]
public class AppEventPackageHolder <: RemoteDataLite {
    init(id: Int64) {
        super(id)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Constructs an AppEventPackageHolder instance. You can call addWatcher to add an event watcher, and then 
     * associate the AppEventPackageHolder instance with the watcher added in the application based on the watcher name.
     *
     * @throws { BusinessException } 11105001 - Parameter error.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public init(watcherName: String) {
        super(unsafe {
            let cWatcherName = LibC.mallocCString(watcherName)
            let id = FfiOHOSHiAppEventConstructor(cWatcherName)
            LibC.free(cWatcherName)
            if (id < 0) {
                throw BusinessException(11105001, "Parameter error.")
            }
            id
        })
    }

    /**
     * Sets the threshold for the data size of the event package obtained each time.
     *
     * @throws { BusinessException } 401 - Parameter error.
     * @throws { BusinessException } 11104001 - Invalid size value.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public func setSize(size: Int32): Unit {
        let ret = unsafe { FfiOHOSHiAppEventSetSize(getID(), size) }
        match {
            case ret != SUCCESS_CODE => throw BusinessException(ret, getErrorInfo(ret))
            case _ => return
        }
    }

    /**
     * Obtains the subscription event.
     * The system obtains the subscription event data based on the data size threshold specified by setSize or the 
     * number of data records specified by setRow. By default, one subscription event data record is obtained. When all 
     * subscription event data is obtained, null is returned.
     * When setRow and setSize are called at the same time, only setRow takes effect.
     * @throws { BusinessException } 11105001 - Invalid parameter error.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.HiviewDFX.HiAppEvent"
    ]
    public func takeNext(): Option<AppEventPackage> {
        let ret = unsafe { FfiOHOSHiAppEventTakeNext(getID()) }
        match {
            case ret.status != SUCCESS_CODE => return None
            case _ =>
                let event = ret.event
                try {
                    var eventPackage = AppEventPackage(
                        event.packageId,
                        event.row,
                        event.size,
                        readArrStr(event.dataArr)
                    )
                    ret.event.free()
                    return Some(eventPackage)
                } catch (e: Exception) {
                    ret.event.free()
                    throw BusinessException(11105001, "Invalid parameter error.")
                }
        }
    }

    /**
    * @throws { BusinessException } 11105001 - Invalid parameter error.
    */
    func readArrStr(cArr: CArrString): Array<String> {
        var result = ArrayList<String>()
        if (cArr.head.isNotNull()) {
            for (i in 0..cArr.size) {
                unsafe { result.add(cArr.head.read(i).toString()) }
            }
        } else {
            throw BusinessException(11105001, "Invalid parameter error.")
        }
        return result.toArray()
    }
}
