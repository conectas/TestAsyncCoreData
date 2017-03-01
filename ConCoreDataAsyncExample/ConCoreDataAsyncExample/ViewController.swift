//
//  ViewController.swift
//  ConCoreDataAsyncExample
//
//  Created by Stefan Glaser on 01.03.17.
//  Copyright © 2017 Stefan Glaser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func canonAction(_ sender: UIButton) {
        // URL: https://www.tonerklau.de/tkmobilejson.php?ID=TKJSON&PROG=ARTIKELNHERSTELLER&HID=10000&LIMITA=0&LIMITB=-1
        let identifier = "goArticlesSegue"
        performSegue(withIdentifier: identifier, sender: "10000")
    }
    
    @IBAction func hpAction(_ sender: UIButton) {
        // URL: https://www.tonerklau.de/tkmobilejson.php?ID=TKJSON&PROG=ARTIKELNHERSTELLER&HID=10001&LIMITA=0&LIMITB=-1
        let identifier = "goArticlesSegue"
        performSegue(withIdentifier: identifier, sender: "10001")
    }
    
    @IBAction func samsungAction(_ sender: UIButton) {
        // URL: https://www.tonerklau.de/tkmobilejson.php?ID=TKJSON&PROG=ARTIKELNHERSTELLER&HID=10041&LIMITA=0&LIMITB=-1
        let identifier = "goArticlesSegue"
        performSegue(withIdentifier: identifier, sender: "10041")
    }
    
    @IBAction func dellAction(_ sender: UIButton) {
        // URL: https://www.tonerklau.de/tkmobilejson.php?ID=TKJSON&PROG=ARTIKELNHERSTELLER&HID=10016&LIMITA=0&LIMITB=-1
        let identifier = "goArticlesSegue"
        performSegue(withIdentifier: identifier, sender: "10016")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // ----------------------------------------------------------------------------------------------------
    // MARK: prepare
    // ----------------------------------------------------------------------------------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let kHid = sender as? String else { return  }
        
        var hName = "keine Angabe..."
        switch kHid {
        case "10000":
            hName = "Canon"
        case "10001":
            hName = "HP"
        case "10041":
            hName = "Samsung"
        case "10016":
            hName = "Dell"
        default:
            break
        }
        let zielTVC = segue.destination as! GoArticlesVC
        zielTVC.kHid = kHid
        zielTVC.hName = hName
    }
    
}

