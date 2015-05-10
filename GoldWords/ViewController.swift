//
//  ViewController.swift
//  GoldWords
//
//  Created by yokota on 2015/04/12.
//  Copyright (c) 2015年 yokota. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var greatMan: UILabel!
    @IBOutlet weak var goldWord: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let SDW = SwiftDataWrapper();
        let (gw, gm) = SDW.getOneGoldWord();
        greatMan.text = gm;
        goldWord.text = gw;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

