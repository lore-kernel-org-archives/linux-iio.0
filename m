Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33613 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdBFGwq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Feb 2017 01:52:46 -0500
Received: by mail-pg0-f41.google.com with SMTP id 204so25893653pge.0
        for <linux-iio@vger.kernel.org>; Sun, 05 Feb 2017 22:52:46 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/4] iio: chemical: add driver for dsm501/ppd42ns particle sensors
From: Matt Ranostay <matt@ranostay.consulting>
In-Reply-To: <20170205162434.GB2191@Arch.lan>
Date: Sun, 5 Feb 2017 22:52:44 -0800
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de
Message-Id: <EA71160F-2978-4383-B382-11151A12602C@ranostay.consulting>
References: <20170205150137.10779-1-tduszyns@gmail.com> <alpine.DEB.2.02.1702051612120.21159@pmeerw.net> <20170205162434.GB2191@Arch.lan>
To: Tomasz Duszynski <tduszyns@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> On Feb 5, 2017, at 08:24, Tomasz Duszynski <tduszyns@gmail.com> wrote:
>=20
> Thanks for review!
>=20
>> On Sun, Feb 05, 2017 at 04:19:47PM +0100, Peter Meerwald-Stadler wrote:
>>=20
>>> This patch adds support for dsm501 and ppd42ns particle sensors.
>>=20
>> quick comments below
>> G
>>> Both sensors work on the same principle. Heater (resistor) heats up air
>>> in sensor chamber which induces upward flow. Particles convect up throug=
h
>>> a light beam provided by internal infra-red LED. Light scattered by
>>> particles is picked by photodiode and internal electronics outputs PWM
>>> signal.
>>>=20
>>> Measuring low time occupancy of the signal during 30s measurement period=

>>> particles number in cubic meter can be computed.
>>>=20

This a SI unit?

Also this maybe could be better off in drivers/iio/light... as much I like t=
o have other people in drivers/iio/chemical =F0=9F=98=80
>>> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
>>> ---
>>> drivers/iio/chemical/Kconfig  |  10 ++
>>> drivers/iio/chemical/Makefile |   1 +
>>> drivers/iio/chemical/dsm501.c | 231 ++++++++++++++++++++++++++++++++++++=
++++++
>>> 3 files changed, 242 insertions(+)
>>> create mode 100644 drivers/iio/chemical/dsm501.c
>>>=20
>>> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig=

