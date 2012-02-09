Return-Path: <jic23@kernel.org>
Message-ID: <4F3411BA.5070401@kernel.org>
Date: Thu, 09 Feb 2012 18:34:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: linux-iio@vger.kernel.org, guenter.roeck@ericsson.com,
 khali@linux-fr.org, dmitry.torokhov@gmail.com,
 broonie@opensource.wolfsonmicro.com, alan@lxorguk.ukuu.org.uk,
 arnd@arndb.de, linus.walleij@linaro.org,
 maxime.ripard@free-electrons.com, thomas.petazzoni@free-electrons.com,
 zdevai@gmail.com, w.sang@pengutronix.de, marek.vasut@gmail.com,
 Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 1/5] staging:iio:core add in kernel interface mapping
 and getting IIO channels.
References: <1327837614-24176-1-git-send-email-jic23@kernel.org> <1327837614-24176-2-git-send-email-jic23@kernel.org> <20120209181056.GA957@kroah.com>
In-Reply-To: <20120209181056.GA957@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 02/09/2012 06:10 PM, Greg KH wrote:
> On Sun, Jan 29, 2012 at 11:46:50AM +0000, Jonathan Cameron wrote:
>> From: Jonathan Cameron <jic23@cam.ac.uk>
>>
>> Lifted from proposal for in kernel interface built on the out of staging
>> branch.
>>
>> Two elements here:
>> * Map as defined in "inkern.h"
>> * Matching code to actually get the iio_dev and channel
>> that we want from the global list of IIO devices.
>>
>> V2: As per Greg KH suggestion, move over to registration by passing
>> the tables into the provider drivers (how regulator does it).
>> This does not prevent us using the original more flexible approach
>> if at a later date there is a usecase that demands it.
>>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  drivers/staging/iio/Kconfig             |    7 +-
>>  drivers/staging/iio/Makefile            |    2 +-
>>  drivers/staging/iio/consumer.h          |  103 +++++++++++++
>>  drivers/staging/iio/driver.h            |   34 ++++
>>  drivers/staging/iio/iio_core.h          |    3 +
>>  drivers/staging/iio/industrialio-core.c |    2 +-
>>  drivers/staging/iio/inkern.c            |  256 +++++++++++++++++++++++++++++++
>>  drivers/staging/iio/machine.h           |   30 ++++
>>  8 files changed, 434 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
>> index 90162aa..65c2a8e 100644
>> --- a/drivers/staging/iio/Kconfig
>> +++ b/drivers/staging/iio/Kconfig
>> @@ -10,8 +10,14 @@ menuconfig IIO
>>  	  drivers for many different types of embedded sensors using a
>>  	  number of different physical interfaces (i2c, spi, etc). See
>>  	  drivers/staging/iio/Documentation for more information.
>> +
>>  if IIO
>>  
>> +config IIO_INKERN
>> +	bool "In kernel support for IIO"
>> +	help
>> +	  Support in kernel users of IIO device drivers.
> 
> Of course you want this, all of the code in the kernel.org tree is "in
> kernel users" :)
> 
> Seriously, I still fail to understand what is so special here that makes
> this a totally different design pattern from all other busses,
> especially when you aren't even a bus at all, but rather a "interface"
> to userspace for different device types.
> 
> Why can't a driver just depend on this interface type, like all other
> interface types are, that way the built-in vs. as-a-module issues are
> all handled "automagically" by the config and build system.
> 
Best simple comparison is with regulators.  They provide voltages to
consumers; This iio stuff is about providing readings of voltage
(simplifying massively) to other users.  All these adc's need
their own driver to provide that voltage to those that care.
The client drivers just want to ask 'what is the voltage?'.

So to do it as a conventional module dependency we need a separate
dependency for every IIO device capable of providing a voltage
to every driver that might want to read one.

There are a number of common use cases or which I'll list a few here.
a) Soc adc's.  Typical soc might have an 8 channel adc.  On a typical
board 2 channels are used for input (touchscreen), 2 for monitoring the
battery and
4 brought out to an edge connector.  Which are used for what and how
many of each are used is entirely under control of the board designer.
Thus we could have each SoC type adc driver handle the logic necessary
to register an input device, a hwmon device (and perhaps an IIO device).
This is the usecase that Mark Brown originally brought up.  Right now
Arnd is blocking some SoC adc drivers that do this internally and
sending them in the direction of IIO.

b) High spec devices used for input.  This one we originally proposed
doing via a bridge in userspace and piping back in via uinput.
When I say high spec I meant 300+ dolar imu's etc.  People do it
for niche systems, but the part will never primarily be used for this
so normally sits better in IIO, If we have borderline devices, they
will end up in IIO.  If this stuff had been in place earlier (as
Dmitry pushed for) some of the existing parts in input might
never have been accepted.

c) The other side is generating signals.  People use arbitary waveform
generators to produce inputs for all sort of strange devices.

So the question was whether to sit another subsystem under hwmon, input
IIO etc, or to have IIO evolve into that underlying subsystem.  Given
with the channel mapping stuff we already had all the infrastructure
in place to do this, a vague consensus said do it in IIO.

Now in many ways we'd love to have the IIO userspace stuff act as
just another client, but that's a way off yet basically due to the huge
number of special cases that would need to be handled.  I'm personally
not yet sure that will ever happen.

So in summary we don't do this as a simple dependency because of the
combinatorial explosion in dependencies that would be needed and the
connection modules that would be needed to glue it all together
vs what is a simple mapping that will sit nicely in device tree etc.

Jonathan
