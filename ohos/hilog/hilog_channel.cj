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

protected class HilogChannel {
    static const TYPE_APP: UInt32 = 0
    static const TYPE_INIT: UInt32 = 1
    static const TYPE_CORE: UInt32 = 3
    static const TYPE_KMSG: UInt32 = 4
    static const LEVEL_DEBUG: UInt32 = 3
    static const LEVEL_INFO: UInt32 = 4
    static const LEVEL_WARN: UInt32 = 5
    static const LEVEL_ERROR: UInt32 = 6
    static const LEVEL_FATAL: UInt32 = 7

    private let type_: UInt32
    private let domain_: UInt32
    private let tag_: CString

    protected init(ty: UInt32, domain: UInt32, tag: String) {
        type_ = ty
        domain_ = domain
        unsafe { tag_ = LibC.mallocCString(tag) }
    }

    ~init() {
        unsafe { LibC.free(tag_) }
    }

    protected func isLoggable(level: UInt32): Bool {
        unsafe { HiLogIsLoggable(domain_, tag_, level) }
    }

    protected func debug<T>(message: T): Unit where T <: ToString {
        dolog(message.toString(), LEVEL_DEBUG)
    }

    protected func info<T>(message: T): Unit where T <: ToString {
        dolog(message.toString(), LEVEL_INFO)
    }

    protected func warn<T>(message: T): Unit where T <: ToString {
        dolog(message.toString(), LEVEL_WARN)
    }

    protected func error<T>(message: T): Unit where T <: ToString {
        dolog(message.toString(), LEVEL_ERROR)
    }

    protected func fatal<T>(message: T): Unit where T <: ToString {
        dolog(message.toString(), LEVEL_FATAL)
    }

    private func dolog(message: String, level: UInt32) {
        if (isLoggable(level)) {
            unsafe {
                let cstr = LibC.mallocCString(message)
                HiLogPrint(type_, level, domain_, tag_, Hilog.STANDARD_FORMAT, cstr)
                LibC.free(cstr)
            }
        }
    }
}
