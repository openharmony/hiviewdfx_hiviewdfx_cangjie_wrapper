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

package ohos_app_cangjie_entry

internal import kit.AbilityKit.{BundleManager, BundleInfo}
internal import kit.PerformanceAnalysisKit.*
internal import kit.PerformanceAnalysisKit.{Watcher as hiWatcher, Event as HEvent}
import std.unittest.testmacro.*
import std.runtime.*
import std.sync.*
import std.time.*
import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.base.*
import std.collection.*

@Test
class Test_hiappevent {
    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_addWatcher_01() {
        try {
            var condition = TriggerCondition(row: 1, size: 120, timeOut: 0)
            var appEventFilter = [AppEventFilter("cangjie_watcher", eventTypes: [EventType.Fault], names: ["test_event"]
            )]
            var watcher = hiWatcher(
                "watcher1",
                triggerCondition: condition,
                appEventFilters: appEventFilter,
                onTrigger: Some(
                    {
                        row, size, holder =>
                        Hilog.info(0, "test_hiAppEvent_addWatcher_01",
                            "HiAppEvent onTrigger: curRow=${row},curSize=${size}")
                        while (let Some(v) <- holder.takeNext()) {
                            let eventPkg = v
                            Hilog.info(0, "test_hiAppEvent_addWatcher_01", "HiAppEvent packageId=${eventPkg.packageId}")
                            Hilog.info(0, "test_hiAppEvent_addWatcher_01", "HiAppEvent row=${eventPkg.row}")
                            Hilog.info(0, "test_hiAppEvent_addWatcher_01", "HiAppEvent size=${eventPkg.size}")
                            for (i in 0..eventPkg.data.size) {
                                Hilog.info(0, "test_hiAppEvent_addWatcher_01", "HiAppEvent info=${eventPkg.data[i]}")
                            }
                        }
                    }
                )
            )
            HiAppEvent.addWatcher(watcher)
            var params = HashMap<String, EventValueType>([
                ("int_data", IntValue(100)),
                ("str_data", StringValue("strValue")),
                ("flo_data", FloatValue(123.45)),
                ("bool_data", BoolValue(true)),
                ("arri32_data", ArrI32([1, 2, 3])),
                ("arrf64_data", ArrFloat64([1.2])),
                ("arrstr_data", ArrString(["123"])),
                ("arrbool_data", ArrBool([true]))
            ])
            var appInfo: AppEventInfo = AppEventInfo("cangjie_watcher", "test_event", EventType.Fault, params)
            HiAppEvent.write(appInfo)
            Hilog.info(0, "test_hiAppEvent_addWatcher_01", "Test_hiappevent_write_pass")
            sleepFor(1.second)
            HiAppEvent.removeWatcher(watcher)
            @Expect(true)
            HiAppEvent()
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_addWatcher_02() {
        try {
            var condition = TriggerCondition(row: 1)
            let watcher = hiWatcher(
                "watcher2",
                triggerCondition: condition,
                onReceive: {
                    domain, AppEventGroups =>
                    Hilog.info(0, "test_hiAppEvent_addWatcher_02", "domain =${domain}")
                    let groupSize = AppEventGroups.size
                    for (i in 0..groupSize) {
                        Hilog.info(0, "test_hiAppEvent_addWatcher_02", "name =${AppEventGroups[i].name}")
                        let appInfosize = AppEventGroups[i].appEventInfos.size
                        for (j in 0..appInfosize) {
                            Hilog.info(0x0000, "test_hiAppEvent_addWatcher_02",
                                "appEventInfo name=${AppEventGroups[i].appEventInfos[j].name}")
                            Hilog.info(0x0000, "test_hiAppEvent_addWatcher_02",
                                "appEventInfo domain=${AppEventGroups[i].appEventInfos[j].domain}")
                            Hilog.info(0x0000, "test_hiAppEvent_addWatcher_02",
                                "appEventInfo event=${AppEventGroups[i].appEventInfos[j].eventType.getValue()}")

                            for ((k, v) in AppEventGroups[i].appEventInfos[j].params) {
                                Hilog.info(0x0000, "test_hiAppEvent_addWatcher_02",
                                    "key=${k}","")
                                Hilog.info(0x0000, "test_hiAppEvent_addWatcher_02", "value=${v.toString()}","")
                            }
                        }
                    }
                }
            )
            HiAppEvent.addWatcher(watcher)
            var params = HashMap<String, EventValueType>([
                ("int_data", IntValue(100)),
                ("str_data", StringValue("strValue")),
                ("flo_data", FloatValue(123.45)),
                ("bool_data", BoolValue(true)),
                ("arri32_data", ArrI32([1, 2, 3])),
                ("arrf64_data", ArrFloat64([1.2])),
                ("arrstr_data", ArrString(["123"])),
                ("arrbool_data", ArrBool([true]))
            ])
            var appInfo: AppEventInfo = AppEventInfo("cangjie_1", "test_event_01", EventType.Fault, params)
            HiAppEvent.write(appInfo)
            var params_01 = HashMap<String, EventValueType>([("str_data", EventValueType.StringValue("strValue1111"))])
            var appInfo_01: AppEventInfo = AppEventInfo("cangjie_2", "test_event_02", EventType.Fault, params_01)
            HiAppEvent.write(appInfo_01)
            HiAppEvent.removeWatcher(watcher)
            @Expect(true)
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_addProcessor() {
        try {
            var processor: Processor = Processor("test_processor")
            let processorId = HiAppEvent.addProcessor(processor)
            HiAppEvent.removeProcessor(processorId)
            @Expect(true)
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_addProcessor_error() {
        try {
            var processor: Processor = Processor("")
            let processorId = HiAppEvent.addProcessor(processor)
            @Expect(true)
        } catch (e: Exception) {
            Hilog.info(0, "test_hiAppEvent_addProcessor_error", "${e.message.toString()}")
            @Expect(e.message.toString(), "Parameter error. Parameter verification failed.")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_addProcessor_with_AppEventReportConfig() {
        try {
            let aerc = AppEventReportConfig()
            var processor: Processor = Processor("", eventConfigs: [aerc])
            let processorId = HiAppEvent.addProcessor(processor)
            @Expect(true)
        } catch (e: Exception) {
            Hilog.info(0, "test_hiAppEvent_addProcessor_with_AppEventReportConfig", "${e.message.toString()}")
            @Expect(e.message.toString(), "Parameter error. Parameter verification failed.")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_removeProcessor_error() {
        try {
            var processor: Processor = Processor("test_processor")
            let processorId = HiAppEvent.addProcessor(processor)
            HiAppEvent.removeProcessor(processorId)
            HiAppEvent.removeProcessor(processorId)
            HiAppEvent.removeProcessor(processorId)
            @Expect(true)
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_write_01() {
        try {
            var params = HashMap<String, EventValueType>([("int_data", IntValue(100)),
                ("str_data", EventValueType.StringValue("strValue"))])
            var appInfo: AppEventInfo = AppEventInfo("test_domain", "test_event", EventType.Fault, params)
            HiAppEvent.write(appInfo)
            @Expect(true)
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_write_02() {
        try {
            var params = HashMap<String, EventValueType>([
                ("int_data", IntValue(100)),
                ("str_data", EventValueType.StringValue("strValue")),
                ("flo_data", FloatValue(123.45)),
                ("bool_data", BoolValue(true)),
                ("arri32_data", ArrI32([1, 2, 3])),
                ("arrf64_data", ArrFloat64([1.2])),
                ("arrstr_data", ArrString(["123"])),
                ("arrbool_data", ArrBool([true]))
            ])
            var appInfo: AppEventInfo = AppEventInfo("test_domain", "test_event", EventType.Statistic, params)
            HiAppEvent.write(appInfo)
            @Expect(true)
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_write_03() {
        try {
            var params = HashMap<String, EventValueType>([("int_data", IntValue(100)),
                ("str_data", EventValueType.StringValue("strValue"))])
            var appInfo: AppEventInfo = AppEventInfo("test_domain", "test_event", EventType.Security, params)
            HiAppEvent.write(appInfo)
            @Expect(true)
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_write_04() {
        try {
            var params = HashMap<String, EventValueType>([("int_data", IntValue(100)),
                ("str_data", EventValueType.StringValue("strValue"))])
            var appInfo: AppEventInfo = AppEventInfo("test_domain", "test_event", EventType.Behavior, params)
            HiAppEvent.write(appInfo)
            @Expect(true)
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_write_error() {
        try {
            var params = HashMap<String, EventValueType>([("", EventValueType.StringValue(""))])
            var appInfo: AppEventInfo = AppEventInfo("", "", EventType.Behavior, params)
            HiAppEvent.write(appInfo)
            @Expect(true)
        } catch (e: Exception) {
            @Expect(e.message.toString(), "Invalid event domain.")
            Hilog.info(0, "test_hiAppEvent_write_error", "${e.message.toString()}")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_configure_01() {
        try {
            var config: ConfigOption = ConfigOption(disable: false, maxStorage: "100M")
            HiAppEvent.configure(config)
            @Expect(true)
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_configure_02() {
        try {
            var config: ConfigOption = ConfigOption(disable: true, maxStorage: "100M")
            HiAppEvent.configure(config)
            @Expect(true)
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_configure_error() {
        try {
            var config: ConfigOption = ConfigOption(disable: true)
            HiAppEvent.configure(config)
            @Expect(true)
        } catch (e: Exception) {
            @Expect(e.message.toString(), "Invalid max storage quota value.")
            Hilog.info(0, "test_hiAppEvent_configure_error", "${e.message.toString()}")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_clearData() {
        try {
            HiAppEvent.clearData()
            @Expect(true)
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_setUserId() {
        try {
            HiAppEvent.setUserId("test_userID_name", "test_userID_value")
            @Expect(true)
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_setUserId_error() {
        try {
            HiAppEvent.setUserId("", "")
            @Expect(true)
        } catch (e: Exception) {
            @Expect(e.message.toString(), "Parameter error. Parameter verification failed.")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_getUserId() {
        try {
            HiAppEvent.setUserId("test_getUserId_name", "test_getUserId_value")
            let userIdName = HiAppEvent.getUserId("test_getUserId_name")
            Hilog.info(0, "HiAppEvent", "HiAppEvent::test_getUserId is ${userIdName}")
            @Expect(true)
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_getUserId_error() {
        try {
            let userIdName = HiAppEvent.getUserId("")
            Hilog.info(0, "HiAppEvent", "HiAppEvent::test_getUserId is ${userIdName}")
            @Expect(true)
        } catch (e: Exception) {
            @Expect(e.message.toString(), "Parameter error. Parameter verification failed.")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_setUserProperty_error() {
        try {
            let test_userID_name = ""
            let test_userID_value: String = ""
            HiAppEvent.setUserProperty(test_userID_name, test_userID_value)
            HiAppEvent.setUserProperty(test_userID_name, test_userID_value)
            @Expect(true)
        } catch (e: Exception) {
            @Expect(e.message.toString(), "Parameter error. Parameter verification failed.")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_getUserProperty() {
        try {
            let test_userID_name = "test_setUserProperty_01"
            let test_userID_value: String = "123456"
            HiAppEvent.setUserProperty(test_userID_name, test_userID_value)
            let userIdName = HiAppEvent.getUserProperty(test_userID_name)
            @Expect(userIdName,"123456")
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_getUserProperty_error() {
        try {
            let userIdName = HiAppEvent.getUserProperty("")
            @Expect(true)
        } catch (e: Exception) {
            @Expect(e.message.toString(), "Parameter error. Parameter verification failed.")
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_AppEventReportConfig() {
        let appEventReportConfig: AppEventReportConfig = AppEventReportConfig()
        @Expect(true)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_ValueType() {
        let value_int = EventValueType.IntValue(123).toString()
        let value_float = EventValueType.FloatValue(123.45).toString()
        let value_string = EventValueType.StringValue("123").toString()
        let value_bool = EventValueType.BoolValue(true).toString()
        let value_arrstring = EventValueType.ArrString(["123"]).toString()
        let value_arrayi32 = EventValueType.ArrI32([123]).toString()
        let value_arraybool = EventValueType.ArrBool([true]).toString()
        let value_arrayf64 = EventValueType.ArrFloat64([123.45]).toString()
        let value_int64 = EventValueType.Int64Value(123).toString()
        let value_arrayi64 = EventValueType.ArrInt64([123]).toString()
        @Expect(true)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_AppEventPackageHolder() {
        AppEventPackageHolde()
        try {
            var condition = TriggerCondition(row: 1, size: 120, timeOut: 0)
            var appEventFilter = [AppEventFilter("cangjie_watcher")]
            var watcher = hiWatcher(
                "watcher1",
                triggerCondition: condition,
                appEventFilters: appEventFilter,
                onTrigger: Some(
                    {
                        row, size, holder =>
                        Hilog.info(0, "test_hiAppEvent_addWatcher_01",
                            "HiAppEvent onTrigger: curRow=${row},curSize=${size}")
                        while (let Some(v) <- holder.takeNext()) {
                            let eventPkg = v
                            Hilog.info(0, "test_hiAppEvent_addWatcher_01", "HiAppEvent packageId=${eventPkg.packageId}")
                            Hilog.info(0, "test_hiAppEvent_addWatcher_01", "HiAppEvent row=${eventPkg.row}")
                            Hilog.info(0, "test_hiAppEvent_addWatcher_01", "HiAppEvent size=${eventPkg.size}")
                            for (i in 0..eventPkg.data.size) {
                                Hilog.info(0, "test_hiAppEvent_addWatcher_01", "HiAppEvent info=${eventPkg.data[i]}")
                            }
                        }
                    }
                )
            )
            if (let Some(holder) <- HiAppEvent.addWatcher(watcher)) {
                holder.setSize(512 * 1024)
                holder.takeNext()
            }
            @Expect(true)
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_Domain() {
        Domain()
        @Expect(Domain.OS, "OS")
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hiAppEvent_Param() {
        Param()
        @Expect(Param.USER_ID, "user_id")
        @Expect(Param.DISTRIBUTED_SERVICE_NAME, "ds_name")
        @Expect(Param.DISTRIBUTED_SERVICE_INSTANCE_ID, "ds_instance_id")
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func Test_hiAppEvent_Event() {
        HEvent()
        @Expect(HEvent.USER_LOGIN, "hiappevent.user_login")
        @Expect(HEvent.USER_LOGOUT, "hiappevent.user_logout")
        @Expect(HEvent.DISTRIBUTED_SERVICE_START, "hiappevent.distributed_service_start")
        @Expect(HEvent.APP_CRASH, "APP_CRASH")
        @Expect(HEvent.APP_FREEZE, "APP_FREEZE")
    }
}
