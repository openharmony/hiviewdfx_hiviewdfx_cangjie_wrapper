# hiviewdfx_cangjie_wrapper

## Introduction

The hiviewdfx_cangjie_wrapper is a Cangjie API encapsulated on OpenHarmony based on the capabilities of the DFX Subsystem. [Design for X](https://en.wikipedia.org/wiki/Design_for_X)  \(DFX\) refers to the software design that aims to improve the quality attribute in OpenHarmony. It mainly consists of two parts: design for reliability \(DFR\) and design for testability \(DFT\).

The DFX subsystem provides the following capabilities:

-   HiLog: Implements logging.

-   Hiview: Functions as the plug-in platform.
-   FaultLoggerd: Implements fault information collection and subscription.
-   HiAppEvent: Implements logging of application events.

## Architecture

**Figure  1**  Architecture of the hiviewdfx_cangjie_wrapper  

![](figures/hiviewdfx_cangjie_wrapper_architecture_en.png)

## Directory Structure

```
base/hiviewdfx/hiviewdfx_cangjie_wrapper
├── ohos             # Cangjie DFX code
├── kit              # Cangjie kit code
├── figures          # architecture pictures
```

## Constraints

The DFX Cangjie interface currently under development only supports standard devices.

## Usage

The hiviewdfx_cangjie_wrapper provides the following capabilities:

As shown in the diagram, DFX Cangjie provides the following capabilities, and developers can use one or more types of interfaces according to their usage requirements:

-   HiLog: Implements logging.
-   HiAppEvent: Implements logging of application events.
-   HiTraceMeter.

Compared to ArkTS, the following features are currently not supported:

-   Hiview: Functions as the plug-in platform.
-   FaultLoggerd: Implements fault information collection and subscription.

DFX Cangjie related APIs, please refer to[ohos.hiviewdfx.hi_app_event（Application Event Logging）](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/PerformanceAnalysisKit/cj-apis-hiappevent.md)，[ohos.hilog（HiLog Logging）](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/PerformanceAnalysisKit/cj-apis-hilog.md)，[ohos.hi_trace.meter（Performance Tracing）](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/PerformanceAnalysisKit/cj-apis-hi_tracemeter.md).For relevant guidance, please refer to[Introduction to Performance Analysis Kit](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/dfx/cj-performance-analysis-kit-overview.md).

## Code Contribution

Developers are welcome to contribute code, documentation, etc. For specific contribution processes and methods, please refer to [Code Contribution](https://gitcode.com/openharmony/docs/blob/master/en/contribute/code-contribution.md).

## Repositories Involved

[hiviewdfx\_hilog](https://gitee.com/openharmony/hiviewdfx_hilog/blob/master/README.md)

[hiviewdfx\_hiappevent](https://gitee.com/openharmony/hiviewdfx_hiappevent/blob/master/README.md)
