
import UIKit

class Container: NSObject {
    let fileUtils: FileUtils = FileUtils(mainBundle: Bundle.main)
    
    func resolvePersonDataSource() -> PersonsDataSource {
        return PersonsDataSource(fileUtils: self.fileUtils)
    }
}
