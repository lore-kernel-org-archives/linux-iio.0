Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:34631 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756546AbbDWHaK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Apr 2015 03:30:10 -0400
MIME-Version: 1.0
In-Reply-To: <1429641822-2007-1-git-send-email-tduszyns@gmail.com>
References: <1429641822-2007-1-git-send-email-tduszyns@gmail.com>
Date: Thu, 23 Apr 2015 10:30:09 +0300
Message-ID: <CAEnQRZBNMZTT7oB8xV+NU1gJg9FJXi_gqJivt3X1hkDhrtkcAA@mail.gmail.com>
Subject: Re: [PATCH] iio: light: add support for ROHM BH1710/BH1715/BH1721/BH1750/BH1751
 ambient light sensors
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Apr 21, 2015 at 9:43 PM, Tomasz Duszynski <tduszyns@gmail.com> wrote:
> Add support for ROHM BH1710/BH1715/BH1721/BH1750/BH1751 ambient light
> sensors.
>
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  drivers/iio/light/Kconfig  |  10 ++
>  drivers/iio/light/Makefile |   1 +
>  drivers/iio/light/bh1750.c | 322 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 333 insertions(+)
>  create mode 100644 drivers/iio/light/bh1750.c
>
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 5a3237b..9fb79ca 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -37,6 +37,16 @@ config APDS9300
>          To compile this driver as a module, choose M here: the
>          module will be called apds9300.
>
> +config BH1750
> +       tristate "BH1750 ambient light sensor"

Better use ROHM BH1750 .. here.


> +static const struct iio_chan_spec bh1750_channels[] = {
> +       {
> +               .type = IIO_INTENSITY,

Shouldn't this be IIO_LIGHT channel type?

Users will get illuminance after multiplying raw value with scale.

> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +                                     BIT(IIO_CHAN_INFO_SCALE) |
> +                                     BIT(IIO_CHAN_INFO_INT_TIME)
> +       }
> +};
> +
> +static int bh1750_probe(struct i2c_client *client,
> +                       const struct i2c_device_id *id)
> +{
> +       int ret, usec;
> +       struct bh1750_data *data;
> +       struct iio_dev *indio_dev;
> +
> +       if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |
> +                               I2C_FUNC_SMBUS_WRITE_BYTE))
> +               return -ENODEV;
> +
> +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       data = iio_priv(indio_dev);
> +       i2c_set_clientdata(client, indio_dev);
> +       data->client = client;
> +       data->chip_info = &chip_info_tbl[id->driver_data];
> +
> +       usec = data->chip_info->mtreg_to_usec * data->chip_info->mtreg_default;
> +       ret = bh1750_change_int_time(data, usec);
> +       if (ret < 0)
> +               return ret;
> +
> +       mutex_init(&data->lock);
> +       indio_dev->dev.parent = &client->dev;
> +       indio_dev->info = &bh1750_info;
> +       indio_dev->name = id->name;
> +       indio_dev->channels = bh1750_channels;
> +       indio_dev->num_channels = ARRAY_SIZE(bh1750_channels);
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +       return devm_iio_device_register(&client->dev, indio_dev);

You need also to add a remove function where the chip is powered down. Then
you shouldn't use devm_iio_device_register here, because you need to control
the order of chip powerdown/ device unregister operations at remove.

thanks,
Daniel.
