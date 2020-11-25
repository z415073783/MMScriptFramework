//
//  ProcessInfoControl.swift
//  YLPackage
//
//  Created by zlm on 2018/8/16.
//  Copyright © 2018年 zlm. All rights reserved.
//

import Foundation
@_exported import KakaJSON
public typealias MMCodable = Convertible
public extension ProcessInfo {
    //参数为: -key=value 格式
    public func getDictionary() -> [String: String] {
        var dic: [String:String] = [:]
        for item in arguments {
//            MMLOG.info("item = \(item)")
            if item.hasPrefix("-") {
                let list = item.split("=")
                if let first = list.first {
                    let key = (first as NSString).substring(with: NSRange(location: 1, length: first.count - 1))
                    let value = item.regularExpressionReplace(pattern: "-.*?=", with: "")
                    dic[key] = value
                }
            }
        }
        MMLOG.info("参数: = \(dic)")
        return dic
    }

//    public func isHelp(helpStr: String) -> Bool {
//        for item in arguments {
//            //            MMLOG.info("item = \(item)")
//            if item.hasPrefix("-") {
//                if item == "-h" || item == "help" || item == "-help"  {
//                    let detail = """
// --------------------------------------------------------
//参数结构: -key=value
//\(helpStr)
//----------------------------------------------------------
//"""
//                    print(detail)
//                    return true
//                }
//            }
//        }
//        return false
//    }

    public func isHelp(helpStr: String, needExit: Bool = true) {
        let detail = """
        script = \(kShellPath)
        --------------------------------------------------------
        参数结构: -key=value
        \(helpStr)
        ----------------------------------------------------------
        """
        print(detail)
        for item in arguments {
            //            MMLOG.info("item = \(item)")
            if item.hasPrefix("-") {
                if item == "-h" || item == "help" || item == "-help"  {
                    exit(0)
                }
            }
        }
    }
    
    class func getDictionary() -> [String: Any] {
        var dic: [String:Any] = [:]
        for item in ProcessInfo.processInfo.arguments {
            if item.hasPrefix("-") {
                let list = item.split("=")
                if let first = list.first {
                    let key = (first as NSString).substring(with: NSRange(location: 1, length: first.count - 1))
                    if let value = item.regularExpressionReplace(pattern: "-.*?=", with: "") {
                        if let boolValue = MMBoolType(rawValue: value)?.boolValue {
                            dic[key] = boolValue
                        } else if let intValue = Int(value) {
                            dic[key] = intValue
                        } else if value.hasPrefix("["), value.hasSuffix("]") {
                            //判断是数组或者字典
                            let begin = value.index(value.startIndex, offsetBy: 1)
                            let end = value.index(value.endIndex, offsetBy: -1)
                            let data = value[begin ..< end]
                            let dataList = data.split(separator: ",")
                            var dataDic: [String: String]?
                            var arr: [String]?
                            for singleData in dataList {
                                let keyValue = singleData.split(separator: ":")
                                if keyValue.count == 2 {
                                    //字典
                                    if dataDic == nil {
                                        dataDic = [:]
                                    }
                                    dataDic?[String(keyValue[0])] = String(keyValue[1])
                                } else {
                                    //数组
                                    if arr == nil {
                                        arr = []
                                    }
                                    arr?.append(String(singleData))
                                }
                            }
                            if dataDic != nil {
                                dic[key] = dataDic
                            } else if arr != nil {
                                dic[key] = arr
                            } else {
                                MMLOG.error("数据解析错误")
                                exit(2)
                            }
                            
                        } else {
                            dic[key] = value
                        }
                    }
                }
            }
        }
        MMLOG.sys("参数: = \(dic)")
        return dic
    }
    
    /// 获取数据model
    /// - Parameter ClassType: ClassType description
    /// - Returns: description
//    @available(OSX 10.15, *)
    class func getModel<T: MMCodable>(_ ClassType: T.Type, dataBlock: ((_ dic:inout [String: Any])->Void)? = nil) -> T {
        var dic = ProcessInfo.getDictionary()
        dataBlock?(&dic)
        let output = model(from: dic, ClassType)
        return output
    }

    
    class func isHelp(helpStr: String) {
        
        let detail = """
        script path => \(kShellPath)
        --------------------------------------------------------
        参数结构: -key=value
        \(helpStr)
        ----------------------------------------------------------
        """
        print(detail)
        for item in ProcessInfo.processInfo.arguments {
            //            MMLOG.sys("item = \(item)")
            if item.hasPrefix("-") {
                if item == "-h" || item == "help" || item == "-help"  {
                    exit(0)
                }
            }
        }
    }
}
