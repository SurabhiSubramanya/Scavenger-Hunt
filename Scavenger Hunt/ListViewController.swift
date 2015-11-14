//
//  ListViewController.swift
//  Scavenger Hunt
//
//  Created by Surabhi Subramanya on 11/14/15.
//  Copyright © 2015 Apple. All rights reserved.
//

import Foundation
import UIKit //Implement UI

//class with superclass + declare to be that delegate...
class ListViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //Items manager
    let myManager = ItemsManager()
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            //use photo library if no camera - like in simulator
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil) //completion handler - call back in swift - we dont need to use here coz nothing to go back to
    }
    
    //Photo back once it's selected
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedItem = myManager.itemsList[indexPath.row]
            let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
            selectedItem.photo = photo
            myManager.save()
            dismissViewControllerAnimated(true, completion: { () -> Void in
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
                
        }
    }
    
    
    @IBAction func unWindToList(segue: UIStoryboardSegue) {
        if segue.identifier == "DoneItem" {
            let addVC = segue.sourceViewController as! AddViewController
            if let newItem = addVC.newItem  {
                myManager.itemsList += [newItem]
                //Call save - save often to make sure to not lose items due to unexpected errors like app crash, phone call etc
                myManager.save()
                let indexPath = NSIndexPath(forRow: myManager.itemsList.count - 1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myManager.itemsList.count

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell", forIndexPath: indexPath)
        
       let item = myManager.itemsList[indexPath.row]
        
       if (item.isCompleted) {
            cell.accessoryType = .Checkmark
            cell.imageView?.image = item.photo
       } else {
            cell.accessoryType = .None
            cell.imageView?.image = nil
        }
        
       cell.textLabel?.text = item.name
        
       return cell
        
    }
}
