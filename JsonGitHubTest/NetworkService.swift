import Foundation
protocol NetworkingServiceProtocol {
    func request(urlString: String, completion: @escaping(Data?, Error?) -> Void)
}
class NetworkService: NetworkingServiceProtocol {
    func request(urlString: String, completion: @escaping(Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let datas = data else { return }
                guard response != nil else { return }
                completion(datas, error)
            }
        }.resume()
    }
     func reqDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let datas = data else { return }
                guard response != nil else { return }
                completion(datas, error)
            }
        }
    }
}
