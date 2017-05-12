Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34739 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756236AbdELG2b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 May 2017 02:28:31 -0400
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1705051027020.3470@vps.pmeerw.net>
References: <20170504071937.25663-1-joel@jms.id.au> <alpine.DEB.2.20.1705051027020.3470@vps.pmeerw.net>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 12 May 2017 15:58:09 +0930
Message-ID: <CACPK8XdfiF0LPMT18o7Zcr0cM5hcBmR=JN8q30j6XFMbNP+mOg@mail.gmail.com>
Subject: Re: [PATCH] iio: Add driver for Infineon DPS310
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, May 5, 2017 at 9:13 PM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
>> The DPS310 is a temperature and pressure sensor. It can be accessed over
>> i2c and SPI.
>
> comments below
>
>> This driver supports polled measurement of temperature over i2c only.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>  drivers/iio/pressure/Kconfig  |  11 ++
>>  drivers/iio/pressure/Makefile |   1 +
>>  drivers/iio/pressure/dps310.c | 401 ++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 413 insertions(+)
>>  create mode 100644 drivers/iio/pressure/dps310.c
>>
>> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
>> index bd8d96b96771..50caefc0cd7d 100644
>> --- a/drivers/iio/pressure/Kconfig
>> +++ b/drivers/iio/pressure/Kconfig
>> @@ -42,6 +42,17 @@ config BMP280_SPI
>>       depends on SPI_MASTER
>>       select REGMAP
>>
>> +config DPS310
>> +       tristate "Infineon DPS310 pressure and temperature sensor"
>> +       depends on I2C
>> +       select REGMAP_I2C
>> +       help
>> +      Support for the Infineon DPS310 digital barometric pressure sensor.
>> +      This driver measures temperature only.
>
> does it make sense to propose a driver for it then?

Yes. We are building a system that uses the sensor to measure temperature.

If you would prefer I can put it under drivers/iio/temp?

> is there intention to add pressure soonish?
>
> link to datasheet would be nice

Good idea.

>> +++ b/drivers/iio/pressure/dps310.c
>> @@ -0,0 +1,401 @@
>> +/*
>> + * Copyright 2017 IBM Corporation
>> + *
>> + * Joel Stanley <joel@jms.id.au>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + *
>> + * The DPS310 is a barometric pressure and temperature sensor.
>> + * Currently only reading a single temperature is supported by
>> + * this driver.
>> + *
>
> maybe add a comment with I2C address

The addresses are specified at the bottom of the file. Is it
convention to add them to a comment too?

>
>> + * TODO:
>> + *  - Pressure sensor readings
>> + *  - Optionally support the FIFO
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/i2c.h>
>> +#include <linux/regmap.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +
>> +#define PRS_BASE     0x00
>
> prefix everything with DPS310_ or dps310_

Ack.

>
>> +#define TMP_BASE     0x03
>> +#define PRS_CFG              0x06
>> +#define TMP_CFG              0x07
>> +#define  TMP_RATE_BITS       GENMASK(6, 4)
>> +#define  TMP_PRC_BITS        GENMASK(3, 0)
>> +#define  TMP_EXT     BIT(7)
>> +#define MEAS_CFG     0x08
>> +#define  MEAS_CTRL_BITS      GENMASK(2, 0)
>> +#define   PRESSURE_EN        BIT(0)
>> +#define   TEMP_EN    BIT(1)
>> +#define   BACKGROUND BIT(2)
>> +#define  PRS_RDY     BIT(4)
>> +#define  TMP_RDY     BIT(5)
>> +#define  SENSOR_RDY  BIT(6)
>> +#define  COEF_RDY    BIT(7)
>> +#define CFG_REG              0x09
>> +#define  INT_HL              BIT(7)
>> +#define  TMP_SHIFT_EN        BIT(3)
>> +#define  PRS_SHIFT_EN        BIT(4)
>> +#define  FIFO_EN     BIT(5)
>> +#define  SPI_EN              BIT(6)
>> +#define RESET                0x0c
>> +#define  RESET_MAGIC (BIT(0) | BIT(3))
>> +#define COEF_BASE    0x10
>> +
>> +#define TMP_RATE(_n) ilog2(_n)
>> +#define TMP_PRC(_n)  ilog2(_n)
>> +
>> +#define MCELSIUS_PER_CELSIUS 1000
>
> indeed :)
> questionable usefulness

Other drivers do the same. Perhaps it could go in the iio core?

As a driver author it tells me that the drivers is doing this
conversion, and not that the hardware requires a scaling of 1000.

>> +static s32 dps310_twos_compliment(u32 raw, size_t num_bits)
>
> use sign_extend32() instead?

Thanks for pointing this out! I was sure it must exist but I couldn't find it.


>> +
>> +     data->regmap = devm_regmap_init_i2c(client, &dps310_regmap_config);
>> +     if (IS_ERR(data->regmap))
>> +             return PTR_ERR(data->regmap);
>> +
>> +     r = regmap_write(data->regmap, TMP_CFG, TMP_EXT | TMP_PRC(1));
>> +     if (r < 0)
>> +             return r;
>> +     r = regmap_write_bits(data->regmap, CFG_REG, TMP_SHIFT_EN, 0);
>> +     if (r < 0)
>> +             return r;
>> +
>> +     /* Turn on temperature measurement in the background */
>> +     r = regmap_write_bits(data->regmap, MEAS_CFG, MEAS_CTRL_BITS,
>> +                     TEMP_EN | BACKGROUND);
>
> should be disabled again if _probe fails lateron

Ok.

>
>> +     if (r < 0)
>> +             return r;
>> +
>> +     /*
>> +      * Calibration coefficients required for reporting temperature.
>> +      * They are availalbe 40ms after the device has started
>
> available

Thanks.

>
>> +      */
>> +     r = dps310_get_temp_coef(data);
>> +     if (r == -EAGAIN)
>> +             return -EPROBE_DEFER;
>
> wouldn't it make more sense to wait for the data to become ready, maybe
> with a timeout?

Ok.

>
>> +     if (r < 0)
>> +             return r;
>> +
>> +     r = devm_iio_device_register(&client->dev, iio);
>> +     if (r)
>> +             return r;
>> +
>> +     i2c_set_clientdata(client, iio);
>> +
>> +     dev_info(&client->dev, "%s: sensor '%s'\n", dev_name(&iio->dev),
>> +                     client->name);
>
> no extra logging, this adds little extra information

I disagree - lets discuss it in my reply to Jonathan.

>
>> +     return 0;
>> +}
>
> turn off measurement in _remove()?

Ok.

Thanks for the review.

Cheers,

Joel
