import Foundation
protocol DataServiceProtocol {
    func mainRequest(completion: @escaping( [User]? ) -> Void)
    func lastUserID(lastUserID: Int, completion: @escaping( [User]? ) -> Void)
    func followers(followers: String, completion: @escaping( [User]? ) -> Void)
}
class DataService: DataServiceProtocol {
    var networkService: NetServDataProtocol!
    init (networkService: NetServDataProtocol = NetworkServiceData()) {
        self.networkService = networkService
    }
    func mainRequest(completion: @escaping( [User]? ) -> Void) {
        let resourseURLString = "https://api.github.com/users"
        networkService.getDataResult(urlString: resourseURLString, response: completion)
    }
    func lastUserID(lastUserID: Int, completion: @escaping( [User]? ) -> Void) {
        let resourseURLString = "https://api.github.com/users?since=\(lastUserID)"
        networkService.getDataResult(urlString: resourseURLString, response: completion)
    }
    func followers(followers: String, completion: @escaping( [User]? ) -> Void) {
        let resourseURLString = "https://api.github.com/users/\(followers)/followers"
        networkService.getDataResult(urlString: resourseURLString, response: completion)
    }
}
