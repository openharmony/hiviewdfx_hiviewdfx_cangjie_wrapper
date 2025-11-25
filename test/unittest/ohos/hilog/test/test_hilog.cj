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

package ohos.hilog.test

import ohos.hilog.*
import std.unittest.mock.*
import std.unittest.mock.mockmacro.*

@Test
class TestHilog { 
    @TestCase
    func TestIsLoggable(): Unit {
        unsafe {
            @On(HiLogIsLoggable(_,_,_)).returns(false)
            @On(HiLogIsLoggable(0u32,_,_)).returns(true)
        }

        let result_expect_true = Hilog.isLoggable(0u32, "test", LogLevel.Debug)
        @Expect(result_expect_true, true)

        let result_expect_false = Hilog.isLoggable(1u32, "test", LogLevel.Error)
        @Expect(result_expect_false, false)
    }
}