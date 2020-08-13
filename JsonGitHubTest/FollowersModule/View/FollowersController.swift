import UIKit
class FollowersController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let dataService = DataService()
    var presenter: FollowePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTVC()
    }
    func setupTVC() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - CollectionView,DataSource,Delegate
extension FollowersController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.followersArray.count
    }
func collectionView(_ colview: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colview.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? FollowerCellCollection
        let followers = presenter.followersArray[indexPath.row]
        cell?.configure(with: followers)
        return cell!
    }
}

// MARK: - Request
extension FollowersController: FollowerVCProtocol {
    func failureWithData(_ error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
    func reloadData() {
        collectionView.reloadData()
    }
}
