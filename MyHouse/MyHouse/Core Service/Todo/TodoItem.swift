//
//  TodoItem.swift
//  MyHouse
//
//  Created by Van Luu on 8/17/17.
//  Copyright © 2017 Luu Dinh Van. All rights reserved.
//

import Foundation
import RealmSwift

class TodoItem: Object {
  
  dynamic var id: Int = 0
  dynamic var title: String = ""
  dynamic var date: Date = Date()
  dynamic var isCompleted: Bool = false
  dynamic var needNotification: Bool = false
  dynamic var additionalInfo: String? = nil
  
  override class func primaryKey() -> String {
    return "id"
  }
}

