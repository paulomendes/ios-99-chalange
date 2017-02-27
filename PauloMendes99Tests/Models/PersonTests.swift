
import XCTest
@testable import PauloMendes99

class PersonTests: XCTestCase {
    
    static private var formatter: DateFormatter = {

        let dateFormatterISO8601 = DateFormatter()
        
        dateFormatterISO8601.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterISO8601.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        var gregorian = Calendar(identifier: Calendar.Identifier.gregorian)
        
        gregorian.timeZone = TimeZone(abbreviation: "GMT")!
        dateFormatterISO8601.calendar = gregorian
        
        return dateFormatterISO8601
        
    }()

    
    override func setUp() {
        super.setUp()
    }
    
    func testPersonModelShouldParseAJosn() {
        let personDictionary = [ "id" : "599df0e4-183c-4bfb-91c5-881d4550cd3f",
                                 "name" : "Craig Federighi",
                                 "image" : "http://www.apple.com/pr/bios/images/federighi_hero20120727.png",
                                 "birthday" : "1969-05-27T00:00:00Z"]
        
        let person: Person = Person(json: personDictionary)!
        XCTAssertEqual(personDictionary["id"], person.id)
        XCTAssertEqual(personDictionary["name"], person.name)
        XCTAssertEqual(URL(string: personDictionary["image"]!), person.image)
        let date: Date = PersonTests.formatter.date(from: personDictionary["birthday"]!)!
        XCTAssertEqual(date, person.birthday)
    }
    
}
