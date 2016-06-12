//
//  FoodStory.swift
//  Health_Food
//
//  Created by kimsung jun on 2016. 6. 3..
//  Copyright © 2016년 kimsung jun. All rights reserved.
//

import UIKit

class FoodStory: UIViewController {
    
    @IBOutlet weak var txt_View: UITextView!
    
    
    
    @IBAction func btn_back(sender: UIButton) {
    
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    var attributedString = NSMutableAttributedString().dynamicType.init(string: "")
    var textAttachment = NSTextAttachment()
    
    // single attributes declared one at a time
    let singleAttribute1 = [ NSForegroundColorAttributeName: UIColor.greenColor() ]
    let singleAttribute2 = [ NSBackgroundColorAttributeName: UIColor.yellowColor() ]
    let singleAttribute3 = [ NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleDouble.rawValue ]
    
    // multiple attributes declared at once
    let multipleAttributes = [
        NSForegroundColorAttributeName: UIColor.greenColor(),
        NSBackgroundColorAttributeName: UIColor.yellowColor(),
        NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleDouble.rawValue ]
    
    // custom attribute
    let customAttribute = [ "MyCustomAttributeName": "Some value" ]

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var num = delegate.row_num
        
        textAttachment.image = UIImage(named: "도담이소개.png")
        
        let attrStringWithImage = NSAttributedString(attachment: textAttachment)
        attributedString.appendAttributedString(attrStringWithImage)
        
        
        
            // Initialize with a string only
        let attrString1 = NSAttributedString(string: "\n Hello.")
        
        // Initialize with a string and inline attribute(s)
        let attrString2 = NSAttributedString(string: "Hello.", attributes: ["MyCustomAttribute": "A value"])
        
        // Initialize with a string and separately declared attribute(s)
        let myAttributes1 = [ NSForegroundColorAttributeName: UIColor.greenColor() ]
        let attrString3 = NSAttributedString(string: "Hello.", attributes: myAttributes1)
        
        
        attributedString.appendAttributedString(attrString1)
        attributedString.appendAttributedString(attrString2)
        attributedString.appendAttributedString(attrString3)
        
//        txt_View.attributedText = attributedString
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 50
        paragraphStyle.maximumLineHeight = 50
        
        var str = String()
        
        let attributes = NSDictionary(object: NSParagraphStyleAttributeName, forKey: paragraphStyle)
        if(num == 0){
            
            str = "🍚 쌀 이야기 \n   - 벼는 인도말 '브리히'에서, 살은 고대 인도어 '사리'에서 만들어졌는데, 퉁구스에서 '시라'로, 우리나라에서 '쌀'로 되었어요. \n\n\n 🍚 쌀에는 어떤 영양이 들어있을까요? \n   - 쌀은 주고 탄수화물이 많이 들어있고, 식물성 단백질이 많아 우리나라 사람들이 하루에 필요한 단백질의 4분의 1을 쌀로 얻어요. \n\n\n 🍚 쌀을 먹으면 무엇이 좋을까요? \n   - 가장 주요한 에너지원이자 뇌의 유일한 에너지원으로, 집중력을 높이고 힘을 내게 해줘요."
            
        }else if(num == 1){
            
            str = "🍄 버섯 이야기기 \n   - 우리가 일반적으로 알고 있는 식물은 씨앗으로 번식하지만, 버섯은 포자로 번식해서 균사를 형성하고, 이것이 여러 개가 모여서 버섯이라는 모양을 만든답니다. \n\n\n 🍄 버섯에는 어떤 영양이 들어있을까요? \n   - 80% ~ 90%가 물로 되어있으며, 그 외에 당질, 단백질, 지질, 비타민, 철, 인, 칼륨 등도 들어있어요. \n\n\n 🍄 버섯을 먹으면 무엇이 좋을까요? \n   - 버섯의 독특한 맛은 구아닐상에서 나오는데, 이것은 혈액 속의 콜레스테롤 수치를 떨어뜨려 고혈압이나 심장병에 좋아요. 또한 칼로리가 거의 없기 때문에 많이 먹어도 살이 찌지않아요."
            
        }else if(num == 2){
            
            str = "🍇 포도 이야기 \n포도에 대한 궁금증 5가지 \n   - 포도는 맣이 먹을수록 좋나요?.\n      포도는 당분이 ㅁ낳아 혈당이 급격히 높아질 수도 있으므로 적당히 먹는 것이 좋아요. \n\n\n   - 포도는 어떻게 씻나요? \n      포도를 작은 송이로 잘라 흐르는 물에 씻거나 식초를 몇 방울 떨어뜨려 씻어요 \n\n\n   - 포도는 어떻게 어떻게 싱싱하게 보관하죠? \n      신문지로 싸거나 포도봉지에 쌓인 상태로 냉장고에 보관하면 더욱 오래 보관할 수 있어요. \n\n\n    - 포도의 껍질과 씨는 먹는 것이 좋나요? \n      포도의 껍질과 씨에는 미백효과가 항암작용을 가진 성분이 들어있기 때문에 함께 먹는 것이 좋아요. \n\n\n🍇 포도에는 어떤 영양이 들어있을까요?\n   - 타닌과 폴리페놀 성분이 암과 심장병을 예방하고 면역력을 지켜주며, 무기질은 피를 만들어줘요"
            
        }else if(num == 3){
            
            str = "🐟 멸치 이야기 \n   - 멸치는 지역마다 조금식 다르게 불린답니다. 서울, 경기도 및 함경도 일부 지방에서는 멸치 또는 메레치, 강원도에서는 멧치, 황해도 지역에서는 돗자래기 또는 초도, 전남, 자주도에서는 멸오 또는 행어라고 불리기도 해요. \n\n\n 🐟 알아두면 좋은 멸치 관련 정보 \n   - 색깔이 검거나 붉은 것, 기름기가 있는 것은 최하품으로 맛이 없고 쓰며 비린내가 나요.\n   - 새콤한 냄새가 나는 것은 상한 것이랍니다.\n   - 멸치를 보관할 때는 팩에 넣어 냉동실에 두어야 상하지 않아요. \n\n\n 🐟 멸치에는 어떤 영양이 들어있을까요? \n   - 성장에 꼭 필요한 단백질과 칼슘, 인 등이 들어있고, DHA, EPA라 부르는 좋은 불포화지방이 많이 들어있어요"
        }else if(num == 4){
            
            str = "🧀 치즈 이야기 \n   - 원래 '치즈(cheese)'란 말은 라티어 '카세우스(caseus)'에서 유래된 단어인데 다시 중세영어인 'chese'를 거쳐 현대의 'cheese'로 변화되었어요. 대부분이 치즈가 서양에서 유래된 것으로 생각하기 쉬운데, 사실 아시아에서 발견되어 유럽으로 전해졌어요. \n\n\n 🧀 치즈에는 어떤 영양이 들어있을까요? \n   - 단백질과 지방이 20!30%씩 함유되어 있고, 칼슘, 비타민, 등이 풍부하게 들어있어요.\n\n\n 🧀 치즈를 먹으면 무엇이 좋을까요? \n   - 성장기 어린이에게 좋고, 뼈에 구멍이 생기는 골다공증을 예방하며, 뼈, 치아, 근육, 피부를 강화시켜요."
        }else if(num == 5){
            
            str = "♦️ 아몬드 이야기 \n   - 고대 이탈리아 결혼식에서 건강, 다산, 사랑, 재산, 행복을 의미하는 아몬드 다섯 알씩을 하객들에게 주었다고 해요. 로마인들도 다산을 기원하는 의미로 결혼한 부부에게 아몬드를 뿌렸다고 해요. \n\n\n ♦️ 아몬드에는 어떤 영양이 들어있을까요?? \n   - 필수 영양소가 다량 함유되어 있고, 콜레스테롤이 없으며, 포화지방이 낮아요, 단백질, 식이섬유 및 중요한 비타민을 함유하고 있어요.\n\n\n ♦️ 아몬드를 먹으면 무엇이 좋을까요? \n   - 매일 한 주먹 정도의 아몬드를 먹으면 동맥경화와 고지혈증에 효과적이고, 무서운 암이나 뇌졸증으 ㄹ예방하며 피부를 예쁘게 해요."
        }
        
        
        
        txt_View.attributedText = NSAttributedString(string: str, attributes: attributes as? [String : AnyObject])
        txt_View.font = UIFont.systemFontOfSize(20)

        // Do any additional setup after loading the view.
    }

    
    /*
 
     NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
     paragraphStyle.minimumLineHeight = 35.f;
     paragraphStyle.maximumLineHeight = 35.f;
     
     
     //    UIFont *font = [UIFont fontWithName:@"System-Bold" size:20];
     NSString *string = contents;
     NSDictionary *attributtes = @{
     NSParagraphStyleAttributeName : paragraphStyle,
     };
     self.txt_news.attributedText = [[NSAttributedString alloc] initWithString:string
     attributes:attributtes];
     
     [self.txt_news setFont:[UIFont systemFontOfSize:18]];
     
 */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
     
     var attachment = NSTextAttachment()
     var imageTest = UIImage(named:"arrow.png")
     attachment.image = imageTest
     var myString = NSMutableAttributedString(string: "My label text ")
     var myStringWithArrow = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
     myStringWithArrow.appendAttributedString(myString)
     lblAttributed.attributedText = myStringWithArrow
     
     
     
     NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
     UIImage *imageTest=[UIImage imageNamed:@"arrow.png"];
     attachment.image = imageTest;
     NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:@"My label text "];
     NSMutableAttributedString *myStringWithArrow = [[NSMutableAttributedString alloc]initWithAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
     [myStringWithArrow appendAttributedString:myString];
     yourLabel.attributedText = myStringWithArrow;
     
     
 
     NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"like after"];
     
     NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
     textAttachment.image = [UIImage imageNamed:@"whatever.png"];
     
     NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
     
     [attributedString replaceCharactersInRange:NSMakeRange(4, 1) withAttributedString:attrStringWithImage];
     
 */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
