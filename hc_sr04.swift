import SwiftIO


class HC_SR04 {
    var pin_trigger: Id
    var pin_echo: Id
    var trigger: DigitalOut
    var echo: DigitalIn
    var temperature:Double = 19.307
    var start_ns:UInt
    var stop_ns:UInt
    var diff_ns:Int64
    
    
    init(pin_trigger:Id, pin_echo:Id){
        self.pin_trigger = pin_trigger
        self.pin_echo = pin_echo
        self.trigger = DigitalOut(self.pin_trigger)
        self.echo = DigitalIn(self.pin_echo, mode:.pullDown)
        self.start_ns = 0
        self.stop_ns = 0
        self.diff_ns = 0
    }
    
    func get_distance() -> Double {
        
        // Make sure trigger is low to begin with
        trigger.write(false)
        wait(us: 2)
        
        // Hold trigger high for 10 microseconds
        trigger.write(true)
        wait(us:10)
        trigger.write(false)
        
        var timeout = 1000
        
        while(echo.read() == false){
            timeout -= 1
            if (timeout == 0x00) {
                print("Echo timeout")
				return -1.0
			}
            wait(us: 1)
        }
        
        // Start timing
        start_ns = getClockCycle()
        
        while(echo.read() == true){
            wait(us: 1)
        }
        
        // stop timing
        stop_ns = getClockCycle()
        print("Getting distance")
        
        if(stop_ns > start_ns){
			diff_ns = cyclesToNanoseconds(start:start_ns, stop:stop_ns)
        
            let diff_us = diff_ns / 1000
            print("Diff_ns", diff_ns, " diff_us ", diff_us)

            var speedOfSoundInCmPerMs:Double = 0.03313 + 0.0000606 * self.temperature
            let distanceCm:Double = Double(diff_us) / 2.0 * speedOfSoundInCmPerMs

            if (distanceCm == 0 || distanceCm > 400) {
                return -1.0
            } else {
                return distanceCm
            }
        } else {
            print("Timing error")
            return -1.0
        }
	}
}