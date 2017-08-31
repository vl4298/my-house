//
//  BillManagerServiceTest.swift
//  MyHouseTests
//
//  Created by Van Luu on 8/21/17.
//  Copyright © 2017 Luu Dinh Van. All rights reserved.
//

import XCTest
import RxSwift
@testable import MyHouse

class BillManagerServiceTest: XCTestCase {
  
  var billService: BillManagerType!
  var disposeBag: DisposeBag!
  var category: BillCategoryItem!
  
  override func setUp() {
    super.setUp()
    
    billService = BillManagerService()
    disposeBag = DisposeBag()
    
  }
  
  @discardableResult
  func addCategory(title: String) -> Observable<BillCategoryItem> {
    return billService.addCategory(title: title, additionalInfo: nil)
  }
  
  func testAddCategory() {
    addCategory(title: "Category 6")
      .subscribe(onNext: { [weak self] category in
        XCTAssert(true)
        
        self!.category = category
      })
      .addDisposableTo(disposeBag)
  }
  
  func testAddCategoryFailed() {
    billService.addCategory(title: "Category 1", additionalInfo: nil)
      .subscribe(
        onNext: { category in
          XCTAssert(false)
      },
        onError: { error in
          
          XCTAssert(true, "something wrong!!!")
      })
      .addDisposableTo(disposeBag)
  }
  
  func testAddSubCategory() {
    addCategory(title: "testCategory").subscribe(onNext: { [weak self] category in
      guard let this = self else { return }
      
      this.billService.addSubcategory(title: "Sub 1 of testCategory", category: category)
        .subscribe(onNext: { subCategory in
          XCTAssert(subCategory.title == "Sub 1 of testCategory")
        })
        .addDisposableTo(this.disposeBag)
    })
      .addDisposableTo(disposeBag)
    
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
}
