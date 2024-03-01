//
//  APIManager.swift
//  MVVMProduct
//
//  Created by Nirmal Prajapati on 14/02/24.
//

import Foundation
import UIKit

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidDecoding
    case invalidData
    case network(Error?)
}




//MARK: Sigleton Design Pattern

class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    
    typealias Handler = (Result<[Product], DataError>) -> Void
    
    func featchProducts(completion: @escaping Handler)
    {
        guard let url = URL(string: Constant.API.productURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do
            {
                let product = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(product))
            }
            catch
            {
                completion(.failure(.network(error)))
            }
            
        }.resume()
        
    }
}
