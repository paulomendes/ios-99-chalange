
import UIKit

class PersonsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var fileUtils: FileUtilsProtocol?
    var personsViewModels: [PersonViewModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPersonsData()
    }
    
    func loadPersonsData() {
        fileUtils?.readPersonsFile { (data) -> Void in
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                guard let array = json as? [Any] else {
                    return
                }
                
                guard let persons = PersonsCollection(jsonArray: array) else {
                    return
                }
                
                var personsViewModelSet: Set<PersonViewModel> = Set()
                
                for person in persons.entries {
                    let personViewModel = PersonViewModel(person: person)
                    personsViewModelSet.insert(personViewModel!)
                }
                
                self.personsViewModels = Array(personsViewModelSet)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            } catch {
                print("json error: \(error)")
            }
        }
    }
    
    // MARK: Table View Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.personsViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PersonTableViewCell = tableView.dequeueReusableCell(withIdentifier: "person-cell",
                                                                      for: indexPath) as! PersonTableViewCell
        cell.populate(personViewModel: personsViewModels[indexPath.row])
        
        return cell
    }
    
}
