Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:48671 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572Ab3HEVZw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 5 Aug 2013 17:25:52 -0400
Received: by mail-ea0-f177.google.com with SMTP id f15so1832066eak.8
        for <linux-iio@vger.kernel.org>; Mon, 05 Aug 2013 14:25:51 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 5 Aug 2013 23:25:50 +0200
Message-ID: <CABuKBeKmE_pj35UfzuZdgQu8cs+AxJ++psjFQQ1vL=YUjW=t7Q@mail.gmail.com>
Subject: Re: Re: [PATCH 03/15] staging:iio:adis16260: Remove support for
 orientation mapping
From: Matthias Brugger <matthias.bgg@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

> -------- Missatge original --------
> Assumpte: Re: [PATCH 03/15] staging:iio:adis16260: Remove support for orientation mapping
> De: Jonathan Cameron <jic23@kernel.org>
> Per a: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Jonathan Cameron <jic23@cam.ac.uk>,linux-iio@vger.kernel.org,m_brugger@web.de
>
> On 07/20/13 10:28, Jonathan Cameron wrote:
>> On 07/17/2013 03:44 PM, Lars-Peter Clausen wrote:
>>> The adis16260 driver implements a unique feature in that it allows to change the
>>> orientation of the gyroscope channel by specifying the orientation in platform
>>> data. This feature is as far as I can see unused though and makes the driver
>>> unnecessarily complex. So this patch removes the support for it. If it turns
>>> out we need this, the cleanest approach to implement it is by adding support for
>>> orientation mapping inside the IIO core so it is available to all drivers.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Now the reason this originally got introduced was to maintain functionality that
>> was in the adis16250 that was merged into here.
>>
>> I agree that moving this into the core, if actually matters, is a good idea.
>> I have cc'd Matthias on the basis it was his driver this originally came from.
>
> Ah well. I'm going to guess that Matthias no longer has a strong opinion on this
> and apply the patch. If he does we'lll look at putting support into the core
> for this sort of mapping.

Sorry for my late answer. Actually I'm not using the driver at the
moment. Anyway I think to use the driver with sense, we need to know
which axis the gyroscope is mounted on the device (at least when you
have more then one gyroscope).

I think it is a good idea to implement this in the core part of IIO.
Unfortunately I can promise to find the time in the near future to do
so. Anyway IMHO as long as no-one else uses the driver, you can leave
this as a low-priority task.

Cheers,
Matthias

