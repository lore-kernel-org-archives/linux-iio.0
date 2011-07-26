Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4E2E9C77.9050506@analog.com>
Date: Tue, 26 Jul 2011 12:52:39 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 0/2] blue part 6: IIO abi rework
References: <1311600234-16128-1-git-send-email-jic23@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177143001196A7@LIMKCMBX1.ad.analog.com> <4E2E863C.2010706@cam.ac.uk>
In-Reply-To: <4E2E863C.2010706@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 07/26/2011 11:17 AM, Jonathan Cameron wrote:
> On 07/26/11 10:01, Hennerich, Michael wrote:
>> Jonathan Cameron wrote on 2011-07-25:
>>> Michael pointed out the issues that not having an explicit direction
>>> for channels was causing and the inconsistency of the inX and outX
>>> channel naming we got from hmwon.
>>>
>>> They are stuck with it, but we aren't, so lets fix this now.
>>>
>>> Interesting question is whether we reset the base units to be volts
>>> whilst we are at it? (for voltage channels obviously!)
>> What do you mean exactly volts versus milli volts?
> Make the in_voltage_scale correspond to conversion to volts instead of
> millivolts as now (I think). Err. Looking at it that isn't actually documented...
> oops.  I wonder which drivers actually do that and which don't.
The ones I wrote provide the scale for millivolts.
With the recent introduction of IIO_VAL_INT_PLUS_NANO we got
the scale accurate enough for the precession 24-bit converters.
If we move to the SI base unit volt, we lose this accuracy again.

Move to IIO_VAL_INT_PLUS_PICO?
>> Or given the fact that we have some current converter currently as inX and outX -
> We do?  Ouch.  In the 'interesting' drivers or in the clean ones?
 From top of my head I know the AD5446/AD5444 are current output DACs.
But the same driver also handles various other voltage output DACs.
I can make sure once we move this driver to channel spec and 
iio_info:write_raw
we get the units right.

>> So we need to audit the datasheet to make sure we the (in|out)_(voltage|current)Y_raw
>> right?
> Probably need to audit everything during the move out of staging anyway. It would be far
> from unusual if we found an off by 1000 error somewhere in he drivers.
>>
>>> Given there will be a lot of auditing and datasheet reading to do
>>> that, I suggest that if we decide to do it, we leave that for when we
>>> are moving drivers out of staging.
>>>
>>> We could roll the doc patch in with the one in the previous series to
>>> reduce churn.  If they go together I'll probably do that.
>>>
>>> Thanks,
>>>
>>> Jonathan
>>>
>>> Jonathan Cameron (2):
>>>    staging:iio: ABI rework - add in_ or out_ prefix to channnels
>>>    staging:iio:Documentation sysfs-bus-iio add in and out prefixes
>>>   drivers/staging/iio/Documentation/sysfs-bus-iio |  536
>>> +++++++++++----
>>> -------
>>>   drivers/staging/iio/dac/ad5686.c                |   24 +-
>>>   drivers/staging/iio/iio.h                       |   31 ++-
>>>   drivers/staging/iio/industrialio-core.c         |   28 +-
>>>   4 files changed, 324 insertions(+), 295 deletions(-)
>> Greetings,
>> Michael
>>
>> --
>> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
>> Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif
>>
>>
>>
>>
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
