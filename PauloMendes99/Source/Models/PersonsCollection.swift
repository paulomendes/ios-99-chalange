
import Gloss

class PersonsCollection: Decodable {
    let entries: [Person]
    
    convenience init?(jsonArray: [Any]) {
        let jsonDictionary = ["entries" : jsonArray]
        
        self.init(json: jsonDictionary)
    }
    
    required init?(json: JSON) {
        guard let entries: [Person] = "entries" <~~ json else {
            return nil
        }
        self.entries = entries
    }
}
