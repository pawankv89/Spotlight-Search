//
//  SpotlightManager.swift
//  CoreSpotlightDemo
//
//  Created by Pawan kumar on 15/02/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//


import UIKit
import CoreSpotlight
import MobileCoreServices

class SpotlightManager {
    
    // Singleton
    class var sharedInstance: SpotlightManager {
        struct Static {
            static let instance: SpotlightManager = SpotlightManager()
        }
        return Static.instance
    }
    
    // Delete all items and set new items.
    func reloadInitialItems(){
        
        // Delete and reload all items
        self.deleteAllItems { (completed) in
            self.setupIndexSearchableItemsInSpotlight()
        }
    }
    
    // Delete all searchable spotlight items.
    func deleteAllItems(_ completed: ((_ success: Bool)->())? = nil){
        CSSearchableIndex.default().deleteAllSearchableItems { (error) in
            let success = error == nil
            if let completed = completed {
                completed(success)
            }
        }
    }
    
    // Setup Searchable Items in Spotlight
    func setupIndexSearchableItemsInSpotlight(){
        
        //let matches ...
        var searchableItems = [CSSearchableItem]()
        
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
    
        //Params Recived when user End 
        let parameters1 = ["title" : title_1.replacingOccurrences(of: " ", with: "%20"), "id" : "12"]
        let parameters2 = ["title" : title_2.replacingOccurrences(of: " ", with: "%20"), "id" : "123"]
        let parameters3 = ["title" : title_3.replacingOccurrences(of: " ", with: "%20"), "id" : "1234"]
        let parameters4 = ["title" : title_4.replacingOccurrences(of: " ", with: "%20"), "id" : "12345"]
        
        let searchableItem_1 = getSearchableItem(parameters1, title: title_1, description: description_1, keywords: [keywords_1])
        
        let searchableItem_2 = getSearchableItem(parameters2, title: title_2, description: description_2, keywords: [keywords_2])
        
        let searchableItem_3 = getSearchableItem(parameters3, title: title_3, description: description_3, keywords: [keywords_3])
        
        let searchableItem_4 = getSearchableItem(parameters4, title: title_4, description: description_4, keywords: [keywords_4])
        
        //Item Added in Search List
        searchableItems.append(searchableItem_1)
        searchableItems.append(searchableItem_2)
        searchableItems.append(searchableItem_3)
        searchableItems.append(searchableItem_4)
        
        CSSearchableIndex.default().indexSearchableItems(searchableItems) { (error) -> Void in
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            }
        }
    }
    
    // Create and return CSSearchableItem from given parameters.
    func getSearchableItem(_ parameters : [String:String] = [:], title: String, description: String, keywords : [String]) -> CSSearchableItem {
        
        let searchableItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        
        searchableItemAttributeSet.title = title
        searchableItemAttributeSet.contentDescription = description
        searchableItemAttributeSet.keywords = keywords
        
        var queryString = "?search=Spotlight"
        
        // set parameters as querystring parameters
        parameters.forEach { (key,value) in
            queryString += "&\(key)=\(value)"
        }
    
        print("queryString:-\(queryString)")
        
        let searchableItem = CSSearchableItem(uniqueIdentifier: queryString, domainIdentifier:"Spotlight", attributeSet: searchableItemAttributeSet)
        
        return searchableItem
    }
    
    // Handle spotlight item.
    func spotlightItemTapAction(_ activity: NSUserActivity){
        
        if activity.activityType == CSSearchableItemActionType {
            if let userInfo = activity.userInfo {
                let selectedItem = userInfo[CSSearchableItemActivityIdentifier] as! String
            
                // Read data from selected activity info that was set to related item, and save into dictionary.
                var valueDict = Dictionary<String,String>()
                
                if let components = URLComponents(string: selectedItem), let queryItems = components.queryItems {
                    
                    print("components:-\(components)")
                    print("queryItems:-\(queryItems)")
                    
                    for item in queryItems {
                        valueDict[item.name] = item.value
                    }
                }
    
                print("Selected Item Parameters: \(valueDict)")
                
                //Goto Details ViewController
                self.tableViewDetails(printer:valueDict)
            }
        }
    }
    
    // method to run when table view cell is tapped
    func tableViewDetails(printer:Dictionary<String,String>) {
      
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController = UIApplication.shared.keyWindow?.rootViewController?.children[0]
        
        let detailsViewController: DetailsViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailsViewController.titleString = printer["title"] as! String
        detailsViewController.subtitleString = printer["id"] as! String
        viewController?.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

