//
//  BillManagerService.swift
//  MyHouse
//
//  Created by Van Luu on 8/21/17.
//  Copyright © 2017 Luu Dinh Van. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class BillManagerService: BillManagerType, RealmUsable {
  
  @discardableResult
  func addCategory(title: String, additionalInfo: String?) -> Observable<BillCategoryItem> {
    
    let category = BillCategoryItem()
    category.title = title
    category.addtionalInfo = additionalInfo
    
    let result = withRealm("addCategory") { realm -> Observable<BillCategoryItem> in
      realm.beginWrite()
      
      if let _ = realm.objects(BillCategoryItem.self).filter("title == '\( category.title)'").first {
        
        return .error(BillManagerError.addCategoryFailed)
      }
      
      realm.add(category)
      
      try realm.commitWrite()
      
      return .just(category)
      
    }
    
    return result ?? .error(BillManagerError.addCategoryFailed)
    
  }
  
  @discardableResult
  func addSubcategory(title: String, category: BillCategoryItem) -> Observable<BillSubCategoryItem> {
    let subCategory = BillSubCategoryItem()
    subCategory.title = title
    
    let result = withRealm("addSubCategory") { realm -> Observable<BillSubCategoryItem> in
      realm.beginWrite()
      
      if let _ = category.subCategories.filter("title == '\(title)'").first {
        return .error(BillManagerError.addSubCategoryFailed)
      }
      
      category.subCategories.append(subCategory)
      
      try realm.commitWrite()
      
      return .just(subCategory)
    }
    
    return result ?? .error(BillManagerError.addSubCategoryFailed)
  }
  
}
