//
//  Created by Timur Bernikovich on 07/03/2019.
//  Copyright © 2019 Timur Bernikovich. All rights reserved.
//

import WebKit
import UIKit

public protocol WarmUpable {
    func warmUp()
}

public class WarmUper<Object: WarmUpable> {
    
    private let creationClosure: () -> Object
    private var warmedUpObjects: [Object] = []
    public var numberOfWamedUpObjects: Int = 5 {
        didSet {
            prepare()
        }
    }
    
    public init(creationClosure: @escaping () -> Object) {
        self.creationClosure = creationClosure
        prepare()
    }
    
    public func prepare() {
        while warmedUpObjects.count < numberOfWamedUpObjects {
            let object = creationClosure()
            object.warmUp()
            warmedUpObjects.append(object)
        }
    }
    
    private func createObjectAndWarmUp() -> Object {
        let object = creationClosure()
        object.warmUp()
        return object
    }
    
    public func dequeue() -> Object {
        let warmedUpObject: Object
        if let object = warmedUpObjects.first {
            warmedUpObjects.removeFirst()
            warmedUpObject = object
        } else {
            warmedUpObject = createObjectAndWarmUp()
        }
        prepare()
        return warmedUpObject
    }
    
}

extension WKWebView: WarmUpable {
    public func warmUp() {
        loadHTMLString("", baseURL: nil)
    }
}

public typealias WKWebViewWarmUper = WarmUper<WKWebView>
public extension WarmUper where Object == WKWebView {
    static let shared = WKWebViewWarmUper(creationClosure: {
        WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    })
}

extension UIWebView: WarmUpable {
    public func warmUp() {
        loadHTMLString("", baseURL: nil)
    }
}

public typealias UIWebViewWarmUper = WarmUper<UIWebView>
public extension WarmUper where Object == UIWebView {
    static let shared = UIWebViewWarmUper(creationClosure: {
        UIWebView()
    })
}
