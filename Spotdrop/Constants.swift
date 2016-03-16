//
//  Constants.swift
//  Spotdrop
//
//  Created by Erik Koebke on 1/11/16.
//  Copyright © 2016 Erik Koebke. All rights reserved.
//

import Foundation

struct Constants {
    struct Cognito {
        static var cognitoIdentityPoolName = "Spotdrop"
        static var cognitoIdentityPoolId = "us-east-1:c8fb3253-1817-47d2-93f0-7ece2e2c1386"
        static var cognitoIdentityPoolARN = "arn:aws:cognito-identity:us-east-1:078269667943:identitypool/us-east-1:c8fb3253-1817-47d2-93f0-7ece2e2c1386"
    }

    struct DynamoDb {
        static var userTableName = "user"
        static var dynamoDbUserTableARN = "arn:aws:dynamodb:us-east-1:078269667943:table/user"
    }
   
}
