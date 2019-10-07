//
//  DetailBenefitVC.swift
//  CardBenefit
//
//  Created by Bono b Bono on 22/09/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

class DetailBenefitVC: UITableViewController {
    //변수들을 넣는다
    var cardId: Int?
    var cardName: String!
    var memo: String?
    
    
    

    
    //디비의 conditions 테이블에서 가져오는 자료형
    var conditionList = [String?]()
    //디비의 shop_adv_res 테이블에서 가져오는 자료형
    //순서대로 shop, advantage, restrict
    var SARList = [(String?, String?, String?)]()
    
    //DAO객체
    let cardDAO = CardDAO()
    
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
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //디비에서 데이터 가져오기
        self.conditionList = self.cardDAO.findCondition(cardId: cardId!)
        self.SARList = self.cardDAO.findSAR(cardId: cardId!)
        
        //프로그래밍 방식으로 네비게이션 바 버튼 만들기 //toEdit라는 함수를 실행하도록 하였다.
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toEdit))
    
        self.navigationItem.rightBarButtonItem = editButton
        self.navigationItem.title = cardName
        
        
        
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell") as! MemoCell
            cell.memoTextView.text = memo!
            //cell.frame = CGRect(x: 0, y: 0, width: <#T##Int#>, height: <#T##Int#>)
            
            return cell
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
        //여기다가 계속 UITableViewCell 반환해라고 에러가 계속 떳음 아래의 주석처리된 놈들은 실패작들임. 이유를 생각해보니......단한가지 떠오르는게 있음. 아래 주석처리된걸 보면 케이스절 아래 바로 딸려오는 이프절이 있는데, 이프절 내 값이 참일경우엔 cell반환하므로 문제없는데 만약에 반환하지 않는 경우에는 cell을 반환하지 않으므로 반환값이 없는 문제가 발생하는것이다. 그래서 셀포로앳 함수는 반환값이 제데로 있을수도, 없을수도 있는 상황에 놓인것이고, 확정적으로 반환값을 가질 수 없는 상태이기 때문에 계속 UITableViewCell을 반환해라고 요청했던것이다!
        
    }
    /*
    //테이블 행을 구성하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //--------------------------------------------------------------------------
        
        
        switch indexPath.section {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell") as! MemoCell
            cell.memoTextView.text = memo!
            return cell
            
        case 1:
            let rowData = self.conditionList
                //각 행마다 어떻게 반환할지 적어준다.
                let cell = tableView.dequeueReusableCell(withIdentifier: "conditionCell") as! ConditionCell
            cell.conditionLabel.text = rowData![indexPath.row]
                return cell
            
        case 2:
            if let rowData = self.SARList{
                //각 행마다 어케할건지 적어준다
                let cell = tableView.dequeueReusableCell(withIdentifier: "benefitCell") as! BenefitCell
                //매장이름은 그냥 집어넣으면 되고
                cell.shopName.text = rowData[indexPath.row].0
                //레이블에 두 스트링을 합쳐서 넣어야 하므로 각각 추출해서 합성하고 레이블에 집어넣는다
                let content1 = rowData[indexPath.row].1
                let content2 = rowData[indexPath.row].2
                
                let contentMerged = content1! + ", " + content2!
                cell.content.text = contentMerged
                
                return cell
            }
        default:
            print("Error: 컨티션리스트에 값이 없다")
            let cell = tableView.dequeueReusableCell(withIdentifier: "conditionCell") as! ConditionCell
            cell.conditionLabel.text = "값을 불러오지 못해습니다"
            return cell
        
            
        }
        //error
    }
    */
    //------------------------------------------------------------------------------------------------------------
        /*
        //섹션별로 셀의 구성을 달리 해주어야 하므로...
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell") as! MemoCell
            cell.memoTextView.text = memo!
            return cell
            
        }else if indexPath.section == 1{

            if let rowData = self.conditionList {
            //각 행마다 어떻게 반환할지 적어준다.
                let cell = tableView.dequeueReusableCell(withIdentifier: "conditionCell") as! ConditionCell
                cell.conditionLabel.text = rowData[indexPath.row]
                return cell
                /*
                for row in 0...indexPath.row {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "conditionCell") as! ConditionCell
                    cell.conditionLabel.text = rowData[row]
                    return cell
 */
                }else{
                print("Error: 컨티션리스트에 값이 없다")
                let cell = tableView.dequeueReusableCell(withIdentifier: "conditionCell") as! ConditionCell
                cell.conditionLabel.text = "값을 불러오지 못해습니다"
                return cell
            }
            //아래 else는 섹션값이 0도 1도 아닌 경우에 대해 설정하고있다. (섹션값이2인경우)
    }else{
            if let rowData = self.SARList{
                //각 행마다 어케할건지 적어준다
                let cell = tableView.dequeueReusableCell(withIdentifier: "benefitCell") as! BenefitCell
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
    }
 */
    
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
        case 1:
            textHeader.text = "카드사용조건"
            //추가버튼을 해당 섹션에 맞게 넣어줘야 되니깐 버튼을 각자 따로 만들어줘야한다.
            if self.tableView.isEditing == true {
            addButton.setTitle("추가", for: .normal)
            addButton.addTarget(self, action: #selector(addCond), for: .touchUpInside)
            }
            
        case 2:
            textHeader.text = "혜택"
            //추가버튼 넣기
            if self.tableView.isEditing == true {
            addButton.setTitle("추가", for: .normal)
            addButton.addTarget(self, action: #selector(addBenefit), for: .touchUpInside)
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
    
    //조건을 추가하는 메소드
    @objc func addCond() {
        print("addCond실행됨")
    }
    
    //혜택을 추가하는 메소드
    @objc func addBenefit() {
        print("addBenefit실행됨")
    }
    
    //각 섹션 헤더의 높이를 결정하는 메소드
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
 
    
    
    
}



