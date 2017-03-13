Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34820 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbdCML55 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 07:57:57 -0400
MIME-Version: 1.0
In-Reply-To: <1489403497-27849-3-git-send-email-eraretuya@gmail.com>
References: <1489403497-27849-1-git-send-email-eraretuya@gmail.com> <1489403497-27849-3-git-send-email-eraretuya@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 13 Mar 2017 13:57:55 +0200
Message-ID: <CAHp75Vc59x4FFwKnJg-LeQWan21RZLMPz20MKmkoBAKihdZF3A@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: accel: adxl345_core: Introduce set_mode, drdy &
 get_triple functions
To: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 13, 2017 at 1:11 PM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
> Move code that enables measurement/standby mode into its own function
> and call that function when appropriate. Previously, we set the sensor
> to measurement in probe and back to standby during remove. Change it
> here to only enter measurement mode when request for data is initiated.
>
> The DATA_READY bit is always set if the corresponding event occurs.
> Introduce the drdy function that monitors the INT_SOURCE register of
> this bit. This is done to ensure consistent readings.
>
> Make use of drdy in read_raw and also refactor the read to perform an
> all-axes read instead through get_triple. This function will come in
> handy when buffered reading is introduced.

> +static int adxl345_get_triple(struct adxl345_data *data, void *buf)
> +{
> +       struct device *dev = regmap_get_device(data->regmap);
> +       int ret;
> +

> +       ret = regmap_bulk_read(data->regmap, ADXL345_REG_DATAX0, buf,
> +                              sizeof(__le16) * 3);

Magic.

> +static int adxl345_drdy(struct adxl345_data *data)

Name is not speaking for itself.

Perhaps
_data_ready(...)

> +{
> +       struct device *dev = regmap_get_device(data->regmap);
> +       int tries = 5;
> +       u32 regval;
> +       int ret;
> +

> +       while (tries--) {

do {} while pattern a bit better here, since it shows explicitly that
you run the code at least once.

> +               ret = regmap_read(data->regmap, ADXL345_REG_INT_SOURCE,
> +                                 &regval);

If you rename regval to val (or v) it would fit one line I guess.

> +               if (ret < 0)
> +                       return ret;
> +               if ((regval & ADXL345_INT_DATA_READY) ==
> +                   ADXL345_INT_DATA_READY)
> +                       return 0;
> +

> +               msleep(20);

This needs explanation. (It's too long for usual IO delays)

> +       }
> +       dev_err(dev, "Data is not yet ready\n");
> +
> +       return -EIO;

Hmm... Not sure which error code is better here, though EIO is possible.

> @@ -67,22 +125,37 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>                             int *val, int *val2, long mask)
>  {
>         struct adxl345_data *data = iio_priv(indio_dev);

> -       __le16 regval;
> +       s16 regval[3];

I'm not sure this is equivalent change. Have you tried to test this
code on different endianess?

>         int ret;
>
>         switch (mask) {
>         case IIO_CHAN_INFO_RAW:
> -               /*
> -                * Data is stored in adjacent registers:
> -                * ADXL345_REG_DATA(X0/Y0/Z0) contain the least significant byte
> -                * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significant byte
> -                */
> -               ret = regmap_bulk_read(data->regmap, chan->address, &regval,
> -                                      sizeof(regval));
> +               ret = adxl345_set_mode(data, ADXL345_POWER_CTL_MEASURE);
> +               if (ret < 0)
> +                       return ret;

+ empty line here.

> +               ret = adxl345_drdy(data);
> +               if (ret < 0)
> +                       return ret;
> +
> +               ret = adxl345_get_triple(data, &regval);
>                 if (ret < 0)
>                         return ret;
>

> -               *val = sign_extend32(le16_to_cpu(regval), 12);
> +               switch (chan->address) {
> +               case ADXL345_REG_DATAX0:
> +                       *val = regval[0];
> +                       break;
> +               case ADXL345_REG_DATAY0:
> +                       *val = regval[1];
> +                       break;
> +               case ADXL345_REG_DATAZ0:
> +                       *val = regval[2];
> +                       break;

Yes, I'm worrying about endianess here.

> @@ -126,9 +199,12 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>         data = iio_priv(indio_dev);
>         dev_set_drvdata(dev, indio_dev);
>         data->regmap = regmap;
> +       /* Make sure sensor is in standby mode before configuring registers */
> +       ret = adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
> +       if (ret < 0)
> +               return ret;
>         /* Enable full-resolution mode */
>         data->data_range = ADXL345_DATA_FORMAT_FULL_RES;

> -

This doesn't belong to the patch, and perhaps you may put _set_mode()
call here surrounded by empty lines.

-- 
With Best Regards,
Andy Shevchenko
