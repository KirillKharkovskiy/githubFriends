import Foundation

struct User: Codable {
    let login: String?
    let idUser: Int32?
    let avatarUrl: String?
    let followersUrl: String?
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case idUser = "id"
        case avatarUrl = "avatar_url"
        case followersUrl = "followers_url"
    }
    init() {
        self.login = nil
        self.idUser = nil
        self.avatarUrl = nil
        self.followersUrl = nil
    }
}
