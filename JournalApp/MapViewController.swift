//
//  MapViewController.swift
//  JournalApp
//
//  Created by Patrick Gao on 2/09/2015.
//  Copyright (c) 2015 Patrick Gao. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class MapViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var entries = [Entry]()
    var selectedEntry:Entry?

    
    // todo
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Load data from Core data
        
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 360))
        let entryEntityDescription = NSEntityDescription.entityForName("Entry",inManagedObjectContext:managedObjectContext!)
        let request = NSFetchRequest()
        request.entity = entryEntityDescription
        var error:NSError?
        
        var objects: [AnyObject]?
        do {
            objects = try managedObjectContext?.executeFetchRequest(request)
        } catch let error1 as NSError {
            error = error1
            objects = nil
        }
        entries = objects as![Entry]
        
        // Initialize Map View
        mapView.delegate = self
        
        for entry in entries {
            let annotation = CustomAnnotation(entry: entry)
            annotation.coordinate = CLLocationCoordinate2D(latitude: entry.latitude as! Double, longitude: entry.longtitude as! Double)
            mapView.addAnnotation(annotation)
            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView! {
        let annotationView = MKPinAnnotationView(annotation: annotation,reuseIdentifier: nil)
            annotationView.animatesDrop = true
            annotationView.canShowCallout = true
        
        let button:UIButton = UIButton(type: UIButtonType.DetailDisclosure)
        
        button.addTarget(self, action: Selector("buttonOnTap"), forControlEvents: UIControlEvents.TouchUpInside)
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = button
        return annotationView
    }
    
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
          print("selected annotation view");
        
        selectedEntry = (view.annotation as! CustomAnnotation).entry
        
        self.performSegueWithIdentifier("mapToJournalSegue", sender:self)
    }
    
    
    func buttonOnTap () {
        
        // todo remove
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destinationController = segue.destinationViewController as! JournalDetailTableViewController
        destinationController.entry = selectedEntry
        
        // pass entry
        
    }

}
