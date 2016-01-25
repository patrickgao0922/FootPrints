//
//  AddEntryViewController.swift
//  JournalApp
//
//  Created by Patrick Gao on 28/08/2015.
//  Copyright (c) 2015 Patrick Gao. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

protocol SaveEntryDelegate {
    func saveEntry()
}


class AddEntryViewController: UIViewController, UIImagePickerControllerDelegate,CLLocationManagerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    let managedObjectContext =
    (UIApplication.sharedApplication().delegate
        as! AppDelegate).managedObjectContext
    
    var images = [UIImage]()
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate: SaveEntryDelegate?
    
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var titleInput: UITextField!
    
    
    @IBOutlet weak var bodyInput: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate=self
        collectionView.dataSource=self
        
        titleInput.delegate = self
        bodyInput.delegate = self
        // Do any additional setup after loading the view.
        
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //Use the dequeueReusableCellWithReuseIdentifier:forIndexPath: to get a cell for an item in the collection view
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as? ImageCollectionViewCell {
            cell.imageView.image = images[indexPath.row]
            return cell
        } else {
            return UICollectionViewCell()
        }
        
        // Configure the cell
        
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(105, 105)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        <#code#>
//    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @IBAction func saveEntry(sender: AnyObject) {
        // Create entity using Core Date
        var error: NSError?
        let entityDescription = NSEntityDescription.entityForName("Entry",
            inManagedObjectContext: managedObjectContext!)
        
        let entry = Entry(entity: entityDescription!,
            insertIntoManagedObjectContext: managedObjectContext)
        entry.title = titleInput.text!
        entry.body = bodyInput.text
        let currentDate = NSDate()
        entry.date = currentDate

        //Request Location and set coordinates
        
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.Restricted || CLLocationManager.authorizationStatus() != CLAuthorizationStatus.Denied) {
            if locationManager.location != nil {
                entry.latitude = locationManager.location!.coordinate.latitude
                entry.longtitude = locationManager.location!.coordinate.longitude
            }
            else {
                entry.latitude = 0
                entry.longtitude = 0
            }
        }
        
        //set images
        let fileManager = NSFileManager.defaultManager()
        let docDir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)
        print(docDir)
        let pictureEntityDescription = NSEntityDescription.entityForName("Picture",
            inManagedObjectContext: managedObjectContext!)
        let journalDir = "\(entry.objectID)"
        
        var picturesArray = [Picture]()
        if images.count != 0 {
            for index in 0...(images.count-1) {
                do {
                    try fileManager.createDirectoryAtPath("\(docDir[0])/images/\(journalDir)", withIntermediateDirectories: true, attributes: nil)
                } catch let error1 as NSError {
                    error = error1
                }
                fileManager.createFileAtPath("\(docDir[0])/images/\(journalDir)/\(index).png", contents: UIImagePNGRepresentation(images[index]), attributes: nil)
                let picture = Picture(entity: pictureEntityDescription!,
                    insertIntoManagedObjectContext: managedObjectContext)
                picture.name = "\(index).png"
                picture.path = "\(docDir[0])/images/\(journalDir)"
                picturesArray.append(picture)
            }
        }

        entry.pictures = NSSet(array: picturesArray)
        
        managedObjectContext?.insertObject(entry)
        
        do {
            try managedObjectContext?.save()
        } catch let error1 as NSError {
            error = error1
        }
        delegate?.saveEntry()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func addImages(sender: AnyObject) {
        
        let controller = UIImagePickerController()
        let sourceSelectionAlert = UIAlertController(title:"Please select",message:"Add picture from camera or photo library",preferredStyle:
            UIAlertControllerStyle.Alert)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler:
            { (action:UIAlertAction) in
                
                if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
                {
                    controller.sourceType = UIImagePickerControllerSourceType.Camera
                }
                controller.allowsEditing = false
                controller.delegate = self
                self.presentViewController(controller, animated: true, completion: nil)
                
        })
        let libraryAction = UIAlertAction(title:"Photo Library", style: UIAlertActionStyle.Default, handler:
            {
                (action:UIAlertAction) in
                if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)) {
                    controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                }
                controller.allowsEditing = false
                controller.delegate = self
                self.presentViewController(controller, animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title:"Cancel", style:UIAlertActionStyle.Cancel,handler:nil)
        
        sourceSelectionAlert.addAction(cameraAction)
        sourceSelectionAlert.addAction(libraryAction)
        sourceSelectionAlert.addAction(cancelAction)
        
        self.presentViewController(sourceSelectionAlert, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        images.append(image)
        collectionView.reloadData()
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "imageCollectionSegue" {
//            let destController = segue.destinationViewController as! PictureCollectionViewController
//            destController.images = self.images
//            destController.delegate = self
//
//        }
//    }
    
    /**
    * Called when 'return' key pressed. return NO to ignore.
    */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /**
    * Called when the user click on the view (outside the UITextField).
    */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        titleInput.resignFirstResponder()
        bodyInput.resignFirstResponder()
        self.view.endEditing(true)
    }


}
