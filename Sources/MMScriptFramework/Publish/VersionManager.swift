//
//  VersionManager.swift
//  Auto_MGAISDK
//
//  Created by zlm on 2019/8/8.
//  Copyright © 2019 zlm. All rights reserved.
//

import Foundation
class VersionManager {
    //build版本号自增
    class func versionNumberIncreasing(path: String, fileName: String = "Info.plist") -> String {
        
//        var plistD = NSMutableDictionary(contentsOfFile: "/Users/mac/Documents/GitSpace/migu-mnn-alldetect-clib/script/../project/ios/MGAILibrary/MGAILibraryTool/Info.plist")
        
        let resultPlistList = FileControl.getFilePath(rootPath: path, selectFile: fileName, isSuffix: false, onlyOne: true, recursiveNum: 1)
        guard let frameworkPlistPathModel = resultPlistList.first else {
            exit(1)
        }
        
        guard var plistDic = NSMutableDictionary(contentsOfFile: frameworkPlistPathModel.fullPath()) as? [String: Any] else {
            exit(2)
        }
        
        var buildNumberVersion: String = plistDic["CFBundleVersion"] as? String ?? "0"
//        var shortVersion = plistDic["CFBundleShortVersionString"]
        
        //版本号自增
        let numberList = buildNumberVersion.split(".")
        if numberList.count <= 1 {
            buildNumberVersion = "1.0.1"
        } else {
            buildNumberVersion = ""
            for i in 0 ..< numberList.count {
                
                if i != numberList.count - 1 {
                    buildNumberVersion += (numberList[i] + ".")
                } else {
                    buildNumberVersion += "\((Int(numberList[i]) ?? 0) + 1)"
                }
            }
        }
        
        
        plistDic["CFBundleVersion"] = buildNumberVersion
        
        //保存plist
        let newPlistDic = NSMutableDictionary(dictionary: plistDic)
        newPlistDic.write(toFile: frameworkPlistPathModel.fullPath(), atomically: true)
        
        MMLOG.info("buildNumberVersion ++ : \(buildNumberVersion)")
        return buildNumberVersion
    }
    
    
    
}
