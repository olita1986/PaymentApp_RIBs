//
//  UrlSessionClient.swift
//  MercadoPagoExample
//
//  Created by Orlando Arzola on 1/28/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation

class UrlSessionClient: Client {
    func genericRequest<T>(withType type: T.Type, url: URL, onSuccess: @escaping (T?) -> Void) where T : Decodable {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                onSuccess(nil)
                return
            }

            guard let data = data else {
                onSuccess(nil)
                return
            }

            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                onSuccess(decodedObject)
            } catch let error {
                print(error.localizedDescription)
                onSuccess(nil)
            }
        }.resume()
    }
}
