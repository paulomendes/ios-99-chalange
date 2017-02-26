
import UIKit

class PersonsTransformer {
    let personsCollection: PersonsCollection
    
    init(personsCollection: PersonsCollection) {
        self.personsCollection = personsCollection
    }
    
    func getPersonsViewModel() -> [PersonViewModel] {
        var personsViewModelSet: Set<PersonViewModel> = Set()
        
        for person in self.personsCollection.entries {
            let personViewModel = PersonViewModel(person: person)
            personsViewModelSet.insert(personViewModel!)
        }
        
        return Array(personsViewModelSet)
    }
}
