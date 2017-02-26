
import UIKit
import Kingfisher

class PersonViewModel: Hashable {
    let avatarImage: URL
    let fullName: String
    let birthday: String
    let personId: String
    
    var hashValue: Int {
        return self.personId.hash
    }
    
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    init?(person: Person) {
        self.personId = person.id
        self.fullName = person.name
        self.birthday = PersonViewModel.formatter.string(from: person.birthday)
        self.avatarImage = person.image
    }
}

func ==(lhs: PersonViewModel, rhs: PersonViewModel) -> Bool {
    return lhs.personId == rhs.personId
}
