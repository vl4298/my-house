//
//  TodoService.swift
//  MyHouse
//
//  Created by Van Luu on 8/17/17.
//  Copyright © 2017 Luu Dinh Van. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

class TodoService: TodoServiceType, RealmUsable {
  
  @discardableResult
  func createTask(title: String, additionalInfo: String?, needNotification: Bool) -> Observable<TodoItem> {
    let result = withRealm("createTodoItem") { realm -> Observable<TodoItem> in
      let todo = TodoItem()
      todo.title = title
      todo.additionalInfo = additionalInfo
      todo.needNotification = needNotification
      
      try realm.write {
        todo.id = (realm.objects(TodoItem.self).max(ofProperty: "id") ?? 0) + 1
        realm.add(todo)
      }
      
      return .just(todo)
    }
    
    return result ?? .error(TodoServiceError.creationfailed)
  }
  
  @discardableResult
  func delete(todo: TodoItem) -> Observable<Void> {
    let result = withRealm("deleteTodoItem") { realm -> Observable<Void> in
      try realm.write {
        realm.delete(todo)
      }
      return .empty()
    }
    
    return result ?? .error(TodoServiceError.deleteFailed(todo))
  }
  
  @discardableResult
  func update(todo: TodoItem, title: String, additionalInfo: String?) -> Observable<TodoItem> {
    let result = withRealm("updateTodoItem") { realm -> Observable<TodoItem> in
      try realm.write {
        todo.title = title
        todo.additionalInfo = additionalInfo
      }
      return .just(todo)
    }
    
    return result ?? .error(TodoServiceError.updateFailed(todo))
  }
  
  func numberOfTodoItems() -> Observable<Int> {
    let result = withRealm("getNumberOfTodoItems") { realm -> Observable<Int> in
      let number = realm.objects(TodoItem.self).count
      return .just(number)
    }
    
    return result!
  }
  
  @discardableResult
  func toggleCompleted(todo: TodoItem) -> Observable<Bool> {
    let result = withRealm("toggleComplete") { realm -> Observable<Bool> in
      try realm.write {
        todo.isCompleted = !todo.isCompleted
      }
      
      return .just(todo.isCompleted)
    }
    
    return result ?? .error(TodoServiceError.toggleFailed(todo))
  }
  
  @discardableResult
  func toggleNotification(todo: TodoItem) -> Observable<Bool> {
    let result = withRealm("toggeNotification") { realm -> Observable<Bool> in
      try realm.write {
        todo.needNotification = !todo.needNotification
      }
      
      return .just(todo.needNotification)
    }
    
    return result ?? .error(TodoServiceError.toggleFailed(todo))
  }
  
  @discardableResult
  func todoItems() -> Observable<Results<TodoItem>> {
    let result = withRealm("getTodoList") { realm -> Observable<Results<TodoItem>> in
      let todoArr = realm.objects(TodoItem.self)
      return .collection(from: todoArr)
    }
    
    return result!
  }
  
}
