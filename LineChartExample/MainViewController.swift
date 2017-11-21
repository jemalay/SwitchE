//
//  MainViewController.swift
//  LineChartExample
//
//  Created by Jemal Aytjanova on 11/19/17.
//  Copyright © 2017 Osian. All rights reserved.
//

import UIKit
var myIndex = 0
var currentSwitch = UISwitch()
class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var myTableView: UITableView!

    @IBOutlet var switchOutlet: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let lst = arr{
            return lst.count
        }
        else{
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        if let lst = arr{
            cell.textLabel?.text = lst[indexPath.row]
            cell.accessoryView = currentSwitch
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue", sender: self)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            arr?.remove(at: indexPath.row)
            myTableView.reloadData()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        myTableView.reloadData()
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
