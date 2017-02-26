
import UIKit

protocol PersonsDataSourceProtocol {
    func getPersons(success: @escaping (PersonsCollection) -> Void, failure: @escaping (PersonsDataSourceError) -> Void)
}

enum PersonsDataSourceError {
    case fileError
    case jsonSerializationError
    case personSerializationError
}

class PersonsDataSource: PersonsDataSourceProtocol {
    
    let fileUtils: FileUtilsProtocol
    
    init(fileUtils: FileUtilsProtocol) {
        self.fileUtils = fileUtils
    }
    
    func getPersons(success: @escaping (PersonsCollection) -> Void, failure: @escaping (PersonsDataSourceError) -> Void) {
        fileUtils.readPersonsFile { (data, err) in
            if err == FileUtilsError.fileNotFound || err == FileUtilsError.invalidFileFormat {
                failure(.fileError)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                guard let array = json as? [Any] else {
                    failure(.jsonSerializationError)
                    return
                }
                
                guard let persons = PersonsCollection(jsonArray: array) else {
                    failure(.personSerializationError)
                    return
                }
                
                success(persons)
                
            } catch {
                print("json error: \(error)")
                failure(.jsonSerializationError)
            }
        }
    }
}
