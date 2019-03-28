extension URL {
    /**
     Check if the device is proxied for the current URL.
     - Note: Simple security check to be used before performing sensitive network requests.
     */
    var isProxied: Bool {
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() else { return false }
        guard let proxies = CFNetworkCopyProxiesForURL(self as CFURL, proxySettings).takeUnretainedValue() as? [[AnyHashable: Any]] else { return false }
        
        // if a proxy exists that isn't "none" then log it and return true
        for proxy in proxies {
            guard let proxyType = proxy[kCFProxyTypeKey] as? String else { continue }
            guard (proxyType as CFString) != kCFProxyTypeNone else { continue }
            #if DEBUG
            print("Proxy Found: \(proxy))")
            #endif
            return true
        }
        
        return false
    }
}

// Obj-C pass through
extension NSURL {
    /**
     Check if the device is proxied for the current URL.
     - Note: Simple security check to be used before performing sensitive network requests.
     */
    @objc(isProxied) var _isProxied: Bool {
        return (self as URL).isProxied
    }
}
