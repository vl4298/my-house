//
//  CategoryItem.swift
//  MyHouse
//
//  Created by Van Luu on 8/21/17.
//  Copyright © 2017 Luu Dinh Van. All rights reserved.
//

import Foundation
import RealmSwift

class BillCategoryItem: Object {

  dynamic var title: String = ""
  dynamic var addtionalInfo: String? = nil
  let subCategories = List<BillSubCategoryItem>()
  
  override class func primaryKey() -> String {
    return "title"
  }
  
}
