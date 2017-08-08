//
//  TipEntity.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 05/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import RealmSwift

class TipEntity: Object {
  dynamic var id: Int = 0
  dynamic var text: String = ""
  dynamic var title: String = ""
  dynamic var likes: Int = 0
  dynamic var dislikes: Int = 0
  dynamic var creator: String = ""
  dynamic var time: String = ""
  dynamic var isLiked: Bool = false
  dynamic var isDisliked: Bool = false

  override static func primaryKey() -> String? {
    return "id"
  }

}
