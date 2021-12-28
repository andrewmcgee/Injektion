//
//  Dependencies+Extensions.swift
//  Injektion
//
//  Created by Andrew McGee on 27/12/2021.
//

import Foundation
@testable import Injektion

extension Dependencies {
    
    var dependencyStructKeyProvider: MockDependencyType {
        get { Self[MockDependencyStructKey.self] }
        set { Self[MockDependencyStructKey.self] = newValue }
    }
    
    var dependencyClassKeyProvider: MockDependencyType {
        get { Self[MockDependencyClassKey.self] }
        set { Self[MockDependencyClassKey.self] = newValue }
    }
}

struct MockDependencyStructKey: DependencyKey {
    static var currentValue: MockDependencyType = MockDependencyStruct()
}

struct MockDependencyClassKey: DependencyKey {
    static var currentValue: MockDependencyType = MockDependencyClass()
}
