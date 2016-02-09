//
//  DeveloperAuthenticationProvider.swift
//  Spotdrop
//
//  Created by Erik Koebke on 1/11/16.
//  Copyright © 2016 Erik Koebke. All rights reserved.
//

import Foundation

class SpotdropIdentityProvider: AWSAbstractIdentityProvider {
    // store the token retrieved from our custom authentication system
    var _token: String!
    
    /*
        stores key which is the domain of the login provider and value which is OAuth/OpenId Connect token
        that results from an authentication with that provider. In our case, developer and Facebook.
    */
    var _logins: [NSObject : AnyObject]!
    
    var username: String?
    var password: String?
    
    // token (retrieved from custom authentication system) getter
    override var token: String {
        get {
            return _token
        }
    }
    
    // logins (which systems the user has been authenticated by)
    override var logins: [ NSObject : AnyObject ]! {
        get {
            return _logins
        }
        
        set {
            _logins = newValue!
        }
    }
    
    // get the identityId for this provider (developer/our identity)
    override func getIdentityId() -> AWSTask! {
        // return user identityId if we already have it
        if (self.identityId != nil) {
            return AWSTask(result: self.identityId)
        }
        // retrieve and return authorization/identityId for our user
        else {
            return AWSTask(result: nil).continueWithBlock({ (task) -> AnyObject! in
                return self.refresh()
            })
        }
    }
    
    // TODO: retrieve authorization for our user - if authorized, update the logins and token properties
    override func refresh() -> AWSTask! {
        return AWSTask()
    }
    
}