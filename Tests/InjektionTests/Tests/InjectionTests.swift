import XCTest
@testable import Injektion

final class InjektionTests: XCTestCase {
    
    @Dependency(\.dependencyStructKeyProvider) var dependencyStructOne: MockDependencyType
    @Dependency(\.dependencyStructKeyProvider) var dependencyStructTwo: MockDependencyType
    @Dependency(\.dependencyClassKeyProvider) var dependencyClassOne: MockDependencyType
    @Dependency(\.dependencyClassKeyProvider) var dependencyClassTwo: MockDependencyType
    
    func testInjectedValuesKeypathSubscriptGetter() {
        let accessed = Dependencies[\.dependencyClassKeyProvider]
        XCTAssertEqual(dependencyClassOne.uuid, accessed.uuid)
    }
    
    func testInjectedValuesKeypathSubscriptSetter() {
        XCTAssertEqual(dependencyClassOne.uuid, Dependencies[\.dependencyClassKeyProvider].uuid)
        let new = MockDependencyClass()
        Dependencies[\.dependencyClassKeyProvider] = new
        XCTAssertEqual(dependencyClassOne.uuid, new.uuid)
    }
    
    func testInjectedValuesKeySubscriptGetter() {
        let accessed = Dependencies[MockDependencyClassKey.self]
        XCTAssertEqual(dependencyClassOne.uuid, accessed.uuid)
    }
    
    func testInjectedValuesKeySubscriptSetter() {
        XCTAssertEqual(dependencyClassOne.uuid, Dependencies[MockDependencyClassKey.self].uuid)
        let new = MockDependencyClass()
        Dependencies[MockDependencyClassKey.self] = new
        XCTAssertEqual(dependencyClassOne.uuid, new.uuid)
    }
    
    func testTwoStructDependenciesUseSameUnderlyingInstance() throws {
        XCTAssertEqual(dependencyStructOne.uuid, dependencyStructTwo.uuid)
    }
    
    func testTwoClassDependenciesUseSameUnderlyingInstance() throws {
        XCTAssertEqual(dependencyClassOne.uuid, dependencyClassTwo.uuid)
    }
    
    func testEachAccessOfAStructDependencyUsesSameUnderlyingInstance() throws {
        XCTAssertEqual(dependencyStructOne.uuid, dependencyStructOne.uuid)
    }
    
    func testEachAccessOfAClassDependencyUsesTheSameUnderlyingInstance() throws {
        XCTAssertEqual(dependencyClassOne.uuid, dependencyClassOne.uuid)
    }
    
    func testUpdateDependencyByDirectAssignment() {
        let initialId = dependencyClassOne.uuid
        XCTAssertEqual(dependencyClassOne.uuid, initialId)
        
        let newInstance = MockDependencyClass()
        XCTAssertNotEqual(newInstance.uuid, initialId)
        self.dependencyClassOne = newInstance
        XCTAssertNotEqual(dependencyClassOne.uuid, initialId)
        XCTAssertEqual(dependencyClassOne.uuid, newInstance.uuid)
    }
    
    func testUpdateDependencyByDirectAssignmentUpdatesAllDependenciesOfSameType() {
        let initialId = dependencyClassOne.uuid
        XCTAssertEqual(dependencyClassOne.uuid, initialId)
        XCTAssertEqual(dependencyClassTwo.uuid, initialId)
        
        let newInstance = MockDependencyClass()
        XCTAssertNotEqual(newInstance.uuid, initialId)
        self.dependencyClassOne = newInstance
        XCTAssertEqual(dependencyClassOne.uuid, newInstance.uuid)
        XCTAssertEqual(dependencyClassTwo.uuid, newInstance.uuid)
    }
    
    func testUpdateDependencyByInjectedValuesSubscript() {
        let initialId = dependencyClassOne.uuid
        XCTAssertEqual(dependencyClassOne.uuid, initialId)
        
        let newInstance = MockDependencyClass()
        XCTAssertNotEqual(newInstance.uuid, initialId)
        Dependencies[\.dependencyClassKeyProvider] = newInstance
        XCTAssertNotEqual(dependencyClassOne.uuid, initialId)
        XCTAssertEqual(dependencyClassOne.uuid, newInstance.uuid)
    }
    
    func testUpdateDependencyByInjectedValuesSubscriptUpdatesAllDependenciesOfSameType() {
        let initialId = dependencyClassOne.uuid
        XCTAssertEqual(dependencyClassOne.uuid, initialId)
        XCTAssertEqual(dependencyClassTwo.uuid, initialId)
        
        let newInstance = MockDependencyClass()
        XCTAssertNotEqual(newInstance.uuid, initialId)
        Dependencies[\.dependencyClassKeyProvider] = newInstance
        XCTAssertEqual(dependencyClassOne.uuid, newInstance.uuid)
        XCTAssertEqual(dependencyClassTwo.uuid, newInstance.uuid)
    }
}
