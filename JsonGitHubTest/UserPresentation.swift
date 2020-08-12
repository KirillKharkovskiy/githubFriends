import Foundation

protocol UserViewControllerProtocol: class {
    func failureWithData(_ error: Error)
    func reloadData()
}

protocol UserPresenterProtocol {
    func getDataFromNetworkService()
    func goToFollowersViewController(with user: User)
}

final class UserPresenter: UserPresenterProtocol {
    private var networkService: NetworkServiceDataProtocol!
    weak var view: UserViewControllerProtocol?
    var dataService: DataServiceProtocol! // 3) тут соблюдаем СОЛИД
    var users = [User]()
    var router: RouterProtocol!
    init(view: UserViewControllerProtocol, networkService: NetworkServiceDataProtocol, dataService: DataServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.dataService = dataService
        self.router = router
    }
    func getDataFromNetworkService() {
        dataService.mainRequest { (userArray) in
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
