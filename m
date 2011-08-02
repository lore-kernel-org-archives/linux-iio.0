Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:41443 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269Ab1HBI6v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Aug 2011 04:58:51 -0400
Message-ID: <4E37BE2B.80002@cam.ac.uk>
Date: Tue, 02 Aug 2011 10:06:51 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: IIO: Interface for capacitance inputs (and outputs)
References: <4E36E0B7.3070900@cam.ac.uk> <4E37B12E.3030206@analog.com>
In-Reply-To: <4E37B12E.3030206@analog.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/02/11 09:11, Michael Hennerich wrote:
> On 08/01/2011 07:21 PM, Jonathan Cameron wrote:
>> Hi Michael / All,
>>
>> We have a quite a few capacitance drivers. They are all simple and s=
o
>> would be easy to clean up, except for the fact that we don't have an=
 abi
>> for them.
>>
>> So lets make one up. How about the following?  Main choice is the un=
its...
>> Doing it with Farads leaves us with a lot of needed decimal places, =
but then
>> we need a lot anyway for these so what the heck.  We are going to ne=
ed those
>> types with holes in them..
>=20
> Hi Jonathan,
>=20
> These devices typically feature an single digit pF input range(2..8 p=
=46).
> Going with a scale in Farads is probably not going to work.
> What do you mean by types with holes in them?
IIO_VAL_INT_PLUS_FEMTO where FEMTO bit has maximum of 999999999  Thus t=
here are quite a
few leading zeros.
> We need something scanf() and friends can eat...
Yup.
> In addition we have enough scale bits before the decimal point as wel=
l.
Please give an example why. Do we have a calibscale type attribute here=
?
> I would make the scale targeting pF of uF.
I thought about that but then we are back to having a fairly illogical =
set of
units for the different types of devices.
>=20
>=20
>> What:           /sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
>> What:           /sys/bus/iio/devices/iio:deviceX/out_capacitanceY_ra=
w
>> What:           /sys/bus/iio/devices/iio:deviceX/in_capacitanceY-cap=
acitanceZ_raw
>> KernelVersion:  3.1
>> Contact:        linux-iio@vger.kernel.org
>> Description:
>>                  Raw (unscaled no bias removal etc) capacitance valu=
e from/to
>>                  channel Y. After application of _offset and _scale,=
 units will
>>                  be Farads.
>>
>> Additional entries for:
>>
>> What:           /sys/bus/iio/devices/iio:deviceX/in_capacitanceY_off=
set
>> What:           /sys/bus/iio/devices/iio:deviceX/in_capacitanceY_sca=
le
>>
>>
>> With the ad7745 the capdac does seem to be available off chip.
> Why do you think the CAPDAC is off-chip on the AD7745?
> The CAPDAC can be seen as a negative capacitance connected internally
> to the Cin pin.
Oops. That was meant to be doesn't not does... Sorry for the confusion.
>=20
>>   If I understand
>> their use correctly it could just be treated as a _calibbias paramet=
ers?
> Yes - it can be seen as a bias - however why do you have out_capacita=
nceY_raw then?
:) Because I hadn't looked at the datasheet properly when I wrote that =
bit and forgot
to go back and edit it.  This really wasn't my most coherent email ever=
=2E  Google isn't
feeding me any digital to capacitance devices so looks like the output =
side of things
is irrelevant.
>> (the complexity being that there are two..)
> Yes - one for each Cin(+|-) pin.
> More tricky on the AD7746, since there are only two CAPDACs for two C=
in(+|-) pin pairs.
As you state below that you tend to save and restore the zero offset, c=
an we not do the
same with the capdac values?  If so they can be treated from a userspac=
e point of view
as completely independent.=20
>=20
>>    Naturally there is also a
>> calibration register so this gets somewhat tricky...
> The calibration register typically holds the zero-scale calibration c=
oefficient.
> It's automatically updated following the capacitance offset calibrati=
on.
> Tricky here is that there is only one on the AD7746, so the values mu=
st be saved
> and restored when switching between the input pairs.
>=20
>> Is there an optimum
>> combination for a given desire measurement range?
>>
>>
> Yes there is - large offsets > 1 pF should be eliminated by the CAPDA=
Cs.
=46air enough.  So what is the conclusion for what interface elements w=
e
actually need to control this?
>=20
> from the datasheet:
>=20
> CAPACITIVE SYSTEM OFFSET CALIBRATION The capacitive offset is
> dominated by the parasitic offset in the application, such as the
> initial capacitance of the sensor, any parasitic capacitance of
> tracks on the board, and the capacitance of any other connections
> between the sensor and the CDC. Therefore, the AD7745/AD7746 are not
> factory calibrated for capacitive offset. It is the user=92s
> responsibility to calibrate the system capacitance offset in the
> application. Any offset in the capacitance input larger than =B11 pF
> should first be removed using the on-chip CAPDACs. The small offset
> within =B11 pF can then be removed by using the capacitance offset
> calibration register. One method of adjusting the offset is to
> connect a zero-scale capacitance to the input and execute the
> capacitance offset calibration mode. The calibration sets the
> midpoint of the =B14.096 pF range (that is, Output Code 0x800000) to
> that zero-scale input. Another method would be to calculate and write
> the offset cali-bration register value, the LSB is value 31.25 aF
> (4.096 pF/217). The offset calibration register is reloaded by the
> default value at power-on or after reset. Therefore, if the offset
> calibration is not repeated after each system power-up, the
> calibration coefficient value should be stored by the host controller
> and reloaded as part of the AD7745/AD7746 setup. On the AD7746, the
> register is shared by the two capacitive channels. If the capacitive
> channels need to be offset calibrated individually, the host
> controller software should read the AD7746 capacitive offset
> calibration register values after performing the offset calibration
> on individual channels and then reload the values back to the AD7746
> before executing a conversion on a different channel.
>> All comments welcom.
>> Jonathan
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe linux-iio"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
>=20

