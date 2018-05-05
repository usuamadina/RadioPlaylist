//
//  DetailViewController.swift
//  radioPlaylists
//
//  Created by labdisca on 26/3/18.
//  Copyright © 2018 umadina. All rights reserved.
//

import UIKit
import AVKit
import CoreData

class DetailViewController: UIViewController {

    var player = AVPlayer()
    
    @IBOutlet weak var radioImg: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var volumenaSlider: UISlider!
    
    
    @IBOutlet weak var radioNameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radioNameLbl.text = selectedStation.stationName
        downloadRadioStationImg()
        
        do
        {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            print("AVAudioSession ready to play!!")
            do
            {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession active")
            }
            catch let error as NSError
            {
                print(error.localizedDescription)
            }
            
        }
        catch let error as NSError
        {
           print(error.localizedDescription)
            
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
       /* let url = URL(string:selectedStation.streamUrl)!
        
        do
        {
            try player = AVAudioPlayer(contentsOf: url)
        }
        
        selectedStation.imgUrl
        selectedStation.stationNamea*/
        
        
    }

    
  
    
    @IBAction func playAction(_ sender: UIButton)
    {
        print(selectedStation.streamUrl)
        player = AVPlayer(url: URL(string: selectedStation.streamUrl)!)
        player.volume = 1.0
        print("reproduciendo")
        player.play()
        
    }
    
    @IBAction func pauseAction(_ sender: UIButton)
    {
        player.pause()
    }
    
    @IBAction func volumenChangedAction(_ sender: UISlider)
    {
        player.volume = sender.value
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadRadioStationImg()
    {
        let url = URL(string:selectedStation.imgUrl)!
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
                            self.radioImg.image = imgStation
                        }
                        
                    }
                    
                }
                
            }
        }
        task.resume()
    }
    
    
    @IBAction func addFavAction(_ sender: Any)
    {
        var stationSaved = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "RadioStations")
        request.returnsObjectsAsFaults = false
        
        
        do
        {
            let results = try context.fetch(request)
            for result in results as! [NSManagedObject]
            {
                if let stationName = result.value(forKey: "stationName") as? String
                {
                    if stationName == selectedStation.stationName
                    {
                        print("Station already add to favs")
                        stationSaved = true
                    }
                    
                }
            }
        }
        catch
        {
            print("Error fetching data")
        }
        
        
        if (!stationSaved)
        {
           
            // SAVE A STATION ON PERSISTANCE
            let radioStation = NSEntityDescription.insertNewObject(forEntityName: "RadioStations", into: context)
            radioStation.setValue(selectedStation.imgUrl, forKey: "imgUrl")
            radioStation.setValue(selectedStation.stationName, forKey: "stationName")
            radioStation.setValue(selectedStation.streamUrl, forKey: "streamUrl")
            
            do
            {
                try context.save()
                print("Radio station added to favs successfully")
            }
            catch
            {
                print("An error ocurred while saving the station")
            }
        }
        
        
    }
    
}
