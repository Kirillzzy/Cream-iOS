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
    Alamofire.request(Constants.Server.apiBase + addString, method: method, parameters: parameters!,
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

  private static var token: String = ""

  static func authorize(login: String, password: String, completion: @escaping (() -> Void)) {
    let parameters: Parameters = [
      "username": login,
      "password": password
    ]
    apiManagerService(addString: "api-login/", method: .post,
                      parameters: parameters, encoding: URLEncoding.httpBody,
                      completion: { json in
                        self.token = json["token"].stringValue
                        completion()
    })
  }

  static func getPosts(completion: @escaping (([TipEntity]) -> Void)) {
    let parameters: Parameters = [
      //swiftlint:disable:next line_length
      "jwt": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1MzM2NDkyNzEsImVtYWlsIjoic2FzaGFAYmFzaGtvcnQub3JnIiwidXNlcl9pZCI6MSwidXNlcm5hbWUiOiJtZXJsaW4ifQ.AZs8cvZ_4t9dd2N0DPgS_rIKFn9vr-n9TnSwCOgB8MM"
    ]
    apiManagerService(addString: "problems/", method: .get,
                      parameters: parameters, encoding: URLEncoding.httpBody,
                      completion: { json in
                        print(json)
    })
  }
}
