//
//  IntroViewController.swift
//  Health_Food
//
//  Created by kimsung jun on 2016. 4. 29..
//  Copyright © 2016년 kimsung jun. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table_View: UITableView!
    
    var myArray = NSMutableArray()
    var myArray2 = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myArray.addObject("section_1")
        myArray.addObject("section_2")
        myArray.addObject("section_3")
        
        for _ in 0...myArray.count{
            
            myArray2.addObject("0")
        }
        
        table_View.delegate = self;
        table_View.dataSource = self;
        
        
        
        print(table_View.frame.size.height)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let btnA = UIButton(type: UIButtonType.Custom) as UIButton
        btnA.frame = CGRectMake(0, 20, tableView.frame.size.width, tableView.frame.size.height-20)
        btnA.tag = section
        switch section {
        case 0:
//            btnA.backgroundColor = UIColor.purpleColor()
//            btnA.titleLabel?.text = "첫 번째 섹션"
            btnA.setImage(UIImage(named: "영양도란방.png"), forState: UIControlState.Normal)
            
        case 1:
//            btnA.backgroundColor = UIColor.greenColor()
//            btnA.titleLabel?.text = "두 번째 섹션"
            btnA.setImage(UIImage(named: "건강도란방.png"), forState: UIControlState.Normal)
        default:
//            btnA.backgroundColor = UIColor.blueColor()
//            btnA.titleLabel?.text = "세 번째 섹션"
            btnA.setImage(UIImage(named: "운동도란방.png"), forState: UIControlState.Normal)
        }
        
        btnA.addTarget(self, action: #selector(IntroViewController.buttonAction1(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        return btnA
        
    }
 
 
    func buttonAction1(sender:UIButton!)
    {
        let aKey = myArray2.objectAtIndex(sender.tag)
        
        if(aKey.isEqual("0")){
            myArray2.replaceObjectAtIndex(sender.tag, withObject: "1")
            table_View.reloadSections(NSIndexSet(index:sender.tag), withRowAnimation: UITableViewRowAnimation(rawValue: 7)!)
        }else{
            
            print(NSIndexPath(index: sender.tag))
            myArray2.replaceObjectAtIndex(sender.tag, withObject: "0")
            table_View.reloadSections(NSIndexSet(index:sender.tag), withRowAnimation: UITableViewRowAnimation(rawValue: 7)!)
//            self.table_View.scrollToRowAtIndexPath(NSIndexPath(), atScrollPosition: UITableViewScrollPosition(rawValue: 3)!, animated: true)
        }
    }
    
    func tableViewScrollToBottom(animated: Bool) {
        
        let delay = 0.1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            
            let numberOfSections = self.table_View.numberOfSections
            let numberOfRows = self.table_View.numberOfRowsInSection(numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
                self.table_View.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: animated)
            }
            
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if(myArray2.objectAtIndex(section).isEqual("0")){
        
        return 0
        }else{
            if(section == 0){
                return 6
            }else if(section == 1){
                return 4
            }else{
                return 6
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return table_View.frame.size.height/3-10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section != 2){
            return 60.0
        }else{
            return 90.0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.font = UIFont.boldSystemFontOfSize(22.0)
        if(indexPath.section == 0){
            cell.textLabel?.numberOfLines = 1;
            
            if(indexPath.row == 0){
                cell.textLabel?.text = String(format: " 🍚 쌀 이야기")
                
                
            }else if(indexPath.row == 1){
                cell.textLabel?.text = String(format: " 🍄 버섯 이야기")
                
            }else if(indexPath.row == 2){
                cell.textLabel?.text = String(format: " 🍇 포도 이야기")
                
            }else if(indexPath.row == 3){
                cell.textLabel?.text = String(format: " 🐟 멸치 이야기")
                
            }else if(indexPath.row == 4){
                cell.textLabel?.text = String(format: " 🧀 치즈 이야기")
                
            }else if(indexPath.row == 5){
                cell.textLabel?.text = String(format: " ♦️ 아몬드 이야기")
                
            }
        }else if(indexPath.section == 1){
            cell.textLabel?.numberOfLines = 1;
            if(indexPath.row == 0){
                cell.textLabel?.text = String(format: " 😋 영양만점 건강식단")
                
            }else if(indexPath.row == 1){
                cell.textLabel?.text = String(format: " 😌 저염 건강식단")
                
            }else if(indexPath.row == 2){
                cell.textLabel?.text = String(format: " 🤑 채식 건강식단")
                
            }else if(indexPath.row == 3){
                cell.textLabel?.text = String(format: " ☺️ 전통음식 건강식단")
                
            }
        }else if(indexPath.section == 2){
            cell.textLabel?.numberOfLines = 2;
            if(indexPath.row == 0){
                cell.textLabel?.text = String(format: " 🚶🏻 걷기 - 30분 \n 80Kcal = 귤 1개")
                
            }else if(indexPath.row == 1){
                cell.textLabel?.text = String(format: " 🏃🏻 달리기 - 30분 \n 150Kcal = 아이스키림콘 1개")
                
            }else if(indexPath.row == 2){
                cell.textLabel?.text = String(format: " 🚴🏼 자전거 - 30분 \n 170Kcal = 초코우유(200ml) 1개")
                
            }else if(indexPath.row == 3){
                cell.textLabel?.text = String(format: " ⛰ 등산 - 30분 \n 180Kcal = 치킨 1조각")
                
            }else if(indexPath.row == 4){
                cell.textLabel?.text = String(format: " 🏊🏼 수영 - 30분 \n 200Kcal = 단팥빵 1개")
                
            }else if(indexPath.row == 5){
                cell.textLabel?.text = String(format: " 🕴줄넘기 - 30분 \n 220Kcal = 피자 1조각")
                
            }
        }
        
        
        return cell
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
 // 스토리보드 Identifier를 가져와 화면 전환하기
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section != 2){
            
            if(indexPath.section == 0){
                
                let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                delegate.row_num = indexPath.row
                
                let story = UIStoryboard(name: "Main", bundle: nil)
                
                var f_story = UIViewController()
                f_story = story.instantiateViewControllerWithIdentifier("FoodStory")
                
                self.navigationController?.pushViewController(f_story, animated: true)
                
            }else if(indexPath.section == 1){
                
                let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                delegate.row_num = indexPath.row
            
                let story = UIStoryboard(name: "Main", bundle: nil)
                
                var f_menu = UIViewController()
                f_menu = story.instantiateViewControllerWithIdentifier("FoodMenu")
                
                self.navigationController?.pushViewController(f_menu, animated: true)
                
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
