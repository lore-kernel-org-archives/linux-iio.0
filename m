Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:39529 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656Ab1E0MPu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 May 2011 08:15:50 -0400
Message-ID: <4DDF97D4.3070306@cam.ac.uk>
Date: Fri, 27 May 2011 13:23:48 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [PATCH] IIO: ADC: New driver for AD7792/AD7793 3 Channel SPI
 ADC
References: <1306335750-428-1-git-send-email-michael.hennerich@analog.com> <4DDE28F4.5040705@cam.ac.uk> <4DDE63B1.2060301@analog.com> <4DDE6A8D.5000007@cam.ac.uk> <4DDF5C32.6010905@analog.com> <4DDF7265.5070309@cam.ac.uk> <4DDF7BA2.1070400@analog.com> <4DDF8297.7020906@cam.ac.uk> <4DDF8305.705@analog.com> <4DDF87F0.1060506@cam.ac.uk> <4DDF8B71.9000200@analog.com>
In-Reply-To: <4DDF8B71.9000200@analog.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/27/11 12:30, Michael Hennerich wrote:
> On 05/27/2011 01:16 PM, Jonathan Cameron wrote:
>> On 05/27/11 11:55, Michael Hennerich wrote:
>>> On 05/27/2011 12:53 PM, Jonathan Cameron wrote:
>>>> On 05/27/11 11:23, Michael Hennerich wrote:
>>>>> On 05/27/2011 11:44 AM, Jonathan Cameron wrote:
>>>>>> ...
>>>>>>> Hi Jonathan,
>>>>>>>
>>>>>>>
>>>>>>> root:/sys/devices/platform/bfin-spi.0/spi0.18/device0>    ls
>>>>>>> device0:buffer0               power
>>>>>>> in-in_scale                   range
>>>>>>> in0-in0_raw                   range_available
>>>>>>> in1-in1_raw                   sampling_frequency
>>>>>>> in2-in2_raw                   sampling_frequency_available
>>>>>>> in3_raw                       subsystem
>>>>>>> in4_supply_raw                temp0_raw
>>>>>>> in4_supply_scale              temp_scale
>>>>>>> in_scale                      trigger
>>>>>>> name                          uevent
>>>>>>>
>>>>>>> root:/sys/devices/platform/bfin-spi.0/spi0.18/device0>    cat i=
n_scale
>>>>>>> 0.000140
>>>>>>>
>>>>>>> root:/sys/devices/platform/bfin-spi.0/spi0.18/device0>    cat r=
ange_available
>>>>>>> 2500 1250 625 312 156 78 39 19
>>>>>>>
>>>>>>> root:/sys/devices/platform/bfin-spi.0/spi0.18/device0>    echo =
312>    range
>>>>>>> root:/sys/devices/platform/bfin-spi.0/spi0.18/device0>    cat i=
n_scale
>>>>>>> 0.000010
>>>>>>>
>>>>>>> root:/sys/devices/platform/bfin-spi.0/spi0.18/device0>    echo =
78>    range
>>>>>>> root:/sys/devices/platform/bfin-spi.0/spi0.18/device0>    cat i=
n_scale
>>>>>>> 0.000000
>>>>>>> root:/sys/devices/platform/bfin-spi.0/spi0.18/device0>
>>>>>>>
>>>>>>> with these 24-bit converters and input AMPs we are already exha=
usted
>>>>>>> the number of available digits we have for scale.
>>>>>> Time for a new return type and extra logic in the core.
>>>>>> IIO_VAL_INT_PLUS_NANO
>>>>>>
>>>>>> should still fit in a 32 bit long.  Perhaps it's better to make =
a  bigger jump - or
>>>>>> this will just bite us again sometime soon.
>>>>>>
>>>>>> After nano we will have to start having padding zeros which is g=
oing to be a little
>>>>>> strange - or I guess we don't have to keep val as being int...
>>>>>>
>>>>>> IIO_VAL_MICRO_PLUS_PICO maybe?  The maximum option of IIO_VAL_NA=
NO_PLUS_ATTO seems a little
>>>>>> 'odd'.
>>>>>>
>>>>>> The more complex question is going to be writing values that are=
 this small. I think we will
>>>>>> have to add another callback into the drivers where they can que=
ry what format a value should
>>>>>> be in so the core can provide it.  Make this optional so it does=
n't effect the majority
>>>>>> of drivers where int + micro does the job.
>>>>>>
>>>>> IIO_VAL_INT_PLUS_NANO should do the job for now.
>>>>>
>>>>>>> What shall we do?
>>>>>>>
>>>>>>> Also how would you name AIN1(-) - AIN1(-)?
>>>>>>>
>>>>>>> #define AD7793_CH_AIN1P_AIN1M        0 /* AIN1(+) - AIN1(-) */
>>>>>>> #define AD7793_CH_AIN2P_AIN2M        1 /* AIN2(+) - AIN2(-) */
>>>>>>> #define AD7793_CH_AIN3P_AIN3M        2 /* AIN3(+) - AIN3(-) */
>>>>>>> #define AD7793_CH_AIN1M_AIN1M        3 /* AIN1(-) - AIN1(-) */
>>>>>>>
>>>>>>> in0-in0_zerooffset_raw ?
>>>>>> Hmm.. That is awkward.  Given only the channel numbers exist in =
event codes
>>>>>> it will also possibly cause us issues at some later date.
>>>>>> How about having in0-in0_raw then in0-in0_offset + in0-in0_offse=
t_available.
>>>>>> (actually this would be shared I guess so in-in_offset_available=
).
>>>>>> A little clunky, but does fit better within the api.  Is there a=
 real use case
>>>>>> for buffering where one grabs both offsets in the same scan?
>>>>> As far as I understand things - We do zero and full scale calibra=
tion,
>>>>> The results read from the other channels should have the offset e=
liminated.
>>>>> I agree the offset read from  AIN1(-) - AIN1(-) should be the sam=
e for all channels.
>>>>> So in-in_offset sounds good to me - why _available?
>>>> Because there are two options possible.  One when we are doing sig=
ned output
>>>> and one for differential but with only positive values possible.
>>> Sorry I can't follow here. These 3 differential channels pairs alwa=
ys deliver signed values.
>>> Why would a differential channel only deliver positive values?
>>> If the voltage on AINx(+) is lower then the voltage on AINx(-) the =
result is negative.
>> So what is AIN1(-) - AIN1(-) ?
>>
>> I thought that was unipolar differential.
> No - In this mode the AIN1(=E2=88=92) input is internally shorted to =
itself.
> This can be used as a test method to evaluate the noise performance o=
f the
> parts with no external noise sources. In this mode, the AIN1(=E2=88=92=
) input should
> be connected to an external voltage
> within the allowable common-mode range for the part.
>=20
> As you see this is only for test and evaluation purposes...
Ah, that had never occurred to me.  So probably never going to be any e=
vents on it?
If so then your original suggestion is fine.  Maybe in0-in0_shorted wil=
l be clearer.
Either is fine with me as long as you document it.

Jonathan

