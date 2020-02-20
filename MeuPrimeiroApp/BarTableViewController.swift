//
//  BarTableViewController.swift
//  MeuPrimeiroApp
//
//  Created by Jonathan on 05/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import os.log

class BarTableViewController: UITableViewController {
    //MARK: Properties
    var Bars = [Bar]()
    
    
    private func loadSampleBars() {
      
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved meals, otherwise load sample data.
        if let savedBars = LoadBar() {
            Bars += savedBars
        }
        else {
            // Load the sample data.
            loadSampleBars()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Bars.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BarTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BarTableViewCell  else {
            fatalError("The dequeued cell is not an instance of BarTableViewCell.")
        }
        let bar = Bars[indexPath.row]

        cell.Name.text = bar.name
        cell.ImageView.image = bar.photo
        cell.RatingBar.rating = bar.rating
        return cell
    }
    
    @IBAction func unwindToBarList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ViewController, let bar = sourceViewController.bar {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                Bars[selectedIndexPath.row] = bar
             tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                // Add a new meal.
                let newIndexPath = IndexPath(row: Bars.count, section: 0)
                
                Bars.append(bar)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                
            }
            // Save the Bars.
            saveBars()
            // Aydd a new bar.
            let newIndexPath = IndexPath(row: Bars.count, section: 0)
            
            Bars.append(bar)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            Bars.remove(at: indexPath.row)
            saveBars()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    private func saveBars() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Bars, toFile: Bar.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Bars successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func LoadBar() -> [Bar]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Bar.ArchiveURL.path) as? [Bar]
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        // Adicionar
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let BarDetailViewController = segue.destination as? ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedBarCell = sender as? BarTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedBarCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = Bars[indexPath.row]
            BarDetailViewController.bar = selectedMeal
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }

}
