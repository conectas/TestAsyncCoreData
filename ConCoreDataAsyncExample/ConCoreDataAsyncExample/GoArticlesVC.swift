//
//  GoArticlesVC.swift
//  ConCoreDataAsyncExample
//
//  Created by Stefan Glaser on 01.03.17.
//  Copyright © 2017 Stefan Glaser. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class GoArticlesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    typealias JSON = [String: AnyObject]
    typealias JSONArray = [JSON]
    
    // --------------------------------------------------
    var kHid = String()
    var hName = String()
    var fromItem = "0"
    
    // --------------------------------------------------
    var articlesDbList: [ArticlesDb]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchRandomUserData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // ----------------------------------------------------------------------------------------------------
    // Tabelle / Database
    // ----------------------------------------------------------------------------------------------------
    
    // ----------------------------------------------------------------------------------------------------
    // Tabelle
    // ----------------------------------------------------------------------------------------------------
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // --------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let articlesDbListeSet = articlesDbList else {
            return 0
        }
        return articlesDbListeSet.count
    }
    
    // --------------------------------------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! GoArticlesTVCell
        
        guard let articlesDbListeSet = articlesDbList else {
            return cell
        }
        
        var singleArticlData: ArticlesDb
        singleArticlData = articlesDbListeSet[indexPath.row]
        
        if singleArticlData.kHersteller != nil && singleArticlData.kName != nil {
            cell.kNameOutlet.text = "\(singleArticlData.kHersteller!) \(singleArticlData.kName!) | \([indexPath.row])"
        }
        
        if singleArticlData.kImageData != nil {
            cell.kImageOutlet.image = UIImage(data: singleArticlData.kImageData! as Data)
        } else {
            let replacementImage = "app_loading_article_image.png"
            
            if let articleImage = UIImage(named: replacementImage) {
                cell.kImageOutlet.image = articleImage
            } else {
                cell.kImageOutlet.image = UIImage()
            }
        }
        
        cell.articelTypGruppe?.text = singleArticlData.typGruppe
        
        return cell
    }

}
