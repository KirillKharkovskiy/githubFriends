import UIKit

protocol AssamblyBuilderProtocol {
    func createUserViewModule (with router: RouterProtocol) -> UIViewController
    func createFollowerModule (with user: User?, with router: RouterProtocol) -> UIViewController
}

class ModelBuilder: AssamblyBuilderProtocol {
    func createUserViewModule(with router: RouterProtocol) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let view = storyboard.instantiateViewController(withIdentifier: "UserViewController") as? UserViewController
        let netService = NetworkServiceData()
        let dataService = DataService()
        let presenter = UserPresenter(view: view!, netServ: netService, dataServ: dataService, router: router)
        view?.presenter = presenter
        return view!
    }
    func createFollowerModule(with user: User?, with router: RouterProtocol) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let view = storyboard.instantiateViewController(withIdentifier: "FollowersController") as? FollowersController
        let dataService = DataService()
        let netService = NetworkServiceData()
        let presenter = FollowePresenter(view: view!, netServ: netService, user: user, dataServ: dataService)
        view?.presenter = presenter
        return view!
    }
}
