import Foundation
protocol NetServDataProtocol {
    func getDataResult<T: Decodable>(urlString: String, response: @escaping(T?) -> Void)
}

class NetworkServiceData: NetServDataProtocol {
    var networking: NetworkingServiceProtocol!
    init(networking: NetworkingServiceProtocol = NetworkService()) {
        self.networking = networking
    }
    func getDataResult<T: Decodable>(urlString: String, response: @escaping (T?) -> Void ) {
        networking.request(urlString: urlString) { (data, error) in
            if let error = error {
                print("Error", error.localizedDescription)
                response(nil)
            }
            let decoder = self.decodeJson(type: T.self, from: data)
            response(decoder)
        }
    }
    func decodeJson<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        if let object = try? decoder.decode(type.self, from: data) {
            return object
        } else {
            print("Failed to decode Json")
            return nil
        }
    }
}
