//
//  Function.swift
//  SimpleForm
//
//  Created by to4iki on 1/6/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

class Function {
    
    /**
    debounce closure
    
    https://gist.github.com/ShamylZakariya/54ee03228d955f458389
    
    :param: delay
    :param: queue
    :param: action
    */
    class func debounce(delay: NSTimeInterval, queue: dispatch_queue_t, action: (() -> ())) -> (() -> ()) {
        var lastFireTime:dispatch_time_t = 0
        let dispatchDelay = Int64(delay * Double(NSEC_PER_SEC))
        
        return {
            lastFireTime = dispatch_time(DISPATCH_TIME_NOW,0)
            dispatch_after(
                dispatch_time(
                    DISPATCH_TIME_NOW,
                    dispatchDelay
                ),
                queue) {
                    let now = dispatch_time(DISPATCH_TIME_NOW, 0)
                    let when = dispatch_time(lastFireTime, dispatchDelay)
                    if now >= when {
                        action()
                    }
            }
        }
    }
}

typealias SimpleForm = Function
