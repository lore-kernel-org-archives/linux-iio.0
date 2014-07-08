Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:35356 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932372AbaGHURP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 Jul 2014 16:17:15 -0400
Message-ID: <53BC524E.5080508@kernel.org>
Date: Tue, 08 Jul 2014 21:19:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio:ad7291: Move out of staging
References: <1404118242-14357-1-git-send-email-lars@metafoo.de> <53B72B50.2070601@gmx.de> <53BBD2E8.60706@gmx.de>
In-Reply-To: <53BBD2E8.60706@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/07/14 12:15, Hartmut Knaack wrote:
> Hartmut Knaack schrieb:
>> Lars-Peter Clausen schrieb:
>>> The ad7291 driver is in a reasonable shape. It does not use non-standard API/ABI
>>> and there are no major style issues with the driver. So this patch moves it out
>>> of staging.
>>>
>>> There is one small warning from checkpatch which is also fixed in this patch.
>>> The patch also sorts the #include directives in alphabetical order.
>> So far, I just took a quick peek into the drivers sources and hope to find some more time for a review later this weekend. But one style issue caught my attention, which I would prefer to have fixed before moving out of staging: the double indentations in ad7291_threshold_reg().
> I finally found the time to review the driver and found some minor issues. No show stoppers, but things we might want to fix before moving out of staging. I just sent out some fixes, so it might be a good idea to apply them first (they should not touch areas of this patch).
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git with all but patch 3 from Hartmut's series
applied.  Thanks to you both for your hard work on this.

I'll push this out as testing as per normal for the autobuilders to play around with
it.

Jonathan
>>> ---
>>>   drivers/iio/adc/Kconfig                                     | 10 ++++++++++
>>>   drivers/iio/adc/Makefile                                    |  1 +
>>>   drivers/{staging => }/iio/adc/ad7291.c                      | 13 +++++++------
>>>   drivers/staging/iio/adc/Kconfig                             |  7 -------
>>>   drivers/staging/iio/adc/Makefile                            |  1 -
>>>   .../iio/adc => include/linux/platform_data}/ad7291.h        |  0
>>>   6 files changed, 18 insertions(+), 14 deletions(-)
>>>   rename drivers/{staging => }/iio/adc/ad7291.c (99%)
>>>   rename {drivers/staging/iio/adc => include/linux/platform_data}/ad7291.h (100%)
>>>
>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>> index 20a7073..11b048a 100644
>>> --- a/drivers/iio/adc/Kconfig
>>> +++ b/drivers/iio/adc/Kconfig
>>> @@ -20,6 +20,16 @@ config AD7266
>>>   	  Say yes here to build support for Analog Devices AD7265 and AD7266
>>>   	  ADCs.
>>>
>>> +config AD7291
>>> +	tristate "Analog Devices AD7291 ADC driver"
>>> +	depends on I2C
>>> +	help
>>> +	  Say yes here to build support for Analog Devices AD7291
>>> +	  8 Channel ADC with temperature sensor.
>>> +
>>> +	  To compile this driver as a module, choose M here: the
>>> +	  module will be called ad7291.
>>> +
>>>   config AD7298
>>>   	tristate "Analog Devices AD7298 ADC driver"
>>>   	depends on SPI
>>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>>> index 38cf5c3..ad81b51 100644
>>> --- a/drivers/iio/adc/Makefile
>>> +++ b/drivers/iio/adc/Makefile
>>> @@ -5,6 +5,7 @@
>>>   # When adding new entries keep the list in alphabetical order
>>>   obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
>>>   obj-$(CONFIG_AD7266) += ad7266.o
>>> +obj-$(CONFIG_AD7291) += ad7291.o
>>>   obj-$(CONFIG_AD7298) += ad7298.o
>>>   obj-$(CONFIG_AD7923) += ad7923.o
>>>   obj-$(CONFIG_AD7476) += ad7476.o
>>> diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
>>> similarity index 99%
>>> rename from drivers/staging/iio/adc/ad7291.c
>>> rename to drivers/iio/adc/ad7291.c
>>> index 357cef2..1728e68 100644
>>> --- a/drivers/staging/iio/adc/ad7291.c
>>> +++ b/drivers/iio/adc/ad7291.c
>>> @@ -6,22 +6,22 @@
>>>    * Licensed under the GPL-2 or later.
>>>    */
>>>
>>> -#include <linux/interrupt.h>
>>>   #include <linux/device.h>
>>> -#include <linux/kernel.h>
>>> -#include <linux/slab.h>
>>> -#include <linux/sysfs.h>
>>> +#include <linux/err.h>
>>>   #include <linux/i2c.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/kernel.h>
>>>   #include <linux/module.h>
>>>   #include <linux/mutex.h>
>>>   #include <linux/regulator/consumer.h>
>>> -#include <linux/err.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/sysfs.h>
>>>
>>>   #include <linux/iio/iio.h>
>>>   #include <linux/iio/sysfs.h>
>>>   #include <linux/iio/events.h>
>>>
>>> -#include "ad7291.h"
>>> +#include <linux/platform_data/ad7291.h>
>>>
>>>   /*
>>>    * Simplified handling
>>> @@ -375,6 +375,7 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
>>>   		case IIO_VOLTAGE:
>>>   			if (chip->reg) {
>>>   				int vref;
>>> +
>>>   				vref = regulator_get_voltage(chip->reg);
>>>   				if (vref < 0)
>>>   					return vref;
>>> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
>>> index b87e382..75d2d1b 100644
>>> --- a/drivers/staging/iio/adc/Kconfig
>>> +++ b/drivers/staging/iio/adc/Kconfig
>>> @@ -3,13 +3,6 @@
>>>   #
>>>   menu "Analog to digital converters"
>>>
>>> -config AD7291
>>> -	tristate "Analog Devices AD7291 ADC driver"
>>> -	depends on I2C
>>> -	help
>>> -	  Say yes here to build support for Analog Devices AD7291
>>> -	  8 Channel ADC with temperature sensor.
>>> -
>>>   config AD7606
>>>   	tristate "Analog Devices AD7606 ADC driver"
>>>   	depends on GPIOLIB
>>> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
>>> index afdcd1f..1c4277d 100644
>>> --- a/drivers/staging/iio/adc/Makefile
>>> +++ b/drivers/staging/iio/adc/Makefile
>>> @@ -8,7 +8,6 @@ ad7606-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
>>>   ad7606-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
>>>   obj-$(CONFIG_AD7606) += ad7606.o
>>>
>>> -obj-$(CONFIG_AD7291) += ad7291.o
>>>   obj-$(CONFIG_AD7780) += ad7780.o
>>>   obj-$(CONFIG_AD7816) += ad7816.o
>>>   obj-$(CONFIG_AD7192) += ad7192.o
>>> diff --git a/drivers/staging/iio/adc/ad7291.h b/include/linux/platform_data/ad7291.h
>>> similarity index 100%
>>> rename from drivers/staging/iio/adc/ad7291.h
>>> rename to include/linux/platform_data/ad7291.h
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>

