import Foundation

protocol Networkable {
    
    func request(url path: String, completion: @escaping (Result<Data, Error>) -> Void)

}
