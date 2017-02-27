
import XCTest
@testable import PauloMendes99

class PersonsTransformerTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
    }
    
    func testShouldReturnAnArrayOfPersonsViewModel() {
        let personArray = [
            [ "id" : "599df0e4-183c-4bfb-91c5-881d4550cd3f",
              "name" : "Craig Federighi",
              "image" : "http://www.apple.com/pr/bios/images/federighi_hero20120727.png",
              "birthday" : "1969-05-27T00:00:00Z"],
            [ "id" : "599df0e4-183c-4bfb-91c5-881d4550cd3a",
              "name" : "Craig Federighia",
              "image" : "http://www.apple.com/pr/bios/images/federighi_hero20120727.png",
              "birthday" : "1969-05-27T00:00:00Z"]
        ]
        
        let persons: PersonsCollection = PersonsCollection(jsonArray: personArray)!
        
        let transformer = PersonsTransformer(personsCollection: persons)
        
        let modelViews = transformer.getPersonsViewModel()
        
        XCTAssertEqual(modelViews.count, 2)
        
        var i = 0
        for modelView in modelViews {
            XCTAssertEqual(modelView.birthday, "May 26, 1969")
            XCTAssertEqual(modelView.avatarImage, persons.entries[i].image)
            XCTAssertEqual(modelView.fullName, persons.entries[i].name)
            i += 1
        }
        
    }
    
    func testShouldntReturnDuplicateEntries() {
        let personArray = [
            [ "id" : "599df0e4-183c-4bfb-91c5-881d4550cd3f",
              "name" : "Craig Federighi",
              "image" : "http://www.apple.com/pr/bios/images/federighi_hero20120727.png",
              "birthday" : "1969-05-27T00:00:00Z"],
            [ "id" : "599df0e4-183c-4bfb-91c5-881d4550cd3f",
              "name" : "Craig Federighi",
              "image" : "http://www.apple.com/pr/bios/images/federighi_hero20120727.png",
              "birthday" : "1969-05-27T00:00:00Z"]
        ]
        
        let persons: PersonsCollection = PersonsCollection(jsonArray: personArray)!
        
        let transformer = PersonsTransformer(personsCollection: persons)
        
        let modelViews = transformer.getPersonsViewModel()
        
        XCTAssertEqual(modelViews.count, 1)
        
        var i = 0
        for modelView in modelViews {
            XCTAssertEqual(modelView.birthday, "May 26, 1969")
            XCTAssertEqual(modelView.avatarImage, persons.entries[i].image)
            XCTAssertEqual(modelView.fullName, persons.entries[i].name)
            i += 1
        }
        
    }
    
}
