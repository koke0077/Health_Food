//
//  FoodMenu.swift
//  Health_Food
//
//  Created by kimsung jun on 2016. 5. 9..
//  Copyright © 2016년 kimsung jun. All rights reserved.
//

import UIKit

class FoodMenu: UIViewController {
    
    let food_txtV = UITextView()
    let lbl = UILabel()
    
    var num:Int? = nil

    @IBOutlet weak var foodMenuName: UILabel!
    @IBOutlet weak var table_img: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        num = delegate.row_num
        
        if(delegate.row_num == 0){
            foodMenuName.text = "영양만점 건강식단"
            food_txtV.text = "오곡밥 \n 돼지고기김치찌개 \n 고등어구어 \n 과일샐러드 \n 파래김자반 \n 배추김치"
        }else if(delegate.row_num == 1){
            foodMenuName.text = "저염 건강식단"
            food_txtV.text = "삼곡밥 \n 콩나물맑은국 \n 저염갈치구이 \n 치커리사과무침 \n 저염김구이 \n 배추김치"
        }else if(delegate.row_num == 2){
            foodMenuName.text = "채식 건강식단"
            food_txtV.text = "곤드레나물밥 \n 도토리묵채국 \n 매콤두부스테이크 \n 브로콜리참깨무침 \n 단호박식혜 \n 배추김치"
        }else if(delegate.row_num == 3){
            foodMenuName.text = "전통음식 건강식단"
            food_txtV.text = "수수밥 \n 아욱토장국 \n 콩나물무침 \n 삼치구이 \n 연근조림 \n 총각김치"
        }
        
        food_txtV.frame = CGRectMake(table_img.frame.size.width/8, table_img.frame.origin.y+table_img.frame.size.height/4, table_img.frame.size.width/2, table_img.frame.size.height/2)
        
//        food_txtV.center = table_img.center
//        food_txtV.text = ""
        food_txtV.font = UIFont.boldSystemFontOfSize(35)
        food_txtV.backgroundColor = UIColor.clearColor()
        food_txtV.textAlignment = NSTextAlignment.Center
        
        self.view.addSubview(food_txtV)
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back_action(sender: UIButton) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func select_eating(sender: UISegmentedControl) {
        
        if(num == 0){
            if(sender.selectedSegmentIndex == 0){
                food_txtV.text = "오곡밥 \n 돼지고기김치찌개 \n 고등어구어 \n 과일샐러드 \n 파래김자반 \n 배추김치"
            }else if(sender.selectedSegmentIndex == 1){
                food_txtV.text = "전복영양밥 \n 모듬견과류조림 \n 두부톳나물 \n 사과오이초무침 \n 요쿠르트 \n 총각김치"
            }else if(sender.selectedSegmentIndex == 2){
                food_txtV.text = "통밀쌀밥 \n 해물순두부찌개 \n 연근쇠고기말이 \n 도라지강정 \n 오곡파이 \n 배추김치"
            }
            
        }else if(num == 1){
            if(sender.selectedSegmentIndex == 0){
                food_txtV.text = "삼곡밥 \n 콩나물맑은국 \n 저염갈치구이 \n 치커리사과무침 \n 저염김구이 \n 배추김치"
            }else if(sender.selectedSegmentIndex == 1){
                food_txtV.text = "쌀밥 \n 만두국 \n 메추리알장조림 \n 야채튀김 \n 시금치곤약무침 \n 열무김치"
            }else if(sender.selectedSegmentIndex == 2){
                food_txtV.text = "율무밥 \n 설렁탕 \n 저염멸치견과류조림 \n 부추양파무침 \n 송편 \n 배추겉절이"
            }
            
        }else if(num == 2){
            if(sender.selectedSegmentIndex == 0){
                food_txtV.text = "곤드레나물밥 \n 도토리묵채국 \n 매콤두부스테이크 \n 브로콜리참깨무침 \n 단호박식혜 \n 배추김치"
            }else if(sender.selectedSegmentIndex == 1){
                food_txtV.text = "채소볶음밥 \n 버섯장국 \n 연근호두조림 \n 미역국수야채무침 \n 과일꼬지 \n 깍두기"
            }else if(sender.selectedSegmentIndex == 2){
                food_txtV.text = "해초비빔밥 \n 호박잎된장국 \n 유부당면잡채 \n 버섯초무침 \n 복분자샐러드 \n 배추김치"
            }
            
        }else if(num == 3){
            if(sender.selectedSegmentIndex == 0){
                food_txtV.text = "수수밥 \n 아욱토장국 \n 콩나물무침 \n 삼치구이 \n 연근조림 \n 총각김치"
            }else if(sender.selectedSegmentIndex == 1){
                food_txtV.text = "보리밥 \n 쇠고기미역국 \n 들깨호박나물 \n 야채달걀찜 \n 모둠야채장아찌 \n 배추김치"
            }else if(sender.selectedSegmentIndex == 2){
                food_txtV.text = "검은콩밥 \n 해물된장찌개 \n 고구마줄기나물 \n 돼지불고기 \n 오이소박이 \n 배추김치"
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
