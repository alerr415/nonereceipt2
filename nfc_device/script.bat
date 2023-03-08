scp -r raspi/* pi@raspberrypi.local:nonereceipt/
ssh pi@raspberrypi.local "cp -r libnfc/utils/ nonereceipt/; cd nonereceipt; make; ./emulate"