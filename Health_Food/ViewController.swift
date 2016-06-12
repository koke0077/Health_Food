//
//  ViewController.swift
//  Health_Food
//
//  Created by kimsung jun on 2016. 4. 29..
//  Copyright © 2016년 kimsung jun. All rights reserved.
//




import UIKit


class ViewController: UIViewController {
    
//    let healthStore = HKHealthStore()
   
   let healthStore = HealthAuth2()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        healthStore.health_Authinit()
        
//        self.navigationController?.hidesBarsOnTap = true
        self.navigationController?.navigationBarHidden = true
        
        let school_data : School_Data_Manager = School_Data_Manager()
        
        print(school_data.loadData())
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.locationInView(self.view)
            let nav = UINavigationController()
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

