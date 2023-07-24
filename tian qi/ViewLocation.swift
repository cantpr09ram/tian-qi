//
//  ViewLocation.swift
//  tian qi
//
//  Created by bochain on 2023/7/21.
//

import Foundation

class ViewLocation : XMLParser, ObservableObject {
    
    @Published var name: String = "hello"
    @Published var City: String = "新北市"
    @Published var Town: String = " "
    
    
    private var textBuffer: String = ""
    
    override init(data: Data) {
        super.init(data: data)
        self.delegate = self
    }
    
    func fetchLocation(latitude: Double, longitude: Double){
        
        print(latitude, longitude)
        var urlComponents = URLComponents()
   
        urlComponents.host = "api.nlsc.gov.tw"
        urlComponents.scheme = "https"
        urlComponents.path = "/other/TownVillagePointQuery/\(longitude)/\(latitude)"
        
        //print(urlComponents.url)
        guard let url = urlComponents.url else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            if error != nil{
                let errorCode = (error! as NSError).code
                    if errorCode == -1009{
                        DispatchQueue.main.async {
                            print("目前沒有連結網路")
                        }
                    }else{
                        DispatchQueue.main.async {
                           print("發生錯誤！！！")
                        }
                    }
            }
            
            if let data = data{
                    //print("\(self.City) \(self.Town)")
                    DispatchQueue.main.async {
                        let parser = ViewLocation(data: data)
                        print("wawa")
                        //print("\(self.City) \(self.Town)")
                        if parser.parse() {
                            print(parser.City)
                        }else{
                            if let error = parser.parserError {
                                print(error)
                            } else {
                                print("Failed with unknown reason")
                            }
                        }
                    }
                
            } else {
                print("Data is empty")
                return
            }
        }.resume()
        
        print("wowo")
    }
}

extension ViewLocation: XMLParserDelegate {
    // Called when opening tag (`<elementName>`) is found
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        switch elementName {
        case "ctyCode":
            textBuffer = ""
        case "ctyName":
            textBuffer = ""
        case "townCode":
            textBuffer = ""
        case "townName":
            textBuffer = ""
        case "officeCode":
            textBuffer = ""
        case "officeName":
            textBuffer = ""
        case "sectName":
            textBuffer = ""
        case "sectCode":
            textBuffer = ""
        case "villageCode":
            textBuffer = ""
        case "VillageName":
            textBuffer = ""
        case "townVillageItem":
            textBuffer = ""
                
        default:
            //print("Ignoring \(elementName)")
            break
        }
    }
    
    // Called when closing tag (`</elementName>`) is found
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
            case "ctyName":
                City = textBuffer
                print(City)
                print("getcity")
            case "townName":
                Town = textBuffer
                print(Town)
                print("get town")
            default:
                //print("Ignoring \(elementName)")
                break
        }
        
    }
    // Called when a character sequence is found
        // This may be called multiple times in a single element
        func parser(_ parser: XMLParser, foundCharacters string: String) {
            textBuffer += string
        }
    
    // For debugging
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)
        print("on:", parser.lineNumber, "at:", parser.columnNumber)
    }
    
}

/*
let xmlString = """
<townVillageItem>
    <ctyCode>F</ctyCode>
    <ctyName>新北市</ctyName>
    <townCode>F27</townCode>
    <townName>淡水區</townName>
    <officeCode>FE</officeCode>
    <officeName>淡水</officeName>
    <sectCode>1287</sectCode>
    <sectName>草麓段</sectName>
    <villageCode>65000100013</villageCode>
    <villageName>水源里</villageName>
</townVillageItem>
"""

if let data = xmlString.data(using: .utf8) {
    let xmlParserDelegate = XMLParserDelegate()
    xmlParserDelegate.parseXML(xmlData: data)
}
*/
