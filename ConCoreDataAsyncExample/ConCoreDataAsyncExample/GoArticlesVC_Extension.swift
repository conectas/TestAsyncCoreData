//
//  GoArticlesVC_Extension.swift
//  ConCoreDataAsyncExample
//
//  Created by Stefan Glaser on 01.03.17.
//  Copyright © 2017 Stefan Glaser. All rights reserved.
//

import UIKit
import Foundation
import CoreData

extension GoArticlesVC {
    
    func fetchRandomUserData() {
        DispatchQueue.global(qos: .background).async {
            
            
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now(), execute: {
                // let randomInt = arc4random_uniform(UINT32_MAX)
                
                // URLSession.shared.dataTask(with: URL(string: "https://randomuser.me/api/?results=1&rand=\(randomInt)")!) { (data, response, error) in
                URLSession.shared.dataTask(with: URL(string: "https://www.tonerklau.de/tkmobilejson.php?ID=TKJSON&PROG=ARTIKELNHERSTELLER&HID=\(self.kHid)&LIMITA=\(self.fromItem)&LIMITB=-1")!) { (data, response, error) in
                    
                    print("url: https://www.tonerklau.de/tkmobilejson.php?ID=TKJSON&PROG=ARTIKELNHERSTELLER&HID=\(self.kHid)&LIMITA=\(self.fromItem)&LIMITB=-1")
                    
                    
                    guard
                        let data = data,
                        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSON,
                        let results = jsonObject?["itemsName"] as? JSONArray else {
                            return
                    }
                    
                    let backgroundContext = (UIApplication.shared.delegate as! AppDelegate).backgroundContext!
                    
                    for user in results {
                        let userDataObject = ArticlesDb(context: backgroundContext)
                        
                        userDataObject.kid = user["KID"] as? String
                        let kName = user["KNAME"] as? String
                        userDataObject.kName = kName
                        
                        let kOrg = user["KORG"] as! Bool
                        userDataObject.kOrg = kOrg
                        
                        if kOrg {
                            userDataObject.kToOrg = kName
                        } else {
                            userDataObject.kToOrg = user["KTOORG"] as? String
                        }
                        
                        userDataObject.kHersteller = user["KHERSTELLER"] as? String
                        userDataObject.kImagePfad = user["IMAGEPFAD"] as? String
                        userDataObject.kImageData = Data() as NSData?
                        
                        userDataObject.kHid = self.kHid
                        
                    }
                    
                    try? backgroundContext.save()
                    
                    DispatchQueue.main.async {
                        self.populateTableViewFromCoreData()
                    }
                    
                    }.resume()
            })
        }
    }
    
    private func populateTableViewFromCoreData() {
        
        var predicates = [NSPredicate]()
        
        let persistentContainer = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
        
        let fetchRequest = NSFetchRequest<ArticlesDb>(entityName: "ArticlesDb")
        // let fetchRequest: NSFetchRequest<ArticlesDb> = ArticlesDb.fetchRequest()
        
        // predicates.append(NSPredicate(format: "kHid = %@", "\(kHid)"))
        predicates.append(NSPredicate(format: "kHid == \(kHid)"))
        fetchRequest.predicate = NSCompoundPredicate(type: .and, subpredicates: predicates)
        
        let kToOrgSortDescriptor = NSSortDescriptor(key: "kToOrg", ascending: true)
        let kOrgSortDescriptor = NSSortDescriptor(key: "kOrg", ascending: true)
        fetchRequest.sortDescriptors = [kToOrgSortDescriptor, kOrgSortDescriptor]
        
        articlesDbList = try! persistentContainer?.viewContext.fetch(fetchRequest)
        tableView.reloadData()
    }
}
