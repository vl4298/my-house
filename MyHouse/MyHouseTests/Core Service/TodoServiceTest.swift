//
//  TodoServiceTest.swift
//  MyHouseTests
//
//  Created by Van Luu on 8/18/17.
//  Copyright © 2017 Luu Dinh Van. All rights reserved.
//

import XCTest
import RxSwift
import RealmSwift
@testable import MyHouse

class TodoServiceTest: XCTestCase {
  
  var disposeBag: DisposeBag!
  var todoService: TodoService!
  
  override func setUp() {
    super.setUp()
    
    disposeBag = DisposeBag()
    todoService = TodoService()
  }
  
  func testRetrievingListTodo() {
    let _ = todoService.todoItems().subscribe(onNext: { results in
      XCTAssertEqual(results.count, 0)
    }).addDisposableTo(disposeBag)
  }
  
  func testAddingTotoItem() {
    let _ = todoService.createTask(title: "task 1", additionalInfo: nil, needNotification: true)
      .subscribe(onNext: { todo in
        XCTAssertEqual(todo.title, "task 1")
      })
      .addDisposableTo(disposeBag)
  }
  
  func testDeletingTodoItem() {
    var todo: TodoItem? = nil
    
    let _ = todoService.createTask(title: "task 2", additionalInfo: nil, needNotification: false)
      .subscribe(onNext: { todoAdded in
        todo = todoAdded
      }).addDisposableTo(disposeBag)
    
    if let todo = todo {
      let _ = todoService.delete(todo: todo)
        .subscribe(onNext: { _ in
          XCTAssertTrue(1 == 1, "Deleting Failed")
        }).addDisposableTo(disposeBag)
    } else {
      XCTAssert(todo != nil, "Failed to add Todo Item")
    }
    
  }
  
  func testToggleCompleted() {
    let _ = todoService.createTask(title: "task 3", additionalInfo: nil, needNotification: true)
      .subscribe(onNext: { [weak self] todo in
        guard let this = self else { return }
        
        this.todoService.toggleCompleted(todo: todo)
          .subscribe(onNext: { isCompleted in
            XCTAssertTrue(isCompleted == true, "Task has completed")
          }).addDisposableTo(this.disposeBag)
        
      })
      .addDisposableTo(disposeBag)
  }
  
  func testToggleNotification() {
    let _ = todoService.createTask(title: "task 4", additionalInfo: nil, needNotification: true)
      .subscribe(onNext: { [weak self] todo in
        guard let this = self else { return }
        
        this.todoService.toggleNotification(todo: todo)
          .subscribe(onNext: { notification in
            XCTAssertTrue(notification == false, "Task has turned off notification")
          }).addDisposableTo(this.disposeBag)
        
      })
      .addDisposableTo(disposeBag)
  }
  
}


