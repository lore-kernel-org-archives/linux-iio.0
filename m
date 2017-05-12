Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36513 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753354AbdELGS5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 May 2017 02:18:57 -0400
MIME-Version: 1.0
In-Reply-To: <0f4989af-1511-7977-50d5-9921277cfc7d@kernel.org>
References: <20170504071937.25663-1-joel@jms.id.au> <0f4989af-1511-7977-50d5-9921277cfc7d@kernel.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 12 May 2017 15:48:35 +0930
Message-ID: <CACPK8XfNX4JqYa2NA0JHpB13FFZLbZsaV+0u7Wu_Ck5zY54EOQ@mail.gmail.com>
Subject: Re: [PATCH] iio: Add driver for Infineon DPS310
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, May 6, 2017 at 4:15 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 04/05/17 08:19, Joel Stanley wrote:
>> The DPS310 is a temperature and pressure sensor. It can be accessed over
>> i2c and SPI.
>>
>> This driver supports polled measurement of temperature over i2c only.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Few bits inline, but looks pretty good for a v1.

Thanks for the reivew.

>> +#include <linux/module.h>
>> +#include <linux/i2c.h>
>> +#include <linux/regmap.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
> Slight preference for alphabetical order though grouping the iio
> ones at the end is fine.

Ok.

>> +
> General preference in IIO is to prefix
> all defines with something driver appropriate.
>
> DPS310_PRS_BASE etc

Sure.

>
> Avoids potential mess down the line with defines
> in headers. Lots of these are very generic so
> that's not implausible.
>> +#define PRS_BASE     0x00
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
> You define these but then have it long hand in the code?

I will drop these I think. I've reworked the code a few times and
these were left over.

>> +static int dps310_get_temp_k(struct dps310_data *data)
>> +{
>> +     int index =3D ilog2(dps310_get_temp_precision(data));
>> +
>> +     return scale_factor[index];
> I'd just put the whole thing in one line, but up to you.

I previously had a check here that the range was not out of range but
I dropped the check as it can't happen.

I'll put it on one line.

>> +static bool dps310_is_volatile_reg(struct device *dev, unsigned int reg=
)
>> +{
>> +     switch (reg) {
>> +     case PRS_BASE ... (PRS_BASE + 2):
> Bit ugly defining this like this.  IS PRS_BASE + 2 something that has
> a logical name of its own?

Agreed. I used to have PRS_B0, PRS_B1, PRS_B2 as we read out the three
bytes at once they were not required. I'll clean it up.


>> +
>> +static int dps310_read_raw(struct iio_dev *iio,
>> +                        struct iio_chan_spec const *chan,
>> +                        int *val, int *val2, long mask)
>> +{
>> +     struct dps310_data *data =3D iio_priv(iio);
>> +     int ret;
>> +
>> +     /* c0 * 0.5 + c1 * T_raw / kT =C2=B0C */
> Whilst interesting why is this comment right here?

Will move it to the top of the file.

>> +
>> +static int dps310_probe(struct i2c_client *client,
>> +                     const struct i2c_device_id *id)
>> +{
>> +     struct dps310_data *data;
>> +     struct iio_dev *iio;
>> +     int r;
>> +
>> +     iio =3D devm_iio_device_alloc(&client->dev,  sizeof(*data));
>> +     if (!iio)
>> +             return -ENOMEM;
>> +
>> +     data =3D iio_priv(iio);
>> +     data->client =3D client;
>> +
>> +     iio->dev.parent =3D &client->dev;
>> +     iio->name =3D id->name;
>> +     iio->channels =3D dps310_channels;
>> +     iio->num_channels =3D ARRAY_SIZE(dps310_channels);
>> +     iio->info =3D &dps310_info;
>> +     iio->modes =3D INDIO_DIRECT_MODE;
>> +
>> +     data->regmap =3D devm_regmap_init_i2c(client, &dps310_regmap_confi=
g);
>> +     if (IS_ERR(data->regmap))
>> +             return PTR_ERR(data->regmap);
>> +
> Not that obvious what the next two calls are doing, perhaps comments?
> (the third one is good)

Ack.

>> +     r =3D regmap_write(data->regmap, TMP_CFG, TMP_EXT | TMP_PRC(1));
>> +     if (r < 0)
>> +             return r;
>> +     r =3D regmap_write_bits(data->regmap, CFG_REG, TMP_SHIFT_EN, 0);
>> +     if (r < 0)
>> +             return r;
>> +
>> +     /* Turn on temperature measurement in the background */
>> +     r =3D regmap_write_bits(data->regmap, MEAS_CFG, MEAS_CTRL_BITS,
>> +                     TEMP_EN | BACKGROUND);
>> +     if (r < 0)
>> +             return r;
>> +
>> +     /*
>> +      * Calibration coefficients required for reporting temperature.
>> +      * They are availalbe 40ms after the device has started
> available
>> +      */
>> +     r =3D dps310_get_temp_coef(data);
>> +     if (r =3D=3D -EAGAIN)
>> +             return -EPROBE_DEFER;
> Deferred why?  If you need 40ms then sleep for 40ms to be sure it
> has woken up. Or even better, loop with a sleep.

I didn't want to delay booting the system for the driver to probe.

>
> Deferred will only result in it being probed if something changes
> such as another driver being loaded (which might provide
> some resource we are waiting for).

Ok, I misunderstood how it worked. Thanks for clearing that up.

I will put the loop/sleep in.

>> +     if (r < 0)
>> +             return r;
>> +
>> +     r =3D devm_iio_device_register(&client->dev, iio);
>> +     if (r)
>> +             return r;
> With the two lines below removed, just
> return devm_iio...
>> +
>> +     i2c_set_clientdata(client, iio);
> Used?

I must admit I was cargo culting. Can you explain under what
circumstances I would want this?

>> +
>> +     dev_info(&client->dev, "%s: sensor '%s'\n", dev_name(&iio->dev),
>> +                     client->name);
> Provides little useful information and just spams the log so
> I would prefer this was dropped.

I would really like the core to do something like this, for both hwmon
and iio devices. I spend a lot of time developing and using systems
that use these drivers, and it's very useful to know the name of the
driver, the bus it's on, and the fact that it was both compiled in and
probed.

Would you take a patch for the core?

Cheers,

Joel
