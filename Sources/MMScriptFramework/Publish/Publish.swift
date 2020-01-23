//
//  File.swift
//  
//
//  Created by zlm on 2020/1/22.
//

import Foundation

func pushFir(outputLog: String = "更新日志", ipaPath: String, bundleID: String, name: String, version: String, apiToken: String) {
    let voucherResult = MMScript.runScript(model: ScriptModel(path: kCurlPath, arguments: ["-X 'POST' 'http://api.fir.im/apps'", "-H 'Content-Type: application/json'", "-d '{'type': 'ios', 'bundle_id': '\(bundleID)', 'api_token': '\(apiToken)'}'"], showOutData: true))

    MMLOG.log("voucherResult = \(voucherResult)")
    //voucherResult.output
    if let jsonData = voucherResult.output?.data(using: String.Encoding.utf8) {
       do {
           let dic = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
           //获取
          
           if let certDic = dic?.value(forKey: "cert") as? NSDictionary, let binaryDic = certDic.value(forKey: "binary") as? NSDictionary, let binaryKey = binaryDic.value(forKey: "key") as? NSString, let binaryToken = binaryDic.value(forKey: "token") as? NSString {
               MMScript.runScript(model: ScriptModel(path: kCurlPath, arguments: ["-F", "key=\(binaryKey)", "-F", "token=\(binaryToken)", "-F", "file=\(ipaPath)", "-F", "x:name=\(name)", "-F", "x:version=\(version)", "-F", "x:build=\(version)", "-F", "x:release_type=Inhouse", "-F", "x:changelog=\(outputLog)"], showOutData: true))
           }
       } catch {
       }
    }
}

func pushPgyer(outputLog: String = "更新日志", ipaPath: String, pgyerAPIKey: String, password: String = "") {
    MMLOG.log("日志: \(outputLog)")
        //上传到蒲公英
    MMScript.runScript(path: kCurlPath, arguments: ["-F", "file=@" + ipaPath, "-F", "_api_key=" + pgyerAPIKey, "-F", "buildUpdateDescription=\(outputLog)", "-F", "buildInstallType=2", "-F", "buildPassword=\(password)", "https://www.pgyer.com/apiv2/app/upload"])
}
