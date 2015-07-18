//
//  DetailViewController.swift
//  College Profile Builder
//
//  Created by Jack Cable on 7/6/15.
//  Copyright © 2015 Jack Cable. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var collegeTextField: UITextField!
    
    @IBOutlet var locationTextField: UITextField!
    
    @IBOutlet var enrollmentTextField: UITextField!
    
    @IBOutlet var websiteTextField: UITextField!
    
    @IBOutlet var imageView: UIImageView!
    
    var imagePicker : UIImagePickerController!
    
    var college : College!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collegeTextField.text = college.name
        locationTextField.text = college.location
        enrollmentTextField.text = String(college.enrollment)
        imageView.image = college.image
        websiteTextField.text = college.website
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }
    
    @IBAction func onTappedSaveButton(sender: AnyObject) {
        college.name = collegeTextField.text!
        college.location = locationTextField.text!
        college.enrollment = Int(enrollmentTextField.text!)!
        college.website = websiteTextField.text!
    }
    
    @IBAction func onOpenWebsiteButtonTapped(sender: AnyObject) {
        
        if let url = NSURL(string: college.website) {
            UIApplication.sharedApplication().openURL(url)

        }
        
    }
    
    @IBAction func cameraButtonTapped(sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker.sourceType = .Camera
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true) { () -> Void in
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.imageView.image = image
                self.college.image = image
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(sender?.tag == 1) {
            let mapViewController = segue.destinationViewController as! MapViewController
            mapViewController.location = college.location
        }
        
    }
    
    

}
