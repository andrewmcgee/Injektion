# Injektion

## Introduction

A simple way to handle dependency injection using property wrappers. It is available as a Swift Package or as a CocoaPod. The concept is heavily based on the work of Antoine van der Lee:

https://www.avanderlee.com/swift/dependency-injection/

## Usage

To set up a dependency, define a new (optionally private) key struct that conforms to the `DependencyKey` protocol. Its current value should be the dependency, which can be abstracted behind a protocol.

```
private struct SomeDependencyKey: DependencyKey {
    static var currentValue: DependencyType = Dependency()
}
```

Then extend the `Dependencies` type to include a new key provider computed property. Its type should be the same as the `DependencyKey`'s `currentValue`. Using its getter and setter it should act as a proxy for the static subscript of `Dependencies` that takes the implementation of `DependencyKey`'s type defined above as an input.

```
extension Dependencies {
    
    var dependencyKeyProvider: DependencyType {
        get { Self[SomeDependencyKey.self] }
        set { Self[SomeDependencyKey.self] = newValue }
    }
}
```

With these parts in place, you can now refer to the dependency throughout you code in the following way:

```
class SomeClass {
    
    @Dependency(\.dependencyKeyProvider) private var dependency: DependencyType
    
}
```

You can update a dependency in two ways. Either like this:

```
class SomeClass {
    
    @Dependency(\.dependencyKeyProvider) private var dependency: DependencyType
    
    func updateDependency() {
        self.dependency = NewDependency()
    }
}
```

or directly like this:

```
Dependencies[SomeDependencyKey.self] = NewDependency()
```

***Please note*** that if you update a dependency, then it will be updated in all the places where it is used.
