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
    
    let CUT_HEIGHT: CGFloat = 248 //화면맨위부터 메모하단까지의 높이....이만큼 잘라주는 애니메이션을 사용할거다. 120(메모텍스트뷰높이) + 40(섹션높이) = 160 //여기에다가 위의 네비게이션바 높이 (추정치 88 )만큼 더해야함 토탈 248
    
    //에디트버튼 눌렀을때 실행되게 할 녀석
    @objc func editDelegate() {
        //잘작동하는지 테스트하기 위한 프린트구문
        print("editDelegate Commence")
        //setupView에서 contentVC에 메인화면의 인스턴스를 넣어줫기때문에 이걸로 해당 VC에 접근가능하므로 이용하여 해당 함수를 실행하려고 했으나 잘 안되는 모양이므로 해당 내용을 옮겨와서 잘 작동하도록 변형하였다.
        self.contentVC.tableView.isEditing =  !self.contentVC.tableView.isEditing
        if self.contentVC.tableView.isEditing == true {
            //여기서 self.contentVC.navigationItem.....이 아니라 self.navigationItem인것은 현재 상황이 네비게이션 바는 RevealVC의 것을 사용하고 있으면서, 화면에 보이는것들에 대한 작동은 DetailBenefitVC의 것들을 조작함으로써 이루어지기 때문이다. 커맨드 이렇게 꼬여도 되는지.....모르겠다 아몰랑 되면되는거지...이게되네....호울리
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
            
            //DetailBenefitVC의 델리게이트 변수에 자신의 참조 정보를 넣어준다.
            
            //바로아래줄 에러나네 띠부럴.....현재 화면의 뷰 컨트롤러 인스턴스를 얻어야 한다!
            //let detailVC = vc.viewControllers[0] as? DetailBenefitVC
            
            //이거 에러날 확률 되게 높음시벌탱.......에러안나고 잘됨ㅋㅋㅋㅋㅋㅋ대다나다
            vc.delegate = self
        }
        
        
        
           
        
        
    }
    //컨디션추가 뷰를 읽어온다
    func getConditionVC(){
        if self.conditionVC == nil {
            //컨디션추가 컨트롤러 객체를 읽어온다
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_cc"){
                //다른 메소드에서도 참조할 수 있도록 conditionVC속성에 저장해둔다
                self.conditionVC = vc
                
                
                //---------------------------------------------------------------------
                //conditionVC의 딜리게이트 변수에 값을 집어넣어야 한다!
                let _vc = vc as! ConditionVC
                _vc.delegate = self
                
                //읽어온 컨디션추가 컨트롤러 객체를 컨테이너 뷰 컨트롤러에 연결한다.
                self.addChild(vc)
                self.view.addSubview(vc.view)
                vc.didMove(toParent: self)
                self.view.bringSubviewToFront((self.contentVC?.view)!)
            }
        }
    }
    //혜택추가 뷰를 읽어온다
    func getBenefitsVC(){
        if self.benefitsVC == nil {
            //혜택추가 컨트롤러 객체를 읽어온다
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_bc"){
                //다른 메소드에서도 참조할 수 있도록 benefitsVC속성에 저장해둔다
                self.benefitsVC = vc
                
                //---------------------------------------------------------------------
                //BenefitsVC의 딜리게이트 변수에 값을 집어넣어야 한다!
                let _vc = vc as! BenefitsVC
                _vc.delegate = self
                
                
                //읽어온 컨디션추가 컨트롤러 객체를 컨테이너 뷰 컨트롤러에 연결한다.
                self.addChild(vc)
                self.view.addSubview(vc.view)
                vc.didMove(toParent: self)
                self.view.bringSubviewToFront((self.contentVC?.view)!)
            }
        }
    }
    //콘텐츠 뷰에 그림자 효과를 준다
    func setShadowEffect(shadow: Bool, offset: CGFloat){
        if(shadow == true){
            self.contentVC?.view.layer.cornerRadius = 10 //그림자 모서리 둥글기
            self.contentVC?.view.layer.shadowOpacity = 0.8 //그림자 투명도
            self.contentVC?.view.layer.shadowColor = UIColor.black.cgColor //그림자 색상
            self.contentVC?.view.layer.shadowOffset = CGSize(width: offset, height: offset)
        }else{
            self.contentVC?.view.layer.cornerRadius = 0.0
            self.contentVC?.view.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    //조건 바를 연다
    func openConditionBar(_ complete: (() -> Void)?) {
        self.getConditionVC() //사이드 바 뷰를 읽어온다. 현 화면 아래에 깔아두는것이다
        self.setShadowEffect(shadow: true, offset: -2) //그림자 효과를 준다
        //애니메이션 옵션
        let options = UIView.AnimationOptions([.curveEaseOut, .beginFromCurrentState])
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME), delay: TimeInterval(0), options: options, animations: {
            //원래 보이던 화면을 이동하면 그아래 있던녀석이 나타나게되어 슬라이드하는것처럼느껴진다. 그럼 여기에서 처리해야 될 것은 원래 화면 맨 위를 고정하고 아래를 잘라내어 뷰가 드러나게 하는것이다.
            self.contentVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.CUT_HEIGHT)
        }, completion: {
            if $0 == true {
                self.isSideBarShowing = true
                complete?()
            }
        })
    }
    //조건 바를 닫는다
    func closeConditionBar(_ complete: (()->Void)?) {
        //애니메이션 옵션을 정의한다.
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        //애니메이션 실행
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME), delay: TimeInterval(0), options: options, animations: {
            self.contentVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: {
            if $0 == true{
                //사이드 바 뷰를 제거한다
                self.conditionVC?.view.removeFromSuperview()
                //이젠 필요없으니깐 인스턴스 제거
                self.conditionVC = nil
                //닫힘 상태로 플래그를 변경한다
                self.isSideBarShowing = false
                //그림자 효과를 제거한다
                self.setShadowEffect(shadow: false, offset: 0)
                //인자값으로 받은 완료함수를 실행한다
                complete?()
            }
        })
    }
    
    
    //혜택 바를 연다
    func openBenefitBar(_ complete: (() -> Void)?) {
        self.getBenefitsVC() //사이드 바 뷰를 읽어온다.현 화면 아래다 깔아둔다고 생각하면 된다
        self.setShadowEffect(shadow: true, offset: -2) //그림자 효과를 준다
        //애니메이션 옵션
        let options = UIView.AnimationOptions([.curveEaseOut, .beginFromCurrentState])
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME), delay: TimeInterval(0), options: options, animations: {
            //원래 보이던 화면을 이동하면 그아래 있던녀석이 나타나게되어 슬라이드하는것처럼느껴진다. 그럼 여기에서 처리해야 될 것은 원래 화면 맨 위를 고정하고 아래를 잘라내어 뷰가 드러나게 하는것이다.
            self.contentVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.CUT_HEIGHT)
        }, completion: {
            if $0 == true {
                self.isSideBarShowing = true
                complete?()
            }
        })
    }
    //혜택 바를 닫는다
    func closeBenefitBar(_ complete: (()->Void)?) {
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        //애니메이션 실행
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME), delay: TimeInterval(0), options: options, animations: {
            self.contentVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: {
            if $0 == true{
                //사이드 바 뷰를 제거한다
                self.benefitsVC?.view.removeFromSuperview()
                //이젠 필요없으니깐 인스턴스 제거
                self.benefitsVC = nil
                //닫힘 상태로 플래그를 변경한다
                self.isSideBarShowing = false
                //그림자 효과를 제거한다
                self.setShadowEffect(shadow: false, offset: 0)
                //인자값으로 받은 완료함수를 실행한다
                complete?()
            }
        })
    }
}
