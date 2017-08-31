//
//  BillManagerType.swift
//  MyHouse
//
//  Created by Van Luu on 8/21/17.
//  Copyright © 2017 Luu Dinh Van. All rights reserved.
//

import Foundation
import RxSwift

enum BillManagerError: Error {
  case addCategoryFailed
  case addSubCategoryFailed
}

protocol BillManagerType {
  
  @discardableResult
  func addCategory(title: String, additionalInfo: String?) -> Observable<BillCategoryItem>
  
  @discardableResult
  func addSubcategory(title: String, category: BillCategoryItem) -> Observable<BillSubCategoryItem>
}
