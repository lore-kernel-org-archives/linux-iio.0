Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13569 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751673AbcDRNHJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2016 09:07:09 -0400
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Subject: RE: [PATCH v2 1/2] iio: humidity: Add support for AM2315
Date: Mon, 18 Apr 2016 13:07:05 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F4023587FE1@IRSMSX109.ger.corp.intel.com>
References: <1460972543-27175-1-git-send-email-tiberiu.a.breana@intel.com>
 <1460972543-27175-2-git-send-email-tiberiu.a.breana@intel.com>
 <alpine.DEB.2.02.1604181204400.6094@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1604181204400.6094@pmeerw.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> -----Original Message-----
> From: Peter Meerwald-Stadler [mailto:pmeerw@pmeerw.net]
> Sent: Monday, April 18, 2016 1:16 PM
> To: Breana, Tiberiu A <tiberiu.a.breana@intel.com>
> Cc: linux-iio@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>
> Subject: Re: [PATCH v2 1/2] iio: humidity: Add support for AM2315
> 
> > Add basic support for the Aosong AM2315 relative humidity and ambient
> > temperature sensor.
> > Includes support for raw readings and ACPI detection.
> 
> comments below

Thanks for your review. Some replies inline.

Tiberiu

> 
> > Datasheet:
> > http://www.aosong.com/asp_bin/Products/en/AM2315.pdf
> >
> > Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
> > ---
> >  drivers/iio/humidity/Kconfig  |  10 ++
> >  drivers/iio/humidity/Makefile |   1 +
> >  drivers/iio/humidity/am2315.c | 212
> > ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 223 insertions(+)
> >  create mode 100644 drivers/iio/humidity/am2315.c
> >
> > diff --git a/drivers/iio/humidity/Kconfig
> > b/drivers/iio/humidity/Kconfig index 866dda1..738a86d 100644
> > --- a/drivers/iio/humidity/Kconfig
> > +++ b/drivers/iio/humidity/Kconfig
> > @@ -3,6 +3,16 @@
> >  #
> >  menu "Humidity sensors"
> >
> > +config AM2315
> > +    tristate "Aosong AM2315 relative humidity and temperature sensor"
> > +    depends on I2C
> > +    help
> > +      If you say yes here you get support for the Aosong AM2315
> > +      relative humidity and ambient temperature sensor.
> > +
> > +      This driver can also be built as a module. If so, the module will
> > +      be called am2315.
> > +
> >  config DHT11
> >  	tristate "DHT11 (and compatible sensors) driver"
> >  	depends on GPIOLIB || COMPILE_TEST
> > diff --git a/drivers/iio/humidity/Makefile
> > b/drivers/iio/humidity/Makefile index c9f089a..4a73442 100644
> > --- a/drivers/iio/humidity/Makefile
> > +++ b/drivers/iio/humidity/Makefile
> > @@ -2,6 +2,7 @@
> >  # Makefile for IIO humidity sensor drivers  #
> >
> > +obj-$(CONFIG_AM2315) += am2315.o
> >  obj-$(CONFIG_DHT11) += dht11.o
> >  obj-$(CONFIG_HDC100X) += hdc100x.o
> >  obj-$(CONFIG_HTU21) += htu21.o
> > diff --git a/drivers/iio/humidity/am2315.c
> > b/drivers/iio/humidity/am2315.c new file mode 100644 index
> > 0000000..c374078
> > --- /dev/null
> > +++ b/drivers/iio/humidity/am2315.c
> > @@ -0,0 +1,212 @@
> > +/**
> > + * Aosong AM2315 relative humidity and temperature
> > + *
> > + * Copyright (c) 2016, Intel Corporation.
> > + *
> > + * This file is subject to the terms and conditions of version 2 of
> > + * the GNU General Public License. See the file COPYING in the main
> > + * directory of this archive for more details.
> > + *
> > + * 7-bit I2C address: 0x5C.
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +#define AM2315_REG_HUM_MSB			0x00
> > +#define AM2315_REG_HUM_LSB			0x01
> > +#define AM2315_REG_TEMP_MSB			0x02
> > +#define AM2315_REG_TEMP_LSB			0x03
> > +
> > +#define AM2315_FUNCTION_READ			0x03
> > +#define AM2315_HUM_OFFSET			0
> > +#define AM2315_TEMP_OFFSET			2
> > +
> > +#define AM2315_DRIVER_NAME			"am2315"
> > +
> > +struct am2315_data {
> > +	struct i2c_client *client;
> 
> not needed as is, but I suggest to add a mutex below
> 
> > +};
> > +
> > +static const struct iio_chan_spec am2315_channels[] = {
> > +	{
> > +		.type = IIO_HUMIDITYRELATIVE,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE)
> > +	},
> > +	{
> > +		.type = IIO_TEMP,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE)
> > +	},
> > +};
> > +
> > +/* CRC calculation algorithm, as specified in the datasheet (page
> > +13). */ static u16 am2315_crc(u8 *data, u8 nr_bytes) {
> > +	int i;
> > +	u16 crc = 0xffff;
> > +
> > +	while (nr_bytes--) {
> > +		crc ^= *data++;
> > +		for (i = 0; i < 8; i++) {
> > +			if (crc & 0x01) {
> > +				crc >>= 1;
> > +				crc ^= 0xA001;
> > +			} else {
> > +				crc >>= 1;
> > +			}
> > +		}
> > +	}
> > +
> > +	return crc;
> > +}
> > +
> > +/* Simple function that sends a few bytes to the device to wake it
> > +up. */
> 
> drop inline

May I ask why? What's the difference?

