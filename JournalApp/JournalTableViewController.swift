//
//  ViewController.swift
//  JournalApp
//
//  Created by Patrick Gao on 28/08/2015.
//  Copyright (c) 2015 Patrick Gao. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData



class JournalTableViewController: UITableViewController, SaveEntryDelegate {
    
    var managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var entries = [Entry]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Load data from core data
        let entryEntityDescription = NSEntityDescription.entityForName("Entry",inManagedObjectContext:managedObjectContext!)
        
        // set sort descriptors
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        let sortDescriptors = [sortDescriptor]
        
        let request = NSFetchRequest()
        request.sortDescriptors = sortDescriptors
        
        
        request.entity = entryEntityDescription
        
        var error: NSError?
        
        var objects: [AnyObject]?
        do {
            try objects = managedObjectContext!.executeFetchRequest(request)
            
        } catch let error1 as NSError {
            error = error1
            objects = nil
        }
        entries = objects as! [Entry]
        print("\(entries.count) entries loaded", terminator: "")
        
        
        
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return entries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("!!", terminator: "")
        let cell = tableView.dequeueReusableCellWithIdentifier("entryCell", forIndexPath: indexPath) as! EntryTableViewCell
        let entry:Entry = entries[indexPath.row]
        cell.entryTitle.text = entry.title
        // load picture
        let fileManager = NSFileManager.defaultManager()
        
        
        
        
        var picturesArray  = entry.pictures!.allObjects as! [Picture]
        
        let picture = picturesArray[0]
        var fileData:NSData = NSData()
        if let file: NSFileHandle = NSFileHandle(forReadingAtPath:"\(picture.path!)/\(picture.name!)")
        {
            print("\(picture.path!)/\(picture.name!)")
            print(file)
            fileData = file.readDataToEndOfFile()
            file.closeFile()
            
            let image = UIImage(data:fileData)!
            cell.entryThumbnail.image = image
        } else {
            print("File open failed")
        }
        
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        cell.entryDate.text = dateFormatter.stringFromDate(entry.date!)
        
        
        return cell
        
    }
    
    // delete row function
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        var error:NSError?
        
        //delete images file
        for picture in entries[indexPath.row].pictures!.allObjects as! [Picture] {
            let fileManager = NSFileManager.defaultManager()
            do {
                try fileManager.removeItemAtPath("\(picture)/\(picture.name)")
            } catch let error1 as NSError {
                error = error1
            }
        }
        
        
        
        managedObjectContext!.deleteObject(entries[indexPath.row])
        do {
            try managedObjectContext?.save()
        } catch let error1 as NSError {
            error = error1
        }
        entries.removeAtIndex(indexPath.row)
        self.tableView.reloadData()
    }
    
    // 
    func saveEntry() {
        print("saveEntry")
        let entryEntityDescription = NSEntityDescription.entityForName("Entry",
            inManagedObjectContext: managedObjectContext!)
        let request = NSFetchRequest()
        
        // set sort descriptors
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        let sortDescriptors = [sortDescriptor]
        
        request.sortDescriptors = sortDescriptors
        
        request.entity = entryEntityDescription
        
        var error: NSError?
        
        var objects: [AnyObject]?
        do {
            objects = try managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            objects = nil
        }
        entries = objects as! [Entry]
        print("\(entries.count) entries loaded", terminator: "")

        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "AddEntrySegue" {
            
            let destinationController = segue.destinationViewController as! AddEntryViewController
            
            destinationController.delegate = self
            
            
        } else if segue.identifier == "journalDetailSegue" {
            let destinationController = segue.destinationViewController as! JournalDetailTableViewController
            let path = tableView.indexPathForSelectedRow!
            destinationController.entry = entries[path.row]
            
        }
        
    }

}

