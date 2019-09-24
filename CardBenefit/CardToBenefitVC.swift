//
//  CardToBenefitVC.swift
//  CardBenefit
//
//  Created by Bono b Bono on 16/09/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

class CardToBenefitVC: UITableViewController {
    
    
    
    

    //상세화면 뷰컨트롤러 인스턴스
    //var uvc: UIViewController?
    //디비의 main 테이블에서 가져오는 자료형
    var cardList: [(Int, String, String?, String?, Int, Int, String?)]!
    //디비의 conditions 테이블에서 가져오는 자료형
    var conditionList: [String?]!
    //디비의 shop_adv_res 테이블에서 가져오는 자료형
    var SARList: [(String?, String?, String?)]!
    
    //DAO객체
    let cardDAO = CardDAO()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.cardList = self.cardDAO.findMain()
        //카드명 셀을 눌렀을때 가져올 뷰컨트롤러를 미리 가져다놓는다
        //uvc = self.storyboard?.instantiateViewController(withIdentifier: "Detail")
    }
    //화면이 나타날때마다 호출되는 메소드
    override func viewWillAppear(_ animated: Bool) {
        //테이블뷰를 리로드하기(새로고침)
        self.tableView.reloadData()
    }
    
    //테이블 행의 개수를 결정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cardList.count
    }
    
    //테이블 행을 구성하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //커스텀타입으로 지정한 셀을 불러온다
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell") as! CardCell
        //해당줄의 데이터 가져온다
        let rowData = self.cardList[indexPath.row]
        //cell안에 데이터를 집어 넣는다.

        //CardVO에 들어있는순서대로 cardId, cardName, image, nickName, traffic, oversea, memo
        //cardName안의 tag속성에 강제로 cardId 값을 담는다
        cell.cardName.tag = rowData.0
        cell.cardName.text = rowData.1
        cell.cardImage?.image = nil //지금당장은 nil값처리해놈 //UIImage(named: rowData.2)
        cell.nickName?.text = rowData.3
        cell.trafficOX.text = (rowData.4 == 0) ? "X" : "O"
        cell.overseaOX.text = (rowData.5 == 0) ? "X" : "O"
        
        return cell
    }
    
    //테이블의 특정 행이 선택되었을때 호출되는 메소드
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /*
        //화면을 전환한 뷰 컨트롤러를 Storyboard ID 정보를 이용하여 읽어와 객채로 생성한다(p3,636)
        if let uvc = self.storyboard?.instantiateViewController(withIdentifier: "Detail"){
            //전달할 데이터를 넘기자
            
            
            //네비게이션컨트롤러를 이용한 화며 전환 실시
            self.navigationController?.pushViewController(uvc, animated: true)
        }
 */
 
        //화면을 전환할 뷰컨트롤러를 직접 생성
        
        //let dvc = DetailBenefitVC() //이따구로 생성하면 잦된다잉. 스토리보드 아이디를 읽어와서 생성하여라
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let dvc = self.storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailBenefitVC //스토리보드 아이디가 디테일임....
        //전달하려는 값을 준다.
        dvc.cardId = self.cardList[indexPath.row].0
        dvc.cardName = self.cardList[indexPath.row].1
        dvc.memo = self.cardList[indexPath.row].6
        //네비게이션컨트롤러를 이용한 화면전환 실시
        self.navigationController?.pushViewController(dvc, animated: true)
        }
 
    
    //테이블 뷰의 섹션의 수 결정하는 메소드 따로 오버라이드 하지 않으면 기본값은 1임
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
