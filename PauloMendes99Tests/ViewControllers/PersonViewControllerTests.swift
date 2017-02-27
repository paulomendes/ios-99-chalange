
import XCTest
@testable import PauloMendes99

class PersonViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    func testShouldPresentAUIAlertIfDataSourceReturnsFileError() {
        
        class PersonsViewControllerMock: PersonsViewController {
            var viewControllerToPresent: UIViewController?
            
            override func present(_ viewControllerToPresent: UIViewController,
                                  animated flag: Bool,
                                  completion: (() -> Swift.Void)? = nil) {
                self.viewControllerToPresent = viewControllerToPresent
            }
        }
        
        class FauxDataSource : PersonsDataSourceProtocol {
            internal func getPersons(success: @escaping (PersonsCollection) -> Void, failure: @escaping (PersonsDataSourceError) -> Void) {
                failure(.fileError)
            }
        }
        
        let vc: PersonsViewControllerMock = PersonsViewControllerMock()
        
        let fauxDS = FauxDataSource()
        vc.personsDataSource = fauxDS
        UIApplication.shared.keyWindow?.rootViewController = vc
        
        if let alert = vc.viewControllerToPresent as? UIAlertController {
            XCTAssertEqual("Erro", alert.title!)
            XCTAssertEqual("Erro ao tentar ler o arquivo. Tente novamente", alert.message!)
        }
        else {
            XCTFail("UIAlertController failed to be presented")
        }

    }
    
    func testShouldPresentAUIAlertIfDataSourceReturnsJsonSerializationError() {
        
        class PersonsViewControllerMock: PersonsViewController {
            var viewControllerToPresent: UIViewController?
            
            override func present(_ viewControllerToPresent: UIViewController,
                                  animated flag: Bool,
                                  completion: (() -> Swift.Void)? = nil) {
                self.viewControllerToPresent = viewControllerToPresent
            }
        }
        
        class FauxDataSource : PersonsDataSourceProtocol {
            internal func getPersons(success: @escaping (PersonsCollection) -> Void, failure: @escaping (PersonsDataSourceError) -> Void) {
                failure(.jsonSerializationError)
            }
        }
        
        let vc: PersonsViewControllerMock = PersonsViewControllerMock()
        
        let fauxDS = FauxDataSource()
        vc.personsDataSource = fauxDS
        UIApplication.shared.keyWindow?.rootViewController = vc
        
        if let alert = vc.viewControllerToPresent as? UIAlertController {
            XCTAssertEqual("Erro", alert.title!)
            XCTAssertEqual("Erro de serialização. Verifique se o arquivo está no formato JSON", alert.message!)
        }
        else {
            XCTFail("UIAlertController failed to be presented")
        }
        
    }
    
    func testShouldPresentAUIAlertIfDataSourceReturnsPersonSerializationError() {
        
        class PersonsViewControllerMock: PersonsViewController {
            var viewControllerToPresent: UIViewController?
            
            override func present(_ viewControllerToPresent: UIViewController,
                                  animated flag: Bool,
                                  completion: (() -> Swift.Void)? = nil) {
                self.viewControllerToPresent = viewControllerToPresent
            }
        }
        
        class FauxDataSource : PersonsDataSourceProtocol {
            internal func getPersons(success: @escaping (PersonsCollection) -> Void, failure: @escaping (PersonsDataSourceError) -> Void) {
                failure(.personSerializationError)
            }
        }
        
        let vc: PersonsViewControllerMock = PersonsViewControllerMock()
        
        let fauxDS = FauxDataSource()
        vc.personsDataSource = fauxDS
        UIApplication.shared.keyWindow?.rootViewController = vc
        
        if let alert = vc.viewControllerToPresent as? UIAlertController {
            XCTAssertEqual("Erro", alert.title!)
            XCTAssertEqual("Erro de serialização de Pessoas. Verifique se o arquivo está no formato JSON", alert.message!)
        }
        else {
            XCTFail("UIAlertController failed to be presented")
        }
        
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
