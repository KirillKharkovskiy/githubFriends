import Foundation

protocol UserVCProtocol: class {
    func failureWithData(_ error: Error)
    func reloadData()
}

protocol UserPresenterProtocol {
    func getDataFromNetworkService()
    func goToFollowersViewController(with user: User)
}

final class UserPresenter: UserPresenterProtocol {
    private var netServ: NetServDataProtocol!
    weak var view: UserVCProtocol?
    var dataServ: DataServiceProtocol!
    var users = [User]()
    var router: RouterProtocol!
    init(view: UserVCProtocol, netServ: NetServDataProtocol, dataServ: DataServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.netServ = netServ
        self.dataServ = dataServ
        self.router = router
    }
    func getDataFromNetworkService() {
        dataServ.mainRequest { (userArray) in
            print("done")
            DispatchQueue.main.async {
                guard let user = userArray else { return }
                self.users = user
                self.view?.reloadData()
            }
        }
    }
    func goToFollowersViewController(with user: User) {
        router.followerViewController(with: user)
    }
}
