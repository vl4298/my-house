//
//  TodoServiceType.swift
//  MyHouse
//
//  Created by Van Luu on 8/17/17.
//  Copyright © 2017 Luu Dinh Van. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

enum TodoServiceError: Error {
  case creationfailed
  case updateFailed(TodoItem)
  case deleteFailed(TodoItem)
  case toggleFailed(TodoItem)
}

protocol TodoServiceType {
  
  @discardableResult
  func createTask(title: String, additionalInfo: String?, needNotification: Bool) -> Observable<TodoItem>
  
  @discardableResult
  func delete(todo: TodoItem) -> Observable<Void>
  
  @discardableResult
  func update(todo: TodoItem, title: String, additionalInfo: String?) -> Observable<TodoItem>
  
  @discardableResult
  func numberOfTodoItems() -> Observable<Int>
  
  @discardableResult
  func toggleCompleted(todo: TodoItem) -> Observable<Bool>
  
  @discardableResult
  func toggleNotification(todo: TodoItem) -> Observable<Bool>
  
  func todoItems() -> Observable<Results<TodoItem>>
}
