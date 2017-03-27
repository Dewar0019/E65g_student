//
//  ViewController.swift
//  Assignment3
//
//  Created by Van Simmons on 1/15/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var stepButton: UIButton!

  @IBOutlet weak var gridView: GridView!

  @IBAction func stepButtonPress(_ sender: UIButton) {
    gridView.grid = gridView.grid.next()
    gridView.setNeedsDisplay()
  }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

