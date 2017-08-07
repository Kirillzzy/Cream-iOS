//
//  ApiManager.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 07/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class ApiManager {
  private static func apiManagerService(addString: String,
                                        method: HTTPMethod = .get,
                                        parameters: Parameters? = nil,
                                        encoding: ParameterEncoding = JSONEncoding.default,
                                        completion: @escaping (_ json: JSON) -> Void) {
    guard Reachability.isInternetAvailable else { return }
    Alamofire.request(Constants.Server.apiBase + addString, method: method, parameters: parameters,
                      encoding: encoding).responseJSON(completionHandler: { response in
                        switch response.result {
                        case .success:
                          guard let value = response.result.value else { return }
                          completion(JSON(value))
                        case .failure(let error):
                          print(error)
                          return
                        }
                      })
  }

  static func authorize(login: String, password: String, completion: @escaping (() -> Void)) {
    let parameters: Parameters = [
      "username": login,
      "password": password
    ]
    apiManagerService(addString: "api-login/", method: .post,
                      parameters: parameters, encoding: URLEncoding.httpBody,
                      completion: { json in
                        UserDefaultsHelper.token = json["token"].stringValue
                        completion()
    })
  }

  static func getPosts(roomPin: String = "0", completion: @escaping (([TipEntity]) -> Void)) {
    apiManagerService(addString: "problems/?jwt=\(UserDefaultsHelper.token)&room_pin=\(roomPin)",
      encoding: URLEncoding.httpBody,
      completion: { json in
        print(json)
    })
  }

  static func sendProblem(title: String, description: String) {
    let parameters: Parameters = [
      "title": title,
      "description": description,
      "jwt": UserDefaultsHelper.token
    ]
    apiManagerService(addString: "problems/", method: .post,
                      parameters: parameters, encoding: URLEncoding.httpBody,
                      completion: { json in
                        print(json)
    })
  }
}
