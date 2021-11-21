//
//  Networking.swift
//  FXServices
//
//  Created by Animesh Mishra on 10/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import Foundation

/// Result enum is a generic for any type of value
/// with success and failure case
public enum Result<T> {
    case success(T)
    case failure(Error)
}

final public class Networking: NSObject {
    
    // MARK: - Private functions
    private static func getData(url: URL,
                                completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    // MARK: - Public functions
    
    /// fetchFXRates function will fetch the FX Rates and returns
    /// Result<FXRates> as completion handler
     public static func fetchFXRates(shouldFail: Bool = false, completion: @escaping (Result<FXRates>) -> Void) {
        var urlString: String?
        if shouldFail {
            urlString = EndPoints.test.rawValue
        } else {
            urlString = EndPoints.prod.rawValue
        }
        
        guard let mainUrlString = urlString,  let url = URL(string: mainUrlString) else { return }
        
        Networking.getData(url: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, error == nil else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .millisecondsSince1970
                let json = try decoder.decode(FXRates.self, from: data)
                completion(.success(json))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}

