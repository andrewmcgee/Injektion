//
//  DependencyKey.swift
//  Injektion
//
//  Created by Andrew McGee on 26/12/2021.
//

import Foundation

/// Implementations of this protocol define keys used to both access and store dependencies.
public protocol DependencyKey {

    /// The associated type representing the type of the dependency injection key's value.
    associatedtype Value

    /// The default value for the dependency injection key.
    static var currentValue: Self.Value { get set }
}
