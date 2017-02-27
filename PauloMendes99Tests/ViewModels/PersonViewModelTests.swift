
import XCTest
@testable import PauloMendes99

class PersonViewModelTests: XCTestCase {
    
    var person: Person?
    
    override func setUp() {
        super.setUp()
        let personDictionary = [ "id" : "599df0e4-183c-4bfb-91c5-881d4550cd3f",
                                 "name" : "Craig Federighi",
                                 "image" : "http://www.apple.com/pr/bios/images/federighi_hero20120727.png",
                                 "birthday" : "1969-05-27T00:00:00Z"]
        
        self.person = Person(json: personDictionary)!
    }
    
    func testPersonViewModelShouldShowCorrectValues() {
        let personViewModel: PersonViewModel = PersonViewModel(person: self.person!)!
        XCTAssertEqual(personViewModel.birthday, "May 26, 1969")
        XCTAssertEqual(personViewModel.avatarImage, self.person?.image)
        XCTAssertEqual(personViewModel.fullName, self.person?.name)
    }
}
