Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35390 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbdAZGRH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Jan 2017 01:17:07 -0500
Received: by mail-pg0-f67.google.com with SMTP id 204so21651796pge.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Jan 2017 22:17:06 -0800 (PST)
Date: Thu, 26 Jan 2017 14:17:01 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>
Subject: Re: [RFC] iio: accel: Add driver for the Analog Devices ADXL345
 3-axis accelerometer
Message-ID: <20170126061655.GA4604@Socrates-UM>
References: <1485336354-26566-1-git-send-email-eraretuya@gmail.com>
 <alpine.DEB.2.02.1701251030520.17520@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1701251030520.17520@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jan 25, 2017 at 10:37:33AM +0100, Peter Meerwald-Stadler wrote:
> 
> > Add basic IIO support for the Analog Devices ADXL345 3-axis accelerometer.
> > The datasheet can be found here:
> > http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL345.pdf
> 
> comments below
>  

Hello Peter,

Thanks for the review.

> > Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> > Cc: Michael Hennerich <michael.hennerich@analog.com>
> > Cc: Daniel Baluta <daniel.baluta@gmail.com>
> > Cc: Alison Schofield <amsfield22@gmail.com>
> > ---
> > Note that this sensor is already supported in input/misc/adxl34x. This IIO
> > driver only supports read_raw on x, y and z axes in full-resolution mode.
> > 
> >  drivers/iio/accel/Kconfig   |  10 +++
> >  drivers/iio/accel/Makefile  |   1 +
> >  drivers/iio/accel/adxl345.c | 173 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 184 insertions(+)
> >  create mode 100644 drivers/iio/accel/adxl345.c
> > 
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index ea295fe..b73f403 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -5,6 +5,16 @@
> >  
> >  menu "Accelerometers"
> >  
> > +config ADXL345
> > +	tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer Driver"
> > +	depends on I2C
> > +	help
> > +	  Say Y here if you want to build support for the Analog Devices
> > +	  ADXL345 3-axis digital accelerometer.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called adxl345.
> > +
> >  config BMA180
> >  	tristate "Bosch BMA180/BMA250 3-Axis Accelerometer Driver"
> >  	depends on I2C
> > diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> > index 69fe8ed..618488d 100644
> > --- a/drivers/iio/accel/Makefile
> > +++ b/drivers/iio/accel/Makefile
> > @@ -3,6 +3,7 @@
> >  #
> >  
> >  # When adding new entries keep the list in alphabetical order
> > +obj-$(CONFIG_ADXL345) += adxl345.o
> >  obj-$(CONFIG_BMA180) += bma180.o
> >  obj-$(CONFIG_BMA220) += bma220_spi.o
> >  obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
> > diff --git a/drivers/iio/accel/adxl345.c b/drivers/iio/accel/adxl345.c
> > new file mode 100644
> > index 0000000..54ea601
> > --- /dev/null
> > +++ b/drivers/iio/accel/adxl345.c
> > @@ -0,0 +1,173 @@
> > +/*
> > + * ADXL345 3-Axis Digital Accelerometer
> > + *
> > + * Copyright (c) 2017 Eva Rachel Retuya <eraretuya@gmail.com>
> > + *
> > + * This file is subject to the terms and conditions of version 2 of
> > + * the GNU General Public License. See the file COPYING in the main
> > + * directory of this archive for more details.
> > + *
> > + * IIO driver for ADXL345
> > + * 7-bit I2C slave address: 0x1D (ALT ADDRESS pin tied to VDDIO) or
> > + * 0x53 (ALT ADDRESS pin grounded)
> 
> buffered mode would be useful in order to get consistent measurements of 
> all three axis at once
> 

Noted. I'm waiting for feedback from others to see whether I can extend
this driver further.

> > + */
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +
> > +#include <linux/iio/iio.h>
> > +
> > +#define ADXL345_REG_DEVID		0x00
> > +#define ADXL345_REG_POWER_CTL		0x2D
> > +#define ADXL345_REG_DATA_FORMAT		0x31
> > +#define ADXL345_REG_DATAX0		0x32
> > +#define ADXL345_REG_DATAY0		0x34
> > +#define ADXL345_REG_DATAZ0		0x36
> > +
> > +#define ADXL345_POWER_CTL_MEASURE	BIT(3)
> > +#define ADXL345_POWER_CTL_STANDBY	0x00
> > +
> > +#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)
> 
> maybe state in comment that FULL_RES is 12 bit
> 

Ack.

