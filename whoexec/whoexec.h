#pragma once

#import <Foundation/Foundation.h>
#import "EndpointSecurity.h"
#import <string.h>
#import <bsm/libbsm.h>


// Events that will be subscribed
static es_event_type_t events[] = {
    ES_EVENT_TYPE_NOTIFY_EXEC,
};

static int eventsSize = 1;


typedef struct executed {
    NSString* executor;
    pid_t pid;
} Executed;

// WhoExec interface
@interface WhoExec : EndpointSecurity

@property NSString* targetName;
@property bool ok;
@property void (^callback) (Executed*);


- (id) init: (NSString*) target;
- (void) monitor: (void (^)(Executed*))findFileCB;
- (void) handler: (es_client_t*) client withMessage: (const es_message_t*) message;
- (NSString*) getLastError;

@end
