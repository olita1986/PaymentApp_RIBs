//
//  AlamoFireClient.swift
//  MercadoPagoExample
//
//  Created by Orlando Arzola on 1/28/19.
//  Copyright © 2019 Orlando Arzola. All rights reserved.
//

import Foundation
import Alamofire

class AlamoFireClient: Client {
    func genericRequest<T>(withType type: T.Type, url: URL, onSuccess: @escaping (T?) -> Void) where T : Decodable {
        Alamofire.request(url).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    onSuccess(decodedObject)
                } catch let error {
                    print(error.localizedDescription)
                    onSuccess(nil)
                }
            case .failure:
                onSuccess(nil)
            }
        }
    }
}
