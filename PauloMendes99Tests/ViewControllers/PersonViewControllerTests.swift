
import XCTest

class PersonViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testPersonViewControllerShouldCallOpenFileInViewDidLoad() {
        class fauxFileUtils : FileUtilsProtocol {
            var passed = false
            func readPersonsFile(success: @escaping ((Data) -> Void)) {
                passed = true
            }
        }
        
        let fileUtils = fauxFileUtils()
        
        let vc: PersonsViewController = PersonsViewController()
        vc.fileUtils = fileUtils
        UIApplication.shared.keyWindow?.rootViewController = vc
        
        XCTAssertTrue(fileUtils.passed)
    }
    
}
