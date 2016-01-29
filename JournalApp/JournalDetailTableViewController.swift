//
//  JournalDetailTableViewController.swift
//  JournalApp
//
//  Created by Patrick Gao on 31/08/2015.
//  Copyright (c) 2015 Patrick Gao. All rights reserved.
//

import UIKit
import MapKit

class JournalDetailTableViewController: UITableViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    var entry:Entry?
    var images:[UIImage] = [UIImage]()

    @IBOutlet weak var journalTitle: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        journalTitle.title = entry?.title
        
        
        print(images.count, terminator: "")
        
        // load picture
        let fileManager = NSFileManager.defaultManager()
        
        
        
        
         var picturesArray:[Picture] = entry?.pictures!.allObjects as! [Picture]
        if picturesArray.count != 0 {
        
            for index in 0 ... (picturesArray.count-1) {
                let picture = picturesArray[index]
                var fileData:NSData = NSData()
                if let file: NSFileHandle = NSFileHandle(forReadingAtPath:"\(picture.path)/\(picture.name)")
                {
                    print("\(picture.path)/\(picture.name)")
                    fileData = file.readDataToEndOfFile()
                    file.closeFile()

                    let image = UIImage(data:fileData)!
                    images.append(image)
                } else {
                    print("File open failed")
                }

            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return images.count
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Journal Body"
        } else if section == 1 {
            return "Location"
        } else {
            return "Pictures"
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        } else if indexPath.section == 1 {
            return 200
        } else {
            return 230
            
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("journalBodyCell", forIndexPath: indexPath) as! JournalBodyTableViewCell
            cell.journalBody.text = entry!.body
            return cell
            }else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier("journalMapCell", forIndexPath: indexPath) as! JournalMapTableViewCell
            cell.journalMap.delegate = self
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: entry!.latitude as! Double, longitude: entry!.longtitude as! Double)
            annotation.title = "Hello"
            annotation.subtitle = "World!"
            cell.journalMap.addAnnotation(annotation)
            cell.journalMap.centerCoordinate = annotation.coordinate
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("journalImageCell", forIndexPath: indexPath) as! JournalImageTableViewCell
            cell.journalImage.image = images[indexPath.row]
            return cell
        }
        
    }
    
    

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
