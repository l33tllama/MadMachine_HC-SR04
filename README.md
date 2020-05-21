# HC-SR04 Library for MadMachine
This is a single file library that you can add to your MadMachine project. Just copy and paste the hc_sr04.swift file into your projects Source directory.

## Usage Notes
**You will need a voltage level converter** to get correct readings from the HC-SR04 module, as it runs at 5V and the MadMachine runs at 3.3V. Usually, a simple resistor on the echo pin should fix it, but it doesn't seem to. 

## Example Code
```Swift
let pin_trigger = Id.D11
let pin_echo = Id.D10

let hc_sr04 = HC_SR04(pin_trigger:pin_trigger, pin_echo:pin_echo)

let distance:Double = hc_sr04.get_distance()

```

