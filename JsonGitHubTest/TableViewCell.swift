import UIKit
import Nuke
class TableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewLabel: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configure( with userArray: User) {
        accessoryType = .disclosureIndicator
        loginLabel.text = userArray.login
        let options = ImageLoadingOptions(
              placeholder: UIImage(named: "ava"),
              transition: .fadeIn(duration: 0.5)
            )
        if let imageLogo = userArray.avatar_url {
            let url = URL(string: imageLogo)!
            Nuke.loadImage(with: url, options: options, into: imageViewLabel)
            self.imageViewLabel.contentMode = .scaleAspectFill
            self.imageViewLabel.layer.cornerRadius = 20
            self.imageViewLabel.clipsToBounds = true
        }
    }
}
