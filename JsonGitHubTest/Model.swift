import Foundation
struct User: Decodable {
    let login: String?
    let id: Int32?
    let avatar_url: String?
    let followers_url: String?
    
    init() {
        self.login = nil
        self.id = nil
        self.avatar_url = nil
        self.followers_url = nil
    }
}


