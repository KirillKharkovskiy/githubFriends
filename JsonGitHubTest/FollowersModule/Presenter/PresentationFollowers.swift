import Foundation
protocol FollowerVCProtocol: class {
    func failureWithData(_ error: Error)
    func reloadData()
}
protocol FollowerPresenterProtocol {
    func setUser()
}
final class FollowePresenter: FollowerPresenterProtocol {
    private var netServ: NetServDataProtocol!
    weak var view: FollowerVCProtocol?
    var dataServ: DataServiceProtocol!
    var followersArray = [User]()
    var user: User?
    init(view: FollowerVCProtocol, netServ: NetServDataProtocol, user: User?, dataServ: DataServiceProtocol) {
        self.view = view
        self.netServ = netServ
        self.user = user
        self.dataServ = dataServ
        setUser()
    }
    public func setUser() {
        guard let followersLogin = user?.login else {return}
        dataServ.followers(followers: followersLogin) { [weak self] (follower) in
            DispatchQueue.main.async {
                guard let follower = follower else { return }
                self?.followersArray = follower
                self?.view?.reloadData()
            }
        }
    }
}
