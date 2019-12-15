//
//  DetailWebViewController.swift
//  SearchGithubUserApp
//
//  Created by 市川星磨 on 2019/12/16.
//  Copyright © 2019 市川 星磨. All rights reserved.
//

import UIKit
import WebKit

class DetailWebViewController: UIViewController {

    public var url: URL?
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = url
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}

extension DetailWebViewController: WKNavigationDelegate {
    
}

extension DetailWebViewController: WKUIDelegate {
    
}
