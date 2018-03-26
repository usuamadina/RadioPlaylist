//
//  GenresTableViewController.swift
//  radioPlaylists
//
//  Created by labdisca on 18/3/18.
//  Copyright © 2018 umadina. All rights reserved.
//

import UIKit

 var selectedCategory: String = ""

class GenresTableViewController: UITableViewController{
    
    var categoryNameList = Array<String>()
    var list:[GenderStruct] = [GenderStruct]()
   
    struct GenderStruct
    {
        var imgUrl = ""
        var genreName = ""
        
        init(imgUrl:String, genreName:String)
        {
            self.imgUrl = imgUrl
            self.genreName = genreName
        }
    }
    var genres = NSDictionary()

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
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
                       // print(jsonResult)
                        
                        if let categories = (jsonResult["categories"] as? NSDictionary)
                        {
                            DispatchQueue.main.sync(execute:{
                                
                                for (categoryName, categoryContent) in categories
                                {
                                    if categoryName is String
                                    {
                                        self.categoryNameList.append(categoryName as! String)
                                        
                                        if let content = categoryContent as? NSDictionary
                                        {
                                            
                                            self.list.append(GenderStruct(imgUrl: content["imageUrl"] as! String, genreName: content["name"] as! String))
                                            // print(content["imageUrl"] as! String)
                                            
                                        }
                                    }
                                    
                                    
                                }
                               //print(self.list.count)
                                print(self.categoryNameList.count)
                                self.tableView.reloadData()
                              
                            })
                           
                        }
                        
                       // if let sections =
                      
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell", for: indexPath) as! GenresTableViewCellController
        
        let url = URL(string:list[indexPath.row].imgUrl)!
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
                    if let imgGenre = UIImage(data: dataUnwrapped)
                    {
                        DispatchQueue.main.async {
                            cell.genreImg.image = imgGenre
                        }
                       
                    }
                    
                }
                
            }
        }
        task.resume()
        cell.lblTitle.text = list[indexPath.row].genreName
      
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = categoryNameList [indexPath.row]
        performSegue(withIdentifier: "segueToStations", sender: nil)
        
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            list.remove(at: indexPath.row)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
