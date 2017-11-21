//
//  ViewController.swift
//  LineChartExample
//
//  Created by Osian on 13/07/2017.
//  Copyright © 2017 Osian. All rights reserved.
//

import UIKit
import Charts // You need this line to be able to use Charts Library

var numbers : [Double] = []
var costVal = Double()
var powerVal = Double()
var energyVal = Double()
class ViewController: UIViewController {
    
    @IBOutlet var myView: UIView!
    @IBOutlet var cost: UILabel!
    @IBOutlet var status: UISwitch!
    @IBOutlet var power: UILabel!
    @IBOutlet var energy: UILabel!
    @IBOutlet weak var chtChart: LineChartView!
    weak var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        status.isOn = currentSwitch.isOn

    }
    @IBAction func status(_ sender: UISwitch) {
        if sender.isOn{
            currentSwitch.isOn = true
        }
        else{
            currentSwitch.isOn = false
        }
        makePOSTCall(endpoint: "http://52.15.86.194/postIO/" + String(sender.isOn))

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func updateGraph(){
        
        var lineChartEntry  = [ChartDataEntry]() //this is the Array that will eventually be displayed on the graph.

        
        
        //here is the for loop
        for i in 0..<numbers.count {

            let value = ChartDataEntry(x: Double(i), y: numbers[i]) // here we set the X and Y status in a data chart entry

            lineChartEntry.append(value) // here we add it to the data set
        }

         let line1 = LineChartDataSet(values: lineChartEntry, label: "Power") //Here we convert lineChartEntry to a LineChartDataSet

        line1.colors = [NSUIColor.blue] //Sets the colour to blue


        let data = LineChartData() //This is the object that will be added to the chart

        data.addDataSet(line1) //Adds the line to the dataSet
        

        chtChart.data = data //finally - it adds the chart data to the chart and causes an update

        chtChart.chartDescription?.text = "SwitchE" // Here we set the description for the graph
        numbers = []

    }
    func makeGETcall(endpoint: String) {
        guard let url = URL(string: endpoint) else {
            print("Could not create URL.")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) {
            
            data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            // Convert server json response to NSDictionary
            do{
                if let parsedData = try JSONSerialization.jsonObject(with: data) as? [String:Any]{
                    print(parsedData)
                    if let p = parsedData["power"] as? Double{
                        powerVal = p
                        print(p)
                    }
                    if let e = parsedData["energy"] as? Double{
                        energyVal = e
                        print(e)
                    }
                    if let c = parsedData["cost"] as? Double{
                        costVal = c
                        print(c)
                    }
                    
                }
                if let parsedData = try JSONSerialization.jsonObject(with: data) as? [[String:Any]]{
                    print(parsedData)
                    for p in parsedData {
                        if let element = p["power"] as? Double{
                            numbers.append(element)
                        }
                    }
                }
            }catch let error as NSError {
                print(error)
            }
            
            //            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            //            print(responseJSON!)
            
        }
        task.resume()
    }
    
    func makePOSTCall(endpoint: String) {
        guard let url = URL(string: endpoint) else {
            print("Could not create URL.")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) {
            
            data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
            
        }
        task.resume()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startTimer()

//        myView.reloadInputViews()
    
    }
    func startTimer() {
        timer?.invalidate()   // just in case you had existing `Timer`, `invalidate` it before we lose our reference to it
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            print("hiii")
            self?.makeGETcall(endpoint: "http://52.15.86.194/getLastPower")
            self?.makeGETcall(endpoint: "http://52.15.86.194/getEnergyLastHour")
            self?.makeGETcall(endpoint: "http://52.15.86.194/getCostLastHour")
            self?.makeGETcall(endpoint: "http://52.15.86.194/getPowerHistory")
            self?.cost.text = "\(costVal)"
            self?.power.text = "\(powerVal)"
            self?.energy.text = "\(energyVal)"
            self?.updateGraph()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }



}


