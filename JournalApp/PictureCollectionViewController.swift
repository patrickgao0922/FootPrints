//
//  PictureCollectionViewController.swift
//  JournalApp
//
//  Created by Patrick Gao on 28/08/2015.
//  Copyright (c) 2015 Patrick Gao. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class PictureCollectionViewController: UICollectionViewController{

    var images:[UIImage] = [UIImage]()
    
//    @IBAction func addPictureAction(sender: AnyObject) {
//        let controller = UIImagePickerController()
//        let sourceSelectionAlert = UIAlertController(title:"Please select",message:"Add picture from camera or photo library",preferredStyle:
//            UIAlertControllerStyle.Alert)
//        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler:
//            { (action:UIAlertAction) in
//                
//                if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
//                {
//                    controller.sourceType = UIImagePickerControllerSourceType.Camera
//                }
//                controller.allowsEditing = false
//                controller.delegate = self
//                self.presentViewController(controller, animated: true, completion: nil)
//                
//        })
//        let libraryAction = UIAlertAction(title:"Photo Library", style: UIAlertActionStyle.Default, handler:
//            {
//                (action:UIAlertAction) in
//                if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)) {
//                    controller.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//                }
//                controller.allowsEditing = false
//                controller.delegate = self
//                self.presentViewController(controller, animated: true, completion: nil)
//        })
//        let cancelAction = UIAlertAction(title:"Cancel", style:UIAlertActionStyle.Cancel,handler:nil)
//        
//        sourceSelectionAlert.addAction(cameraAction)
//        sourceSelectionAlert.addAction(libraryAction)
//        sourceSelectionAlert.addAction(cancelAction)
//        
//        self.presentViewController(sourceSelectionAlert, animated: true, completion: nil)
//        
//        
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        
        
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: UICollectionViewDataSource
    // numberOfSectionsInCollectionView function is used to specify how many sections displaied in collection view
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    // The next method is called by the collection view to identify the number of items that are to be displayed in each section.
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return images.count
    }
    
    // The cellForItemAtIndexPath method will be called by the collection view in order to obtain cells configured based on the indexPath value passed to the method. This method will request a cell object from the reuse queue and then set the image on the Image View object which was configured in the cell prototype earlier in this chapter, using the index path row as the index into the carImages array
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //Use the dequeueReusableCellWithReuseIdentifier:forIndexPath: to get a cell for an item in the collection view
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        
        // Configure the cell
        
        cell.imageView.image = images[indexPath.row]
        return cell
    }
    
    

    
    // MARK: UICollectionViewDelegate
    
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    }
    */
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
    return false
    }
    
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    


}
