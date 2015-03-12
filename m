Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37113 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbbCLHYw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2015 03:24:52 -0400
Message-ID: <55013F40.5020004@kernel.org>
Date: Thu, 12 Mar 2015 07:24:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Tomasz Duszynski <tduszyns@gmail.com>
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: add support for MS5611 pressure and
 temperature sensor
References: <1426104718-24021-1-git-send-email-tduszyns@gmail.com>
In-Reply-To: <1426104718-24021-1-git-send-email-tduszyns@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/03/15 20:11, Tomasz Duszynski wrote:
> Add support for Measurement Specialities MS5611 pressure
> and temperature sensor.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Various trivial bits but one big one I missed in the previous
review (sorry, must have been asleep - unlike now where I haven't
woken up yet - hmm airports).

spi_write requires the buffer to sit in it's own cacheline.
(i.e. it requires a dma safe buffer which is not controllable
 when you use buffers on the stack).

Otherwise, looks good to me.

Jonathan
> ---
> 
>  Changes in v2:
> 	- Fix coding style
>      	- Document i2c slave addresses
>      	- Simplify device registration/removal using devm_iio_device_register()
> 	- Return temperature in mC and pressure in kPa
> 
>  drivers/iio/pressure/Kconfig       |  27 +++++
>  drivers/iio/pressure/Makefile      |   3 +
>  drivers/iio/pressure/ms5611.h      |  44 ++++++++
>  drivers/iio/pressure/ms5611_core.c | 213 +++++++++++++++++++++++++++++++++++++
>  drivers/iio/pressure/ms5611_i2c.c  | 126 ++++++++++++++++++++++
>  drivers/iio/pressure/ms5611_spi.c  | 127 ++++++++++++++++++++++
>  6 files changed, 540 insertions(+)
>  create mode 100644 drivers/iio/pressure/ms5611.h
>  create mode 100644 drivers/iio/pressure/ms5611_core.c
>  create mode 100644 drivers/iio/pressure/ms5611_i2c.c
>  create mode 100644 drivers/iio/pressure/ms5611_spi.c
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index a3be537..fa62950 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -52,6 +52,33 @@ config MPL3115
>            To compile this driver as a module, choose M here: the module
>            will be called mpl3115.
> 
> +config MS5611
> +	tristate "Measurement Specialities MS5611 pressure sensor driver"
> +	help
> +	  Say Y here to build support for the Measurement Specialities
> +	  MS5611 pressure and temperature sensor.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called ms5611_core.
> +
> +config MS5611_I2C
> +	tristate "support I2C bus connection"
> +	depends on I2C && MS5611
> +	help
> +	  Say Y here to build I2C bus support for MS5611.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called ms5611_i2c.
> +
> +config MS5611_SPI
> +	tristate "support SPI bus connection"
> +	depends on SPI_MASTER && MS5611
> +	help
> +	  Say Y here to build SPI bus support for MS5611.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called ms5611_spi.
> +
>  config IIO_ST_PRESS
>  	tristate "STMicroelectronics pressure sensor Driver"
>  	depends on (I2C || SPI_MASTER) && SYSFS
> diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
> index 88011f2..a4f98f8 100644
> --- a/drivers/iio/pressure/Makefile
> +++ b/drivers/iio/pressure/Makefile
> @@ -7,6 +7,9 @@ obj-$(CONFIG_BMP280) += bmp280.o
>  obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
>  obj-$(CONFIG_MPL115) += mpl115.o
>  obj-$(CONFIG_MPL3115) += mpl3115.o
> +obj-$(CONFIG_MS5611) += ms5611_core.o
> +obj-$(CONFIG_MS5611_I2C) += ms5611_i2c.o
> +obj-$(CONFIG_MS5611_SPI) += ms5611_spi.o
>  obj-$(CONFIG_IIO_ST_PRESS) += st_pressure.o
>  st_pressure-y := st_pressure_core.o
>  st_pressure-$(CONFIG_IIO_BUFFER) += st_pressure_buffer.o
> diff --git a/drivers/iio/pressure/ms5611.h b/drivers/iio/pressure/ms5611.h
> new file mode 100644
> index 0000000..099c6cd
> --- /dev/null
> +++ b/drivers/iio/pressure/ms5611.h
> @@ -0,0 +1,44 @@
> +/*
> + * MS5611 pressure and temperature sensor driver
> + *
> + * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef _MS5611_H
> +#define _MS5611_H
> +
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mutex.h>
> +
> +#define MS5611_RESET			0x1e
> +#define MS5611_READ_ADC			0x00
> +#define MS5611_READ_PROM_WORD		0xA0
> +#define MS5611_START_TEMP_CONV		0x58
> +#define MS5611_START_PRESSURE_CONV	0x48
> +
> +#define MS5611_CONV_TIME_MIN		9040
> +#define MS5611_CONV_TIME_MAX		10000
> +
> +#define MS5611_PROM_WORDS_NB		8
> +
> +struct ms5611_state {
> +	void *client;
> +	struct mutex lock;
> +
> +	int (*reset)(struct device *dev);
> +	int (*read_prom_word)(struct device *dev, int index, u16 *word);
> +	int (*read_adc_temp_and_pressure)(struct device *dev,
> +					  s32 *temp, s32 *pressure);
> +
> +	u16 prom[MS5611_PROM_WORDS_NB];
> +};
> +
> +int ms5611_probe(struct iio_dev *indio_dev, struct device *dev);
> +
> +#endif /* _MS5611_H */
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> new file mode 100644
> index 0000000..3d34644
> --- /dev/null
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -0,0 +1,213 @@
> +/*
> + * MS5611 pressure and temperature sensor driver
> + *
> + * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Data sheet:
> + *  http://www.meas-spec.com/downloads/MS5611-01BA03.pdf
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/iio/iio.h>
> +#include <linux/delay.h>
> +
> +#include "ms5611.h"
> +
> +static bool ms5611_prom_is_valid(u16 *prom, size_t len)
> +{
> +	int i, j;
> +	uint16_t crc = 0, crc_orig = prom[7] & 0x000F;
> +
> +	prom[7] &= 0xFF00;
> +
> +	for (i = 0; i < len * 2; i++) {
> +		if (i % 2 == 1)
> +			crc ^= prom[i >> 1] & 0x00FF;
> +		else
> +			crc ^= prom[i >> 1] >> 8;
> +
> +		for (j = 0; j < 8; j++) {
> +			if (crc & 0x8000)
> +				crc = (crc << 1) ^ 0x3000;
> +			else
> +				crc <<= 1;
> +		}
> +	}
> +
> +	crc = (crc >> 12) & 0x000F;
> +	return crc_orig != 0x0000 && crc == crc_orig;
> +}
> +
> +static int ms5611_read_prom(struct iio_dev *indio_dev)
> +{
> +	int ret, i;
> +	struct ms5611_state *st = iio_priv(indio_dev);
> +
> +	for (i = 0; i < MS5611_PROM_WORDS_NB; i++) {
> +		ret = st->read_prom_word(&indio_dev->dev, i, &st->prom[i]);
> +		if (ret < 0) {
> +			dev_err(&indio_dev->dev,
> +				"failed to read prom at %d\n", i);
> +			return ret;
> +		}
> +	}
> +
> +	if (!ms5611_prom_is_valid(st->prom, MS5611_PROM_WORDS_NB)) {
> +		dev_err(&indio_dev->dev, "PROM integrity check failed\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ms5611_read_temp_and_pressure(struct iio_dev *indio_dev,
> +					 s32 *temp, s32 *pressure)
> +{
> +	int ret;
> +	s32 t, p;
> +	s64 off, sens, dt;
> +	struct ms5611_state *st = iio_priv(indio_dev);
> +
> +	ret = st->read_adc_temp_and_pressure(&indio_dev->dev, &t, &p);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev,
> +			"failed to read temperature and pressure\n");
> +		return ret;
> +	}
> +
> +	dt = t - (st->prom[5] << 8);
> +	off = ((s64)st->prom[2] << 16) + ((st->prom[4] * dt) >> 7);
> +	sens = ((s64)st->prom[1] << 15) + ((st->prom[3] * dt) >> 8);
> +
> +	t = 2000 + ((st->prom[6] * dt) >> 23);
> +	if (t < 2000) {
> +		s64 off2, sens2, t2;
> +
> +		t2 = (dt * dt) >> 31;
> +		off2 = (5 * (t - 2000) * (t - 2000)) >> 1;
> +		sens2 = off2 >> 1;
> +
> +		if (t < -1500) {
> +			s64 tmp = (t + 1500) * (t + 1500);
> +
> +			off2 += 7 * tmp;
> +			sens2 += (11 * tmp) >> 1;
> +		}
> +
> +		t -= t2;
> +		off -= off2;
> +		sens -= sens2;
> +	}
> +
> +	*temp = t;
> +	*pressure = (((p * sens) >> 21) - off) >> 15;
> +
> +	return 0;
> +}
> +
> +static int ms5611_reset(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct ms5611_state *st = iio_priv(indio_dev);
> +
> +	ret = st->reset(&indio_dev->dev);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev, "failed to reset device\n");
> +		return ret;
> +	}
> +
> +	usleep_range(3000, 4000);
> +	return 0;
> +}
> +
> +static int ms5611_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	int ret;
> +	s32 temp, pressure;
> +	struct ms5611_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		mutex_lock(&st->lock);
> +		ret = ms5611_read_temp_and_pressure(indio_dev,
> +						    &temp, &pressure);
> +		mutex_unlock(&st->lock);
> +		if (ret < 0)
> +			return ret;
> +
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			*val = temp * 10;
> +			return IIO_VAL_INT;
> +		case IIO_PRESSURE:
> +			*val = pressure / 1000;
> +			*val2 = (pressure % 1000) * 1000;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_chan_spec ms5611_channels[] = {
> +	{
> +		.type = IIO_PRESSURE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +			BIT(IIO_CHAN_INFO_SCALE)
> +	},
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +			BIT(IIO_CHAN_INFO_SCALE)
> +	}
> +};
> +
> +static const struct iio_info ms5611_info = {
> +	.read_raw = &ms5611_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int ms5611_init(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +
> +	ret = ms5611_reset(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ms5611_read_prom(indio_dev);
> +}
> +
> +int ms5611_probe(struct iio_dev *indio_dev, struct device *dev)
> +{
> +	int ret;
> +	struct ms5611_state *st = iio_priv(indio_dev);
> +
> +	mutex_init(&st->lock);
> +	indio_dev->dev.parent = dev;
> +	indio_dev->name = dev->driver->name;
> +	indio_dev->info = &ms5611_info;
> +	indio_dev->channels = ms5611_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ms5611_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = ms5611_init(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +EXPORT_SYMBOL(ms5611_probe);
> +
> +MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
> +MODULE_DESCRIPTION("MS5611 core driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
> new file mode 100644
> index 0000000..4a700bd
> --- /dev/null
> +++ b/drivers/iio/pressure/ms5611_i2c.c
> @@ -0,0 +1,126 @@
> +/*
> + * MS5611 pressure and temperature sensor driver (I2C bus)
> + *
> + * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * 7-bit I2C slave addresses:
> + *
> + * 0x77 (CSB pin low)
> + * 0x76 (CSB pin high)
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +
> +#include "ms5611.h"
> +
> +static int ms5611_reset(struct device *dev)
> +{
> +	struct ms5611_state *st = iio_priv(dev_to_iio_dev(dev));
> +
> +	return i2c_smbus_write_byte(st->client, MS5611_RESET);
> +}
> +
> +static int ms5611_read_prom_word(struct device *dev, int index, u16 *word)
> +{
> +	int ret;
> +	struct ms5611_state *st = iio_priv(dev_to_iio_dev(dev));
> +
> +	ret = i2c_smbus_read_word_swapped(st->client,
> +			MS5611_READ_PROM_WORD + (index << 1));
> +	if (ret < 0)
> +		return ret;
> +
> +	*word = ret;
> +	return 0;
> +}
> +
> +static int ms5611_read_adc(struct ms5611_state *st, s32 *val)
> +{
> +	int ret;
> +	u8 buf[3];
> +
> +	ret = i2c_smbus_read_i2c_block_data(st->client, MS5611_READ_ADC,
> +					    3, buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = (buf[0] << 16) | (buf[1] << 8) | buf[2];
blank line here (and all through the driver before return statements)
It's trivial, but it does make them ever so slightly easier to read!.
> +	return 0;
> +}
> +
> +static int ms5611_read_adc_temp_and_pressure(struct device *dev,
> +					     s32 *temp, s32 *pressure)
> +{
> +	int ret;
> +	struct ms5611_state *st = iio_priv(dev_to_iio_dev(dev));
> +
> +	ret = i2c_smbus_write_byte(st->client, MS5611_START_TEMP_CONV);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(MS5611_CONV_TIME_MIN, MS5611_CONV_TIME_MAX);
> +
> +	ret = ms5611_read_adc(st, temp);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_write_byte(st->client, MS5611_START_PRESSURE_CONV);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(MS5611_CONV_TIME_MIN, MS5611_CONV_TIME_MAX);
> +
> +	return ms5611_read_adc(st, pressure);
> +}
> +
> +static int ms5611_i2c_probe(struct i2c_client *client,
> +			    const struct i2c_device_id *id)
> +{
> +	struct ms5611_state *st;
> +	struct iio_dev *indio_dev;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_WRITE_BYTE |
> +				     I2C_FUNC_SMBUS_READ_WORD_DATA |
> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK))
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->reset = ms5611_reset;
I know the scope of the definitions ensures we get the right ones, but
I would personally prefer these functions to having naming that makes
it clear that these are the i2c versions  ms5611_i2c_read_prom_word etc
perhaps?
> +	st->read_prom_word = ms5611_read_prom_word;
> +	st->read_adc_temp_and_pressure = ms5611_read_adc_temp_and_pressure;
> +	st->client = client;
> +
> +	return ms5611_probe(indio_dev, &client->dev);
> +}
> +
> +static const struct i2c_device_id ms5611_id[] = {
> +	{ "ms5611", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ms5611_id);
> +
> +static struct i2c_driver ms5611_driver = {
> +	.driver = {
> +		.name = "ms5611",
> +		.owner = THIS_MODULE,
> +	},
> +	.id_table = ms5611_id,
> +	.probe = ms5611_i2c_probe,
> +};
> +module_i2c_driver(ms5611_driver);
> +
> +MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
> +MODULE_DESCRIPTION("MS5611 i2c driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
> new file mode 100644
> index 0000000..08a8ab4
> --- /dev/null
> +++ b/drivers/iio/pressure/ms5611_spi.c
> @@ -0,0 +1,127 @@
> +/*
> + * MS5611 pressure and temperature sensor driver (SPI bus)
> + *
> + * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +
> +#include "ms5611.h"
> +
> +static int ms5611_reset(struct device *dev)
> +{
> +	u8 cmd = MS5611_RESET;
> +	struct ms5611_state *st = iio_priv(dev_to_iio_dev(dev));
> +
> +	return spi_write(st->client, &cmd, 1);
> +}
> +
> +static int ms5611_read_prom_word(struct device *dev, int index, u16 *word)
> +{
> +	int ret;
> +	struct ms5611_state *st = iio_priv(dev_to_iio_dev(dev));
> +
> +	ret = spi_w8r16be(st->client, MS5611_READ_PROM_WORD + (index << 1));
> +	if (ret < 0)
> +		return ret;
> +
> +	*word = ret;
Convention puts a blank line before the return statement.
(Another trivial point ;)
> +	return 0;
> +}
> +
> +static int ms5611_read_adc(struct device *dev, s32 *val)
> +{
> +	int ret;
> +	u8 buf[3];
> +	struct ms5611_state *st = iio_priv(dev_to_iio_dev(dev));
> +
> +	buf[0] = MS5611_READ_ADC;
Trivial suggestion:
Could use c99 style initialization to tidy this up a tiny bit.
u8 buf[3] = { MS5611_READ_ADC };

> +
> +	ret = spi_write_then_read(st->client, buf, 1, buf, 3);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = (buf[0] << 16) | (buf[1] << 8) | buf[2];
convention would put a blank line here.
> +	return 0;
> +}
> +
> +static int ms5611_read_adc_temp_and_pressure(struct device *dev,
> +					     s32 *temp, s32 *pressure)
> +{
> +	u8 cmd;
> +	int ret;
> +	struct ms5611_state *st = iio_priv(dev_to_iio_dev(dev));
> +
> +	cmd = MS5611_START_TEMP_CONV;
> +	ret = spi_write(st->client, &cmd, 1);

The buffer cmd is not in it's own cacheline which is a bug as
the spi subsystem can pass this buffer directly to DMA engines.
To avoid this, you need to force the buffer to be on the heap.
Standard trick is to use the __cacheline_aligned magic to put this
at the end of your state structure.  With this in mind IIO will
also always cacheline align the private data.

Note the spi_write_then_read actually doesn't need this as it
copies data into new buffers and the result back again.
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(MS5611_CONV_TIME_MIN, MS5611_CONV_TIME_MAX);
> +
> +	ret = ms5611_read_adc(dev, temp);
> +	if (ret < 0)
> +		return ret;
> +
> +	cmd = MS5611_START_PRESSURE_CONV;
> +	ret = spi_write(st->client, &cmd, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(MS5611_CONV_TIME_MIN, MS5611_CONV_TIME_MAX);
> +
> +	return ms5611_read_adc(dev, pressure);
> +}
> +
> +static int ms5611_spi_probe(struct spi_device *spi)
> +{
> +	int ret;
> +	struct ms5611_state *st;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	spi->mode = SPI_MODE_0;
> +	spi->max_speed_hz = 20000000;
> +	spi->bits_per_word = 8;
> +	ret = spi_setup(spi);
> +	if (ret < 0)
> +		return ret;
> +
> +	st = iio_priv(indio_dev);
> +	st->reset = ms5611_reset;
> +	st->read_prom_word = ms5611_read_prom_word;
> +	st->read_adc_temp_and_pressure = ms5611_read_adc_temp_and_pressure;
> +	st->client = spi;
> +
> +	return ms5611_probe(indio_dev, &spi->dev);
> +}
> +
> +static const struct spi_device_id ms5611_id[] = {
> +	{ "ms5611", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ms5611_id);
> +
> +static struct spi_driver ms5611_driver = {
> +	.driver = {
> +		.name = "ms5611",
> +		.owner = THIS_MODULE,
> +	},
> +	.id_table = ms5611_id,
> +	.probe = ms5611_spi_probe,
> +};
> +module_spi_driver(ms5611_driver);
> +
> +MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
> +MODULE_DESCRIPTION("MS5611 spi driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

