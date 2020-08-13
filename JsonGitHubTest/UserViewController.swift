import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var presenter: UserPresenter!
    let dataService = DataService()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationController()
    }
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        presenter.getDataFromNetworkService()
    }
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true // Bigtitle
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
}

// MARK: - Table view
extension UserViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TableViewCell
        let userArray = presenter.users[indexPath.row]
        cell?.configure(with: userArray)
        return cell!
    }
    // - пагинация
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.users.count - 1 {
            guard let userLastId = presenter.users.last?.idUser else { return }
            dataService.lastUserID(lastUserID: Int(userLastId)) { (user) in
                self.presenter.users.append(contentsOf: user!)
                tableView.reloadData()
            }
        }
    }
    //- передача имени юзера
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = presenter.users[indexPath.row]
        presenter.goToFollowersViewController(with: user)
    }
}
// MARK: - Request
extension UserViewController: UserVCProtocol {
    func reloadData() {
        self.tableView.reloadData()
    }
    func failureWithData(_ error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
}
