//
//  ServiceLayer.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/19/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import Foundation

class ServiceLayer {
    class func request<T: Codable>(router: Router, completion: @escaping (Result<[T], Error>) -> ()) {

        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path

        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method

        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
//            let testTHing = try? JSONSerialization.jsonObject(with: data!, options: [])

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
                        
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
            let responseObject = try decoder.decode([T].self, from: data)
                
                
                
            DispatchQueue.main.async {
                    completion(.success(responseObject))
                    
                    
            
                }
            } catch {
                print(error)
            }
        }
        dataTask.resume()
    }
}
