Return-Path: <SRS0=Z9Zb=M6=gmail.com=songqiang1304521@kernel.org>
From: Song Qiang <songqiang1304521@gmail.com>
Subject: Re: [PATCH v4 3/3] iio: magnetometer: Add driver support for PNI
 RM3100
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
 mark.rutland@arm.com, preid@electromag.com.au, himanshujha199640@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20181002143812.3661-1-songqiang1304521@gmail.com>
 <20181012073536.20339-1-songqiang1304521@gmail.com>
 <20181012073536.20339-4-songqiang1304521@gmail.com>
 <20181013111935.00a2e1af@archlinux>
Message-ID: <e1715942-8fd8-152f-49c8-2a9e081d8a2a@gmail.com>
Date: Thu, 18 Oct 2018 16:24:15 +0800
MIME-Version: 1.0
In-Reply-To: <20181013111935.00a2e1af@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>


On 2018/10/13 下午6:19, Jonathan Cameron wrote:
> On Fri, 12 Oct 2018 15:35:36 +0800
> Song Qiang<songqiang1304521@gmail.com>  wrote:
>
>> PNI RM3100 is a high resolution, large signal immunity magnetometer,
>> composed of 3 single sensors and a processing chip with a MagI2C
>> interface.
>>
>> Following functions are available:
>>   - Single-shot measurement from
>>     /sys/bus/iio/devices/iio:deviceX/in_magn_{axis}_raw
>>   - Triggerd buffer measurement.
>>   - DRDY pin for data ready trigger.
>>   - Both i2c and spi interface are supported.
>>   - Both interrupt and polling measurement is supported, depends on if
>>     the 'interrupts' in DT is declared.
>>
>> Signed-off-by: Song Qiang<songqiang1304521@gmail.com>
> A few questions for you (getting very close to being good to go btw!)
>
> Why do we have the 3second additional wait for conversions?  I know we
> rarely wait that long, but still seems excessive.
>
> Few more comments inline.
>
> Thanks,
>
> Jonathan

Hi Jonathan,


The measurement time of this device varies from 1.7ms to 13 seconds, 3 seconds 
is just a number in the middle between them. This may be worth discussing, 
hoping to get a better solution from the community.


>> ---
>>   MAINTAINERS                            |   7 +
>>   drivers/iio/magnetometer/Kconfig       |  29 ++
>>   drivers/iio/magnetometer/Makefile      |   4 +
>>   drivers/iio/magnetometer/rm3100-core.c | 627 +++++++++++++++++++++++++
>>   drivers/iio/magnetometer/rm3100-i2c.c  |  58 +++
>>   drivers/iio/magnetometer/rm3100-spi.c  |  64 +++
>>   drivers/iio/magnetometer/rm3100.h      |  17 +
>>   7 files changed, 806 insertions(+)
>>   create mode 100644 drivers/iio/magnetometer/rm3100-core.c
>>   create mode 100644 drivers/iio/magnetometer/rm3100-i2c.c
>>   create mode 100644 drivers/iio/magnetometer/rm3100-spi.c
>>   create mode 100644 drivers/iio/magnetometer/rm3100.h
>>

...

>
>> +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	unsigned long scan_mask = *indio_dev->active_scan_mask;
>> +	unsigned int mask_len = indio_dev->masklength;
>> +	struct rm3100_data *data = iio_priv(indio_dev);
>> +	struct regmap *regmap = data->regmap;
>> +	int ret, i, bit;
>> +
>> +	mutex_lock(&data->lock);
>> +	switch (scan_mask) {
>> +	case BIT(0) | BIT(1) | BIT(2):
>> +		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
>> +		mutex_unlock(&data->lock);
>> +		if (ret < 0)
>> +			goto done;
>> +	break;
>> +	case BIT(0) | BIT(1):
>> +		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 6);
>> +		mutex_unlock(&data->lock);
>> +		if (ret < 0)
>> +			goto done;
>> +	break;
>> +	case BIT(1) | BIT(2):
>> +		ret = regmap_bulk_read(regmap, RM3100_REG_MY2, data->buffer, 6);
>> +		mutex_unlock(&data->lock);
>> +		if (ret < 0)
>> +			goto done;
>> +	break;
> What about BIT(0) | BIT(2)?
>
> Now you can do it like you have here and on that one corner case let the iio core
> demux code take care of it, but then you will need to provide available_scan_masks
> so the core knows it needs to handle this case.
>

This confused me a little. The available_scan_masks I was using is {BIT(0) | 
BIT(1) | BIT(2), 0x0}. Apparently in this version of patch I would like it to 
handle every circumstances like BIT(0), BIT(0) | BIT(2), BIT(1) | BIT(2), etc. 
Since Phil mentioned he would like this to reduce bus usage as much as we can 
and I want it, too, I think these three circumstances can be read consecutively 
while others can be read one axis at a time. So I plan to let  BIT(0) | BIT(2) 
fall into the 'default' section, which reads axis one by one.

My question is, since this handles every possible combination, do I still need 
to list every available scan masks in available_scan_masks?


All other problems will be fixed in the next patch.

yours,

Song Qiang


...
