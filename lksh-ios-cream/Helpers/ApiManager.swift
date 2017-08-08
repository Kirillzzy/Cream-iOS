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
  static let roomPin: String = "0"
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

  static func authorize(login: String, password: String, completion: @escaping ((Bool) -> Void)) {
    let parameters: Parameters = [
      "username": login,
      "password": password
    ]
    apiManagerService(addString: "api-login/", method: .post,
                      parameters: parameters, encoding: URLEncoding.httpBody,
                      completion: { json in
                        if json["token"].stringValue != "" {
                          UserDefaultsHelper.token = json["token"].stringValue
                          completion(true)
                        }
                        completion(false)
    })
  }

  static func getPosts(roomPin: String = roomPin, completion: @escaping (([TipEntity], String) -> Void)) {
    apiManagerService(addString: "problems/?jwt=\(UserDefaultsHelper.token)&room_pin=\(roomPin)",
      encoding: URLEncoding.httpBody,
      completion: { json in
        var tips = [TipEntity]()
        for tip in json["data"].arrayValue {
          let newTip = TipEntity()
          newTip.id = tip["id"].intValue
          newTip.title = tip["title"].stringValue
          newTip.creator = tip["author_name"].stringValue
          newTip.text = tip["description"].stringValue
          newTip.likes = tip["liked"].intValue
          newTip.dislikes = tip["disliked"].intValue
          newTip.time = tip["time"].stringValue
          newTip.isLiked = tip["is_liked"].boolValue
          newTip.isDisliked = tip["is_disliked"].boolValue
          tips.append(newTip)
        }
        completion(tips, json["room_name"].stringValue)
    })
  }

  static func sendProblem(title: String, description: String,
                          roomPin: String = roomPin, completion: @escaping ((TipEntity) -> Void)) {
    let parameters: Parameters = [
      "title": title,
      "description": description,
      "jwt": UserDefaultsHelper.token,
      "room_pin": roomPin
    ]
    apiManagerService(addString: "problems/", method: .post,
                      parameters: parameters, encoding: URLEncoding.httpBody,
                      completion: { json in
                        let tip = TipEntity()
                        tip.id = json["id"].intValue
                        tip.title = json["title"].stringValue
                        tip.text = json["description"].stringValue
                        tip.creator = json["author_name"].stringValue
                        tip.time = json["time"].stringValue
                        tip.likes = json["liked"].intValue
                        tip.dislikes = json["disliked"].intValue
                        completion(tip)
    })
  }

  static func sendLike(problemId: Int, isLiked: Bool, roomPin: String = "0") {
    let parameters: Parameters = [
      "problem_id": problemId,
      "is_liked": (isLiked ? "like" : "dislike"),
      "jwt": UserDefaultsHelper.token,
      "room_pin": roomPin
    ]
    apiManagerService(addString: "api-like/", method: .post,
                      parameters: parameters, encoding: URLEncoding.httpBody,
                      completion: { json in
                        print(json)
    })
  }
}
