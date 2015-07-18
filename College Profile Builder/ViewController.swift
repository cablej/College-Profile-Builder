//
//  ViewController.swift
//  College Profile Builder
//
//  Created by Jack Cable on 7/6/15.
//  Copyright © 2015 Jack Cable. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var editButton: UIBarButtonItem!
    
    var colleges : [College] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        editButton.tag = 0
        
        colleges.append(College(name: "Stanford", location: "Stanford", enrollment: 12000, website: "http://stanford.edu", image: UIImage(named: "default")!))
        
        colleges.append(College(name: "MIT", location: "Boston", enrollment: 15000, website: "http://mit.edu", image: UIImage(named: "MIT")!))
        
        colleges.append(College(name: "Harvard", location: "Boston", enrollment: 10000, website: "http://harvard.edu", image: UIImage(named: "Harvard")!))
        
    }
    
    @IBAction func onTappedPlusButton(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add College", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Add college"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.Default) { (action) -> Void in
            
            let collegeTextField = alert.textFields![0] as UITextField
            self.colleges.append(College(name: collegeTextField.text!))
            self.tableView.reloadData() }
        
        alert.addAction(addAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func onTappedEditButton(sender: UIBarButtonItem) {
        if(sender.tag == 0) {
            tableView.editing = true
            sender.tag = 1
        } else {
            tableView.editing = false
            sender.tag = 0
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colleges.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = colleges[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            colleges.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let college = colleges[sourceIndexPath.row]
        colleges.removeAtIndex(sourceIndexPath.row)
        colleges.insert(college, atIndex: destinationIndexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dvc = segue.destinationViewController as! DetailViewController
        let index = tableView.indexPathForSelectedRow?.row
        dvc.college = colleges[index!]
    }

}

