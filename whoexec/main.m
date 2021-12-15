#import <Foundation/Foundation.h>
#import "whoexec.h"


int main(int argc, const char * argv[]) {
    int exitCode = EXIT_SUCCESS;
    if (argc < 2) {
        fprintf(stderr, "Usage: %s EXECUTABLE_FILE\n", argv[0]);
        exitCode = EXIT_FAILURE;
        goto bye;
        
    }
    
    @autoreleasepool {
                
        NSString* target = [[NSString alloc] initWithUTF8String:argv[1]];
        WhoExec* execTracer = [[WhoExec alloc] init: target];
        
        if (execTracer.ok) {
            NSLog(@"Monitoring exec calls...");
            [execTracer monitor:^(Executed* executed) {
                NSLog(@"%@ was executed by %@ PID: %d\n", target, executed->executor, executed->pid);
            }];

        } else {
            NSString* error = [execTracer getLastError];
            NSLog(@"Error: %@\n", error);
            
        }
    }
bye:
    return 0;
}
