//
//  BenefitsVC.swift
//  CardBenefit
//
//  Created by Bono b Bono on 07/10/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

//혜택내용을 입력할때 쓰는 키보드는....키보드위에 조그만 바를 두어 바의 done를 눌렀을때 키보드 내려가게 해야겟슴
class BenefitsVC: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    
    //변수를 정의
    
        //혜택내용 placeholder 레이블
    @IBOutlet var benefitPlaceholder: UILabel!
        //제약조건 placeholder 레이블
    @IBOutlet var restrictionPlaceholder: UILabel!
        //혜택내용 텍스트뷰
    @IBOutlet var benefitTextView: UITextView!
        //제약조건 텍스트뷰
    @IBOutlet var restrictionTextView: UITextView!
    
        //키보드 사이즈를 저장할 변수
    var keyboardHeight: CGFloat!
    
    
    //DAO 함수 선언
    let cardDAO = CardDAO()
    //cardId넘겨받을 변수 선언
    var cardId: Int!
    //혜택받을곳이 어딘지 표시해주는 텍스트필드
    @IBOutlet var store: UITextField!
    //혜택받을곳 선택하는 버튼
    @IBAction func selectButton(_ sender: UIButton) {
        let uvc = self.storyboard!.instantiateViewController(withIdentifier: "shop") as! ShopVC
        uvc.originVC = self
        present(uvc, animated: true, completion: nil)
    }

    
    //사이드 바 오픈 기능을 위임할 델리게이트
    var delegate: RevealVC?
    
    //Done버튼...눌럿을때 실행할것들
    @IBAction func doneButton(_ sender: UIButton) {
        
        print("BenefitsVC의 done눌러짐")
        if benefitTextView.hasText == false {
            self.alert("혜택내용을 입력해주세요")
        }else if self.store.hasText == false{
            self.alert("혜택받을곳을 입력해주세요")
        }else{
        
        //우선 혜택내용에 입력된 내용이 있는지 확인하고 입력된 내용이 없으면 경고창 띄워서 입력하게 유도한다.
        
        //여기에 디비에 넣는 작업을 하면 된다
            cardDAO.addSAR(cardId: self.cardId, shop: self.store.text!, advantage: self.benefitTextView.text, restrict: self.restrictionTextView.text)
            
        print("디비에 넣는코드 실행완료/ 넣어졌는지는 직접 확인하시오")
        
        //사용자가 키보드를 내리지 않고 done버튼을 눌렀을 경우에 대비해서 키보드를 내리는 함수를 실행한다.
        self.store.resignFirstResponder()
        
            
            
            
        self.delegate?.closeConditionBar(nil) //사이드 바를 닫는다
            
            //원래 있던 화면을 갱신하고 나서 사이드바를 닫기 위해 여기선 원래화면갱신하는 코드를 넣는다
            self.delegate?.contentVC.viewDidLoad()
            self.delegate?.contentVC.tableView.reloadData()
            print("viewDidLoad Load success")
            
        }
    }
    
    //리턴키 눌럿을때 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //textField.endEditing(true)
        //원래 있던 녀석
        textField.resignFirstResponder()
        return true
    }
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //텍스트뷰 키보드 위에 done버튼 집어넣기 위한 구문
        self.benefitTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
         self.restrictionTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        
        
        
        //텍스트필드의 딜리게이트 메소드를 연결하려면 반드시 아래 구문이 필요함
        self.store.delegate = self
        //텍스트뷰도 마찬가지
        self.benefitTextView.delegate = self
        self.restrictionTextView.delegate = self
        
        //키볻 높이 구하는 기초작업
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    //혜택내용의 텍스트뷰나 제약조건의 텍스트뷰가 입력될때 placeholder사라지게 하기
    func textViewDidChange(_ textView: UITextView) {
        //텍스트뷰에 내용이 없다면 사라졌던 placeholder가 다시 나타나게 하는 기능도 필요함(아래에 한꺼번에 구현할거임)
        
        //텍스트뷰에 내용이 추가되면 placeholder를 감춰야 한다
            //해당 텍스트뷰에 텍스트가 입력되어있지 않다면
        if self.benefitTextView.hasText == false {
            self.benefitPlaceholder.isHidden = false
        }else{
            self.benefitPlaceholder.isHidden = true
        }
        
        if self.restrictionTextView.hasText == false{
            self.restrictionPlaceholder.isHidden = false
        }else{
            self.restrictionPlaceholder.isHidden = true
        }
    }
    
    //키보드 사이즈를 측정하기 위하여 필요한 것들임
    @objc func keyboardWillShow(_ notification: Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.keyboardHeight = keyboardRectangle.height
        }
    }
    
    
    
    //텍스트뷰가 편집하기 시작했을때(터치되었을때)호출되는 메소드...여기서 내가 원하는 녀석 터치한걸 분별해서 view를 올리면되겟군
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == self.restrictionTextView
        {
            //여기에 스크롤하는 구문작성
            if self.view.frame.origin.y == 0 {
                print("위로 스크롤할 준비 완료")
                self.view.frame.origin.y -= keyboardHeight/2
            }
            
        }else{
            //여기는 다른 텍스트뷰 터치되었을때 실행될예정임
        }
    }
    
    //텍스트뷰 편집이 끝나면 원래대로 화면을 내려야하는데 그때 쓸 함수
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == self.restrictionTextView {
            print("원상복귀가즈아")
            self.view.frame.origin.y = 0
        }else{
            
        }
    }
    
    //TextView의 Done버튼이 눌렸을때 실행될 함수
    @objc func tapDone(sender: Any) {
        
        self.view.endEditing(true)
    }
}
