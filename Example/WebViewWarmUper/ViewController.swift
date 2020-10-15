//
//  Created by Timur Bernikovich on 07/03/2019.
//  Copyright © 2019 Timur Bernikovich. All rights reserved.
//

import UIKit

struct WebViewControllerConfiguration {
    let title: String
    let warmUp: Bool

    func createWebViewController() -> UIViewController {
        let controller = WebViewController(warmUp: warmUp)
        controller.title = title
        return controller
    }
}

class ViewController: UIViewController {

    let tableView = UITableView(frame: .zero, style: .plain)
    let configurationCollection: [WebViewControllerConfiguration] = {
        var collecton: [WebViewControllerConfiguration] = []
        
        collecton.append(WebViewControllerConfiguration(title: "WKWebView", warmUp: false))
        collecton.append(WebViewControllerConfiguration(title: "WKWebView + WarmUper", warmUp: true))

        return collecton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configurationCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = configurationCollection[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(configurationCollection[indexPath.row].createWebViewController(), animated: true)
    }
}
