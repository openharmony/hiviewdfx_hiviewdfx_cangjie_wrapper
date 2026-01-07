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

package ohos.hilog

import ohos.labels.APILevel

@!APILevel[since: "22", syscap: "SystemCapability.HiviewDFX.HiLog"]
public enum LogLevel {
    @!APILevel[since: "22", syscap: "SystemCapability.HiviewDFX.HiLog"]
    Debug
    | @!APILevel[since: "22", syscap: "SystemCapability.HiviewDFX.HiLog"]
    Info
    | @!APILevel[since: "22", syscap: "SystemCapability.HiviewDFX.HiLog"]
    Warning
    | @!APILevel[since: "22", syscap: "SystemCapability.HiviewDFX.HiLog"]
    Error
    | @!APILevel[since: "22", syscap: "SystemCapability.HiviewDFX.HiLog"]
    Fatal
    | ...
}

@!APILevel[since: "22", syscap: "SystemCapability.HiviewDFX.HiLog"]
public class Hilog {
    @!APILevel[since: "22", syscap: "SystemCapability.HiviewDFX.HiLog"]
    public static func isLoggable(domain: UInt32, tag: String, level: LogLevel): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.HiviewDFX.HiLog"]
    public static func debug(domain: UInt32, tag: String, format: String, args: Array<String>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.HiviewDFX.HiLog"]
    public static func info(domain: UInt32, tag: String, format: String, args: Array<String>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.HiviewDFX.HiLog"]
    public static func warn(domain: UInt32, tag: String, format: String, args: Array<String>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.HiviewDFX.HiLog"]
    public static func error(domain: UInt32, tag: String, format: String, args: Array<String>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.HiviewDFX.HiLog"]
    public static func fatal(domain: UInt32, tag: String, format: String, args: Array<String>): Unit {
        return ()
    }
    
}