//
//  ViewController.swift
//  Stars
//
//  Created by Adrian Florescu on 20.04.16.
//  Copyright © 2016 infloresc.ro. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {
  @IBOutlet weak var tvTable: UITableView!

  let MAX: Int = 5
  let ONE_MIDDLE_LINE: Int = 1

  override func viewDidLoad() {
    super.viewDidLoad()
    tvTable.dataSource = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  //
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MAX;
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MainCell
    let stars: String
    let str: String = " ☉ "
    if (indexPath.section == 0) {
      stars = repeatString(str, times: indexPath.row + 1)
    } else {
      stars = repeatString(str, times: MAX - indexPath.row - ONE_MIDDLE_LINE)
      // stars = String(count: MAX - indexPath.row - ONE_MIDDLE_LINE, repeatedValue: char)
    }
    cell.lblStars.text = stars

    return cell
  }

  // MARK - Helper
  func repeatString(string: String, times: Int) -> String {
    var str: String = ""

    if (times < 1) {
      return ""
    }

    for _ in 1 ... times {
      str = "\(str)\(string)"
    }
    return str
  }

}

