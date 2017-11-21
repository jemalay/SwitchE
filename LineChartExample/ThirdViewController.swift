//
//  ThirdViewController.swift
//  LineChartExample
//
//  Created by Jemal Aytjanova on 11/19/17.
//  Copyright © 2017 Osian. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet var deviceName: UITextField!
    @IBOutlet var plugId: UITextField!
    @IBOutlet var category: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func submit(_ sender: UIButton) {
        if (deviceName.text != nil) && deviceName.text != ""{
            arr?.append(deviceName.text!)
            deviceName.text = ""
            plugId.text = ""
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
