//
//  MockDependencyType.swift
//  Injektion
//
//  Created by Andrew McGee on 27/12/2021.
//

import Foundation

protocol MockDependencyType {
    var uuid: UUID { get }
}

struct MockDependencyStruct: MockDependencyType {
    let uuid: UUID = UUID()
}

class MockDependencyClass: MockDependencyType {
    let uuid: UUID = UUID()
}
