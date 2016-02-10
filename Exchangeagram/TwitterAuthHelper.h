//
//  TwitterAuthHelper.h
//  Exchangeagram
//
//  Created by Jonathan Kilgore on 2/10/16.
//  Copyright © 2016 CJM Inc. All rights reserved.
//

#import <Firebase/Firebase.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>


@interface TwitterAuthHelper : NSObject

@property (strong, nonatomic) ACAccountStore *store;
@property (strong, nonatomic) Firebase *ref;
@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NSArray *accounts;

- (id) initWithFirebaseRef:(Firebase *)ref apiKey:(NSString *)apiKey;

// Step 1a
- (void) selectTwitterAccountWithCallback:(void (^)(NSError *error, NSArray *accounts))callback;

// Step 1b through 3:
- (void) authenticateAccount:(ACAccount *)account withCallback:(void (^)(NSError *error, FAuthData *authData))callback;

@end

typedef NS_ENUM(NSInteger, AuthHelperError) {
    AuthHelperErrorAccountAccessDenied = -1,
    AuthHelperErrorOAuthTokenRequestDenied = -2
};
