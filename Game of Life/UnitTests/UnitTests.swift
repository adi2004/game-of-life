//
//  UnitTests.swift
//  UnitTests
//
//  Created by Adrian Florescu on 09.06.16.
//  Copyright © 2016 infloresc.ro. All rights reserved.
//

import XCTest
@testable import Game_of_Life

class UnitTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEntitiesWillDieAfterOneCicle() {
        var entities = Set<Point>()
        entities.insert(Point(x: 0, y: 0))
        entities.insert(Point(x: 0, y: 1))
        let g = Game(entities)
        g.next()
    
        XCTAssertEqual(g.entities.count, 0)
    }
    
    func testEntitiesWillSurvive() {
        var entities = Set<Point>()
        entities.insert(Point(x: 0, y: 0))
        entities.insert(Point(x: 0, y: 1))
        entities.insert(Point(x: 0, y: 2))
        let g = Game(entities)
        g.next()
        g.next()
        g.next()
        
        XCTAssertEqual(g.entities.count, 3)
    }
    
    func testRandomInit() {
        let g = Game(nrOfEntities: 30, x: 0, y: 0, width: 10, height: 10)
        g.next()
        
        XCTAssertGreaterThan(g.entities.count, 0)
    }
    
    func testPerformanceWith3Entities() {
        var entities = Set<Point>()
        entities.insert(Point(x: 0, y: 0))
        entities.insert(Point(x: 0, y: 1))
        entities.insert(Point(x: 0, y: 2))
        let g = Game(entities)
        self.measure {
            for _ in 1...1_000 {
                g.next()
            }
        }
    }
    
}
