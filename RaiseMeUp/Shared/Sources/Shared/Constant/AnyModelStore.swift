//
//  AnyModelStore.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 1/16/24.
//

import Foundation

public protocol ModelStore {
    associatedtype Model: Identifiable
    var isEmpty: Bool { get }
    
    func fetchByID(_ id: Model.ID) -> Model?
}

public final class AnyModelStore<Model: Identifiable>: ModelStore {
    
    private var models = [Model.ID: Model]()
    public var isEmpty: Bool {
        return models.isEmpty
    }
    
    public init(_ models: [Model]) {
        self.models = models.groupingByUniqueID()
    }
    
    public func fetchByID(_ id: Model.ID) -> Model? {
        return self.models[id]
    }
}

extension Sequence where Element: Identifiable {
    func groupingByID() -> [Element.ID: [Element]] {
        return Dictionary(grouping: self, by: { $0.id })
    }
    
    func groupingByUniqueID() -> [Element.ID: Element] {
        return Dictionary(uniqueKeysWithValues: self.map { ($0.id, $0) })
    }
}
