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
    var memo: String?
    
    //디비의 conditions 테이블에서 가져오는 자료형
    var conditionList: [String?]!
    //디비의 shop_adv_res 테이블에서 가져오는 자료형
    var SARList: [(String?, String?, String?)]!
    
    //DAO객체
    let cardDAO = CardDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //디비에서 데이터 가져오기
        self.conditionList = self.cardDAO.findCondition(cardId: cardId!)
        self.SARList = self.cardDAO.findSAR(cardId: cardId!)
        
    }
    
    
    
    
    //화면이 나타날때마다 호출되는 메소드
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    
    //테이블 행을 구성하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "benefitCell")
            }
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
        }
    }
    //테이블의 특정 행이 선택되었을때 호출되는 메소드
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        <#code#>
    }
 
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
        //섹션에 따라 타이틀 다르게 설정
        switch section {
        case 0:
            textHeader.text = "메모"
        case 1:
            textHeader.text = "카드사용조건"
        case 2:
            textHeader.text = "혜택"
        default:
            textHeader.text = "KissMyAss"
        }
        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        v.backgroundColor = UIColor(red: 0.93, green: 0.96, blue: 0.99, alpha: 1.0)
        v.addSubview(textHeader)
        
        
        return v
    }
    //각 섹션 헤더의 높이를 결정하는 메소드
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
 
}
