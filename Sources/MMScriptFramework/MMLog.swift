//
//  MMLOG.swift
//  SwiftShellFramework
//
//  Created by zlm on 2018/7/2.
//  Copyright © 2018年 zlm. All rights reserved.
//

import Foundation
//import os
public class MMLOG: NSObject {
    public enum LogLevel: String {
        case log = "log", info = "info", error = "err", exception = "exception", sys = "sys"
    }
    public static let shared = MMLOG()
    public var staticStr: StaticString = StaticString()
    public var logs: String = ""
    public class func info( _ closure: @autoclosure () -> String?) {
        log(closure(), level: MMLOG.LogLevel.info)
    }
    public class func sys( _ closure: @autoclosure () -> String?) {
        log(closure(), level: MMLOG.LogLevel.sys)
    }

    public class func error( _ closure: @autoclosure () -> String?) {
        log(closure(), level: MMLOG.LogLevel.error)
    }

    public class func except( _ closure: @autoclosure () -> String?) {
        log(closure(), level: MMLOG.LogLevel.exception)
    }
    public class func log( _ closure: @autoclosure () -> String?) {
        let str = closure()
        print("\(str ?? "")")
    }

    public class func log( _ closure: @autoclosure () -> String?, level: LogLevel = .log) {
        let str = closure()
        let beginTime = showLogDate(timeInterval: Date().timeIntervalSince1970)
        
        var extendedDetails: String = ""
        if Thread.isMainThread {
            extendedDetails += "[main] "
        } else {
//            Thread.current
            if let threadName: String = Thread.current.name, !threadName.isEmpty {
                if threadName.count != 0 {
                    extendedDetails += "[\(threadName)] "
                }
            } else if let operationName = OperationQueue.current?.name, !operationName.isEmpty {
                extendedDetails += "[\(operationName)] "
            } else {
                extendedDetails += "[\(Thread.current.description)] "
            }
        }
        let _log = "\(beginTime) [\(level.rawValue)] \(extendedDetails)\(str ?? "")"
        
        
        print(_log)
        shared.logs += "\(_log)\n"
//        os_log(shared.staticStr, log)
//        fread(&log, 1, 1, stdout)
    }



}

