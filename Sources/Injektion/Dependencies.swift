//
//  Dependencies.swift
//  Injektion
//
//  Created by Andrew McGee on 26/12/2021.
//

import Foundation

/// Provides the subscripts used to access and update injectable dependencies.
/// Dependencies are added by extending this struct.
public struct Dependencies {
    
    /// A private instance of `Dependencies` used to access the computed properties defined
    /// in extensions of `Dependencies` using keypaths.
    private static var current = Dependencies()
    
    /// A static subscript for updating the `currentValue` of `InjectionKey` instances.
    public static subscript<K>(key: K.Type) -> K.Value where K : DependencyKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }
    
    /// A static subscript use to access or update dependencies directly using the given `WritableKeyPath`.
    static subscript<T>(_ keyPath: WritableKeyPath<Dependencies, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}
