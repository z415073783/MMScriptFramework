//
//  InterfaceModel.swift
//  LanguageTranslate
//
//  Created by zlm on 2019/1/17.
//  Copyright © 2019 zlm. All rights reserved.
//

import Foundation
public struct JSONBaiduTranslate: MMJSONCodable {
    public var from: String?
    public var to: String?
    public var trans_result: [JSONBaiduTranslateResult]?
}
public struct JSONBaiduTranslateResult: MMJSONCodable {
    public var src: String?
    public var dst: String?
}
