//
//  DetailViewController.swift
//  radioPlaylists
//
//  Created by labdisca on 26/3/18.
//  Copyright © 2018 umadina. All rights reserved.
//

import UIKit
import AVKit

class DetailViewController: UIViewController {

    var player = AVPlayer()
    
    @IBOutlet weak var radioImg: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var volumenaSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do
        {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            print("AVAudioSession ready to play")
            do
            {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession active")
            }
            catch
            {
                
            }
            
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
       /* let url = URL(string:selectedStation.streamUrl)!
        
        do
        {
            try player = AVAudioPlayer(contentsOf: url)
        }
        
        selectedStation.imgUrl
        selectedStation.stationNamea*/
        
        
    }

    @IBAction func stopAction(_ sender: Any) {
    }
    
    @IBAction func playAction(_ sender: Any) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
