//
//  PauloMendes99UITests.swift
//  PauloMendes99UITests
//
//  Created by Paulo Mendes on 26/02/17.
//  Copyright © 2017 99. All rights reserved.
//

import XCTest

class PauloMendes99UITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        
        let app = XCUIApplication()
        XCTAssertEqual(app.tables.count, 1)
        
        let table = app.tables.element(boundBy: 0)
        XCTAssertEqual(table.cells.count, 6)
        
        table.swipeUp()
        table.swipeDown()
    }
    
}
