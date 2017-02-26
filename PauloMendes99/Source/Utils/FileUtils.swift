
import UIKit

enum FileUtilsError {
    case fileNotFound
    case invalidFileFormat
    case none
}

protocol FileUtilsProtocol {
    func readPersonsFile(success: @escaping (Data, FileUtilsError) -> Void)
}

class FileUtils: NSObject, FileUtilsProtocol {
    
    let mainBundle: Bundle
    
    init(mainBundle: Bundle) {
        self.mainBundle = mainBundle
    }
    
    func readPersonsFile(success: @escaping (Data, FileUtilsError) -> Void) {
        DispatchQueue.global(qos: .background).async {
            
            guard let filePath = self.mainBundle.path(forResource: "teste99", ofType:"json") else {
                print("File Not Found")
                DispatchQueue.main.async {
                    success(Data(), .fileNotFound)
                }
                return
            }
            
            guard let data = try? Data(contentsOf: URL(fileURLWithPath:filePath), options: .uncached) else {
                print("File Format Error")
                DispatchQueue.main.async {
                    success(Data(), .invalidFileFormat)
                }
                return
            }
            
            DispatchQueue.main.async {
                success(data, .none)
            }
        }
    }
}
