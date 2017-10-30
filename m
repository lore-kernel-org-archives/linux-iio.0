Return-Path: <SRS0=BmL3=B5=axentia.se=peda@kernel.org>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Jonathan Cameron <jic23@kernel.org>
From: Peter Rosin <peda@axentia.se>
Subject: Battery temperature
Message-ID: <fd2a5fff-de60-fd71-cc91-198ff2565d4b@axentia.se>
Date: Mon, 30 Oct 2017 09:26:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

Hi!

We have a device with a series of rechargeable batteries.

The chargers are bq24725 and the batteries have a thermistor
for temperature monitoring. This thermistor is connected to
a standard adc component (ads1015). This means that the value
the kernel knows for the temperature is in volts (from the
iio driver). We can also monitor the charging current and the
battery voltage for each battery/charger (also with that very
same adc). A gpio pin indicates if external AC power is present.
This gpio pin has to be polled, i.e. it is not possible to hook
up interrupts for it.

We currently have this "working" without the concept of neither
battery nor charger manager in the kernel. It is all handled
from user space by writing to

    /sys/class/power_supply/bq24735@<i2c-bus-and-addr>/status

to en-/disable charging and by monitoring the adc voltages
and doing the unit conversion to degrees Celsius in user space.

IIUC, ideally there should be in-kernel charger-managers and
battery objects for each charger/battery.

I wonder if there is any existing way to do the non-linear
conversion from the iio-adc volt-reading of the thermistor to
the desired unit of degrees-celsius, or if I need to write
something myself?

I do see the generic-adc-battery driver, which sounds about
right, but it has no DT binding and it also has its
cal_charge() callback which is presumably difficult to handle
from DT? We have no way to get at the battery charge level,
short of inaccurate guesses based on the battery voltage. The
driver also appears to have no concept of battery temperature,
but I suppose it could be extended with that? Not sure if it's
even applicable, I'm fumbling...

I may have completely misunderstood how this is supposed to be
hooked up in an ideal world.

Cheers,
Peter
