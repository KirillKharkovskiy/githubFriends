import Foundation
protocol FollowerViewControllerProtocol: class {
    func failureWithData(_ error: Error)
    func reloadData()
}
protocol FollowerPresenterProtocol {
    func setUser()
}
final class FollowePresenter: FollowerPresenterProtocol {
    
    private var networkService: NetworkServiceDataProtocol!
    weak var view: FollowerViewControllerProtocol?
    var dataService: DataServiceProtocol!
    var followersArray = [User]()
    var user: User?
    init(view: FollowerViewControllerProtocol, networkService: NetworkServiceDataProtocol, user: User?, dataService: DataServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.user = user
        self.dataService = dataService
        setUser()
    }
    public func setUser() {
        guard let followersLogin = user?.login else {return}
        dataService.followers(followers: followersLogin) { [weak self] (follower) in
            DispatchQueue.main.async {
                guard let follower = follower else { return }
                self?.followersArray = follower
                self?.view?.reloadData()
            }
        }
    }
}
