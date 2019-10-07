//
//  RevealViewController.swift
//  CardBenefit
//
//  Created by Bono b Bono on 07/10/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

class RevealVC: UIViewController{
    
    //호출한 뷰컨트롤러부터 전달받을 값!
    var cardId: Int?
    var cardName: String!
    var memo: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //초기화면설정하는 메소드 호출!
        self.setupView()
    }
    
    //다음아래의 함수들은 뷰를 아래쪽으로 여닫는걸 하기 위한것들임 571
    
    //설정 변수
    var contentVC: UITableViewController!
    var conditionVC: UIViewController? //이녀석은 카드사용조건 추가 눌럿을때 나타날녀석
    var benefitsVC: UIViewController?  //이녀석은 혜택 추가 눌럿을때 나타날녀석
    var isSideBarShowing = false
    let SLIDE_TIME = 0.3
    let SIDEBAR_HEIGHT: CGFloat = 1000
    
    //에디트버튼 눌렀을때 실행되게 할 녀석
    @objc func editDelegate() {
        //잘작동하는지 테스트하기 위한 프린트구문
        print("editDelegate Commence")
        //setupView에서 contentVC에 메인화면의 인스턴스를 넣어줫기때문에 이걸로 해당 VC에 접근가능하므로 이용하여 해당 함수를 실행하려고 했으나 잘 안되는 모양이므로 해당 내용을 옮겨와서 잘 작동하도록 변형하였다.
        self.contentVC.tableView.isEditing =  !self.contentVC.tableView.isEditing
        if self.contentVC.tableView.isEditing == true {
            //여기서 self.contentVC.navigationItem.....이 아니라 self.navigationItem인것은 현재 상황이 네비게이션 바는 RevealVC의 것을 사용하고 있으면서, 화면에 보이는것들에 대한 작동은 DetailBenefitVC의 것들을 조작함으로써 이루어지기 때문이다. 커맨드 이렇게 꼬여도 되는지.....모르겠다 아몰랑 되면되는거지
            self.navigationItem.rightBarButtonItem?.title = "Done"
        }else{
            self.navigationItem.rightBarButtonItem?.title = "Edit"
        }
        self.contentVC.tableView.reloadData()
    }
    //초기 화면을 설정한다
    func setupView(){
        //메인화면(DetailBenefitVC) 객체를 읽어온다
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailBenefitVC {
            //읽어오고 전달받았던 값을 넘겨준다(중간도매상이냐뭐냐)
            vc.cardId = self.cardId
            vc.cardName = self.cardName
            vc.memo = self.memo
            
            
            //읽어온 녀석을 클래스 전체에서 참조할 수 있도록 contentVC속성에 저장한다
            self.contentVC = vc
            //읽어온 녀석을 메인 컨트롤러의 자식으로 등록한다.
            self.addChild(vc)
            //읽어온 녀석의 뷰를 메인 컨트롤러의 서브 뷰로 등록
            self.view.addSubview(vc.view)
            //읽어온 녀석에게 부모 뷰 컨트롤러가 바뀌었음을 알려준다
            vc.didMove(toParent: self)
            
            //네비게이션바 우측상단에 에디트 버튼 만들고 누르면 읽어온 녀석에 존재하는 똑같은 버튼을 누를때 실행되는 함수가 실행되게 한다.
            let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editDelegate))
            
                self.navigationItem.rightBarButtonItem = editButton
                self.navigationItem.title = cardName
            
        }
        
        
        
    }
    //컨디션추가 뷰를 읽어온다
    func getConditionVC(){
        
    }
    //혜택추가 뷰를 읽어온다
    func getBenefitsVC(){
        
    }
    //콘텐츠 뷰에 그림자 효과를 준다
    func setShadowEffect(shadow: Bool, offset: CGFloat){
        
    }
    //사이드 바를 연다
    func openSideBar(_ complete: (() -> Void)?) {
        
    }
    //사이드 바를 닫는다
    func closeSideBar(_ complete: (()->Void)?) {
        
    }
}
