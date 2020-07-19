//
//  ServiceLayer.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/19/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import Foundation

class ServiceLayer {
    // 1.
    class func request<T: Codable>(router: Router, completion: @escaping (Result<[String: [T]], Error>) -> ()) {
        // 2.
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        // 3.
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        // 4.
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            // 5.
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription)
                return
            }
            guard response != nil else {
                return
            }
            guard let data = data else {
                return
            }
            // 6.
            let responseObject = try! JSONDecoder().decode([String: [T]].self, from: data)
            // 7.
            DispatchQueue.main.async {
                // 8.
                completion(.success(responseObject))
            }
        }
        dataTask.resume()
    }
}
