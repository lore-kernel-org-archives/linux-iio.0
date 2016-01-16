Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53057 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbcAPLT2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jan 2016 06:19:28 -0500
Subject: Re: [PATCH v2 2/2] iio: pressure: mpl115: support MPL115A1
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-iio@vger.kernel.org
References: <1452873603-17381-1-git-send-email-akinobu.mita@gmail.com>
 <1452873603-17381-2-git-send-email-akinobu.mita@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <569A273B.1030907@kernel.org>
Date: Sat, 16 Jan 2016 11:19:23 +0000
MIME-Version: 1.0
In-Reply-To: <1452873603-17381-2-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/01/16 16:00, Akinobu Mita wrote:
> mpl115 driver currently supports i2c interface (MPL115A2).
> There is also SPI version (MPL115A1).  The difference between them
> is only physical transport so we can easily support both while sharing
> most of the code.
> 
> Split the driver into a core support module and one module each for I2C
> and SPI support.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: linux-iio@vger.kernel.org
Looks pretty good to me - couple of comments and utterly trivial nitpicks
inline (I'll fix those up whilst applying unless you end up doing another
version to address comments from other reiewers).

Would like to leave this on the list for a week though to let Peter / Lars
(and others of course!) take a look at the patch if they would like to.

Jonathan
> ---
> * v2
> - split the driver into a core support module and one module each
>   for I2C and SPI support, suggested by Lars-Peter Clausen
> 
>  drivers/iio/pressure/Kconfig      |  17 +++++-
>  drivers/iio/pressure/Makefile     |   2 +
>  drivers/iio/pressure/mpl115.c     |  65 ++++++++++-------------
>  drivers/iio/pressure/mpl115.h     |  25 +++++++++
>  drivers/iio/pressure/mpl115_i2c.c |  71 +++++++++++++++++++++++++
>  drivers/iio/pressure/mpl115_spi.c | 107 ++++++++++++++++++++++++++++++++++++++
>  6 files changed, 248 insertions(+), 39 deletions(-)
>  create mode 100644 drivers/iio/pressure/mpl115.h
>  create mode 100644 drivers/iio/pressure/mpl115_i2c.c
>  create mode 100644 drivers/iio/pressure/mpl115_spi.c
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index 6f2e7c9..e8f60db 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -31,14 +31,29 @@ config HID_SENSOR_PRESS
>            will be called hid-sensor-press.
>  
>  config MPL115
> +	tristate
> +
> +config MPL115_I2C
>  	tristate "Freescale MPL115A2 pressure sensor driver"
>  	depends on I2C
> +	select MPL115
>  	help
>  	  Say yes here to build support for the Freescale MPL115A2
>  	  pressure sensor connected via I2C.
>  
>            To compile this driver as a module, choose M here: the module
> -          will be called mpl115.
> +          will be called mpl115_i2c.
Hmm. Nothing to do with your patch (other than you continue what is already
there) but this whole file has a random mix of spacing vs tabs for indenting.
Clearly wants a trivial cleanup patch at some point.

