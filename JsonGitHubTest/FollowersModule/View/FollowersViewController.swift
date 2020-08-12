import UIKit
class FollowersViewController: UIViewController {
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
extension FollowersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.followersArray.count
    }
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? FollowersCellCollectionView
        let followers = presenter.followersArray[indexPath.row]
        cell?.configure(with: followers)
        return cell!
    }
}

// MARK: - Request
extension FollowersViewController: FollowerViewControllerProtocol {
    func failureWithData(_ error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
    func reloadData() {
        collectionView.reloadData()
    }
}