> 
> the comment is not very precise: this SENDS the chip address and the
> register value, then RECEIVES a BYTE (or maybe not)

I agree that the comment does not 100% accurately describe what the function
does, but it does explain its purpose. The function's return value is discarded
as there are no bytes received, because the device does not implement the
smbus standard.

> 
> > +static inline void am2315_ping(struct i2c_client *client) {
> > +	i2c_smbus_read_byte_data(client, AM2315_REG_HUM_MSB); }
> > +
> > +static int am2315_read_data(struct i2c_client *client, u8 *rx_buf) {
> > +	int ret;
> > +	/* tx_buf format: <function code> <start addr> <nr of regs to read>
> */
> > +	u8 tx_buf[3] = { AM2315_FUNCTION_READ,
> AM2315_REG_HUM_MSB, 4 };
> > +	u16 crc;
> > +
> 
> you need a mutex around here

I will add a mutex in v3.

> 
> > +	/* First wake up the device. */
> > +	am2315_ping(client);
> > +
> > +	ret = i2c_master_send(client, tx_buf, sizeof(tx_buf));
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "failed to send read request\n");
> > +		return ret;
> > +	}
> > +	/* Wait 2-3 ms, then read back the data sent by the device. */
> > +	usleep_range(2000, 3000);
> > +
> > +	ret = i2c_master_recv(client, rx_buf, sizeof(rx_buf));
> 
> this seems very wrong; sizeof(rx_buf) is the size of a pointer

It is indeed wrong. It was merely a coincidence that sizeof(rx_buf)
and the actual array size were both 8. To be fixed in v3.

> 
> > +	if (ret < 0) {
> > +		dev_err(&client->dev, "failed to read sensor data\n");
> > +		return ret;
> > +	}
> > +	/*
> > +	 * Do a CRC check on the data and compare it to the value
> > +	 * calculated by the device.
> > +	 */
> > +	crc = am2315_crc(rx_buf, sizeof(rx_buf) - 2);
> > +	if ((crc & 0xff) != rx_buf[6] || (crc >> 8) != rx_buf[7]) {
> > +		dev_err(&client->dev, "failed to verify sensor data\n");
> > +		return -EIO;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int am2315_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan,
> > +			   int *val, int *val2, long mask) {
> > +	int ret;
> > +	u8 rx_buf[8];
> > +	u8 offset;
> > +	struct am2315_data *data = iio_priv(indio_dev);
> > +	struct i2c_client *client = data->client;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		offset = (chan->type == IIO_HUMIDITYRELATIVE) ?
> > +				AM2315_HUM_OFFSET :
> AM2315_TEMP_OFFSET;
> > +		/* Do a bulk data read, then pick out what we need. */
> > +		ret = am2315_read_data(client, rx_buf);
> > +		if (ret < 0)
> > +			return ret;
> > +		/*
> > +		 * rx_buf format:
> > +		 * <function code> <number of registers read>
> > +		 * <humidity MSB> <humidity LSB> <temp MSB> <temp LSB>
> > +		 * <CRC LSB> <CRC MSB>
> > +		 */
> > +		*val = (rx_buf[offset + 2] << 8) | rx_buf[offset + 3];
> 
> the + 2 could go into AM2315_HUM_OFFSET and AM2315_TEMP_OFFSET,
> resp.
> 
> a packed struct with the fields would be even nicer

Will make these changes in v3.

> 
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val = 100;
> > +		return IIO_VAL_INT;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static const struct iio_info am2315_info = {
> > +	.driver_module		= THIS_MODULE,
> > +	.read_raw		= am2315_read_raw,
> > +};
> > +
> > +static int am2315_probe(struct i2c_client *client,
> > +			const struct i2c_device_id *id)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct am2315_data *data;
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +	if (!indio_dev) {
> > +		dev_err(&client->dev, "iio allocation failed!\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	data = iio_priv(indio_dev);
> > +	data->client = client;
> > +	i2c_set_clientdata(client, indio_dev);
> > +
> > +	indio_dev->dev.parent = &client->dev;
> > +	indio_dev->info = &am2315_info;
> > +	indio_dev->name = AM2315_DRIVER_NAME;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->channels = am2315_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(am2315_channels);
> > +
> > +	return iio_device_register(indio_dev);
> 
> could use devm_, but probably not due to subsequent patch
> 
> > +}
> > +
> > +static int am2315_remove(struct i2c_client *client) {
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > +
> > +	iio_device_unregister(indio_dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct i2c_device_id am2315_i2c_id[] = {
> > +	{"am2315", 0},
> > +	{}
> > +};
> > +
> > +static const struct acpi_device_id am2315_acpi_id[] = {
> > +	{"AOS2315", 0},
> > +	{}
> > +};
> > +
> > +MODULE_DEVICE_TABLE(acpi, am2315_acpi_id);
> > +
> > +static struct i2c_driver am2315_driver = {
> > +	.driver = {
> > +		.name = "am2315",
> > +		.acpi_match_table = ACPI_PTR(am2315_acpi_id),
> > +	},
> > +	.probe =            am2315_probe,
> > +	.remove =	    am2315_remove,
> > +	.id_table =         am2315_i2c_id,
> > +};
> > +
> > +module_i2c_driver(am2315_driver);
> > +
> > +MODULE_AUTHOR("Tiberiu Breana <tiberiu.a.breana@intel.com>");
> > +MODULE_DESCRIPTION("Aosong AM2315 relative humidity and
> > +temperature"); MODULE_LICENSE("GPL v2");
> >
> 
> --
> 
> Peter Meerwald-Stadler
> +43-664-2444418 (mobile)
