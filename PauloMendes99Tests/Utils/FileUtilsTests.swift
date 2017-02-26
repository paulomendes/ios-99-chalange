
import XCTest


class FileUtilsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testShouldReturnFileNotFoundIfSearchBundlePathReturnsNil() {
        class FauxBundle : Bundle {
            override func path(forResource name: String?, ofType ext: String?) -> String? {
                return nil
            }
        }

        let expec = expectation(description: "readFileFunction")
        let fauxBundle = FauxBundle()
        let fileUtils = FileUtils(mainBundle: fauxBundle)
        
        fileUtils.readPersonsFile { (data, err) in
            XCTAssertEqual(err, .fileNotFound)
            expec.fulfill()
        }
        
        self.waitForExpectations(timeout: 5) { (err) in
            XCTAssertNil(err, "Something gone wrong")
        }
    }
    
    func testShouldReturnInvalidFileFormatIfPathSearchReturnsSomethingThatDoesntExsits() {
        class FauxBundle : Bundle {
            override func path(forResource name: String?, ofType ext: String?) -> String? {
                return "Something That Doesn't Exists"
            }
        }
        
        let expec = expectation(description: "readFileFunction")
        let fauxBundle = FauxBundle()
        let fileUtils = FileUtils(mainBundle: fauxBundle)
        
        fileUtils.readPersonsFile { (data, err) in
            XCTAssertEqual(err, .invalidFileFormat)
            expec.fulfill()
        }
        
        self.waitForExpectations(timeout: 5) { (err) in
            XCTAssertNil(err, "Something gone wrong")
        }
    }
    
    func testShouldReturnSuccessIfBundleSearchRetursAnExistentFile() {

        let expec = expectation(description: "readFileFunction")
        let mainBundle = Bundle.main
        let fileUtils = FileUtils(mainBundle: mainBundle)
        
        fileUtils.readPersonsFile { (data, err) in
            XCTAssertEqual(err, .none)
            expec.fulfill()
        }
        
        self.waitForExpectations(timeout: 5) { (err) in
            XCTAssertNil(err, "Something gone wrong")
        }
    }
    
}
