//
//  RadioStationTableViewController.swift
//  radioPlaylists
//
//  Created by labdisca on 18/3/18.
//  Copyright © 2018 umadina. All rights reserved.
//

import UIKit

struct StationStruct
{
    var imgUrl = ""
    var stationName = ""
    var streamUrl = ""
    
    init(imgUrl:String, stationName:String, streamUrl:String)
    {
        self.imgUrl = imgUrl
        self.stationName = stationName
        self.streamUrl = streamUrl
    }
}

var selectedStation = StationStruct(imgUrl:"", stationName:"", streamUrl:"")

class RadioStationTableViewController: UITableViewController {
    
   
    
    var stationNameList = Array<String>()
    var stationList = [StationStruct]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let url = URL(string: "https://ia800505.us.archive.org/4/items/03.InternetRadioStationJson/03.InternetRadioStationJson.txt")!
        
        
        // let request = NSMutableURLRequest(url:url)
        
        let task = URLSession.shared.dataTask(with: url)
        {
            (data, response, error) in
            if error != nil
            {
                print(error as Any)
            }
            else{
                if let content = data
                {
                    do
                    {
                        let jsonResult = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                         //print(jsonResult)
                        
                        if let stations = jsonResult["stations"] as? NSDictionary
                        {
                          //  print (stations.count)
                            
                            DispatchQueue.main.sync(execute:{
                                
                                for (stationName, stationContent) in stations
                                {
                                    if stationName is String
                                    {
                                       
                                        if let content = stationContent as? NSDictionary
                                        {
                                            
                                            if content["category"] as! String == selectedCategory
                                            {
                                                self.stationNameList.append(stationName as! String)
                                                self.stationList.append(StationStruct(imgUrl: content["imageUrl"] as! String, stationName: content["name"] as! String, streamUrl: content["streamUrl"] as! String))
                                            }
                                        }
                                    }
                                    
                                }
                               // print(self.stationList.count)
                             //   print(self.stationNameList.count)
                                self.tableView.reloadData()
                                
                           })
                            
                        }
                        
                    }
                    catch
                    {
                        print("Error procesando el json")
                    }
                    
                }
                
            }
            
            
            
        }
        task.resume()
        
       
    }
   

    // MARK: - Table view data source
  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
         return stationList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "stationCell", for: indexPath) as! RadioStationTableViewCellController
        
        
        let url = URL(string:stationList[indexPath.row].imgUrl)!
        let request = NSMutableURLRequest(url:url)
        let task = URLSession.shared.dataTask(with: request as URLRequest)
        {
            data, response, error in
            if error != nil
            {
                print(error as Any)
            }
            else
            {
                if let dataUnwrapped = data
                {
                    if let imgStation = UIImage(data: dataUnwrapped)
                    {
                        DispatchQueue.main.async {
                            cell.img.image = imgStation
                        }
                        
                    }
                    
                }
                
            }
        }
        task.resume()
        cell.name.text = stationList[indexPath.row].stationName
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedStation.imgUrl = stationList[indexPath.row].imgUrl
        selectedStation.stationName = stationList[indexPath.row].stationName
        selectedStation.streamUrl = stationList[indexPath.row].streamUrl
        
        self.performSegue(withIdentifier: "segueToDetail", sender: self)
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
