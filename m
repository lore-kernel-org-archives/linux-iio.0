Return-Path: <vladimir.barinov@cogentembedded.com>
Message-ID: <556C6F2B.5010404@cogentembedded.com>
Date: Mon, 01 Jun 2015 17:41:47 +0300
From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: hi-843x: Holt HI-8435/8436/8437 descrete
 ADC
References: <1433161073-21967-1-git-send-email-vladimir.barinov@cogentembedded.com> <1433161211-22034-1-git-send-email-vladimir.barinov@cogentembedded.com> <alpine.DEB.2.02.1506011440121.1644@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1506011440121.1644@pmeerw.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hello Peter,

Thank you for the review.

On 01.06.2015 15:55, Peter Meerwald wrote:
>> Add Holt descrete ADC driver for HI-8435/8436/8437 chips
> discrete
Thx, will replace in the next try.
>
> link to datasheet would be nice, comments below
the official link is here:
http://www.holtic.com/products/3081-hi-8435.aspx
>
> what is the purpose of the driver?
Support hi-8435/36/37 chips in linux kernel via IIO subsystem with use 
of iio-buffer and triggered-buffer features.
>
> the driver-specific ABI needs to be documented under
> Documentation/ABI/testing/sys-bus-iio-*
Thanks, I will add this in the next try.
>
>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>> ---
>>   drivers/iio/adc/Kconfig   |  12 +
>>   drivers/iio/adc/Makefile  |   1 +
>>   drivers/iio/adc/hi-843x.c | 777 ++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 790 insertions(+)
>>   create mode 100644 drivers/iio/adc/hi-843x.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index e36a73e..71b0efc 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -164,6 +164,18 @@ config EXYNOS_ADC
>>   	  of SoCs for drivers such as the touchscreen and hwmon to use to share
>>   	  this resource.
>>   
>> +config HI_843X
> we recommend against using a placeholder in a drivers name;
> we suggest to name the driver after the first/primary chip it supports
> (that you test with most)
Ok, I will name the driver as hi8435_adc/HI8435_ADC in the next try.
> +#include <linux/interrupt.h>
> +
> +#define DRV_NAME "hi-843x"
> HI84.. prefix
sure, as mentioned above I will also use hi8435_adc name and rename all 
functions appropriately with this prefix.
> +static int hi843x_readw(struct hi843x_priv *priv, u8 reg, u16 *val)
> +{
> +	int ret;
> +
> +	reg |= HI843X_READ_OPCODE;
> +	ret = spi_write_then_read(priv->spi, &reg, 1, val, 2);
> +	*val = swab16p(val);
> will this work on big- and little-endian CPUs?
Actually I've tested it with little-endian CPU.
I will replace it with  be16_to_cpup in the next try and the same for 
swab32p -> be32_to_cpup.
>
> +#define HI843X_VOLTAGE_CHANNEL(num)				\
> +	{							\
> +		.type = IIO_VOLTAGE,				\
> +		.indexed = 1,					\
> +		.channel = num,					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +		.scan_index = num,				\
> +		.scan_type = {					\
> +			.sign = 'u',				\
> +			.realbits = 1,				\
> huh? this is unusual for an ADC
This is discrete ADC, only 2 possible results: 0 or 1.

Regards,
Vladimir
