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

package ohos.hilog

import ohos.labels.APILevel
import ohos.business_exception.BusinessException

foreign func HiLogIsLoggable(domain: UInt32, tag: CString, level: UInt32): Bool

foreign func HiLogPrint(ty: UInt32, level: UInt32, domain: UInt32, tag: CString, format: CString, content: CString): Unit

foreign func IsPrivateSwitchOn(): Bool

/**
 * Log level define
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.HiviewDFX.HiLog"
]
public enum LogLevel {
    /**
     * DEBUG Log level define
     *
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.HiviewDFX.HiLog"
    ]
    Debug
    /**
     * INFO Log level define
     *
     */
    | @!APILevel[
        22,
        syscap: "SystemCapability.HiviewDFX.HiLog"
    ]
    Info
    /**
     * WARN Log level define
     *
     */
    | @!APILevel[
        22,
        syscap: "SystemCapability.HiviewDFX.HiLog"
    ]
    Warning
    /**
     * ERROR Log level define
     *
     */
    | @!APILevel[
        22,
        syscap: "SystemCapability.HiviewDFX.HiLog"
    ]
    Error
    /**
     * FATAL Log level define
     *
     */
    | @!APILevel[
        22,
        syscap: "SystemCapability.HiviewDFX.HiLog"
    ]
    Fatal
    | ...

    func getValue(): UInt32 {
        match (this) {
            case Debug => 3
            case Info => 4
            case Warning => 5
            case Error => 6
            case Fatal => 7
            case _ => throw BusinessException(11105001, "Parameter error.")
        }
    }
}

let DEFAULT_LOG_TYPE: UInt32 = 0

/**
 * Provides interfaces to generate system logs.
 *
 */
@!APILevel[
    22,
    syscap: "SystemCapability.HiviewDFX.HiLog"
]
public class Hilog {
    static let STANDARD_FORMAT = unsafe { LibC.mallocCString("%{public}s") }
    static init() {
        Thread.handleUncaughtExceptionBy {
            _: Thread, exception: Exception =>
            Hilog.error(0, "exception", "An exception has occurred:")
            Hilog.error(0, "exception", exception.toString())
            var traceElementArray = exception.getStackTrace()
            for (element in traceElementArray) {
                Hilog.error(0, "exception",
                    "\t at ${element.declaringClass}.${element.methodName}(${element.fileName}:${element.lineNumber})")
            }
        }
    }

    /**
     * Checks whether logs of the specified tag, and level can be printed.
     *
     * @param { UInt32 } domain - Indicates the service domain of logs.
     * @param { String } tag - Indicates the log tag.
     * @param { LogLevel } level - Indicates the log level.
     * @returns { Bool } Returns true if the log can be printed; false otherwise.
     */ 
    @!APILevel[
        22,
        syscap: "SystemCapability.HiviewDFX.HiLog"
    ]
    public static func isLoggable(domain: UInt32, tag: String, level: LogLevel): Bool {
        unsafe {
            let cstr = LibC.mallocCString(tag)
            let result = HiLogIsLoggable(domain, cstr, level.getValue())
            LibC.free(cstr)
            return result
        }
    }

    /**
     * Outputs debug-level logs.
     *
     * @param { UInt32 } domain - Indicates the service domain of logs.
     * @param { String } tag - Indicates the log tag.
     * @param { String } format - Indicates the log format string.
     * @param { Array<String> } args - Indicates the log format parameters.
     */ 
    @!APILevel[
        22,
        syscap: "SystemCapability.HiviewDFX.HiLog"
    ]
    public static func debug(domain: UInt32, tag: String, format: String, args: Array<String>): Unit {
        let logContent = parseLogContent(format, args)
        unsafe {
            try (
                cTag = LibC.mallocCString(tag).asResource(),
                cFormat = LibC.mallocCString(logContent).asResource()
            ) {
                HiLogPrint(DEFAULT_LOG_TYPE, LogLevel.Debug.getValue(), domain, cTag.value, STANDARD_FORMAT,
                    cFormat.value)
            }
        }
    }

    /**
     * Outputs info-level logs.
     *
     * @param { UInt32 } domain - Indicates the service domain of logs.
     * @param { String } tag - Indicates the log tag.
     * @param { String } format - Indicates the log format string.
     * @param { Array<String> } args - Indicates the log format parameters.
     */ 
    @!APILevel[
        22,
        syscap: "SystemCapability.HiviewDFX.HiLog"
    ]
    public static func info(domain: UInt32, tag: String, format: String, args: Array<String>): Unit {
        let logContent = parseLogContent(format, args)
        unsafe {
            try (
                cTag = LibC.mallocCString(tag).asResource(),
                cFormat = LibC.mallocCString(logContent).asResource()
            ) {
                HiLogPrint(
                    DEFAULT_LOG_TYPE,
                    LogLevel.Info.getValue(),
                    domain,
                    cTag.value,
                    STANDARD_FORMAT,
                    cFormat.value
                )
            }
        }
    }

