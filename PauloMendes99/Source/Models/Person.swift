
import Gloss

struct Person: Decodable {
    
    let id: String
    let name: String
    let image: URL
    let birthday: Date
    
    init?(json: JSON) {
        
        guard let id: String = "id" <~~ json else {
            return nil
        }
        
        guard let name: String = "name" <~~ json else {
            return nil
        }
        
        guard let image: URL = "image" <~~ json else {
            return nil
        }
        
        guard let birthday: Date = Decoder.decode(dateISO8601ForKey: "birthday")(json) else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.image = image
        self.birthday = birthday
    }
}
