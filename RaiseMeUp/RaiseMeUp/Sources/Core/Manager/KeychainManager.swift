//
//  KeyChainManager.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 11/26/23.
//

import Foundation

struct KeychainManager {
    private let serviceName: String = "RaiseMeUp"
    
    public func save(key: KeychainType, data: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key.toString,
            kSecValueData as String: data.data(using: .utf8, allowLossyConversion: false) as Any
        ]
        
        // Keychain은 Key값에 중복이 생기면, 저장할 수 없기 때문에 먼저 Delete해줌
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess ? true : false
    }
    
    public func load(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key,
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
            kSecAttrAccount as String: key.toString
        ]
        
        let attributes: [String: Any] = [
            kSecAttrAccount as String: key.toString,
            kSecValueData as String: data
        ]

        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        return status == errSecSuccess ? true : false
    }
    
    public func delete(key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess ? true : false
    }
}
