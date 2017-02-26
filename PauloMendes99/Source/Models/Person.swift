
import Gloss

struct Person: Decodable {
    
    let id: String?
    let name: String?
    let image: URL?
    let birthday: Date?
    
    init?(json: JSON) {
        self.id = "id" <~~ json
        self.name = "name" <~~ json
        self.image = "image" <~~ json
        self.birthday = Decoder.decode(dateISO8601ForKey: "birthday")(json)
    }
}
