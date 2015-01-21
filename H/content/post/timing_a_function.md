+++
date = "2015-01-18T20:56:26+01:00"
draft = true
title = "Timing a function using defer"

+++
Timing a function using defer 






    func timed(start time.Time, name string) {
    elapsed := time.Since(start)
    log.Printff("%s took %s", name, elapsed)
    }

    and later:

    func myfunction () {
    defer timed(time.Now(), "myfunction")
    ...
    }


you can use this feature to dump runtime statistics :-)
