//
//  DetailBenefitVC.swift
//  CardBenefit
//
//  Created by Bono b Bono on 22/09/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

class DetailBenefitVC: UITableViewController, UITextViewDelegate {
    //변수들을 넣는다
    var cardId: Int?
    var cardName: String!
    var memo: String?
    
    
    //사이드 바 오픈 기능을 위임할 델리게이트
    var delegate: RevealVC?

    
    //디비의 conditions 테이블에서 가져오는 자료형
    var conditionList = [String?]()
    //디비의 shop_adv_res 테이블에서 가져오는 자료형
    //순서대로 shop, advantage, restrict
    var SARList = [(String?, String?, String?)]()
    
    //DAO객체
    let cardDAO = CardDAO()
    
    //메모셀을 전역변수로 사용하기 위해 정의한 녀석
    var memoCell: MemoCell!
    
    
    
    
    //toEdit함수는 네비게이션 바 우측 상단의 에디트 버튼을 눌렀을때 새로운 화면으로 전환시켜주는 역할임 //dvc는 destination ViewController줄임말임
    @objc func toEdit() {
        
        //맨처음 계획은 새로운 화면으로 이동하여 설정하려는 것이었으나...실질적으로 새 화면으로 이동했을때 얻는 이득이 없다고 판단되므로, 현재 화면에서 에디트 모드를 토글하는것으로 변경하였다. 새 화면으로 이동하고 싶다면 아래의 주석을 해제하기 바람
        /*
        let dvc = self.storyboard?.instantiateViewController(withIdentifier: "EditBenefit") as! EditBenefitVC //스토리보드 아이디가 디테일임....
        //전달하려는 값이 있는 경우 값을 전달한다.
    
        //네비게이션컨트롤러를 이용한 화면전환 실시
        self.navigationController?.pushViewController(dvc, animated: true)
 */
        
        //새로운 계획 실시(현재 화면에서 처리해부리기)
        self.tableView.isEditing = !self.tableView.isEditing
        if tableView.isEditing == true {
        self.navigationItem.rightBarButtonItem?.title = "Done"
            
        }else{
            self.navigationItem.rightBarButtonItem?.title = "Edit"
            
        }
        //화면을 다시 로드하여 변동된 에디트 모드에 대한 적용사항들이 나타나도록 한다
        //self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //디비에서 데이터 가져오기
        self.refreshDB()
        //아래 두줄은 구식으로 하드코딩하던것임
        //self.conditionList = self.cardDAO.findCondition(cardId: cardId!)
        //self.SARList = self.cardDAO.findSAR(cardId: cardId!)
        
        //프로그래밍 방식으로 네비게이션 바 버튼 만들기 //toEdit라는 함수를 실행하도록 하였다.
        //현재 사이드 뷰가 슉 나오는방식으로 하기 때문에 이거 없어도 무관함.......젠장
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toEdit))
    
        self.navigationItem.rightBarButtonItem = editButton
        self.navigationItem.title = cardName
        
        
        
        
        
    }
    
    //디비를 다시 읽어오는 메소드
    func refreshDB(){
        self.conditionList = self.cardDAO.findCondition(cardId: cardId!)
        self.SARList = self.cardDAO.findSAR(cardId: cardId!)
    }
    
    
    //화면이 나타날때마다 호출되는 메소드
    override func viewWillAppear(_ animated: Bool) {

        self.tableView.reloadData()
    }

    
    //각 행 높이를 설정하는 메소드
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //시스템이 알이서 정하게 두는 방법
        //return UITableView.automaticDimension
        //각 섹션별로 다르게 주고싶은경우
        
        switch indexPath.section {
        case 0 :
            return 120
        case 1 :
            return UITableView.automaticDimension
        default :
            return UITableView.automaticDimension
        }
 
    }
    //각 행에 무엇을 나타낼지 결정하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            
        case 0 :
            
            self.memoCell = tableView.dequeueReusableCell(withIdentifier: "memoCell") as? MemoCell
            self.memoCell.memoTextView.text = memo!
            
            //메모 텍스틑뷰의 딜리게이트를 현재 클래스로 설정
            self.memoCell.memoTextView.delegate = self
            
            //메모의 텍스트뷰 터치했을때 키보드에 done버튼 추가하는 코드
            self.memoCell.memoTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
            
            //메모 텍스트뷰 에디팅이 불가능하게 막기
            self.memoCell.memoTextView.isEditable = false
            
            //기존 구문 시작
            //let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell") as! MemoCell
            //cell.memoTextView.text = memo!
            //기존 구문 끗
            
            //cell.frame = CGRect(x: 0, y: 0, width: <#T##Int#>, height: <#T##Int#>)
            
            return memoCell
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "conditionCell") as! ConditionCell
            let rowData = self.conditionList
            cell.conditionLabel.text = rowData[indexPath.row]
            return cell
        default :
            let cell = tableView.dequeueReusableCell(withIdentifier: "benefitCell") as! BenefitCell
            

            let rowData = self.SARList
            //매장이름은 그냥 집어넣으면 되고
            cell.shopName.text = rowData[indexPath.row].0
            //레이블에 두 스트링을 합쳐서 넣어야 하므로 각각 추출해서 합성하고 레이블에 집어넣는다
            let content1 = rowData[indexPath.row].1
            let content2 = rowData[indexPath.row].2
            
            let contentMerged = content1! + ", " + content2!
            cell.content.text = contentMerged
            return cell
        }
        
        
    }
    
    
    //테이블 행의 개수를 결정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return self.conditionList.count
        case 2:
            return self.SARList.count
        default:
            return 1
        }
    }
    /*
    //테이블의 특정 행이 선택되었을때 호출되는 메소드
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        <#code#>
    }
 */
    //테이블 뷰의 섹션의 수 결정하는 메소드 따로 오버라이드 하지 않으면 기본값은 1임
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    //각 섹션 헤더에 들어갈 뷰를 정의하는 메소드. 섹션별 타이틀을 뷰 형태로 구성하는 메소드 1080 뷰형태이기때문에 이미지도 넣을수 있는 커스텀이 가능하나 복잡하므로 난 타이틀만 넣고싶다고 하면 titleForHeaderInSection을 사용해야함
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //헤더에 들어갈 레이블 객체 정의
        let textHeader = UILabel(frame: CGRect(x: 35, y: 5, width: 200, height: 30))
        textHeader.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 2.5))
        textHeader.textColor = UIColor(red: 0.03, green: 0.28, blue: 0.71, alpha: 1.0)
        
        //헤더에 들어갈 버튼 정의
        let addButton = UIButton(type: .custom)
        //x좌표는 동적으로 실행하기 위해서 이러케 해놈
        addButton.frame = CGRect(x: self.view.frame.size.width - 150, y: 5, width: 200, height: 30)
        addButton.setTitleColor(UIColor.black, for: .normal)
        //섹션에 따라 타이틀 다르게 설정
        switch section {
        case 0:
            textHeader.text = "메모"
            //에디트 버튼을 눌렀을때 메모텍스트뷰가 수정 가능하게 해야함
            if self.tableView.isEditing == true {
                print("Editing commence")
                self.memoCell.memoTextView.isEditable = true
            }
        case 1:
            textHeader.text = "카드사용조건"
            //추가버튼을 해당 섹션에 맞게 넣어줘야 되니깐 버튼을 각자 따로 만들어줘야한다.
            if self.tableView.isEditing == true {
            addButton.setTitle("추가", for: .normal)
                //셀렉터안에 내용을 moveCondition으로 바꿔주면 사이드뷰가 열린다. 지금은 알라트뷰로 끝내려고 해서 변경함
                addButton.addTarget(self, action: #selector(moveCondition(_:)), for: .touchUpInside)
            }
            
        case 2:
            textHeader.text = "혜택 및 제약조건"
            //추가버튼 넣기
            if self.tableView.isEditing == true {
            addButton.setTitle("추가", for: .normal)
                addButton.addTarget(self, action: #selector(moveBenefit(_:)), for: .touchUpInside)
            }
            
        default:
            textHeader.text = "KissMyAss"
        }
        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        v.backgroundColor = UIColor(red: 0.93, green: 0.96, blue: 0.99, alpha: 1.0)
        v.addSubview(textHeader)
        v.addSubview(addButton)
        
        
        return v
    }
    //팝업창을 띄워서 하려햇으나 포기....액션을 이용해서 원래 뷰컨트롤러에서 또 처리해줘야하는듯 그리고 내가 지금까지 어떤 조건을 추가햇엇는지 보기도 해야하니깐...
    /*
    @objc func popAlert(_ sender: Any) {
        let alert = UIAlertController(title: "조건추가", message: "추가할 카드사용조건을 입력해주세요", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: <#T##((UIAlertAction) -> Void)?##((UIAlertAction) -> Void)?##(UIAlertAction) -> Void#>)
    }
    */
    
    //조건을 추가하는 사이드 뷰를 열고 닫는 메소드
    @objc func moveCondition(_ sender: Any) {
        print("moveCondition실행됨")
        if self.delegate?.isSideBarShowing == false {
            self.delegate?.openConditionBar(nil) //사이드 바를 연다
        }else{
            self.delegate?.closeConditionBar(nil) //사이드 바를 닫는다
        }
    }
    
    //혜택을 추가하는 사이드 뷰를 열고 닫는 메소드
    @objc func moveBenefit(_ sender: Any) {
        print("moveBenefit실행됨")
        if self.delegate?.isSideBarShowing == false {
            self.delegate?.openBenefitBar(nil) //사이드 바를 연다
        }else{
            self.delegate?.closeBenefitBar(nil) //사이드 바를 닫는다
        }
    }
    
    //각 섹션 헤더의 높이를 결정하는 메소드
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
 
    //테이블의 한 행을 삭제하는 함수(디비까지 처리해야함에 주의)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            //메모를 지운다. 지운다기보다 메모에 빈값을 입력하는것이다.
            if(indexPath.section == 0){
                //디비에서 지우고
                self.cardDAO.deleteMemo(cardId: self.cardId!)
                //화면내에 저장된 변수에서 지우고
                self.memo = ""
                //화면 리로딩!
                self.tableView.reloadData()
            //카드사용조건을 지운다. 요놈은 진짜로 디비의 데이터를 지워야 한다.
            }else if(indexPath.section == 1){
                //디비에서 지운다
                //print("현재 선택한 녀석 : \(indexPath.row)")
                self.cardDAO.deleteCondition(cardId: self.cardId!, condition: self.conditionList[indexPath.row]!)
                //화면내 저장된 변수에서 지우고
                self.conditionList.remove(at: indexPath.row)
                //테이블뷰에서 지운다
                tableView.deleteRows(at: [indexPath], with: .automatic)
                //화면 리로딩!
                self.tableView.reloadData()
            //혜택을 지워야 한다
            }else{
                //디비에서 지운다
                self.cardDAO.deleteBenefit(cardId: self.cardId!, shop: self.SARList[indexPath.row].0!, advantage: self.SARList[indexPath.row].1!, restrict: self.SARList[indexPath.row].2!)
                //화면내 저장된 변수에서 지우고
                self.SARList.remove(at: indexPath.row)
                //테이블뷰에서 지운다
                tableView.deleteRows(at: [indexPath], with: .automatic)
                //화면 리로딩
                self.tableView.reloadData()
            }
        }
    }
    
    //텍스트뷰가 수정되었을때 변경내용을 일단 텍스트뷰에 저장(현재 화면에서 저장하는것)
    func textViewDidChange(_ textView: UITextView) {
        self.memo = self.memoCell.memoTextView.text
        
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("메모내용을 디비에 변경작업 시작")
        
        if cardId == nil {
            print("cardId값이 nil이므로 잦됫슴")
        }else if memo == nil {
            print("memo값이 nil이므로 잦됫슴")
        }else{
        self.cardDAO.updateMemo(cardId: cardId!, memo: memo!)
            print("메모내용 변경작업 완료")
        }
    }
    
    //TextView의 Done버튼이 눌렸을때 실행될 함수
    @objc func tapDone(sender: Any) {
        
        print("tabDone함수 실행됨")
        self.view.endEditing(true)
    }
}



