//
//  RealmUsable.swift
//  MyHouse
//
//  Created by Van Luu on 8/21/17.
//  Copyright © 2017 Luu Dinh Van. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmUsable {
  
}

extension RealmUsable {
  func withRealm<T>(_ operation: String, action: (Realm) throws -> T) -> T? {
    do {
      let realm = try Realm()
      return try action(realm)
    } catch let err {
      
      print("Failed with \(operation) realm with err: \(err)")
      return nil
    }
  }
}
