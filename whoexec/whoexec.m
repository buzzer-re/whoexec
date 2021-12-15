#import "whoexec.h"

@implementation WhoExec

@synthesize targetName;
@synthesize ok;


- (id) init: (NSString*) target {
    self = [super init];
    self.callback = NULL;
    self.ok = [super subscribeClient:events withSize:eventsSize andHandler:^(es_client_t *client, const es_message_t* message) {
        // Forward
        if (!self.callback) return;
        
        [self handler:client withMessage:message];
    }];
    self.targetName = target;
    return self;
}


- (void) monitor:(void (^)(Executed*))findFileCB {
    self.callback = findFileCB;
    [[NSRunLoop currentRunLoop] run];
}

- (void) handler:(es_client_t *)client withMessage:(const es_message_t *)message {
    es_process_t* process = message->process;
    if (process->is_es_client) return;
    
    NSString* path;
    pid_t execPid = audit_token_to_pid(process->audit_token);
    es_event_exec_t exec;
    
    if (message->event_type == ES_EVENT_TYPE_NOTIFY_EXEC) {
        exec = message->event.exec;
        path = [[NSString alloc] initWithUTF8String:exec.target->executable->path.data];
        
        if (![targetName isEqual:[path lastPathComponent]]) return;
        
        Executed executed = {
            .executor = [[NSString alloc] initWithUTF8String: process->executable->path.data],
            .pid = execPid
        };
        
        self.callback(&executed);
        
    }
}


- (NSString*) getLastError {
    return self.lastError;
}
@end
