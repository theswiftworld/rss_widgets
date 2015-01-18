//
//  ViewController.swift
//  rsswidget
//
//  Copyright (c) 2015 theswiftworld. All rights reserved.
//

import UIKit
import PKHUD

class ViewController: UIViewController,UIWebViewDelegate {
    
    var webView:UIWebView?
    
    var newsUrl:String?
    
    override func viewDidLoad() {
        
        var contentView = HUDContentView.ProgressView()
        HUDController.sharedController.contentView = contentView

        
        self.webView = UIWebView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        self.webView?.delegate = self
        self.view.addSubview(self.webView!)
        
        if(newsUrl != nil){

            self.webView?.loadRequest(NSURLRequest(URL: NSURL(string: newsUrl!)!))
            
        }

    }
    
    func reloadUrl(url:String){
        
        HUDController.sharedController.show()
        self.webView?.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        HUDController.sharedController.hide(animated: true) 
        
    }
    
}

