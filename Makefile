POD=pod
OPEN=open
XCODEGEN=xcodegen

install: 
	$(POD) install

xcodegen:
	$(XCODEGEN) generate

open:
	$(OPEN) ./swift-material-ui-tutorial.xcworkspace
