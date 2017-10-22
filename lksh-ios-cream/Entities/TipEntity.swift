//
//  TipEntity.swift
//  lksh-ios-cream
//
//  Created by Kirill Averyanov on 05/08/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import RealmSwift

class TipEntity: Object {
  @objc dynamic var id: Int = 0
  @objc dynamic var text: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var likes: Int = 0
  @objc dynamic var dislikes: Int = 0
  @objc dynamic var creator: String = ""
  @objc dynamic var time: String = ""
  @objc dynamic var isLiked: Bool = false
  @objc dynamic var isDisliked: Bool = false

  override static func primaryKey() -> String? {
    return "id"
  }

}
