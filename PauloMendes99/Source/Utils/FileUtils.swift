
import UIKit

protocol FileUtilsProtocol {
    func readPersonsFile(success: @escaping ((_ data: Data) -> Void))
}

class FileUtils: NSObject, FileUtilsProtocol {
    
    public func readPersonsFile(success: @escaping ((_ data: Data) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            
            guard let filePath = Bundle.main.path(forResource: "teste99", ofType:"json") else {
                print("File Not Found")
                return
            }
            
            guard let data = try? Data(contentsOf: URL(fileURLWithPath:filePath), options: .uncached) else {
                print("File Format Error")
                return
            }
            
            success(data)
        }
    }
}
