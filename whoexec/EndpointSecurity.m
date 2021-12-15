#import "EndpointSecurity.h"

@implementation EndpointSecurity

- (bool) subscribeClient:(es_event_type_t*) subs withSize: (int)n  andHandler:(es_handler_block_t)handler {
    self.esClient = NULL;
    es_new_client_result_t newClientResult = es_new_client(&_esClient, handler);
    bool ok = newClientResult == ES_NEW_CLIENT_RESULT_SUCCESS;
    
    if (!ok) {
        // Error handler
        switch (newClientResult) {
            case ES_NEW_CLIENT_RESULT_ERR_NOT_PRIVILEGED:
                _lastError = @"Extension is not running as root!";
                break;
            case ES_NEW_CLIENT_RESULT_ERR_NOT_ENTITLED:
                _lastError = @"Extesion is missing entitlement.";
                break;
            case ES_NEW_CLIENT_RESULT_ERR_NOT_PERMITTED:
                _lastError = @"Not permitted to execute!";
                break;
            case ES_NEW_CLIENT_RESULT_ERR_TOO_MANY_CLIENTS:
                _lastError = @"Exceeded the maximum of simultaneously-connected ES clients.";
                break;
            case ES_NEW_CLIENT_RESULT_ERR_INVALID_ARGUMENT:
                _lastError = @"Invalid argument to es_new_client(); client or handler was null.";
                break;
            case ES_NEW_CLIENT_RESULT_ERR_INTERNAL:
                _lastError = @"Failed to connect to the Endpoint security subsystem.";
                break;
        }
        
        return ok;
    }
        
    ok = ES_RETURN_SUCCESS == es_subscribe(_esClient, subs, n);

    return ok;
}

@end
