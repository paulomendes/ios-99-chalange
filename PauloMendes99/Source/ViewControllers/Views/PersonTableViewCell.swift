
import UIKit

class PersonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populate(personViewModel: PersonViewModel) {
        avatarImageView.kf.setImage(with: personViewModel.avatarImage)
        birthdayLabel.text = personViewModel.birthday
        nameLabel.text = personViewModel.fullName
    }
}
