//
//  MMgit.swift
//  AutoPackageScript
//
//  Created by Apple on 2019/1/22.
//  Copyright © 2019 zlm. All rights reserved.
//

import Foundation


public class MMGit: NSObject {
    
    /// 获取当前branch的名称
    public class func getCurrentBranchName() -> String? {
        let result = MMScript.runScript(model: ScriptModel(path: kGitShellPath, arguments: ["name-rev", "--name-only", "HEAD"], scriptRunPath: kShellPath, showOutData: true))
        var newName = ""
        _ = result.output?.map({ (char) -> String in
//            MMLOG.info("$0 = \(char)")
            if char == "\n" {
                return ""
            } else {
                newName += "\(char)"
                return "\(char)"
            }
        })
      
        return newName
    }
    
    
    
    //初始化最新代码
    /// git 拉取
    ///
    /// - Parameters:
    ///   - gitPath: git url
    ///   - branchname: git tag 或分支
    ///   - projectName: 工程名称
    ///   - projectPath: 拉取的根目录
    /// - Returns:
    class func updateGit(gitPath: String, branchname: String, projectPath: String) ->Bool {
        
        MMLOG.sys("------init---gitPath = \(gitPath)---branchname = \(branchname)")
        var name = "master"
        if branchname.count != 0 {
            name = branchname
        }
        
        var isExist = FileManager.default.fileExists(atPath: projectPath)
        
        if isExist == false {
            MMLOG.sys("代码不存在,clone")
            MMScript.runScript(model: ScriptModel(path: kGitShellPath, arguments: ["clone", gitPath, "--recursive", "-b", "master"], scriptRunPath: projectPath))
        }
        
        MMScript.runScript(model: ScriptModel(path: kGitShellPath, arguments: ["reset", "--hard"], scriptRunPath: projectPath))
        MMScript.runScript(model: ScriptModel(path: kGitShellPath, arguments: ["clean", "-xdf"], scriptRunPath: projectPath))
        
        // 拉取所有分支
        MMScript.runScript(model: ScriptModel(path: kGitShellPath, arguments: ["fetch", "--all"], scriptRunPath: projectPath))
        // 拉取所有tag
        MMScript.runScript(model: ScriptModel(path: kGitShellPath, arguments: ["fetch", "--tags", "--force"], scriptRunPath: projectPath))
        
        //更新所有本地分支
        MMScript.runScript(model: ScriptModel(path: kGitShellPath, arguments: ["pull", "--all"], scriptRunPath: projectPath))
        //移除冲突或者增加的文件
        let time = Date().timeIntervalSince1970
        MMScript.runScript(model: ScriptModel(path: kGitShellPath, arguments: ["stash", "save", String(format: "%d", time)], scriptRunPath: projectPath))
        MMScript.runScript(model: ScriptModel(path: kGitShellPath, arguments: ["stash", "clear"], scriptRunPath: projectPath))
        
        // 检出指定tag
        let result = MMScript.runScript(model: ScriptModel(path: kGitShellPath, arguments: ["checkout", name], scriptRunPath: projectPath))
        if result.status == false && name != "master"{
            MMLOG.error("git上未获取到指定tag版本")
            return false
        }
        
        if name == "master" {
            //默认master时,需要更新到最新
            //更新所有本地分支
            MMScript.runScript(model: ScriptModel(path: kGitShellPath, arguments: ["pull", "--all"], scriptRunPath: projectPath))
        }
        
        // 所有子模块同步
        MMScript.runScript(model: ScriptModel(path: kGitShellPath, arguments: ["submodule", "sync", "--recursive"], scriptRunPath: projectPath))
        // 所有子模块更新到tag对应的版本
        MMScript.runScript(model: ScriptModel(path: kGitShellPath, arguments: ["submodule", "update", "--init", "--recursive"], scriptRunPath: projectPath))




        isExist = FileManager.default.fileExists(atPath: projectPath)
        if isExist == true {
            MMLOG.sys("代码初始化成功")
            MMLOG.sys("-----------UI代码更新完成-------------")
            return true
        }else{
            MMLOG.sys("代码初始化失败")
            return false
        }
    }
}
