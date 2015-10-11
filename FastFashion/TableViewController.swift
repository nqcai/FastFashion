//
//  TableViewController.swift
//  FastFashion
//
//  Created by Nicholas Cai on 10/10/15.
//  Copyright © 2015 Nicholas Cai. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    // MARK: Properties
    
    var meals = [Meal]()
    
//    var imageSize = CGSize(width: 90, height: 90)

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleMeals()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func getOptimalImageSize(image: UIImage) -> CGSize {
        let x = image.size.width
        let y = image.size.height
        let minDimension = min(x, y)
        return CGSize(width: minDimension, height: minDimension)
    }
    
    func loadSampleMeals() {
        var photo1 = UIImage(named: "salsa")!
        photo1 = RBSquareImageTo(photo1, size: getOptimalImageSize(photo1))
        let meal1 = Meal(name: "Salsa", photo: photo1, rating: 4, recipe: ["Add salsa"])!
        
        var photo2 = UIImage(named: "coffee")!
        photo2 = RBSquareImageTo(photo2, size: getOptimalImageSize(photo2))
        let meal2 = Meal(name: "Iced Coffee", photo: photo2, rating: 2, recipe: ["Put some caffeine"])!
        
        var photo3 = UIImage(named: "baconpopper")!
        photo3 = RBSquareImageTo(photo3, size: getOptimalImageSize(photo3))
        let meal3 = Meal(name: "Bacon Wrapped Jalepeno Poppers", photo: photo3, rating: 1, recipe: ["Wrap with bacon"])!
        
        meals += [meal1, meal2, meal3]
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func DoneButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "RecipeTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RecipeTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text         =   meal.name
        cell.photoImageView.image   =   meal.photo
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
