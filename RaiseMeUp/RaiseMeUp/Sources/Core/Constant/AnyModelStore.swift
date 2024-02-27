//
//  AnyModelStore.swift
//  RaiseMeUp
//
//  Created by 홍석현 on 1/16/24.
//

import Foundation

protocol ModelStore {
    associatedtype Model: Identifiable
    var isEmpty: Bool { get }
    
    func fetchByID(_ id: Model.ID) -> Model?
}

class AnyModelStore<Model: Identifiable>: ModelStore {
    
    private var models = [Model.ID: Model]()
    var isEmpty: Bool {
        return models.isEmpty
    }
    
    init(_ models: [Model]) {
        self.models = models.groupingByUniqueID()
    }
    
    func fetchByID(_ id: Model.ID) -> Model? {
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