>
> Applied to the togreg branch of iio.git
>
> Thanks,
>
> Jonathan
>>
>> Jonathan
>>> ---
>>>  drivers/staging/iio/gyro/adis16260.h               |  1 -
>>>  drivers/staging/iio/gyro/adis16260_core.c          | 49 ++++++----------------
>>>  drivers/staging/iio/gyro/adis16260_platform_data.h | 17 --------
>>>  3 files changed, 13 insertions(+), 54 deletions(-)
>>>  delete mode 100644 drivers/staging/iio/gyro/adis16260_platform_data.h
>>>
>>> diff --git a/drivers/staging/iio/gyro/adis16260.h b/drivers/staging/iio/gyro/adis16260.h
>>> index 05bf274..00455af 100644
>>> --- a/drivers/staging/iio/gyro/adis16260.h
>>> +++ b/drivers/staging/iio/gyro/adis16260.h
>>> @@ -1,7 +1,6 @@
>>>  #ifndef SPI_ADIS16260_H_
>>>  #define SPI_ADIS16260_H_
>>>
>>> -#include "adis16260_platform_data.h"
>>>  #include <linux/iio/imu/adis.h>
>>>
>>>  #define ADIS16260_STARTUP_DELAY     220 /* ms */
>>> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
>>> index 83ec32e..5cec675 100644
>>> --- a/drivers/staging/iio/gyro/adis16260_core.c
>>> +++ b/drivers/staging/iio/gyro/adis16260_core.c
>>> @@ -119,21 +119,16 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
>>>  static IIO_DEVICE_ATTR(sampling_frequency_available,
>>>                     S_IRUGO, adis16260_read_frequency_available, NULL, 0);
>>>
>>> -#define ADIS16260_GYRO_CHANNEL_SET(axis, mod)                               \
>>> -struct iio_chan_spec adis16260_channels_##axis[] = {                \
>>> -    ADIS_GYRO_CHAN(mod, ADIS16260_GYRO_OUT, ADIS16260_SCAN_GYRO, \
>>> -            BIT(IIO_CHAN_INFO_CALIBBIAS) | \
>>> -            BIT(IIO_CHAN_INFO_CALIBSCALE), 14), \
>>> -    ADIS_INCLI_CHAN(mod, ADIS16260_ANGL_OUT, ADIS16260_SCAN_ANGL, 0, 14), \
>>> -    ADIS_TEMP_CHAN(ADIS16260_TEMP_OUT, ADIS16260_SCAN_TEMP, 12), \
>>> -    ADIS_SUPPLY_CHAN(ADIS16260_SUPPLY_OUT, ADIS16260_SCAN_SUPPLY, 12), \
>>> -    ADIS_AUX_ADC_CHAN(ADIS16260_AUX_ADC, ADIS16260_SCAN_AUX_ADC, 12), \
>>> -    IIO_CHAN_SOFT_TIMESTAMP(5),                             \
>>> -}
>>> -
>>> -static const ADIS16260_GYRO_CHANNEL_SET(x, X);
>>> -static const ADIS16260_GYRO_CHANNEL_SET(y, Y);
>>> -static const ADIS16260_GYRO_CHANNEL_SET(z, Z);
>>> +static const struct iio_chan_spec adis16260_channels[] = {
>>> +    ADIS_GYRO_CHAN(X, ADIS16260_GYRO_OUT, ADIS16260_SCAN_GYRO,
>>> +            BIT(IIO_CHAN_INFO_CALIBBIAS) |
>>> +            BIT(IIO_CHAN_INFO_CALIBSCALE), 14),
>>> +    ADIS_INCLI_CHAN(X, ADIS16260_ANGL_OUT, ADIS16260_SCAN_ANGL, 0, 14),
>>> +    ADIS_TEMP_CHAN(ADIS16260_TEMP_OUT, ADIS16260_SCAN_TEMP, 12),
>>> +    ADIS_SUPPLY_CHAN(ADIS16260_SUPPLY_OUT, ADIS16260_SCAN_SUPPLY, 12),
>>> +    ADIS_AUX_ADC_CHAN(ADIS16260_AUX_ADC, ADIS16260_SCAN_AUX_ADC, 12),
>>> +    IIO_CHAN_SOFT_TIMESTAMP(5),
>>> +};
>>>
>>>  static const u8 adis16260_addresses[][2] = {
>>>      [ADIS16260_SCAN_GYRO] = { ADIS16260_GYRO_OFF, ADIS16260_GYRO_SCALE },
>>> @@ -301,10 +296,9 @@ static const struct adis_data adis16260_data = {
>>>
>>>  static int adis16260_probe(struct spi_device *spi)
>>>  {
>>> -    int ret;
>>> -    struct adis16260_platform_data *pd = spi->dev.platform_data;
>>>      struct iio_dev *indio_dev;
>>>      struct adis *adis;
>>> +    int ret;
>>>
>>>      /* setup the industrialio driver allocated elements */
>>>      indio_dev = iio_device_alloc(sizeof(*adis));
>>> @@ -319,25 +313,8 @@ static int adis16260_probe(struct spi_device *spi)
>>>      indio_dev->name = spi_get_device_id(spi)->name;
>>>      indio_dev->dev.parent = &spi->dev;
>>>      indio_dev->info = &adis16260_info;
>>> -    indio_dev->num_channels
>>> -            = ARRAY_SIZE(adis16260_channels_x);
>>> -    if (pd && pd->direction)
>>> -            switch (pd->direction) {
>>> -            case 'x':
>>> -                    indio_dev->channels = adis16260_channels_x;
>>> -                    break;
>>> -            case 'y':
>>> -                    indio_dev->channels = adis16260_channels_y;
>>> -                    break;
>>> -            case 'z':
>>> -                    indio_dev->channels = adis16260_channels_z;
>>> -                    break;
>>> -            default:
>>> -                    return -EINVAL;
>>> -            }
>>> -    else
>>> -            indio_dev->channels = adis16260_channels_x;
>>> -    indio_dev->num_channels = ARRAY_SIZE(adis16260_channels_x);
>>> +    indio_dev->channels = adis16260_channels;
>>> +    indio_dev->num_channels = ARRAY_SIZE(adis16260_channels);
>>>      indio_dev->modes = INDIO_DIRECT_MODE;
>>>
>>>      ret = adis_init(adis, indio_dev, spi, &adis16260_data);
>>> diff --git a/drivers/staging/iio/gyro/adis16260_platform_data.h b/drivers/staging/iio/gyro/adis16260_platform_data.h
>>> deleted file mode 100644
>>> index 73c5899..0000000
>>> --- a/drivers/staging/iio/gyro/adis16260_platform_data.h
>>> +++ /dev/null
>>> @@ -1,17 +0,0 @@
>>> -/*
>>> - * ADIS16260 Programmable Digital Gyroscope Sensor Driver Platform Data
>>> - *
>>> - * Based on adis16255.h Matthia Brugger <m_brugger&web.de>
>>> - *
>>> - * Copyright (C) 2010 Fraunhofer Institute for Integrated Circuits
>>> -  *
>>> - * Licensed under the GPL-2 or later.
>>> - */
>>> -
>>> -/**
>>> - * struct adis16260_platform_data - instance specific data
>>> - * @direction: x y or z
>>> - **/
>>> -struct adis16260_platform_data {
>>> -    char direction;
>>> -};
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>



-- 
motzblog.wordpress.com
