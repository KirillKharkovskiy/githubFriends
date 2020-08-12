import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assamblyBilder: AssamblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func mainViewController ()
    func userViewController (with name: String )
    func followerViewController (with user: User?)
}

final class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assamblyBilder: AssamblyBuilderProtocol?
    init (navigationController: UINavigationController, assamblyBilder: AssamblyBuilderProtocol){
        self.navigationController = navigationController
        self.assamblyBilder = assamblyBilder
    }
    func mainViewController() {
        guard let initialViewController = assamblyBilder?.createUserViewModule(with: self) else { return }
        navigationController?.viewControllers = [initialViewController]
    }
    func userViewController(with name: String) {
        if let navigationController = navigationController {
            guard let selecterViewController = assamblyBilder?.createUserViewModule(with: self) else {return}
            navigationController.pushViewController(selecterViewController, animated: true)
        }
    }
    func followerViewController(with user: User?) {
        if let navigationController = navigationController {
            guard let hzViewController = assamblyBilder?.createFollowerModule(with: user, with: self) else {return}
            navigationController.navigationItem.title = user?.login
            navigationController.pushViewController(hzViewController, animated: true)
        }
    }
}
