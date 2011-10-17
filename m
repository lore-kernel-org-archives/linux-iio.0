Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:43579 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312Ab1JQNsw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2011 09:48:52 -0400
Message-ID: <4E9C3248.9030304@cam.ac.uk>
Date: Mon, 17 Oct 2011 14:48:56 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Alexander Stein <alexander.stein@systec-electronic.com>
CC: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	guenter.roeck@ericsson.com, khali@linux-fr.org,
	dmitry.torokhov@gmail.com, broonie@opensource.wolfsonmicro.com,
	gregkh@suse.de, alan@lxorguk.ukuu.org.uk, arnd@arndb.de
Subject: Re: [PATCH 1/6] IIO: Core sysfs only support.
References: <1318857381-13787-1-git-send-email-jic23@cam.ac.uk> <1318857381-13787-2-git-send-email-jic23@cam.ac.uk> <201110171542.24673.alexander.stein@systec-electronic.com>
In-Reply-To: <201110171542.24673.alexander.stein@systec-electronic.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/17/11 14:42, Alexander Stein wrote:
> Hello Jonathan,
> 
> On Monday 17 October 2011 15:16:16 you wrote:
>> Add support for simple sysfs only interfaces.
>>
>> Bulk of patch is concerned with taking struct iio_chan_spec
>> arrays and generating all the relevant interfaces from them.
>>
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>> ---
>>  drivers/Kconfig           |    2 +
>>  drivers/Makefile          |    3 +
>>  drivers/iio/Kconfig       |   11 +
>>  drivers/iio/Makefile      |    6 +
>>  drivers/iio/iio.c         |  591
>> +++++++++++++++++++++++++++++++++++++++++++++ include/linux/iio/iio.h   | 
>> 250 +++++++++++++++++++
>>  include/linux/iio/sysfs.h |   68 +++++
>>  7 files changed, 931 insertions(+), 0 deletions(-)
>>
>> [...]
>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>> new file mode 100644
>> index 0000000..5d9a97d
>> --- /dev/null
>> +++ b/drivers/iio/Kconfig
>> @@ -0,0 +1,11 @@
>> +#
>> +# Industrial I/O subsystem
>> +#
>> +
>> +menuconfig IIO
>> +	tristate "Industrial I/O support"
>> +	depends on GENERIC_HARDIRQS
>> +	help
>> +	  The Industrial input / output subsystem provides a unified
>> +	  framework for many different types of embedded sensor.
>> +	  See Documentation/iio for more information.
> 
> I don't know much about iio so I want to read about it. But where does 
> Documentation/iio come from?
An excellent point.  First fix for V2 ;)

It is in drivers/staging/iio/  I haven't lifted most of it over yet.

Sadly some of it is somewhat bit rotted. Best bet is to read
sysfs-bus-iio to see sysfs interface and we do have an example driver
but it's not quite merged yet (working its way to staging-next).
So see

https://github.com/jic23/linux-iio/blob/master/drivers/staging/iio/iio_simple_dummy.c

As someone new to IIO I'd particularly like to hear you
opinions on whether the dummy driver helped you to figure
out what is going on.   Any other comments of course would
be most welcome.

Perhaps I'll pull the dummy driver into V2 of this patch set.

Thanks,

Jonathan
