
import XCTest

class PersonViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testPersonViewControllerShouldCallGetPersonsOnViewDidLoad() {
        class FauxDataSource : PersonsDataSourceProtocol {
            var passed = false
            internal func getPersons(success: @escaping (PersonsCollection) -> Void, failure: @escaping (PersonsDataSourceError) -> Void) {
                passed = true
            }
        }
        
        let fauxDS = FauxDataSource()
        
        let vc: PersonsViewController = PersonsViewController()
        vc.personsDataSource = fauxDS
        UIApplication.shared.keyWindow?.rootViewController = vc
        
        XCTAssertTrue(fauxDS.passed)
    }
    
}
