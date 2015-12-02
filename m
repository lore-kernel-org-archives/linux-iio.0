Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36662 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbbLBQUY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2015 11:20:24 -0500
Received: by wmww144 with SMTP id w144so221903130wmw.1
        for <linux-iio@vger.kernel.org>; Wed, 02 Dec 2015 08:20:22 -0800 (PST)
Subject: Re: [PATCH v2 1/2] iio: ina2xx: add support for TI INA2xx Power
 Monitors
To: Guenter Roeck <linux@roeck-us.net>
References: <1448884155-2546-1-git-send-email-mtitinger@baylibre.com>
 <1448884155-2546-2-git-send-email-mtitinger@baylibre.com>
 <20151202021429.GA19098@roeck-us.net> <565EC5DB.5040401@baylibre.com>
 <565F169D.2050709@roeck-us.net>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Marc Titinger <mtitinger@baylibre.com>
Message-ID: <565F1A44.3080504@baylibre.com>
Date: Wed, 2 Dec 2015 17:20:20 +0100
MIME-Version: 1.0
In-Reply-To: <565F169D.2050709@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/12/2015 17:04, Guenter Roeck wrote:
> On 12/02/2015 02:20 AM, Marc Titinger wrote:
>> On 02/12/2015 03:14, Guenter Roeck wrote:
>>> On Mon, Nov 30, 2015 at 12:49:14PM +0100, Marc Titinger wrote:
>>>> in SOFTWARE buffer mode, a kthread will capture the active
>>>> scan_elements
>>>> into a kfifo, then compute the remaining time until the next capture
>>>> tick
>>>> and do an active wait (udelay).
>>>>
>>>> This will produce a stream of up to fours channels plus a 64bits
>>>> timestamps (ns).
>>>>
>>>> Tested with ina226, on BeagleBoneBlack.
>>>>
>>>> Datasheet: http://www.ti.com/lit/gpn/ina226
>>>>
>>>> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
>>>> ---
>>>>   drivers/iio/adc/Kconfig      |   9 +
>>>>   drivers/iio/adc/Makefile     |   1 +
>>>>   drivers/iio/adc/ina2xx-iio.c | 678
>>>> +++++++++++++++++++++++++++++++++++++++++++
>>>>   3 files changed, 688 insertions(+)
>>>>   create mode 100644 drivers/iio/adc/ina2xx-iio.c
>>>> +
>>> [ ... ]
>>>> +
>>>> +static const struct i2c_device_id ina2xx_id[] = {
>>>> +    {"ina219", ina219},
>>>> +    {"ina220", ina219},
>>>> +    {"ina226", ina226},
>>>> +    {"ina230", ina226},
>>>> +    {"ina231", ina226},
>>>> +    {}
>>>> +};
>>>
>>> I wonder what is going to happen if both this driver and the hwmon
>>> driver for the same chips are configured in a system which supports
>>> devicetree (or any system, really). Unless I am missing something,
>>> the result will be that both drivers will try to instantiate, and
>>> one will fail with -EBUSY. Or the instantiated driver is more or less
>>> random, depending on which one happens to be loaded. Not a good
>>> situation to be in.
>>
>> I agree, we should put a mutual exclusion in Kconfig, plus maybe a
>> cross-reference in the help section.
>>
>>>
>>> For the time being, it might make sense to add cross-dependencies
>>> in Kconfig to only permit one of the two drivers to be configured.
>>>
>>> Ultimately we may need a better solution for the iio-hwmon bridge,
>>> one that makes the underlying driver transparent in both devicetree
>>> properties and user space ABI. No idea how to do that, though.
>>>
>>
>> IDK if ina2xx is a special case or if this matter of dual driver
>> stacks for the same chip already occurred and requires specific
>> plumbing. Making the user aware of the mutual of the exclusion sounds
>> fine with me.
>>
> htu21. We'll drop that driver from hwmon with the 4.5 kernel.
> We could just drop ina2xx as well, but it is more widely used
> and referenced from dts files. The ABI changes, so I am not sure
> if we can just do that.

I changed iio/adc/Kconfig to the following:

+config INA2XX_ADC
+       tristate "Texas Instruments INA2xx Power Monitors IIO driver"
+       depends on I2C && !SENSORS_INA2XX
+       select REGMAP_I2C
+       select IIO_BUFFER
+       select IIO_KFIFO_BUF
+       help
+         Say yes here to build support for TI INA2xx family of Power 
Monitors.
+         This driver is mutually exclusive with the HWMON version.
+


anything the patch should also add to hwmon/Kconfig (that will not lead 
to a cycling reference warning) ?


>
> Guenter
>

