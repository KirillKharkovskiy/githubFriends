import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var asBilder: AssamblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func mainViewController ()
    func userViewController (with name: String )
    func followerViewController (with user: User?)
}

final class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var asBilder: AssamblyBuilderProtocol?
    init (navigationController: UINavigationController, asBilder: AssamblyBuilderProtocol) {
        self.navigationController = navigationController
        self.asBilder = asBilder
    }
    func mainViewController() {
        guard let initialViewController = asBilder?.createUserViewModule(with: self) else { return }
        navigationController?.viewControllers = [initialViewController]
    }
    func userViewController(with name: String) {
        if let navigationController = navigationController {
            guard let selecterViewController = asBilder?.createUserViewModule(with: self) else {return}
            navigationController.pushViewController(selecterViewController, animated: true)
        }
    }
    func followerViewController(with user: User?) {
        if let navigationController = navigationController {
            guard let hzViewController = asBilder?.createFollowerModule(with: user, with: self) else {return}
            navigationController.navigationItem.title = user?.login
            navigationController.pushViewController(hzViewController, animated: true)
        }
    }
}
