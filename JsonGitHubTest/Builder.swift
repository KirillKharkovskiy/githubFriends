import UIKit

protocol AssamblyBuilderProtocol {
    func createUserViewModule (with router: RouterProtocol) -> UIViewController
    func createFollowerModule (with user: User?, with router: RouterProtocol) -> UIViewController
}

class ModelBuilder: AssamblyBuilderProtocol {
    func createUserViewModule(with router: RouterProtocol) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let view = storyboard.instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
        let networkService = NetworkServiceData()
        let dataService = DataService()
        let presenter = UserPresenter(view: view, networkService: networkService, dataService: dataService, router: router)
        view.presenter = presenter
        return view
    }
    func createFollowerModule(with user: User?, with router: RouterProtocol) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let view = storyboard.instantiateViewController(withIdentifier: "FollowersViewController") as! FollowersViewController
        let dataService = DataService()
        let networkService = NetworkServiceData()
        let presenter = FollowePresenter(view: view, networkService: networkService, user: user, dataService: dataService)
        view.presenter = presenter
        return view
    }
}
