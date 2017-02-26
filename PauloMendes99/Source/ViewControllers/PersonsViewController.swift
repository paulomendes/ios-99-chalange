
import UIKit

class PersonsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var personsDataSource: PersonsDataSourceProtocol?
    var personsViewModels: [PersonViewModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPersonsData()
    }
    
    private func loadPersonsData() {
        
        personsDataSource?.getPersons(success: { (persons) in
            
            self.transformPersonsAndReloadData(persons: persons)
            
        }, failure: { (err) in
            switch err {
                case .fileError:
                    self.showAlertError(message: "Erro ao tentar ler o arquivo. Tente novamente")
                case .jsonSerializationError:
                    self.showAlertError(message: "Erro de serialização. Verifique se o arquivo está no formato JSON")
            case .personSerializationError:
                self.showAlertError(message: "Erro de serialização de Pessoas. Verifique se o arquivo está no formato JSON")
            }
        })
    }
    
    private func showAlertError(message: String) {
        let alert: UIAlertController = UIAlertController(title: "Erro",
                                                         message: message,
                                                         preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func transformPersonsAndReloadData(persons: PersonsCollection) {
        
        let personsTransformer = PersonsTransformer(personsCollection: persons)
        
        self.personsViewModels = personsTransformer.getPersonsViewModel()
        self.tableView.reloadData()
    }
    
    // MARK: Table View Delegate
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.personsViewModels.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PersonTableViewCell = tableView.dequeueReusableCell(withIdentifier: "person-cell",
                                                                      for: indexPath) as! PersonTableViewCell
        cell.populate(personViewModel: personsViewModels[indexPath.row])
        
        return cell
    }
    
}
