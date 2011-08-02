Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4E37B12E.3030206@analog.com>
Date: Tue, 2 Aug 2011 10:11:26 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: IIO: Interface for capacitance inputs (and outputs)
References: <4E36E0B7.3070900@cam.ac.uk>
In-Reply-To: <4E36E0B7.3070900@cam.ac.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 08/01/2011 07:21 PM, Jonathan Cameron wrote:
> Hi Michael / All,
>
> We have a quite a few capacitance drivers. They are all simple and so
> would be easy to clean up, except for the fact that we don't have an ab=
i
> for them.
>
> So lets make one up. How about the following?  Main choice is the units=
...
> Doing it with Farads leaves us with a lot of needed decimal places, but=
 then
> we need a lot anyway for these so what the heck.  We are going to need =
those
> types with holes in them..

Hi Jonathan,

These devices typically feature an single digit pF input range(2..8 pF).
Going with a scale in Farads is probably not going to work.
What do you mean by types with holes in them?
We need something scanf() and friends can eat...
In addition we have enough scale bits before the decimal point as well.
I would make the scale targeting pF of uF.


> What:           /sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
> What:           /sys/bus/iio/devices/iio:deviceX/out_capacitanceY_raw
> What:           /sys/bus/iio/devices/iio:deviceX/in_capacitanceY-capaci=
tanceZ_raw
> KernelVersion:  3.1
> Contact:        linux-iio@vger.kernel.org
> Description:
>                  Raw (unscaled no bias removal etc) capacitance value f=
rom/to
>                  channel Y. After application of _offset and _scale, un=
its will
>                  be Farads.
>
> Additional entries for:
>
> What:           /sys/bus/iio/devices/iio:deviceX/in_capacitanceY_offset
> What:           /sys/bus/iio/devices/iio:deviceX/in_capacitanceY_scale
>
>
> With the ad7745 the capdac does seem to be available off chip.
Why do you think the CAPDAC is off-chip on the AD7745?
The CAPDAC can be seen as a negative capacitance connected internally
to the Cin pin.

>   If I understand
> their use correctly it could just be treated as a _calibbias parameters=
?
Yes - it can be seen as a bias - however why do you have=20
out_capacitanceY_raw then?
> (the complexity being that there are two..)
Yes - one for each Cin(+|-) pin.
More tricky on the AD7746, since there are only two CAPDACs for two=20
Cin(+|-) pin pairs.

>    Naturally there is also a
> calibration register so this gets somewhat tricky...
The calibration register typically holds the zero-scale calibration=20
coefficient.
It's automatically updated following the capacitance offset calibration.
Tricky here is that there is only one on the AD7746, so the values must=20
be saved
and restored when switching between the input pairs.

> Is there an optimum
> combination for a given desire measurement range?
>
>
Yes there is - large offsets > 1 pF should be eliminated by the CAPDACs.

from the datasheet:

CAPACITIVE SYSTEM OFFSET CALIBRATION
The capacitive offset is dominated by the parasitic offset in the=20
application, such as the initial capacitance of the sensor, any=20
parasitic capacitance of tracks on the board, and the capacitance of any=20
other connections between the sensor and the CDC. Therefore, the=20
AD7745/AD7746 are not factory calibrated for capacitive offset. It is=20
the user=92s responsibility to calibrate the system capacitance offset in=
=20
the application.
Any offset in the capacitance input larger than =B11 pF should first be=20
removed using the on-chip CAPDACs. The small offset within =B11 pF can=20
then be removed by using the capacitance offset calibration register.
One method of adjusting the offset is to connect a zero-scale=20
capacitance to the input and execute the capacitance offset calibration=20
mode. The calibration sets the midpoint of the =B14.096 pF range (that is=
,=20
Output Code 0x800000) to that zero-scale input.
Another method would be to calculate and write the offset cali-bration=20
register value, the LSB is value 31.25 aF (4.096 pF/217).
The offset calibration register is reloaded by the default value at=20
power-on or after reset. Therefore, if the offset calibration is not=20
repeated after each system power-up, the calibration coefficient value=20
should be stored by the host controller and reloaded as part of the=20
AD7745/AD7746 setup.
On the AD7746, the register is shared by the two capacitive channels. If=20
the capacitive channels need to be offset calibrated individually, the=20
host controller software should read the AD7746 capacitive offset=20
calibration register values after performing the offset calibration on=20
individual channels and then reload the values back to the AD7746 before=20
executing a conversion on a different channel.
> All comments welcom.
>
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--=20
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