>>> index cea7f9857a1f..986d612aa77f 100644
>>> --- a/drivers/iio/chemical/Kconfig
>>> +++ b/drivers/iio/chemical/Kconfig
>>> @@ -21,6 +21,16 @@ config ATLAS_PH_SENSOR
>>>     To compile this driver as module, choose M here: the
>>>     module will be called atlas-ph-sensor.
>>>=20
>>> +config DSM501
>>> +    tristate "Samyoung DSM501 particle sensor"
>>> +    depends on GPIOLIB
>>> +    help
>>> +     Say yes here to build support for the Samyoung DSM501
>>> +     particle sensor.
>>> +
>>> +     To compile this driver as a module, choose M here: the module
>>> +     will be called dsm501.
>>> +
>>> config IAQCORE
>>>    tristate "AMS iAQ-Core VOC sensors"
>>>    depends on I2C
>>> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefi=
le
>>> index b02202b41289..76f50ff8ba7d 100644
>>> --- a/drivers/iio/chemical/Makefile
>>> +++ b/drivers/iio/chemical/Makefile
>>> @@ -4,5 +4,6 @@
>>>=20
>>> # When adding new entries keep the list in alphabetical order
>>> obj-$(CONFIG_ATLAS_PH_SENSOR)    +=3D atlas-ph-sensor.o
>>> +obj-$(CONFIG_DSM501)        +=3D dsm501.o
>>> obj-$(CONFIG_IAQCORE)        +=3D ams-iaq-core.o
>>> obj-$(CONFIG_VZ89X)        +=3D vz89x.o
>>> diff --git a/drivers/iio/chemical/dsm501.c b/drivers/iio/chemical/dsm501=
.c
>>> new file mode 100644
>>> index 000000000000..013f6b3bfd48
>>> --- /dev/null
>>> +++ b/drivers/iio/chemical/dsm501.c
>>> @@ -0,0 +1,231 @@
>>> +/*
>>> + * Samyoung DSM501 particle sensor driver
>>> + *
>>> + * Copyright (C) 2017 Tomasz Duszynski <tduszyns@gmail.com>
>>> + *
>>> + * Datasheets:
>>> + *  http://www.samyoungsnc.com/products/3-1%20Specification%20DSM501.pd=
f
>>> + *  http://wiki.timelab.org/images/f/f9/PPD42NS.pdf
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify=

>>> + * it under the terms of the GNU General Public License as published by=

>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + */
>>> +
>>> +#include <linux/delay.h>
>>> +#include <linux/gpio/consumer.h>
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/init.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/module.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/timekeeping.h>
>>> +
>>> +#define DSM501_DRV_NAME "dsm501"
>>> +#define    DSM501_IRQ_NAME "dsm501_irq"
>>=20
>> replace tab by space
> Ack.
>>=20
>>> +
>>> +#define DSM501_DEFAULT_MEASUREMENT_TIME 30 /* seconds */
>>> +
>>> +struct dsm501_data {
>>> +    ktime_t ts;
>>> +    ktime_t low_time;
>>> +    ktime_t meas_time;
>>> +
>>> +    int irq;
>>> +    struct gpio_desc *gpio;
>>> +
>>> +    struct mutex lock;
>>> +
>>> +    int (*number_concentration)(struct dsm501_data *data);
>>> +};
>>> +
>>> +/*
>>> + * Series of data points in Fig. 8-3 (Low Ratio vs Particle)
>>> + * can be approximated by following polynomials:
>>> + *
>>> + * p(r) =3D 0 (undefined) for r < 4
>>> + * p(r) =3D 2353564.2r - 4373814.7 for 4 <=3D r < 20
>>> + * p(r) =3D 4788112.4r - 53581390 for r >=3D 20
>>> + *
>>> + * Note: Result is in pcs/m3. To convert to pcs/0.01cf multiply
>>> + *     by 0.0002831685.
>>=20
>> is cf needed?
> No. I've put that sidenote so that others looking at figures in
> datahseets won't scratch their heads why units here are pcs/m3 and
> pcs/0.01cf there. Anyway I am happy to drop that part.
>>=20
>>> + */
>>> +static int dsm501_number_concentartion(struct dsm501_data *data)
>>> +{
>>> +    s64 retval =3D 0, r =3D div64_s64(ktime_to_ns(data->low_time) * 100=
,
>>> +                      ktime_to_ns(data->meas_time));
>>> +
>>> +    if (r >=3D 4 && r < 20)
>>> +        retval =3D 23535642 * r - 43738147;
>>> +    else if (r >=3D 20)
>>> +        retval =3D 47881124 * r - 535813900;
>>> +
>>> +    return div_s64(retval, 10);
>>> +}
>>> +
>>> +/*
>>> + * Series of data points in Fig. 2 (Lo Pulse Occupancy Time vs Concentr=
ation)
>>> + * can be approximated by following polynomial:
>>> + *
>>> + * p(r) =3D 3844.2r^3 - 16201.3r^2 + 1848746.1r + 52497.2
>>> + *
>>> + * Note: Result is in pcs/m3. To convert to pcs/0.01cf multiply
>>> + *     by 0.0002831685.
>>> + */
>>> +static int ppd42ns_number_concentration(struct dsm501_data *data)
>>> +{
>>> +    s64 retval, r3, r2, r =3D div64_s64(ktime_to_ns(data->low_time) * 1=
00,
>>> +                      ktime_to_ns(data->meas_time));
>>> +
>>> +    r2 =3D r * r;
>>> +    r3 =3D r2 * r;
>>> +
>>> +    retval =3D 38442 * r3;
>>> +    retval -=3D 162013 * r2;
>>> +    retval +=3D 18487461 * r;
>>> +    retval +=3D 524972;
>>> +
>>> +    return div_s64(retval, 10);
>>> +}
>>> +
>>> +static irqreturn_t dsm501_irq(int irq, void *dev_id)
>>> +{
>>> +    struct dsm501_data *data =3D iio_priv(dev_id);
>>> +    int val =3D gpiod_get_value(data->gpio);
>>> +    ktime_t dt, ts =3D ktime_get();
>>> +
>>> +    if (ktime_to_ns(data->ts) =3D=3D 0) {
>>> +        data->ts =3D ts;
>>> +        data->low_time =3D ktime_set(0, 0);
>>> +    }
>>> +
>>> +    if (val) {
>>> +        dt =3D ktime_sub(ts, data->ts);
>>> +        data->low_time =3D ktime_add(data->low_time, dt);
>>> +    } else {
>>> +        data->ts =3D ts;
>>> +    }
>>=20
>> {} needed?
> According to CodingStyle yes. {} could be dropped if there was single
> statement under if (val) { ...
>>=20
>>> +
>>> +    return IRQ_HANDLED;
>>> +}
>>> +
>>> +static int dsm501_read_raw(struct iio_dev *indio_dev,
>>> +               struct iio_chan_spec const *chan, int *val,
>>> +               int *val2, long mask)
>>> +{
>>> +    struct dsm501_data *data =3D iio_priv(indio_dev);
>>> +    struct device *dev =3D indio_dev->dev.parent;
>>> +    unsigned long irqflags =3D IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLI=
NG;
>>> +    int ret;
>>> +
>>> +
>>> +    switch (mask) {
>>> +    case IIO_CHAN_INFO_PROCESSED:
>>> +        mutex_lock(&data->lock);
>>> +        data->ts =3D ktime_set(0, 0);
>>> +
>>> +        ret =3D devm_request_irq(dev, data->irq, dsm501_irq, irqflags,
>>> +                       DSM501_IRQ_NAME, indio_dev);
>>=20
>> why devm_()? if the irq is explicitly freed below?
>> requesting the irq for every measurement seems weird even if it only
>> happens every 30s
> Ack.
>>=20
>>> +        if (ret) {
>>> +            dev_err(dev, "Failed to request interrupt %d\n", data->irq)=
;
>>> +            mutex_unlock(&data->lock);
>>> +            return ret;
>>> +        }
>>> +
>>> +        msleep_interruptible(ktime_to_ms(data->meas_time));
>>> +        devm_free_irq(dev, data->irq, indio_dev);
>>> +
>>> +        *val =3D data->number_concentration(data);
>>> +        mutex_unlock(&data->lock);
>>> +
>>> +        return IIO_VAL_INT;
>>> +    default:
>>> +        return -EINVAL;
>>> +    }
>>> +}
>>> +
>>> +static const struct iio_info dsm501_info =3D {
>>> +    .driver_module    =3D THIS_MODULE,
>>> +    .read_raw =3D dsm501_read_raw,
>>> +};
>>> +
>>> +static const struct iio_chan_spec dsm501_channels[] =3D {
>>> +    {
>>> +        .type =3D IIO_NUMBERCONCENTRATION,
>>> +        .info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),
>>> +    },
>>> +};
>>> +
>>> +static int dsm501_probe(struct platform_device *pdev)
>>> +{
>>> +    struct dsm501_data *data;
>>> +    struct iio_dev *indio_dev;
>>> +    struct device *dev =3D &pdev->dev;
>>> +
>>> +    indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*data));
>>> +    if (!indio_dev)
>>> +        return -ENOMEM;
>>> +
>>> +    data =3D iio_priv(indio_dev);
>>> +    platform_set_drvdata(pdev, indio_dev);
>>> +
>>> +    data->gpio =3D devm_gpiod_get_index(dev, NULL, 0, GPIOD_IN);
>>> +    if (IS_ERR(data->gpio)) {
>>> +        dev_err(dev, "Failed to get GPIO\n");
>>> +        return PTR_ERR(data->gpio);
>>> +    }
>>> +
>>> +    data->irq =3D gpiod_to_irq(data->gpio);
>>> +    if (data->irq < 0) {
>>> +        dev_err(dev, "GPIO has no interrupt\n");
>>> +        return data->irq;
>>> +    }
>>> +
>>> +    data->meas_time =3D ktime_set(DSM501_DEFAULT_MEASUREMENT_TIME, 0);
>>> +    data->number_concentration =3D of_device_get_match_data(dev);
>>> +    mutex_init(&data->lock);
>>> +
>>> +    indio_dev->name =3D DSM501_DRV_NAME;
>>> +    indio_dev->dev.parent =3D dev;
>>> +    indio_dev->info =3D &dsm501_info;
>>> +    indio_dev->modes =3D INDIO_DIRECT_MODE;
>>> +    indio_dev->channels =3D dsm501_channels;
>>> +    indio_dev->num_channels =3D ARRAY_SIZE(dsm501_channels);
>>> +
>>> +    return devm_iio_device_register(&pdev->dev, indio_dev);
>>> +}
>>> +
>>> +static const struct of_device_id dsm501_id[] =3D {
>>> +    {
>>> +        .compatible =3D "samyoung,dsm501",
>>> +        .data =3D dsm501_number_concentartion,
>>=20
>> type: concentration
> Are you refering to function naming here?  *_number_concentration was name=
d
> after returned physical quantity.
>>=20
>>> +    },
>>> +    {
>>> +        .compatible =3D "shinyei,ppd42ns",
>>> +        .data =3D ppd42ns_number_concentration,
>>> +    },
>>> +    { }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, dsm501_id);
>>> +
>>> +static struct platform_driver dsm501_driver =3D {
>>> +    .driver    =3D {
>>> +        .name =3D DSM501_DRV_NAME,
>>> +        .of_match_table =3D of_match_ptr(dsm501_id)
>>> +    },
>>> +    .probe =3D dsm501_probe
>>> +};
>>> +module_platform_driver(dsm501_driver);
>>> +
>>> +MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
>>> +MODULE_DESCRIPTION("Samyoung DSM501 particle sensor driver");
>>> +MODULE_LICENSE("GPL v2");
>>>=20
>>=20
>> --
>>=20
>> Peter Meerwald-Stadler
>> +43-664-2444418 (mobile)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
