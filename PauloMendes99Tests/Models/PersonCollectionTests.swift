
import XCTest

class PersonCollectionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

    }
    
    func testPersonModelShouldParseAJosnCollection() {
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
        
        let person: PersonsCollection = PersonsCollection(jsonArray: personArray)!
        XCTAssertTrue(person.entries.count == 2)
        
    }
}
