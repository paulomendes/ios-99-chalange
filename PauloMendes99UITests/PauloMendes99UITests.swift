//
//  PauloMendes99UITests.swift
//  PauloMendes99UITests
//
//  Created by Paulo Mendes on 26/02/17.
//  Copyright © 2017 99. All rights reserved.
//

import XCTest
@testable import PauloMendes99

class PauloMendes99UITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()

    }
    
    func testOpenAndSwipeTableView() {
        
        let app = XCUIApplication()
        XCTAssertEqual(app.tables.count, 1)
        
        let table = app.tables.element(boundBy: 0)
        XCTAssertEqual(table.cells.count, 6)
        
        table.swipeUp()
        table.swipeDown()
    }
}
