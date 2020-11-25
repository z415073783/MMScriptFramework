//
//  File.swift
//  
//
//  Created by 曾亮敏(平安智慧企业产品研发中心统一平台开发团队) on 2020/11/24.
//

import Foundation
public enum MMBoolType: String {
    case m_true = "true", m_false = "false"
    public var boolValue: Bool {
        switch self {
        case .m_true:
            return true
        case .m_false:
            return false
        }
    }
    
}
