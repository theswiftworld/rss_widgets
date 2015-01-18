//
//  NewsItem.swift
//  googleNews
//
//  Created by mengxiangping on 12/26/14.
//  Copyright (c) 2014 gl9. All rights reserved.
//

import Foundation
import Alamofire

class NewsItem {
    
    var title:String?
    var link:String?
    var pubDate:String?
    var description:String?
    var thumbnail:String?
    
    init(title:String, link:String,pubDate:String,description:String, thumbnail:String){
        
        self.title = title
        self.link = link
        self.pubDate = pubDate
        self.description = description
        self.thumbnail = thumbnail
        
    }
    
    class func getNews(completionHandler: (Array<NewsItem>) -> Void) {
        
        var url:String = "http://feeds.bbci.co.uk/news/rss.xml"
        
        Alamofire.request(.GET, url).responseString { (_, _, string, err) in
            
            if(err != nil){
                print(err?.debugDescription)
            }
            
            var error: NSError?
            
            if let xmlData:NSData = string?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true){
                
                if let xmlDoc = AEXMLDocument(xmlData: xmlData, error: &error) {
                    
                    var resultNewsList:Array<NewsItem> = Array()
                    
                    for item in xmlDoc.rootElement["channel"]["item"].all {
                        
                        var newsTitle:String = item["title"].value
                        var newsLink:String = item["link"].value
                        var newsPubDate:String = item["pubDate"].value
                        var newsDescription:String = item["description"].value
                        var thumbnail:String = item["media:thumbnail"].all[1].attributes["url"] as String
                        
                        var newsItem:NewsItem = NewsItem(title: newsTitle, link: newsLink, pubDate: newsPubDate, description: newsDescription, thumbnail:thumbnail)
                        resultNewsList.append(newsItem)
                        
                    }

                    completionHandler(resultNewsList)
                    
                }
                
                
            }
            
            
        }
        
    }
    
}