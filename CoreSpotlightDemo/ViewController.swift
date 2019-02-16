//
//  ViewController.swift
//  CoreSpotlightDemo
//
//  Created by Pawan kumar on 15/02/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import UIKit

import CoreSpotlight
import MobileCoreServices

/*
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
    }
     func setSelectedItem(data: [String : String]){
     
     print("Selected Identifier custom: \(data)")
     
     }
     
    override func restoreUserActivityState(_ activity: NSUserActivity) {
        if activity.activityType == CSSearchableItemActionType, let info = activity.userInfo, let selectedIdentifier = info[CSSearchableItemActivityIdentifier] as? String {
            print("Selected Identifier default:  \(selectedIdentifier)")
        }
    }
}*/


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var printers: [Any] = []
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let title_1 = "Paper Out"
        let description_1 = "If your printer isn't out of paper"
        let keywords_1 = "Paper Out"
        
        let title_2 = "Paper Jam"
        let description_2 = "Your printer has a paper jam"
        let keywords_2 = "Paper Jam"
        
        let title_3 = "Printer Error"
        let description_3 = "There are many causes for this error code"
        let keywords_3 = "Printer Error"
        
        let title_4 = "Ink Cartridge"
        let description_4 = "There are many causes for this error code"
        let keywords_4 = "Ink Cartridge"
        
        let parameters_1 : [String:String] = ["title": title_1, "description": description_1, "keywords": keywords_1]
         let parameters_2 : [String:String] = ["title": title_2, "description": description_2, "keywords": keywords_2]
         let parameters_3 : [String:String] = ["title": title_3, "description": description_3, "keywords": keywords_3]
         let parameters_4 : [String:String] = ["title": title_4, "description": description_4, "keywords": keywords_4]

        printers = [parameters_1,parameters_2,parameters_3,parameters_4]
        
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.printers.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        //let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellReuseIdentifier)
        
        // set the text from the data model
        
        let printer = self.printers[indexPath.row] as! [String:String]
        cell.textLabel?.text = printer["title"]
        cell.detailTextLabel?.text = printer["description"]
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        let detailsViewController: DetailsViewController =  self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        let printer = self.printers[indexPath.row] as! [String:String]
        detailsViewController.titleString = printer["title"] as! String
        detailsViewController.subtitleString = printer["description"] as! String
        self.navigationController?.pushViewController(detailsViewController, animated: true)
        
    }
}

