//
//  SearchHomeVC.swift
//  CardBenefit
//
//  Created by Bono b Bono on 08/11/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

class SearchHomeVC: UIViewController, UISearchBarDelegate {
    
    //화면에 있는 객체들을 연결한다
    
        //디비사용하기 위한 객체 선언
    let cardDAO = CardDAO()
        //서치바
    @IBOutlet var SearchBar: UISearchBar!
        //카드명 스위치 중괄호안의 내용은 버튼이 터치될때마다 실행된다.
    @IBAction func cardNameSW(_ sender: UISwitch) {
        if(self.switchCheck()){
            sender.isOn = true
        }
    }
        //카드명 스위치 값
    @IBOutlet var cardNameValue: UISwitch!
    
        //별칭 스위치
    @IBAction func nickNameSW(_ sender: UISwitch) {
        if(self.switchCheck()){
            sender.isOn = true
        }
    }
        //별칭 스위치 값
    @IBOutlet var nickNameValue: UISwitch!
    
        //메모 스위치
    @IBAction func memoSW(_ sender: UISwitch) {
        if(self.switchCheck()){
            sender.isOn = true
        }
    }
        //메모 스위치 값
    @IBOutlet var memoValue: UISwitch!
    
        //카드사용조건 스위치
    @IBAction func conditionSW(_ sender: UISwitch) {
        if(self.switchCheck()){
            sender.isOn = true
        }
    }
        //카드사용조건 값
    @IBOutlet var conditionValue: UISwitch!
    
        //상호명 스위치
    @IBAction func shopNameSW(_ sender: UISwitch) {
        if(self.switchCheck()){
            sender.isOn = true
        }
    }
        //상호명 값
    @IBOutlet var shopNameValue: UISwitch!
    
        //제약조건 스위치
    @IBAction func restrictionSW(_ sender: UISwitch) {
        if(self.switchCheck()){
            sender.isOn = true
        }
    }
        //제약조건 값
    @IBOutlet var restrictionValue: UISwitch!
    
        //혜택 스위치
    @IBAction func benefitSW(_ sender: UISwitch) {
        if(self.switchCheck()){
        sender.isOn = true
        }
    }
        //혜택 값
    @IBOutlet var benefitValue: UISwitch!
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //검색바 딜리게이트를 여기로 설정
        self.SearchBar.delegate = self
        //서치바 선택시 나타나는 키보드위쪽에 done버튼 만들고 이거 누르면 키보드 사라지게 하기
        self.SearchBar.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
    }

    //스위치가 눌릴때매다 실행될 함수...스위치의 값을 검사하여 모두 0 이 된 경우 마지막에 0으로 만든 녀석을 다시 1로 돌린다
    //모든 값이 0이면 true반환, 하나라도 1이면 false반환
    func switchCheck() -> Bool {
        //if절 내에서 스위치의 값을 비교하여 모두 0이면 실행하도록 하자
        if((self.cardNameValue.isOn || self.nickNameValue.isOn || self.memoValue.isOn || self.conditionValue.isOn || self.shopNameValue.isOn || self.restrictionValue.isOn || self.benefitValue.isOn) == false){
            //마지막에 실행된 스위치의 값을 다시 1로 돌리는 로직 작성
            print("모든 스위치 값이 0임을 확인함")
            self.alert("최소한 하나의 검색조건은 활성화되어야 합니다")
            return true
        }
        else{
            return false
        }
    }

    //서치바 키보드 done버튼 눌릴때 실행될 함수
    @objc func tapDone(sender: Any) {
        
        print("tabDone함수 실행됨")
        self.view.endEditing(true)
    }
    
    //서치바의 서치버튼이 클릭되었을경우 실행된다
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("서치버튼클릭됨")
        //화면을 네비게이션 방싣으로 넘기는 코드 시작
        let dvc = self.storyboard?.instantiateViewController(withIdentifier: "SearchResults") as! SearchResultVC //스토리보드 아이디가 SearchResultVC임....
        //전달하려는 값을 준다.
        dvc.cardName = self.cardNameValue.isOn
        dvc.nickName = self.nickNameValue.isOn
        dvc.memo = self.memoValue.isOn
        dvc.condition = self.conditionValue.isOn
        dvc.shop = self.shopNameValue.isOn
        dvc.restriction = self.restrictionValue.isOn
        dvc.benefit = self.benefitValue.isOn
        dvc.keyWord = self.SearchBar.text
        
        
        //네비게이션컨트롤러를 이용한 화면전환 실시
        self.navigationController?.pushViewController(dvc, animated: true)
        //화면을 네비게이션방식으로 넘기는 코드 끗
    }
}
