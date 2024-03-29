//
//  OSLog+Extension.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 12/4/23.
//

import Foundation
import OSLog

public extension OSLog {
    private static let subSystem = Bundle.main.bundleIdentifier!
    
    static let ui = OSLog(subsystem: subSystem, category: "UI")
    static let network = OSLog(subsystem: subSystem, category: "Network")
    static let debug = OSLog(subsystem: subSystem, category: "Debug")
    static let info = OSLog(subsystem: subSystem, category: "Info")
    static let error = OSLog(subsystem: subSystem, category: "Error")
    
    static func message(_ type: OSLogType, log: OSLog = .default, _ message: String) {
        os_log(type, log: log, "%@", message)
    }
}
