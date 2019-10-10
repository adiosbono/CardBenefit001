//
//  ShopVC.swift
//  CardBenefit
//
//  Created by Bono b Bono on 09/10/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

//혜택받을곳 직접 입력은 알라트팝업을 띄워서 해결한다(한화면에서 동일한 내용을 선택하는게 2개이상 존재하면 뭐로 선택됫는지 헷갈리기때문에 UI작업을 그렇게 함

class ShopVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    //변수들 정의
        //이거슨 피커뷰에 들어갈 자료를 받는 녀석
    var shopList: [String]!
    
        //이거슨 피커뷰로 선택하였거나, 혜택받을곳 직접 입력을 통해 하여튼 선택한 것 저장할넘
    var selection: String?
    
    var originVC : BenefitsVC!
    
    //DAO객체
    let cardDAO = CardDAO()
    
    @IBAction func doneButton(_ sender: UIButton) {
        //원래의 뷰컨트롤러에 입력받은 값 전달해보리기
        //바로아래줄의 BenefitsVC읽어오는거는 바로 에러뜸
        //let originVC = self.presentingViewController as! BenefitsVC
        print("전달직전의값: \(selection ?? "nil입니다 주륵")")
        
            
        originVC.store.text = self.selection
        
        //프레젠트 방식으로 넘긴 화면에서 원래대로 돌아간드아
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButton(_ sender: UIButton) {
        //프레젠트 방식으로 넘긴 화면에서 원래대로 돌아간드아
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    //피커뷰 연결
    @IBOutlet var pickerView: UIPickerView!
    
    //직접 입력하기 버튼임. 알라트팝업을띄울것임
    @IBAction func directInput(_ sender: UIButton) {
        
        //기본적인 알라트팝업세팅
        let alert = UIAlertController(title: "혜택받을곳 입력", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelHandler(alert:))
        //오케이액션에 핸들러가 있는데 그녀석을 쓰기 위해서는 함수를 따로 만들어야함
        let okAction = UIAlertAction(title: "OK", style: .default, handler: okHandler(alert:))
        
        
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
    
        //알라트팝업 가운데에 끼워넣을 뷰
        let v = UIViewController()
        //알라트팝업내에 추가할 텍스트필드를 만든다
        let txtField = UITextField(frame: CGRect(x: 15, y: 5, width: 240, height: 40))
        //배경색은 흰색으로(설정안하면 투명색임)
        txtField.backgroundColor = UIColor.white
        //테두리를 나타내자
        txtField.borderStyle = .roundedRect
        txtField.placeholder = "혜택받을곳을 입력해주세요"
        //키보드내리는 딜리게이트를 이 클래스 내에 구현했으므로 이게 필요함
        txtField.delegate = self
        
        v.view.addSubview(txtField)
        
        //알림창에 뷰 컨트롤러를 등록한다
        alert.setValue(v, forKey: "contentViewController")
        
        //알라트팝업을 표시한다
        self.present(alert, animated: false, completion: nil)
    }
    
    //오케이액션에 쓸 함수 만들자
    func okHandler(alert: UIAlertAction){
        //해야할것 : shopVC를 해제하기...(해제안하면 픽커뷰 다시 보이므로 사람이 혼동할 수 있음)
        //원래의 뷰컨트롤러에 입력받은 값 전달해보리기
        
        //바로아래줄의 BenefitsVC읽어오는거는 바로 에러뜸
        //let originVC = self.presentingViewController as! BenefitsVC
        //self.originVC.store.text = self.selection
        
        originVC.store.text = self.selection
        
        
        //프레젠트 방식으로 넘긴 화면에서 원래대로 돌아간드아
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    //캔슬액션에 쓸 함수 만들자
    func cancelHandler(alert: UIAlertAction){
        //해야할것 : 이미 입력된 텍스트필드의 값에 nil 집어넣어보리기...(입력이 들어갔지만 이걸 다시 없던걸로 돌리는거임 ㅋㅋㅋㅋㅋㅋㅋ뭣이중헌디)
        self.selection = nil
        print("cancel입력값은 : \(self.selection ?? "nil 이여브러라")")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //피커뷰를 사용하기 위한 기초작업
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        //피커뷰에 표시될 데이터를 디비로부터 불러온다
        self.shopList = self.cardDAO.readShop()
        
        //피커뷰 암것도 건드리지 않았는데 내가 원하는게 선택된 경우를 대비해서...초기값으로 맨 위에 있는 값 넣어주기
        self.selection = self.shopList[0]
        
        //이 화면 불러온 녀석을 참조할수 있도록 클래스 내 변수에 대입하기
        //self.originVC = self.storyboard?.instantiateViewController(withIdentifier: "sw_bc") as? BenefitsVC
        
        
        //self.originVC = self.storyboard?.instantiateViewController(withIdentifier: "EditBenefit") as! EditBenefitVC
    }

    //피커뷰 딜리게이트 메소드 4종집합---------------------------------------------------------------
        //피커뷰에 들어갈 컴포넌트 수...여기선 1개만필요함
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        //컴포넌트마다 몇개의 행이 필요한지 결정하는 함수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.shopList.count
    }
        //피커뷰의 타이틀? 뭘까유
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.shopList[row]
    }
        //피커뷰로 선택한넘
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("선택한넘 : \(self.shopList[row])")
        self.selection = self.shopList[row]
        
        
        
    }
    //피커뷰딜리게이트 집합 끝-------------------------------------------------------------------

    
    
    //리턴키 눌럿을때 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    //카드명 텍스트필드의 입력 완료시 뭐할지 정하는곳
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //입력완료시 현재 클래스 안의 변수 selection에 저장하는 로직을 넣는다
        self.selection = textField.text
        print("입력값은 : \(textField.text ?? "nil 이여브러라")")
        }
    
}

