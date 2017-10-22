// @author: Aadit Kapoor
// @version: StackAlpa (ver1.0)

import Foundation
import Kanna
import os
import SwiftyJSON
/**
 Scrapes the stackoverflow answer from the given url.
 */
public class Scraper {
    
    /// The given url
    var url: URL!
    
    /// Title of the question
    var questionTitle: String!
    
    /// The first answer on the website
    var firstAnswer: String!
    
    init(forUrl: String) {
        if let tUrl = Foundation.URL(string: forUrl) {
            self.url = tUrl
        } else {
            self.url = nil
            if #available(iOS 10.0, *) {
                os_log("ERROR: Invalid URL!")
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    
    /**
     A function that scrapes the **FIRST ANSWER** from the given url.
     - parameter completion:  Callback provided when request is completed, contains one the question and the answer.
     - note: You call this method when you have attained all the urls from the main API.
     - returns: ()
     */
    func scrape(completion:@escaping (String, String) -> Void) {
        if self.url != nil {
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                
                if let data = data {
                    let html = String(data: data, encoding: .utf8)
                    
                    if let doc = HTML(html: html!, encoding: .utf8) {
                        self.questionTitle = doc.title!
                        
                        for i in doc.xpath("//div") {
                            if i.className == "answer" {
                                self.firstAnswer = i.text!
                                debugPrint(SuccessMessages.fetchedAnswer.rawValue)
                            }
                        }
                        
                        completion(self.questionTitle, self.firstAnswer.trimmingCharacters(in: .whitespacesAndNewlines))
                    } else {
                        if #available(iOS 10.0, *) {
                            os_log("Parsing error!")
                        } else {
                            // Fallback on earlier versions
                        }
                        debugPrint(ErrorMessages.parsedError.rawValue)
                    }
                } else {
                    if #available(iOS 10.0, *) {
                        os_log("Error: URLSession!")
                    } else {
                        // Fallback on earlier versions
                    }
                }
                }.resume()
        } else {
            completion("error", "error")
        }
    }
    
    func getAnswerText() -> String {
        // Perform sanitize the answer
        return self.firstAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
        
    }
}
/**
 Access the StackOverFlow API to get urls of the questions asked from the given query.
 */
public class StackOverFlowAnswerAPI {
    
    /// The query provided by you.
    var query: String!
    
    /// Computed prop from the query
    var mainUrl: String {
        return "https://api.stackexchange.com/2.2/search/advanced?order=desc&sort=activity&site=stackoverflow&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&answers=3"
    }
    
    /// Final url made after encoding and all.
    var url: URL!
    
    
    /// Intializes the class with a query
    init(query: String) {
        self.query = query
        if let u = Foundation.URL(string: self.mainUrl) {
            self.url = u
        } else {
            if #available(iOS 10.0, *) {
                os_log("URL Formed Error!")
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    /**
     A function that get the possbile question urls from the given query.
     - parameter completion:  Callback provided when request is completed, contains **StackData**.
     - note: This class is a direct interface to the StackOverFlow API.
     */
    func getPossibleQuestions(completion: @escaping ([StackData]) -> Void) {
        var stackData: [StackData] = []
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if data != nil {
                let json = JSON(data: data!)
                
                let items = json.dictionary!["items"]?.array
                for item in items! {
                    if item["answer_count"].intValue > 1 {
                        stackData.append(StackData(title: item["title"].stringValue, url: item["link"].stringValue))
                    }
                }
                completion(stackData)
            } else {
                completion([StackData(title: "No internet connection.", url: "No internet Connection")])
            }
            
            }.resume()
    }
}