> > +#define ADXL345_DATA_FORMAT_2G		0
> > +#define ADXL345_DATA_FORMAT_4G		1
> > +#define ADXL345_DATA_FORMAT_8G		2
> > +#define ADXL345_DATA_FORMAT_16G		3
> > +
> > +#define ADXL345_DEVID			0xE5
> > +
> > +struct adxl345_data {
> > +	struct i2c_client *client;
> > +	u8 data_range;
> > +};
> > +
> > +#define ADXL345_CHANNEL(reg, axis) {					\
> > +	.type = IIO_ACCEL,						\
> > +	.modified = 1,							\
> > +	.channel2 = IIO_MOD_##axis,					\
> > +	.address = reg,							\
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> 
> haven't checked but likely we need _SCALE to present the correct unit of 
> measurement
> 

I was told to send just the raw measurement only however, I have a patch ready
with the scale in mind.

> > +}
> > +
> > +static const struct iio_chan_spec adxl345_channels[] = {
> > +	ADXL345_CHANNEL(ADXL345_REG_DATAX0, X),
> > +	ADXL345_CHANNEL(ADXL345_REG_DATAY0, Y),
> > +	ADXL345_CHANNEL(ADXL345_REG_DATAZ0, Z),
> > +};
> > +
> > +static int adxl345_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val, int *val2, long mask)
> > +{
> > +	struct adxl345_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		/*
> > +		 * Data is stored in adjacent registers:
> > +		 * ADXL345_REG_DATA(X0/Y0/Z0) contain the least significant byte
> > +		 * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significant byte
> > +		 */
> 
> there is no data ready? we might get old data?
> 

This is just a simple IIO driver so yes, not yet implemented.

> > +		ret = i2c_smbus_read_word_data(data->client, chan->address);
> > +
> 
> drop newline
> 

Ack.

> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		*val = sign_extend32(le16_to_cpu(ret), 12);
> 
> le16_to_cpu() not needed, I2C read_word_data does it for you
> 

Ack.

> > +		return IIO_VAL_INT;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static const struct iio_info adxl345_info = {
> > +	.driver_module	= THIS_MODULE,
> > +	.read_raw	= adxl345_read_raw,
> > +};
> > +
> > +static int adxl345_probe(struct i2c_client *client,
> > +			 const struct i2c_device_id *id)
> > +{
> > +	struct adxl345_data *data;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +
> > +	ret = i2c_smbus_read_byte_data(client, ADXL345_REG_DEVID);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "Error reading device ID: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	if (ret != ADXL345_DEVID) {
> > +		dev_err(&client->dev, "Invalid device ID: %d\n", ret);
> > +		return -ENODEV;
> > +	}
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	i2c_set_clientdata(client, indio_dev);
> > +	data->client = client;
> > +	/* Enable full-resolution mode */
> > +	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
> > +
> > +	ret = i2c_smbus_write_byte_data(data->client, ADXL345_REG_DATA_FORMAT,
> > +					data->data_range);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "Failed to set data range: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	indio_dev->dev.parent = &client->dev;
> > +	indio_dev->name = id->name;
> > +	indio_dev->info = &adxl345_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->channels = adxl345_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
> > +
> > +	/* Enable measurement mode */
> > +	ret = i2c_smbus_write_byte_data(data->client, ADXL345_REG_POWER_CTL,
> > +					ADXL345_POWER_CTL_MEASURE);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "Failed to enable measurement mode: %d\n",
> > +			ret);
> > +		return ret;
> > +	}
> > +
> > +	return iio_device_register(indio_dev);
> 
> stop measurement mode if registration fails
> 

Ack.

Best Regards,
Eva

> > +}
> > +
> > +static int adxl345_remove(struct i2c_client *client)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > +	struct adxl345_data *data = iio_priv(indio_dev);
> > +
> > +	iio_device_unregister(indio_dev);
> > +
> > +	return i2c_smbus_write_byte_data(data->client, ADXL345_REG_POWER_CTL,
> > +					 ADXL345_POWER_CTL_STANDBY);
> > +}
> > +
> > +static const struct i2c_device_id adxl345_i2c_id[] = {
> > +	{ "adxl345", 0 },
> > +	{ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
> > +
> > +static struct i2c_driver adxl345_driver = {
> > +	.driver = {
> > +		.name	= "adxl345",
> > +	},
> > +	.probe		= adxl345_probe,
> > +	.remove		= adxl345_remove,
> > +	.id_table	= adxl345_i2c_id,
> > +};
> > +
> > +module_i2c_driver(adxl345_driver);
> > +
> > +MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
> > +MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer driver");
> > +MODULE_LICENSE("GPL v2");
> > 
> 
> -- 
> 
> Peter Meerwald-Stadler
> +43-664-2444418 (mobile)
