//
//  ViewLocation.swift
//  tian qi
//
//  Created by bochain on 2023/7/21.
//

import Foundation
/*
class ViewLocation : ObservableObject{
    
    func dowmloadXML(withXMLAddress xmlAddress:String){
        if let url = URL(string: xmlAddress){
            URLSession.shared.dataTask(with: url) { (data, Response, error) in
                if error != nil{
                    let errorCode = (error! as NSError).code
                    if errorCode == -1009{
                        DispatchQueue.main.async {
                            self.showAlert(title: "目前沒有連結網路")
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.showAlert(title: "發生錯誤！！！")
                        }
                    }
                    return
                }
                if let loadData = data{
                    let parser = XMLParser(data: loadData)
                    let rssParserDelegate = RssParserDelegate()
                    parser.delegate = rssParserDelegate
                    if parser.parse() == true{
                        self.news = rssParserDelegate.getResult()
                        DispatchQueue.main.async {
                            self.myTableView.reloadData()
                        }
                    }else{
                        DispatchQueue.main.async {
                            self.showAlert(title: "XML 解析失敗！！！")
                        }
                    }
                }
            }.resume()
        }
    }
    
}
 */