    /**
     * Outputs warning-level logs.
     *
     * @param { UInt32 } domain - Indicates the service domain of logs.
     * @param { String } tag - Indicates the log tag.
     * @param { String } format - Indicates the log format string.
     * @param { Array<String> } args - Indicates the log format parameters.
     */ 
    @!APILevel[
        22,
        syscap: "SystemCapability.HiviewDFX.HiLog"
    ]
    public static func warn(domain: UInt32, tag: String, format: String, args: Array<String>): Unit {
        let logContent = parseLogContent(format, args)
        unsafe {
            try (
                cTag = LibC.mallocCString(tag).asResource(),
                cFormat = LibC.mallocCString(logContent).asResource()
            ) {
                HiLogPrint(
                    DEFAULT_LOG_TYPE,
                    LogLevel.Warning.getValue(),
                    domain,
                    cTag.value,
                    STANDARD_FORMAT,
                    cFormat.value
                )
            }
        }
    }

    /**
     * Outputs error-level logs.
     *
     * @param { UInt32 } domain - Indicates the service domain of logs.
     * @param { String } tag - Indicates the log tag.
     * @param { String } format - Indicates the log format string.
     * @param { Array<String> } args - Indicates the log format parameters.
     */ 
    @!APILevel[
        22,
        syscap: "SystemCapability.HiviewDFX.HiLog"
    ]
    public static func error(domain: UInt32, tag: String, format: String, args: Array<String>): Unit {
        let logContent = parseLogContent(format, args)
        unsafe {
            try (
                cTag = LibC.mallocCString(tag).asResource(),
                cFormat = LibC.mallocCString(logContent).asResource()
            ) {
                HiLogPrint(DEFAULT_LOG_TYPE, LogLevel.Error.getValue(), domain, cTag.value, STANDARD_FORMAT,
                    cFormat.value)
            }
        }
    }

    /**
     * Outputs fatal-level logs.
     *
     * @param { UInt32 } domain - Indicates the service domain of logs.
     * @param { String } tag - Indicates the log tag.
     * @param { String } format - Indicates the log format string.
     * @param { Array<String> } args - Indicates the log format parameters.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.HiviewDFX.HiLog"
    ]
    public static func fatal(domain: UInt32, tag: String, format: String, args: Array<String>): Unit {
        let logContent = parseLogContent(format, args)
        unsafe {
            try (
                cTag = LibC.mallocCString(tag).asResource(),
                cFormat = LibC.mallocCString(logContent).asResource()
            ) {
                HiLogPrint(DEFAULT_LOG_TYPE, LogLevel.Fatal.getValue(), domain, cTag.value, STANDARD_FORMAT,
                    cFormat.value)
            }
        }
    }
}

const PUBLIC_LEN:Int64 = 6
const PRIVATE_LEN:Int64 = 7
const PROPERTY_POS:Int64 = 2

struct LogContentInfo {
    var count: Int64
    var isPriv: Bool

    init(count!: Int64 = 0, isPriv!: Bool = true) {
        this.count = count
        this.isPriv = isPriv
    }
}

func parseLogContent(formatStr: String, args: Array<String>): String {
    var logContent: String = ""
    if (args.isEmpty()) {
        return formatStr
    }

    let size = args.size
    let len = formatStr.size

    var info: LogContentInfo = LogContentInfo()
    var pos: Int64 = 0
    while (pos < len) {
        var showPriv = true

        if (String.fromUtf8([formatStr[pos]]) != "%") {
            logContent += String.fromUtf8([formatStr[pos]])
            pos += 1
            continue
        }

        if (info.count >= size) {
            break
        }

        if ((pos + PUBLIC_LEN + PROPERTY_POS) < formatStr.size &&
            formatStr[(pos + PROPERTY_POS)..(pos + PROPERTY_POS + PUBLIC_LEN)] == "public") {
            pos += (PUBLIC_LEN + PROPERTY_POS)
            showPriv = false
        } else if ((pos + PRIVATE_LEN + PROPERTY_POS) < formatStr.size &&
            formatStr[(pos + PROPERTY_POS)..(pos + PROPERTY_POS + PRIVATE_LEN)] == "private") {
            pos += (PRIVATE_LEN + PROPERTY_POS)
        }

        info.isPriv = showPriv && unsafe { IsPrivateSwitchOn() }

        if (info.isPriv) {
            logContent += "<private>"
        } else {
            logContent += args[info.count]
        }
        info.count += 1
        pos += 1
    }

    if (pos < len) {
        logContent += formatStr[pos..]
    }

    return logContent
}