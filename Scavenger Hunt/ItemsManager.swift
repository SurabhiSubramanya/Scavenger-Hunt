//
//  ItemsManager.swift
//  Scavenger Hunt
//
//  Created by Surabhi Subramanya on 11/14/15.
//  Copyright © 2015 Apple. All rights reserved.
//

import UIKit

class ItemsManager {
    var itemsList = [ScavengerHuntItem]()
    
    //archive path to save file
    func archivePath() -> String? {
        let directoryList = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        if let documentDirectory = directoryList.first {
            return documentDirectory + "/ScavengerHuntItem"
        }
        
        //handle assertion failure
        assertionFailure("Could not determine where to save the file")
        return nil
    }
    
    //We need somewhere to save
    func save() {
        if let theArchivePath = archivePath() {
            if NSKeyedArchiver.archiveRootObject(itemsList, toFile: theArchivePath) {
                print("Saved Successfully!")
            } else {
                assertionFailure("Could not save to \(theArchivePath)")
            
            }
        }
    }

func unarchiveSavedItems() {
    if let theArchivePath = archivePath() {
        if NSFileManager.defaultManager().fileExistsAtPath(theArchivePath) {
            itemsList = NSKeyedUnarchiver.unarchiveObjectWithFile(theArchivePath) as! [ScavengerHuntItem]
        }
    }
}

init() {
    unarchiveSavedItems()
  }

}
