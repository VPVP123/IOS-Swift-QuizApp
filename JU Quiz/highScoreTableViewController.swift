//
//  highScoreTableViewController.swift
//  JU Quiz
//
//  Created by Victor Svanqvist on 2020-12-07.
//

import UIKit
import CoreData

class highScoreTableViewController: UITableViewController {

    var fetchedResultsController: NSFetchedResultsController<GameResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "highScoreIndentifier")
        setupFetchedResultsController()
    }

    // MARK: - Table view data source

    
    private func setupFetchedResultsController() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<GameResult>(entityName: "GameResult")
        let dateSort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [dateSort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
        }catch{
            fatalError("failed to initzilaied fetchedResultsController")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreIndentifier", for: indexPath)

        let gameResult = fetchedResultsController.object(at: indexPath)
        let fortmatter = DateFormatter()
        fortmatter.dateStyle = .short
        
        cell.textLabel?.text = "\(fortmatter.string(from: gameResult.date!)): \(gameResult.rightAnswers)/\(gameResult.numberOfQuestions) Difficulty:() \(String(gameResult.difficulty ?? "easy"))"

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
