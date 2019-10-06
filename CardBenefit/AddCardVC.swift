//
//  CardEditVC.swift
//  CardBenefit
//
//  Created by Bono b Bono on 25/09/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

//UITextFieldDelegate는 텍스트필드를 사용하기 위한것
class AddCardVC: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    
    //CardToBenefitVC로부터 전달받을 현재 카드 갯수(이 숫자는 새로 카드 만들때 적어줘야 할 ORDERS 항목때문에 필요함
    var cardCount: Int!
    
    //DAO객체
    let cardDAO = CardDAO()
    
    //작성내용을 임시 저장해 둘 변수들
    var cardName: String?
    var nickName: String?
    var traffic: Bool?
    var oversea: Bool?
    var image: String?
    var memo: String?
    
    //화면상에 나타난 컨트롤들을 연결
    @IBOutlet var cardNameField: UITextField!
    @IBOutlet var nickNameField: UITextField!
    @IBOutlet var trafficSegment: UISegmentedControl!
    @IBOutlet var overseaSegment: UISegmentedControl!
    @IBOutlet var memoView: UITextView!
    @IBAction func uploadImage(_ sender: UIButton) {
    }
    
    //메모 텍스트 뷰 입력완료시 임시저장한다.
    func textViewDidEndEditing(_ textView: UITextView) {
        self.memo = textView.text
    }
    
    //메모 텍스트뷰 수정시 중간작업내용을 저장한다
    func textViewDidChange(_ textView: UITextView) {
        self.memo = textView.text
    }
    
    //카드명 텍스트필드의 입력 완료시 임시저장한다.
    func textFieldDidEndEditing(_ textField: UITextField) {
        //텍스트필드에 뭔가 입력했을때에만 임시변수에 저장한다.
        if cardNameField.hasText {
        cardName = cardNameField.text
        }
        if nickNameField.hasText {
        nickName = nickNameField.text
        }
    }
    //리턴키 눌럿을때 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //우측 바버튼(done버튼)을 눌럿을때 실행될 함수임
    @objc func finished() {
        //입력값이 제대로 들어갔는지 확인하는 로직 입력
        //별칭 및 이미지를 제외하고 값이 없는경우 알라트 띄운다
        if cardName == nil {
            self.alert("카드이름을 입력해주세요")
        }else if traffic == nil {
            self.alert("교통카드 사용가능여부를 체크해주세요")
        }else if oversea == nil{
            self.alert("해외결제 가능여부를 체크해주세요")
        }else {
            //현재 입력된 내용을 바탕으로 디비입력작업 개시 뻑큐
            //디비입력시 사용자가 입력하지 않은 내용에 대해서는 빈값을 넣는것으로 대체하고자 함.
            var _nickName: String!
            var _image: String!
            var _memo: String!
            
            if self.nickName == nil {
                _nickName = ""
            }else{
                _nickName = self.nickName
            }
            if self.image == nil {
                _image = ""
            }else{
                _image = self.image
            }
            if self.memo == nil {
                _memo = ""
            }else{
                _memo = self.memo
            }
            
            
            cardDAO.addCard(cardName: self.cardName!, image: _image, nickName: _nickName, traffic: self.traffic!, oversea: self.oversea!, memo: _memo, order: self.cardCount+1)
            print("카드추가가 완료되엇습니드앙")
        
            
            
            
            //원래 화면으로 돌아가는 로직
            self.navigationController?.popViewController(animated: true)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "카드추가"
        
        //프로그래밍 방식으로 네비게이션 바 버튼 만들기 //finished 라는 함수를 실행하도록 하였다.
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finished))
        self.navigationItem.rightBarButtonItem = doneButton
        
        //세그먼트 컨트롤이 기본적으로 값을 가지고 있지 않도록 설정
        self.trafficSegment.selectedSegmentIndex = -1
        self.overseaSegment.selectedSegmentIndex = -1
        
        //세그먼트컨트롤 값이 변경되면 임시변수에 저장되도록 함수에 연결
        self.trafficSegment.addTarget(self, action: #selector(trafficValueChanged), for: .valueChanged)
        
        self.overseaSegment.addTarget(self, action: #selector(overseaValueChanged), for: .valueChanged)
        
        //텍스트필드 딜리게이트 설정
        cardNameField.delegate = self
        nickNameField.delegate = self
        
        //메모텍스트뷰 딜리게이트 설정
        memoView.delegate = self
    }
    
    //교통카드사용가능여부 바뀌었을때 임시변수에 저장하는 메소드
    @objc func trafficValueChanged() {
        self.traffic = (self.trafficSegment.selectedSegmentIndex == 1) ? true : false
        
    }
    //해외결제가능여부 바뀌었을때 임시변수에 저장하는 메소드
    @objc func overseaValueChanged() {
        self.oversea = (self.overseaSegment.selectedSegmentIndex == 1) ? true : false
    }
}