> +
> +config MPL115_SPI
> +	tristate "Freescale MPL115A1 pressure sensor driver"
> +	depends on SPI_MASTER
> +	select MPL115
> +	help
> +	  Say yes here to build support for the Freescale MPL115A1
> +	  pressure sensor connected via SPI.
> +
> +          To compile this driver as a module, choose M here: the module
> +          will be called mpl115_spi.
>  
>  config MPL3115
>  	tristate "Freescale MPL3115A2 pressure sensor driver"
> diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
> index 46571c96..d336af1 100644
> --- a/drivers/iio/pressure/Makefile
> +++ b/drivers/iio/pressure/Makefile
> @@ -6,6 +6,8 @@
>  obj-$(CONFIG_BMP280) += bmp280.o
>  obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
>  obj-$(CONFIG_MPL115) += mpl115.o
> +obj-$(CONFIG_MPL115_I2C) += mpl115_i2c.o
> +obj-$(CONFIG_MPL115_SPI) += mpl115_spi.o
>  obj-$(CONFIG_MPL3115) += mpl3115.o
>  obj-$(CONFIG_MS5611) += ms5611_core.o
>  obj-$(CONFIG_MS5611_I2C) += ms5611_i2c.o
> diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
> index 3e1e3353..138344c 100644
> --- a/drivers/iio/pressure/mpl115.c
> +++ b/drivers/iio/pressure/mpl115.c
> @@ -1,5 +1,5 @@
>  /*
> - * mpl115.c - Support for Freescale MPL115A2 pressure/temperature sensor
> + * mpl115.c - Support for Freescale MPL115A pressure/temperature sensor
>   *
>   * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
>   *
> @@ -7,17 +7,16 @@
>   * the GNU General Public License.  See the file COPYING in the main
>   * directory of this archive for more details.
>   *
> - * (7-bit I2C slave address 0x60)
> - *
>   * TODO: shutdown pin
>   *
>   */
>  
>  #include <linux/module.h>
> -#include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  #include <linux/delay.h>
>  
> +#include "mpl115.h"
> +
>  #define MPL115_PADC 0x00 /* pressure ADC output value, MSB first, 10 bit */
>  #define MPL115_TADC 0x02 /* temperature ADC output value, MSB first, 10 bit */
>  #define MPL115_A0 0x04 /* 12 bit integer, 3 bit fraction */
> @@ -27,16 +26,18 @@
>  #define MPL115_CONVERT 0x12 /* convert temperature and pressure */
>  
>  struct mpl115_data {
> -	struct i2c_client *client;
> +	struct device *dev;
>  	struct mutex lock;
>  	s16 a0;
>  	s16 b1, b2;
>  	s16 c12;
> +	const struct mpl115_ops *ops;
>  };
>  
>  static int mpl115_request(struct mpl115_data *data)
>  {
> -	int ret = i2c_smbus_write_byte_data(data->client, MPL115_CONVERT, 0);
> +	int ret = data->ops->write(data->dev, MPL115_CONVERT, 0);
> +
>  	if (ret < 0)
>  		return ret;
>  
> @@ -57,12 +58,12 @@ static int mpl115_comp_pressure(struct mpl115_data *data, int *val, int *val2)
>  	if (ret < 0)
>  		goto done;
>  
> -	ret = i2c_smbus_read_word_swapped(data->client, MPL115_PADC);
> +	ret = data->ops->read(data->dev, MPL115_PADC);
>  	if (ret < 0)
>  		goto done;
>  	padc = ret >> 6;
>  
> -	ret = i2c_smbus_read_word_swapped(data->client, MPL115_TADC);
> +	ret = data->ops->read(data->dev, MPL115_TADC);
>  	if (ret < 0)
>  		goto done;
>  	tadc = ret >> 6;
> @@ -90,7 +91,7 @@ static int mpl115_read_temp(struct mpl115_data *data)
>  	ret = mpl115_request(data);
>  	if (ret < 0)
>  		goto done;
> -	ret = i2c_smbus_read_word_swapped(data->client, MPL115_TADC);
> +	ret = data->ops->read(data->dev, MPL115_TADC);
>  done:
>  	mutex_unlock(&data->lock);
>  	return ret;
> @@ -145,65 +146,53 @@ static const struct iio_info mpl115_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> -static int mpl115_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +int mpl115_probe(struct device *dev, const char *name,
> +			const struct mpl115_ops *ops)
>  {
>  	struct mpl115_data *data;
>  	struct iio_dev *indio_dev;
>  	int ret;
>  
> -	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> -		return -ENODEV;
> -
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
> -	data->client = client;
> +	data->dev = dev;
> +	data->ops = ops;
>  	mutex_init(&data->lock);
>  
>  	indio_dev->info = &mpl115_info;
> -	indio_dev->name = id->name;
> -	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = name;
> +	indio_dev->dev.parent = dev;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = mpl115_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(mpl115_channels);
>  
> -	ret = i2c_smbus_read_word_swapped(data->client, MPL115_A0);
> +	ret = data->ops->init(data->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = data->ops->read(data->dev, MPL115_A0);
>  	if (ret < 0)
>  		return ret;
>  	data->a0 = ret;
> -	ret = i2c_smbus_read_word_swapped(data->client, MPL115_B1);
> +	ret = data->ops->read(data->dev, MPL115_B1);
>  	if (ret < 0)
>  		return ret;
>  	data->b1 = ret;
> -	ret = i2c_smbus_read_word_swapped(data->client, MPL115_B2);
> +	ret = data->ops->read(data->dev, MPL115_B2);
>  	if (ret < 0)
>  		return ret;
>  	data->b2 = ret;
> -	ret = i2c_smbus_read_word_swapped(data->client, MPL115_C12);
> +	ret = data->ops->read(data->dev, MPL115_C12);
>  	if (ret < 0)
>  		return ret;
>  	data->c12 = ret;
>  
> -	return devm_iio_device_register(&client->dev, indio_dev);
> +	return devm_iio_device_register(dev, indio_dev);
>  }
> -
> -static const struct i2c_device_id mpl115_id[] = {
> -	{ "mpl115", 0 },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(i2c, mpl115_id);
> -
> -static struct i2c_driver mpl115_driver = {
> -	.driver = {
> -		.name	= "mpl115",
> -	},
> -	.probe = mpl115_probe,
> -	.id_table = mpl115_id,
> -};
> -module_i2c_driver(mpl115_driver);
> +EXPORT_SYMBOL_GPL(mpl115_probe);
>  
>  MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
>  MODULE_DESCRIPTION("Freescale MPL115 pressure/temperature driver");
> diff --git a/drivers/iio/pressure/mpl115.h b/drivers/iio/pressure/mpl115.h
> new file mode 100644
> index 0000000..77efbad
> --- /dev/null
> +++ b/drivers/iio/pressure/mpl115.h
> @@ -0,0 +1,25 @@
> +/*
> + * Freescale MPL115A pressure/temperature sensor
> + *
> + * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
> + * Copyright (c) 2016 Akinobu Mita <akinobu.mita@gmail.com>
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + *
Nitpick ;) No need for blank comment line here.
> + */
> +
> +#ifndef _MPL115_H_
> +#define _MPL115_H_
> +
> +struct mpl115_ops {
> +	int (*init)(struct device *);
> +	int (*read)(struct device *, u8);
> +	int (*write)(struct device *, u8, u8);
> +};
> +
> +int mpl115_probe(struct device *dev, const char *name,
> +			const struct mpl115_ops *ops);
> +
> +#endif
> diff --git a/drivers/iio/pressure/mpl115_i2c.c b/drivers/iio/pressure/mpl115_i2c.c
> new file mode 100644
> index 0000000..098b45f
> --- /dev/null
> +++ b/drivers/iio/pressure/mpl115_i2c.c
> @@ -0,0 +1,71 @@
> +/*
> + * Freescale MPL115A2 pressure/temperature sensor
> + *
> + * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * (7-bit I2C slave address 0x60)
> + *
> + * Datasheet: http://www.nxp.com/files/sensors/doc/data_sheet/MPL115A2.pdf
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +
> +#include "mpl115.h"
> +
> +static int mpl115_i2c_init(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int mpl115_i2c_read(struct device *dev, u8 address)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	return i2c_smbus_read_word_swapped(client, address);
I'd roll these into one line for compactness as the separation doesn't
add anything significant to readability. i.e.
    	return i2c_smbus_read_word_swapped(to_i2c_client(dev), address);
> +}
> +
> +static int mpl115_i2c_write(struct device *dev, u8 address, u8 value)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +
> +	return i2c_smbus_write_byte_data(client, address, value);
> +}
> +
> +static const struct mpl115_ops mpl115_i2c_ops = {
> +	.init = mpl115_i2c_init,
> +	.read = mpl115_i2c_read,
> +	.write = mpl115_i2c_write,
> +};
> +
> +static int mpl115_i2c_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> +		return -ENODEV;
> +
> +	return mpl115_probe(&client->dev, id->name, &mpl115_i2c_ops);
> +}
> +
> +static const struct i2c_device_id mpl115_i2c_id[] = {
> +	{ "mpl115", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mpl115_i2c_id);
> +
> +static struct i2c_driver mpl115_i2c_driver = {
> +	.driver = {
> +		.name	= "mpl115",
> +	},
> +	.probe = mpl115_i2c_probe,
> +	.id_table = mpl115_i2c_id,
> +};
> +module_i2c_driver(mpl115_i2c_driver);
> +
> +MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
> +MODULE_DESCRIPTION("Freescale MPL115A2 pressure/temperature driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/pressure/mpl115_spi.c b/drivers/iio/pressure/mpl115_spi.c
> new file mode 100644
> index 0000000..eae779b
> --- /dev/null
> +++ b/drivers/iio/pressure/mpl115_spi.c
> @@ -0,0 +1,107 @@
> +/*
> + * Freescale MPL115A1 pressure/temperature sensor
> + *
> + * Copyright (c) 2016 Akinobu Mita <akinobu.mita@gmail.com>
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * Datasheet: http://www.nxp.com/files/sensors/doc/data_sheet/MPL115A1.pdf
> + *
Another blank line that isn't useful or necessary.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +
> +#include "mpl115.h"
> +
> +#define MPL115_SPI_WRITE(address)	((address) << 1)
> +#define MPL115_SPI_READ(address)	(0x80 | (address) << 1)
> +
> +struct mpl115_spi_buf {
> +	u8 tx[4];
> +	u8 rx[4];
> +};
> +
> +static int mpl115_spi_init(struct device *dev)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct mpl115_spi_buf *buf;
> +
> +	buf = devm_kzalloc(dev, sizeof(*buf), GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	spi_set_drvdata(spi, buf);
> +
> +	return 0;
> +}
> +
> +static int mpl115_spi_read(struct device *dev, u8 address)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct mpl115_spi_buf *buf = spi_get_drvdata(spi);
> +	struct spi_transfer xfer = {
> +		.tx_buf = buf->tx,
> +		.rx_buf = buf->rx,
> +		.len = 4,
> +	};
> +	int ret;
> +
> +	buf->tx[0] = MPL115_SPI_READ(address);
> +	buf->tx[2] = MPL115_SPI_READ(address + 1);
Hmm. Got to love a device that presents 16bit registers over i2c and
8 bit ones over spi.  Up until this I was wondering if this would
fit sensibly into regmap.  Could probably still be done, but perhaps
more effort that it's worth!

> +
> +	ret = spi_sync_transfer(spi, &xfer, 1);
> +	if (ret)
> +		return ret;
> +
> +	return (buf->rx[1] << 8) | buf->rx[3];
> +}
> +
> +static int mpl115_spi_write(struct device *dev, u8 address, u8 value)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct mpl115_spi_buf *buf = spi_get_drvdata(spi);
> +	struct spi_transfer xfer = {
> +		.tx_buf = buf->tx,
> +		.len = 2,
> +	};
> +
> +	buf->tx[0] = MPL115_SPI_WRITE(address);
> +	buf->tx[1] = value;
> +
> +	return spi_sync_transfer(spi, &xfer, 1);
> +}
> +
> +static const struct mpl115_ops mpl115_spi_ops = {
> +	.init = mpl115_spi_init,
> +	.read = mpl115_spi_read,
> +	.write = mpl115_spi_write,
> +};
> +
> +static int mpl115_spi_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +
> +	return mpl115_probe(&spi->dev, id->name, &mpl115_spi_ops);
> +}
> +
> +static const struct spi_device_id mpl115_spi_ids[] = {
> +	{ "mpl115", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, mpl115_spi_ids);
> +
> +static struct spi_driver mpl115_spi_driver = {
> +	.driver = {
> +		.name   = "mpl115",
> +	},
> +	.probe = mpl115_spi_probe,
> +	.id_table = mpl115_spi_ids,
> +};
> +module_spi_driver(mpl115_spi_driver);
> +
> +MODULE_AUTHOR("Akinobu Mita <akinobu.mita@gmail.com>");
> +MODULE_DESCRIPTION("Freescale MPL115A1 pressure/temperature driver");
> +MODULE_LICENSE("GPL");
> 

