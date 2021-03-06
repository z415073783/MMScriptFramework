//
//  YLWholeDefine.swift
//  SwiftShellFramework
//
//  Created by zlm on 2018/7/2.
//  Copyright © 2018年 zlm. All rights reserved.
//

import Foundation
public let kGitShellPath = "/usr/bin/git"
public let kCocoapodsShellPath = "/usr/local/bin/pod"
public let kCodebuildPath = "/usr/bin/xcodebuild" //xcode打包命令
public let kCDPath = "/usr/bin/cd"
public let kFirPath = "/usr/local/bin/fir"
public let kCurlPath = "/usr/bin/curl"
public let kMkdirPath = "/bin/mkdir" //创建文件夹
public let kMountPath = "/sbin/mount_smbfs" //挂载
public let kBashPath = "/bin/sh"
public let kScriptPath = "usr/bin/osascript"
public let kLsPath = "/bin/ls"
public let kEnvPath = "/usr/bin/env" //调用可执行文件
public let kMVPath = "/bin/mv"
public let kCPPath = "/bin/cp"  //复制
public let kScpPath = "/usr/bin/scp"  //复制文件夹
public let kChmodPath = "/bin/chmod"
public let kPythonPath = "/usr/bin/python"
public let kPython3Path = "/usr/local/bin/python3"
public let kZipPath = "/usr/bin/zip"
public let kRmPath = "/bin/rm"
public let kOpenPath = "/usr/bin/open"
public let kIDPath = "/usr/bin/id"    //获取用户名 id -un
public let kLipoPath = "/usr/bin/lipo"

//初始路径 需要根据脚本位置改为相对路径 "/Users/zlm/Documents/Odin-iOS-UC0524/shell"
public let kShellPath = Bundle.main.bundlePath
//public let kShellPath = "/Users/zlm/Work/Git/MMLibrary"


