# DFX仓颉接口

## 简介

DFX仓颉接口是在 OpenHarmony 上基于DFX子系统能力之上封装的仓颉API。在OpenHarmony中，DFX\([Design for X](https://en.wikipedia.org/wiki/Design_for_X)\)是为了提升质量属性软件设计，目前包含的内容主要有：DFR（Design for Reliability，可靠性）和DFT（Design for Testability，可测试性）特性。

提供以下功能：

-   HiLog流水日志。

-   HiView插件平台。
-   FaultLoggerd应用故障收集和订阅。
-   HiAppEvent应用事件记录接口及框架。

## 系统架构

**图 1**  DFX仓颉架构图<a name="fig18347131919423"></a>  


![](figures/hiviewdfx_cangjie_wrapper_architecture.png)

## 目录

```
base/hiviewdfx/hiviewdfx_cangjie_wrapper
├── ohos             # 仓颉DFX接口实现
├── kit              # 仓颉kit化代码
├── figures          # 存放readme中的架构图
```

## 约束

当前开发的DFX仓颉接口仅支持standard设备。

## 使用说明

如架构图所示，DFX仓颉提供了以下功能，开发者可以根据使用诉求，综合使用一类或多类接口：

-   HiLog流水日志。
-   HiAppEvent应用事件记录接口及框架。
-   性能打点。

与ArkTS相比，暂不支持以下功能：

-   HiView插件平台。
-   FaultLoggerd应用故障收集和订阅。

DFX仓颉相关API请参见[ohos.hiviewdfx.hi_app_event（应用事件打点）](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/PerformanceAnalysisKit/cj-apis-hiappevent.md)，[ohos.hilog（HiLog日志打印）](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/PerformanceAnalysisKit/cj-apis-hilog.md)，[ohos.hi_trace.meter（性能打点）](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/PerformanceAnalysisKit/cj-apis-hi_tracemeter.md)，相关指导请参见[Performance Analysis Kit简介](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_zh_cn/dfx/cj-performance-analysis-kit-overview.md)。

## 参与贡献

欢迎广大开发者贡献代码、文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)。

## 相关仓

[hiviewdfx\_hilog](https://gitee.com/openharmony/hiviewdfx_hilog/blob/master/README_zh.md)

[hiviewdfx\_hiappevent](https://gitee.com/openharmony/hiviewdfx_hiappevent/blob/master/README_zh.md)
