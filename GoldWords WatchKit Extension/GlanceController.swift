//
//  GlanceController.swift
//  GoldWords
//
//  Created by yokota on 2015/05/10.
//  Copyright (c) 2015年 yokota. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {
    

    

    @IBOutlet weak var glanceHeader: WKInterfaceLabel!
    @IBOutlet weak var greatMan: WKInterfaceLabel!
    @IBOutlet weak var goldWord: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let SDW = SwiftDataWrapper();
        let (gw, gm) = SDW.getOneGoldWord();
        greatMan.setText(gm);
        goldWord.setText(gw);
        glanceHeader.setText("今日の金言");
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
