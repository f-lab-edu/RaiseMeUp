//
//  KeyChainManager.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/26/23.
//

import Foundation

struct KeychainManager {
    public static let shared: KeychainManager = KeychainManager()
    
    private init() { }
    
    private let serviceName: String = "RaiseMeUp"
    
    public func save(key: KeychainType, data: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key.keychainIdentifier,
            kSecValueData as String: data.data(using: .utf8, allowLossyConversion: false) as Any
        ]

        let status = SecItemAdd(query as CFDictionary, nil)

        // 중복 item일 경우
        if status == errSecDuplicateItem {
            // 기존 항목 업데이트
            let updateQuery: [String: Any] = [
                kSecValueData as String: data.data(using: .utf8, allowLossyConversion: false) as Any
            ]
            
            // 기존 항목을 업데이트
            let updateStatus = SecItemUpdate(query as CFDictionary, updateQuery as CFDictionary)
            return updateStatus == errSecSuccess
        }
        
        return status == errSecSuccess
    }
    
    public func load(key: KeychainType) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key.keychainIdentifier,
            kSecReturnData as String: true,  // CFData 타입으로 불러오라는 의미
            kSecMatchLimit as String: kSecMatchLimitOne       // 중복되는 경우, 하나의 값만 불러오라는 의미
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        let searchedData = status == noErr ? (item as? Data) : nil
        guard let retrievedData = searchedData else { return nil }
        let value = String(data: retrievedData, encoding: String.Encoding.utf8)
        return value
    }
    
    public func update(key: KeychainType, data: Data) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key.keychainIdentifier
        ]
        
        let attributes: [String: Any] = [
            kSecAttrAccount as String: key.keychainIdentifier,
            kSecValueData as String: data
        ]

        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        return status == errSecSuccess ? true : false
    }
    
    public func delete(key: KeychainType) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key.keychainIdentifier
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess ? true : false
    }
}
