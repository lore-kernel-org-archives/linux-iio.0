Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34983 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768AbbKLJZ4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Nov 2015 04:25:56 -0500
Received: by wmdw130 with SMTP id w130so145636785wmd.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2015 01:25:55 -0800 (PST)
Subject: Re: [RFC 1/4] iio: ina2xx: add direct IO support for TI INA2xx Power
 Monitors
To: Daniel Baluta <daniel.baluta@gmail.com>
References: <1447171653-12756-1-git-send-email-mtitinger@baylibre.com>
 <1447171653-12756-2-git-send-email-mtitinger@baylibre.com>
 <CAEnQRZCvsB1ZRLXf8xmQa=h6R1jcs-DXmhFpsmpTZdWd-102gQ@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	mturquette@baylibre.com, bcousson@baylibre.com,
	ptitiano@baylibre.com
From: Marc Titinger <mtitinger@baylibre.com>
Message-ID: <56445B22.2050903@baylibre.com>
Date: Thu, 12 Nov 2015 10:25:54 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZCvsB1ZRLXf8xmQa=h6R1jcs-DXmhFpsmpTZdWd-102gQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/11/2015 11:14, Daniel Baluta wrote:
> On Tue, Nov 10, 2015 at 6:07 PM, Marc Titinger <mtitinger@baylibre.com> wrote:
>> Basic support or direct IO raw read, with averaging attribute.
>> Values are RAW, INT_PLUS_MICRO (Volt/Ampere/Watt).
>>

Hi Daniel,

thanks for the review,
comments bellow,

Marc.


>> IIO context has 1 devices:
> Is this from libiio right? Perhaps you should specify this:
>
> "libiio context has 1 devices"

It's the raw output from iio_info to give a quick overview of the features.

>
>>       iio:device0: ina226
>>        4 channels found:
>>          power3:  (input)
>>          1 channel-specific attributes found:
>>                  attr 0: raw value: 1.150000
>>          voltage0:  (input)
>>          1 channel-specific attributes found:
>>                  attr 0: raw value: 0.000003
>>          voltage1:  (input)
>>          1 channel-specific attributes found:
>>                  attr 0: raw value: 4.277500
>>          current2:  (input)
>>          1 channel-specific attributes found:
>>                  attr 0: raw value: 0.268000
>>        2 device-specific attributes found:
>>                  attr 0: in_calibscale value: 10000
>>                  attr 1: in_mean_raw value: 4
>>
>>
>
> Link to datasheet?

Ok, will add it.

http://www.ti.com/lit/gpn/ina226


...


>>
>> +config INA2XX_IIO
>> +        tristate "Texas Instruments INA2xx Power Monitors IIO driver"
>> +       depends on I2C
>
> Since you are using regmap you should select it here.

Right.

>
>> +        help
>> +          Say yes here to build support for TI INA2xx familly Power Monitors.
>> +
>> +         Note that this is not the existing hwmon interface for this device.
>> +
>> +
>
> Config symbol should be in alphabetical order.

Ok
>
...


>>   obj-$(CONFIG_AD7266) += ad7266.o
>> +obj-$(CONFIG_INA2XX_IIO) += ina2xx-iio.o
>
> The same here.

Ok.

>
>>   obj-$(CONFIG_AD7291) += ad7291.o
>>   obj-$(CONFIG_AD7298) += ad7298.o
>>   obj-$(CONFIG_AD7923) += ad7923.o
>> diff --git a/drivers/iio/adc/ina2xx-iio.c b/drivers/iio/adc/ina2xx-iio.c
>> new file mode 100644
>> index 0000000..257d8d5
>> --- /dev/null
>> +++ b/drivers/iio/adc/ina2xx-iio.c
>> @@ -0,0 +1,404 @@
>> +/*
>> + * INA2XX Current and Power Monitors
>> + *

...

>> + *
>> + * Licensed under the GPL-2 or later.
>
> If you know the I2C address its recommended to mention it here.

ok.

...

>> +
>> +static struct regmap_config ina2xx_regmap_config = {
>> +       .reg_bits = 8,
>> +       .val_bits = 16,
> Specify here which registers are cacheable, read/write.

ok.

...

>> +
>> +       return iio_device_register(indio_dev);
>
> If there is no reverse operation for ina2xx_init (e.g ina2xx_poweroff) then here
> you can use devm_iio_device_register and completely remove
> ina2xx_remove function.

right, thanks!


