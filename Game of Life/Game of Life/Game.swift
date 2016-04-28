//
//  Game.swift
//  Game of Life
//
//  Created by Adrian Florescu on 22.04.16.
//  Copyright © 2016 infloresc.ro. All rights reserved.
//

import UIKit

class Game: NSObject {
  var entities = Set<Point>()
  var generation: Int = 0
  
  override init() {
  }

  init(nrOfEntities nr: Int, x: UInt32, y: UInt32, width: UInt32, height: UInt32) {
    for _ in 0 ..< nr {
      entities.insert(Point(x: Int(x + arc4random_uniform(width)), y: Int(y + arc4random_uniform(height))))
    }
  }

  func next() {
    var nextEntities = Set<Point>()

    // get the set where the entities can be born
    let searchSet = getSearchSet()

    // see who will be born
    for e in searchSet {
      if getNeighbours(e).intersect(entities).count == 3 {
        nextEntities.insert(e)
      }
    }

    // see who will stay alive
    for e in entities {
      let liveNeighboursCount = getNeighbours(e).intersect(entities).count
      if liveNeighboursCount == 2 || liveNeighboursCount == 3 {
        nextEntities.insert(e)
      }
    }

    // nothing else to do, everyone else dies
    generation += 1
    entities = nextEntities
  }

  func getSearchSet() -> Set<Point> {
    var searchSet = Set<Point>()

    for e in entities {
      let neighbours = getNeighbours(e)
      for n in neighbours {
        if !entities.contains(n) {
          searchSet.insert(n)
        }
      }
    }

    return searchSet
  }

  func getNeighbours(entity: Point) -> Set<Point> {
    var neighbours = Set<Point>()
    neighbours.insert(Point(x: entity.x - 1, y: entity.y - 1))
    neighbours.insert(Point(x: entity.x, y: entity.y - 1))
    neighbours.insert(Point(x: entity.x + 1, y: entity.y - 1))

    neighbours.insert(Point(x: entity.x - 1, y: entity.y))
    neighbours.insert(Point(x: entity.x + 1, y: entity.y))

    neighbours.insert(Point(x: entity.x - 1, y: entity.y + 1))
    neighbours.insert(Point(x: entity.x, y: entity.y + 1))
    neighbours.insert(Point(x: entity.x + 1, y: entity.y + 1))

    return neighbours
  }
}
