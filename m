Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4E3810A3.4010508@analog.com>
Date: Tue, 2 Aug 2011 16:58:43 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: IIO: Interface for capacitance inputs (and outputs)
References: <4E36E0B7.3070900@cam.ac.uk> <4E37B12E.3030206@analog.com> <4E37BE2B.80002@cam.ac.uk>
In-Reply-To: <4E37BE2B.80002@cam.ac.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 08/02/2011 11:06 AM, Jonathan Cameron wrote:
> On 08/02/11 09:11, Michael Hennerich wrote:
>> On 08/01/2011 07:21 PM, Jonathan Cameron wrote:
>>> Hi Michael / All,
>>>
>>> We have a quite a few capacitance drivers. They are all simple and so
>>> would be easy to clean up, except for the fact that we don't have an =
abi
>>> for them.
>>>
>>> So lets make one up. How about the following?  Main choice is the uni=
ts...
>>> Doing it with Farads leaves us with a lot of needed decimal places, b=
ut then
>>> we need a lot anyway for these so what the heck.  We are going to nee=
d those
>>> types with holes in them..
>> Hi Jonathan,
>>
>> These devices typically feature an single digit pF input range(2..8 pF=
).
>> Going with a scale in Farads is probably not going to work.
>> What do you mean by types with holes in them?
> IIO_VAL_INT_PLUS_FEMTO where FEMTO bit has maximum of 999999999  Thus t=
here are quite a
> few leading zeros.
The part has a full range of +/- 4.096pf and it is a 24-bit converter.
We like to store the conversion result as 3-byte direct readings from=20
the device result register.

Thus the Farad scale would need to be
8.192E-12 / 2^24 =3D 4.8828125E-19 =3D 0.00000000000000000048828125.

I don't think this makes any sense?

>> We need something scanf() and friends can eat...
> Yup.
>> In addition we have enough scale bits before the decimal point as well=
.
> Please give an example why. Do we have a calibscale type attribute here=
?
I don't understand, why calibscale would matter here?

But sure we have a in_capacitanceY_scale.
If we say the in_capacitanceY_scale targets pF.

Then we still need enough fractional digits, due to the 24-bit nature of=20
the device.

Now not talking about this part, maybe something that can measure ranges=20
up to 1mF
- which is quite a huge capacitance.
If the scale targets pF, then we actually use the pre-decimal point=20
positions we have.


>> I would make the scale targeting pF of uF.
> I thought about that but then we are back to having a fairly illogical =
set of
> units for the different types of devices.
That's in the nature of these units.
1V, 1A is pretty common 1F is not.
Either move to an floating point exponential notation, or balance the=20
scale somewhere in the middle.

>>
>>> What:           /sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
>>> What:           /sys/bus/iio/devices/iio:deviceX/out_capacitanceY_raw
>>> What:           /sys/bus/iio/devices/iio:deviceX/in_capacitanceY-capa=
citanceZ_raw
>>> KernelVersion:  3.1
>>> Contact:        linux-iio@vger.kernel.org
>>> Description:
>>>                   Raw (unscaled no bias removal etc) capacitance valu=
e from/to
>>>                   channel Y. After application of _offset and _scale,=
 units will
>>>                   be Farads.
>>>
>>> Additional entries for:
>>>
>>> What:           /sys/bus/iio/devices/iio:deviceX/in_capacitanceY_offs=
et
>>> What:           /sys/bus/iio/devices/iio:deviceX/in_capacitanceY_scal=
e
>>>
>>>
>>> With the ad7745 the capdac does seem to be available off chip.
>> Why do you think the CAPDAC is off-chip on the AD7745?
>> The CAPDAC can be seen as a negative capacitance connected internally
>> to the Cin pin.
> Oops. That was meant to be doesn't not does... Sorry for the confusion.
>>>    If I understand
>>> their use correctly it could just be treated as a _calibbias paramete=
rs?
>> Yes - it can be seen as a bias - however why do you have out_capacitan=
ceY_raw then?
> :) Because I hadn't looked at the datasheet properly when I wrote that =
bit and forgot
> to go back and edit it.  This really wasn't my most coherent email ever=
.  Google isn't
> feeding me any digital to capacitance devices so looks like the output =
side of things
> is irrelevant.
>>> (the complexity being that there are two..)
>> Yes - one for each Cin(+|-) pin.
>> More tricky on the AD7746, since there are only two CAPDACs for two Ci=
n(+|-) pin pairs.
> As you state below that you tend to save and restore the zero offset, c=
an we not do the
> same with the capdac values?  If so they can be treated from a userspac=
e point of view
> as completely independent.
Sure
>>>     Naturally there is also a
>>> calibration register so this gets somewhat tricky...
>> The calibration register typically holds the zero-scale calibration co=
efficient.
>> It's automatically updated following the capacitance offset calibratio=
n.
>> Tricky here is that there is only one on the AD7746, so the values mus=
t be saved
>> and restored when switching between the input pairs.
>>
>>> Is there an optimum
>>> combination for a given desire measurement range?
>>>
>>>
>> Yes there is - large offsets>  1 pF should be eliminated by the CAPDAC=
s.
> Fair enough.  So what is the conclusion for what interface elements we
> actually need to control this?
Let me think about this a bit more.

>> from the datasheet:
>>
>> CAPACITIVE SYSTEM OFFSET CALIBRATION The capacitive offset is
>> dominated by the parasitic offset in the application, such as the
>> initial capacitance of the sensor, any parasitic capacitance of
>> tracks on the board, and the capacitance of any other connections
>> between the sensor and the CDC. Therefore, the AD7745/AD7746 are not
>> factory calibrated for capacitive offset. It is the user=92s
>> responsibility to calibrate the system capacitance offset in the
>> application. Any offset in the capacitance input larger than =B11 pF
>> should first be removed using the on-chip CAPDACs. The small offset
>> within =B11 pF can then be removed by using the capacitance offset
>> calibration register. One method of adjusting the offset is to
>> connect a zero-scale capacitance to the input and execute the
>> capacitance offset calibration mode. The calibration sets the
>> midpoint of the =B14.096 pF range (that is, Output Code 0x800000) to
>> that zero-scale input. Another method would be to calculate and write
>> the offset cali-bration register value, the LSB is value 31.25 aF
>> (4.096 pF/217). The offset calibration register is reloaded by the
>> default value at power-on or after reset. Therefore, if the offset
>> calibration is not repeated after each system power-up, the
>> calibration coefficient value should be stored by the host controller
>> and reloaded as part of the AD7745/AD7746 setup. On the AD7746, the
>> register is shared by the two capacitive channels. If the capacitive
>> channels need to be offset calibrated individually, the host
>> controller software should read the AD7746 capacitive offset
>> calibration register values after performing the offset calibration
>> on individual channels and then reload the values back to the AD7746
>> before executing a conversion on a different channel.
>>> All comments welcom.
>>> Jonathan
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
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
