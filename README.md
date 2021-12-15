# whoexec


Whoexec is a tool that will monitor every `exec` call inside MacOS by using the latest Endpoint Security Framework, with this it's able to detect any execution of a target file.


## Use cases

There are many cases for you to use this, you can use this to trace which process call a unknown binary, trace if a malware will attempt to execute some system command or even to check if your cronjob is running properly.

## Disclaimer

I'm not a professional Apple developer (not even close), so I don't have the necessary entitlements to run this project in machines with SIP enabled, so if you want to use this for research porpuse you must disable SIP (you probably already did this),
then you are ready to go, that's also the reason I will not publish any non signed/notorized binary in this repository.

### Building

First, clone this project:

> git clone git@github.com:AandersonL/whoexec.git

Make sure to have `Xcode` installed in your machine, after this you can:

* Open the project in Xcode and build it inside
* run the following
  * xcodebuild -configuration Debug


## Using & example

For the sake of simpliticy, you just have 1 argument to pass to this tiny tracer, the binary to be monitored:

> sudo ./whoexec ps

Then, after the endpoint security engine start and setup ours handlers, any kind of `exec` call will be logged in the terminal:


