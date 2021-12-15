#pragma once

#import <Foundation/Foundation.h>
#import <EndpointSecurity/EndpointSecurity.h>

@interface EndpointSecurity : NSObject

@property es_client_t* esClient;
@property NSString* lastError;

- (bool) subscribeClient: (es_event_type_t[]) subs withSize: (int)n  andHandler:(es_handler_block_t)handler;
@end
