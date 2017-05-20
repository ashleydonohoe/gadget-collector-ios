//
//  GadgetsViewController.swift
//  GadgetCollector
//
//  Created by Ashley Donohoe on 5/20/17.
//  Copyright © 2017 Ashley Donohoe. All rights reserved.
//

import UIKit

class GadgetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var gadgets: [Gadget] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Get stuff from core data
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            gadgets = try context.fetch(Gadget.fetchRequest())
            tableView.reloadData()
        } catch {
            print("Could not fetch gadgets")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gadgets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gadget = gadgets[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = gadget.title
        cell.imageView?.image = UIImage(data: gadget.image as! Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gadget = gadgets[indexPath.row]
        performSegue(withIdentifier: "showGadget", sender: gadget)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! AddGadgetViewController
        nextVC.gadget = sender as? Gadget
    }
}
