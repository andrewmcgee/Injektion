//
//  Dependency.swift
//  Injektion
//
//  Created by Andrew McGee on 26/12/2021.
//

import Foundation

/// A property wrapper initialized with a keypath, used when accessing and storing an injected dependency.
/// The wrapped value is the generic dependency.
@propertyWrapper
public struct Dependency<T> {

    /// The wrapped value of the property wrapper which stores and returns the generic dependency.
    public var wrappedValue: T {
        get { Dependencies[keyPath] }
        set { Dependencies[keyPath] = newValue }
    }
    
    /// Stores a private reference to a `WritableKeyPath` used when accessing and storing an injected dependency.
    private let keyPath: WritableKeyPath<Dependencies, T>

    /// Initializes an `Dependency` instance using the given `WritableKeyPath` when accessing and storing  an injected dependency.
    /// - Parameter keyPath: A `WritableKeyPath` used to access and store an injected dependency.
    public init(_ keyPath: WritableKeyPath<Dependencies, T>) {
        self.keyPath = keyPath
    }
}
