import UIKit
import Nuke
class FollowersCellCollectionView: UICollectionViewCell {
    @IBOutlet weak var imageViewLabel: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    
    func configure(with followersArray: User) {
        loginLabel.text = followersArray.login
        let options = ImageLoadingOptions(
          placeholder: UIImage(named: "ava"),
          transition: .fadeIn(duration: 0.5)
        )
        if let imageLogo = followersArray.avatar_url {
            let url = URL(string: imageLogo)!
            Nuke.loadImage(with: url, options: options, into: imageViewLabel)
            self.imageViewLabel.contentMode = .scaleAspectFill
            self.imageViewLabel.layer.cornerRadius = 20
            self.imageViewLabel.clipsToBounds = true
        }
    }
}
