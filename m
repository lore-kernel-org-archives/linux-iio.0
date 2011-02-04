Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Fri, 4 Feb 2011 13:48:06 +0000
Subject: RE: [PATCH] IIO: ADC: New driver for AD7606/AD7606-6/AD7606-4
Message-ID: <544AC56F16B56944AEC3BD4E3D591771324C1BA4F2@LIMKCMBX1.ad.analog.com>
References: <1296744691-24320-1-git-send-email-michael.hennerich@analog.com>
 <4D4B1208.3080604@cam.ac.uk>
In-Reply-To: <4D4B1208.3080604@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-02-03:
> On 02/03/11 14:51, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> This patch adds support for the:
>> AD7606/AD7606-6/AD7606-4 8/6/4-Channel Data Acquisition system (DAS)
>> with 16-Bit, Bipolar, Simultaneous Sampling ADC.
>
> Hi Michael,
>
> Another nice clean driver, various points inline with the code.
>
> With the parallel interface, I'll admit I've not seen one of these
> before so my questions may be somewhat uninformed ;) On that note I'd
> also like to have some more eyes on that element if possible.
> (looks fine to me)
>
> The big one is whether the assumption that all such interfaces are
> going to be memory mappable is reasonable or whether there should be
> some abstraction in below the driver?

If these parallel interfaces are memory mappable or not depends on the
device in question. In general there are two types of interfaces.
One with just a parallel bus and a clock. Or ones with a parallel bus and
chip/memory select and read/write strobes. Later ones doesn't differ in any=
 form from
a external Flash, USB or NIC/MACPHY, and are therefore memory mappable.
The asynchronous parallel bus timing requirements by the device must match =
the capabilities of the
processor. Most processors allow you to set the timings for setup, access a=
nd hold cycles.

The AD7606 is not very demanding here, and easily connects to any host feat=
uring such interface.

Additional abstraction doesn't make sense for memory mapped.

However some parts have a parallel interface with only a clock.
These devices typically connect to some special Machine/Host dependant peri=
pheral.
For example - on Blackfin it would be the PPI (Parallel Peripheral Interfac=
e)

http://en.wikipedia.org/wiki/Parallel_Peripheral_Interface

OMAP calls it Universal Parallel Port (uPP), and so on.
These are not abstracted by a standard bus in Linux.

Bus abstraction here makes absolute sense...


> I'd like to see some more
> documentation on the requirements of that interface, even if just a
> quick explanation for those not familiar with this sort of interface
> within the kernel.

Memory mapped parallel interfaces are nothing new.
They actually become rare. And the datasheet of the device in question
is typically the documentation.


>>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> ---
>>  drivers/staging/iio/Documentation/sysfs-bus-iio |   25 +
>>  drivers/staging/iio/adc/Kconfig                 |   27 ++
>>  drivers/staging/iio/adc/Makefile                |    6 +
>>  drivers/staging/iio/adc/ad7606.h                |  119 +++++
>>  drivers/staging/iio/adc/ad7606_core.c           |  560
>>  +++++++++++++++++++++++ drivers/staging/iio/adc/ad7606_par.c
>>   |  191 ++++++++ drivers/staging/iio/adc/ad7606_ring.c           |
>>  261 +++++++++++ drivers/staging/iio/adc/ad7606_spi.c            |  133
>>  ++++++ 8 files changed, 1322 insertions(+), 0 deletions(-)  create mode
>> 100644 drivers/staging/iio/adc/ad7606.h  create mode 100644
>> drivers/staging/iio/adc/ad7606_core.c
>>  create mode 100644 drivers/staging/iio/adc/ad7606_par.c
>>  create mode 100644 drivers/staging/iio/adc/ad7606_ring.c
>>  create mode 100644 drivers/staging/iio/adc/ad7606_spi.c
>> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio
>> b/drivers/staging/iio/Documentation/sysfs-bus-iio
>> index 8e5d8d1..b415019 100644
>> --- a/drivers/staging/iio/Documentation/sysfs-bus-iio
>> +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
>> @@ -53,6 +53,31 @@ Description:
>>              When the internal sampling clock can only take a small
>>              discrete set of values, this file lists those available.
>> +What:               /sys/bus/iio/devices/deviceX/range
>> +KernelVersion:      2.6.38
>> +Contact:    linux-iio@vger.kernel.org
>> +Description:
>> +            Hardware dependent ADC Full Scale Range.
> Could you give an illustrative example of a usecase where this is
> necessary?

The AD7606 features true bipolar analog inputs (ranges are +/-10 and +/- 5V=
olt)
While being powered from a single 5Volt supply.

The range is selected by a special logic input strobe.

> I'm generally a bit dubious about the obviously considerable
> overlap between this and the _scale and _type attributes.  I guess
> having them yoked together as you have here works out fine.  We might
> want to set a preference though. Perhaps always have _scale as the
> controlable option and range as the dependant value?

In this case range directly influences the maximum voltage that
can be applied to the inputs. Setting range however also influences the sca=
le.
Since +/- 10 Volt are now distributed over 16-bit resolution.
Actually there is a bug in my scale implementation, since the ABS value is =
20V.

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
