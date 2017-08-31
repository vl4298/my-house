//
//  BillSubCategoryItem.swift
//  MyHouse
//
//  Created by Van Luu on 8/21/17.
//  Copyright © 2017 Luu Dinh Van. All rights reserved.
//

import Foundation
import RealmSwift

class BillSubCategoryItem: Object {

  dynamic var title: String = ""
  
  override class func primaryKey() -> String {
    return "title"
  }
}
