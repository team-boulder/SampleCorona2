//
//
// Copyright (c) 2015 Fyber. All rights reserved.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FYBTPNValidationresult) {
    FYBTPNValidationNoVideoAvailable,
    FYBTPNValidationNoSdkIntegrated,
    FYBTPNValidationTimeout,
    FYBTPNValidationNetworkError,
    FYBTPNValidationDiskError,
    FYBTPNValidationError,
    FYBTPNValidationSuccess
};

NSString *FYBTPNValidationresultToString(FYBTPNValidationresult validationresult);

typedef NS_ENUM(NSInteger, FYBTPNVideoEvent) {
    FYBTPNVideoEventStarted,
    FYBTPNVideoEventAborted,
    FYBTPNVideoEventFinished,
    FYBTPNVideoEventClosed,
    FYBTPNVideoEventNoVideo,
    FYBTPNVideoEventTimeout,
    FYBTPNVideoEventNoSdk,
    FYBTPNVideoEventError
};

NSString *FYBTPNVideoEventToString(FYBTPNVideoEvent event);

typedef void (^FYBTPNValidationresultBlock)(NSString *tpnKey, FYBTPNValidationresult validationresult);
typedef void (^FYBTPNVideoEventsHandlerBlock)(NSString *tpnKey, FYBTPNVideoEvent event);
