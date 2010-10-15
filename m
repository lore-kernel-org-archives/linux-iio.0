Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:35258 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331Ab0JOKO4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2010 06:14:56 -0400
Message-ID: <4CB82AFD.3040401@cam.ac.uk>
Date: Fri, 15 Oct 2010 11:20:45 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Matthias Brugger <matthias.bgg@gmail.com>
CC: linux-iio@vger.kernel.org, matthias <mensch0815@googlemail.com>
Subject: Re: [PATCH] iio - add barometer bmp085
References: <4CB81BF0.1080802@gmail.com>
In-Reply-To: <4CB81BF0.1080802@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/15/10 10:16, Matthias Brugger wrote:
> This patch adds:
> - digital barometer support to the iio subsytem
> - Bosch Sensortec bmp085 driver
> 
> I resend the patches I sent yesterday, because I merged them to one.
> Also the comments and the define has been deleted and so, from my point of view is ready to merge.
One quick comment about patch submissions in general. When it's an updated
version of a previously posted patch, the title should be something like
[PATCH V2] iio - add barometer bmp085.  Makes it easy down the line to make
sure you have the right patch!.

To sumarise the important inline comments:

As a general rule, if you know the size of the storage of a give value
(because it is comming from hardware) it is better to use fixed sized
types.  u16 and friends.  It's way too unpredictable how large a long or
a short might be.

Don't eat errors.

All channel naming must have either _raw or _input on the end of
the direct read attributes so we know whether it is already in SI units.

Mostly fine, but various comments inline.

Thanks,

Jonathan

> 
> Signed-off-by: Matthias Brugger <m_brugger@web.de>
> ---
>  drivers/staging/iio/Kconfig            |    1 +
>  drivers/staging/iio/Makefile           |    1 +
>  drivers/staging/iio/barometer/Kconfig  |   12 +
>  drivers/staging/iio/barometer/Makefile |    5 +
>  drivers/staging/iio/barometer/baro.h   |    8 +
>  drivers/staging/iio/barometer/bmp085.c |  418 ++++++++++++++++++++++++++++++++
>  drivers/staging/iio/barometer/bmp085.h |   73 ++++++
>  7 files changed, 518 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/barometer/Kconfig
>  create mode 100644 drivers/staging/iio/barometer/Makefile
>  create mode 100644 drivers/staging/iio/barometer/baro.h
>  create mode 100644 drivers/staging/iio/barometer/bmp085.c
>  create mode 100644 drivers/staging/iio/barometer/bmp085.h
> 
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index ed48815..d5ca09a 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -46,6 +46,7 @@ source "drivers/staging/iio/gyro/Kconfig"
>  source "drivers/staging/iio/imu/Kconfig"
>  source "drivers/staging/iio/light/Kconfig"
>  source "drivers/staging/iio/magnetometer/Kconfig"
> +source "drivers/staging/iio/barometer/Kconfig"
>  
>  source "drivers/staging/iio/trigger/Kconfig"
>  
> diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
> index e909674..73112b2 100644
> --- a/drivers/staging/iio/Makefile
> +++ b/drivers/staging/iio/Makefile
> @@ -16,3 +16,4 @@ obj-y += imu/
>  obj-y += light/
>  obj-y += trigger/
>  obj-y += magnetometer/
> +obj-y += barometer/
> diff --git a/drivers/staging/iio/barometer/Kconfig b/drivers/staging/iio/barometer/Kconfig
> new file mode 100644
> index 0000000..d5942e9
> --- /dev/null
> +++ b/drivers/staging/iio/barometer/Kconfig
> @@ -0,0 +1,12 @@
> +#
> +# IIO Digital Barometer Sensor drivers configuration
> +#
> +comment "Digital barometer sensors"
> +
> +config BMP085
> +
> +	tristate "BMP085 Barometer Sensor I2C driver"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for Bosch Sensortec BMP085,
> +	  digital barometer sensor.
> diff --git a/drivers/staging/iio/barometer/Makefile b/drivers/staging/iio/barometer/Makefile
> new file mode 100644
> index 0000000..3234d96
> --- /dev/null
> +++ b/drivers/staging/iio/barometer/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for digital barometer sensor drivers
> +#
> +
> +obj-$(CONFIG_BMP085) += bmp085.o
> diff --git a/drivers/staging/iio/barometer/baro.h b/drivers/staging/iio/barometer/baro.h
> new file mode 100644
> index 0000000..e3b73a1
> --- /dev/null
> +++ b/drivers/staging/iio/barometer/baro.h
> @@ -0,0 +1,8 @@
> +
> +#include "../sysfs.h"
> +
> +/* Barometer types of attribute */
> +
> +#define IIO_DEV_ATTR_BARO_PRESSURE(_mode, _show, _store, _addr)	\
> +	IIO_DEVICE_ATTR(baro_pressure, _mode, _show, NULL, _addr)
If it's processed (i.e. si units) it needs to be baro_pressure_input.
If raw it needs to be baro_pressure_raw and conversion factors etc provided.
> +
> diff --git a/drivers/staging/iio/barometer/bmp085.c b/drivers/staging/iio/barometer/bmp085.c
> new file mode 100644
> index 0000000..67dac39
> --- /dev/null
> +++ b/drivers/staging/iio/barometer/bmp085.c
> @@ -0,0 +1,418 @@
> +/**
> + * Bosch Sensortec BMP085 Digital Pressure Sensor
> + *
> + * Written by: Matthias Brugger <m_brugger@web.de>
> + *
> + * Copyright (C) 2010 Fraunhofer Institute for Integrated Circuits
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the
> + * Free Software Foundation, Inc.,
> + * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <linux/delay.h>
> +#include <linux/time.h>
> +#include <linux/mutex.h>
> +
> +#include "bmp085.h"
> +
> +int oss = 3;
> +module_param(oss, int , S_IRUSR);
> +MODULE_PARM_DESC(oss, "Oversampling setting [0-3]");
Not convinced this should be a module parameter.  Better to use a combination
of board config (for default on a given board) and appropriate sysfs attribute
to allow it to be changed.  Still, fine for initial merge, we can change this
later.
> +
> +/**************************************************************************
> + * Calcualtion of temperature and pressure
Typo Calcualtion -> Calculation.
> + **************************************************************************/
> +static short bmp085_calc_temperature(struct i2c_client *client,
> +	       unsigned long ut)
> +{
> +	struct bmp085_data *data = i2c_get_clientdata(client);
> +	long x1, x2;
> +	short temp;
> +
> +	x1 = ((long) ut - (long) data->ac6) * (long) data->ac5 >> 15;
> +	x2 = ((long) data->mc << 11) / (x1 + data->md);
> +	data->b5 = x1 + x2;
> +	temp = ((data->b5 + 8) >> 4);
> +
> +	return temp;
> +}
> +
> +static long bmp085_calc_pressure(struct i2c_client *client, unsigned long up)
> +{
> +	struct bmp085_data *data = i2c_get_clientdata(client);
> +	long b6, x1, x2, x3, b3;
> +	unsigned long b4, b7;
> +	long pressure, p;
> +	long tmp;
> +
> +	b6 = data->b5 - 4000;
> +	x1 = (data->b2 * (b6 * b6 / (1<<12))) / (1<<11);
> +	x2 = data->ac2 * b6 / (1<<11);
> +	x3 = x1 + x2;
> +	b3 = (((data->ac1 * 4 + x3) << data->oss) + 2) / 4;
> +
> +	x1 = data->ac3 * b6 / (1<<13);
> +	x2 = (data->b1 * ((b6 * b6) / (1<<12))) / (1<<16);
> +	x3 = ((x1 + x2) + 2) / (1<<2);
> +	b4 = data->ac4 * (unsigned long) (x3 + 32768) / (1<<15);
> +	b7 = ((unsigned long)up - b3) * (50000 >> data->oss);
> +
> +	if (b7 < 0x80000000)
> +		p = (b7 * 2) / b4;
> +	else
> +		p = (b7 / b4) * 2;
> +	tmp = (p / (1<<8)) * (p / (1<<8));
> +	x1 = (tmp * 3038) / (1<<16);
> +	x2 = (-7357 * p) / (1<<16);
> +	pressure = p + ((x1 + x2 + 3791) / (1<<4));
> +
> +	return pressure;
> +}
> +
> +/**************************************************************************
> + * Digital interface to sensor
> + **************************************************************************/
> +
This is an extremely slim function.  I think it would be easier to remove it and
just ahve the i2c_block_data function inline in the code.
> +static ssize_t bmp085_read(struct i2c_client *client, u8 reg, size_t count,
> +	       unsigned char *buffer)
> +{
> +	int rc;
> +	rc = i2c_smbus_read_i2c_block_data(client, reg, count, buffer);
> +	if (rc < 0)
No.  Pass the error that came out of the i2c command on.  Never eat an
error as you just reduce the information available.
> +			return -EIO;
> +
> +	return count;
> +}
> +
> +static short bmp085_read_temp(struct i2c_client *client)
> +{
> +	s32 ret;
> +	short temp;
> +	struct bmp085_data *data = i2c_get_clientdata(client);
> +
> +	mutex_lock(&data->bmp085_lock);
> +	ret = i2c_smbus_write_byte_data(client, BMP085_START_CONV,
> +		       BMP085_START_TEMP);
> +	mutex_unlock(&data->bmp085_lock);
> +	if (ret < 0) {
> +		dev_warn(&client->dev, "starting temperature conversation "
> +			       "failed\n");
> +		return ret;
> +	}
> +
probably msleep.
> +	mdelay(5);
> +	ret = bmp085_read(client, BMP085_REG_CONV, 2, data->data);
> +	if (ret < 0) {
> +		dev_warn(&client->dev, "reading ut failed, value is %#x\n"
> +				, ret);
> +		return ret;
> +	}
> +
> +	data->ut = (data->data[0] << 8) | data->data[1];
> +
> +	temp = bmp085_calc_temperature(client, data->ut);
> +
> +	return temp;
> +}
> +
> +static long bmp085_read_pressure(struct i2c_client *client)
> +{
> +	unsigned long up = 0;
> +	int ret;
> +	u8 xlsb, ret1, ret2;
> +	long pressure;
> +	u8 reg;
Don't worry about the todo.  Overshooting on this isn't going
to greatly change your possible read rate.
> +	/* TODO should be 4.5, 7.5, 13.5, 25.5 ms */
> +	int time_delay[4] = {5, 8, 14, 26};
> +	struct bmp085_data *data = i2c_get_clientdata(client);
> +
> +	if (data->oss == 0)
> +		reg = BMP085_START_PRESS_OSRS0;
> +	else if (data->oss == 1)
> +		reg = BMP085_START_PRESS_OSRS1;
> +	else if (data->oss == 2)
> +		reg = BMP085_START_PRESS_OSRS2;
> +	else if (data->oss == 3)
> +		reg = BMP085_START_PRESS_OSRS3;
> +	else {
> +		dev_warn(&client->dev, "undefined oss value, use oss = 0\n");
> +		data->oss = 0;
> +		reg = BMP085_START_PRESS_OSRS0;
> +	}
> +
> +	mutex_lock(&data->bmp085_lock);
> +	ret = i2c_smbus_write_byte_data(client, BMP085_START_CONV, reg);
> +	mutex_unlock(&data->bmp085_lock);
> +	if (ret < 0)
> +		return ret;
> +
Does this need to be that precise?  If not an msleep would be a better
bet to allow the system to get on with something else.
> +	mdelay(time_delay[data->oss]);
> +
> +	mutex_lock(&data->bmp085_lock);
> +	ret1 = i2c_smbus_read_byte_data(client, 0xf6);
> +	ret2 = i2c_smbus_read_byte_data(client, 0xf7);
> +	xlsb = i2c_smbus_read_byte_data(client, 0xf8);
> +	mutex_unlock(&data->bmp085_lock);
> +
> +	up = (((unsigned long) ret1 << 16) | ((unsigned long) ret2 << 8)
> +				| (unsigned long) xlsb) >> (8 - data->oss);
> +	data->up = up;
> +
> +	pressure = bmp085_calc_pressure(client, up);
Why cache the pressure?
> +	data->pressure = pressure;
> +
> +	return pressure;
> +}
> +
> +/**************************************************************************
> + * sysfs attributes
> + **************************************************************************/
> +static ssize_t barometer_show_temp(struct device *dev,
> +		struct device_attribute *da, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmp085_data *data = indio_dev->dev_data;
> +	struct i2c_client *client = data->client;
> +	long status;
> +
> +	status = bmp085_read_temp(client);
> +	if (status < 0)
> +		dev_warn(&client->dev, "error reading temperature: %ld\n",
> +				status);
> +
> +	data->temp = status;
> +
> +	return sprintf(buf, "%ld\n", data->temp);
> +}
> +static IIO_DEV_ATTR_TEMP_RAW(barometer_show_temp);
> +
> +/**
> + * In standard mode, the temperature has to be reat every second before the
> + * pressure can be reat. We leave this semantics to the userspace, if later
past tense of read is infact read not reat.
> + * on a trigger based reading will be implemented, this should be taken into
> + * account.
Ouch, that's an uggly requirement.
> + */
> +static ssize_t barometer_show_pressure(struct device *dev,
> +		struct device_attribute *da, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmp085_data *data = indio_dev->dev_data;
> +	struct i2c_client *client = data->client;
> +	long status;
> +
> +	status = bmp085_read_pressure(client);
> +	if (status < 0)
> +		dev_warn(&client->dev, "error reading pressure: %ld\n", status);
> +
Why cache the preesure?
> +	data->pressure = status;
> +
> +	return sprintf(buf, "%ld\n", data->pressure);
> +}
> +static IIO_DEV_ATTR_BARO_PRESSURE(S_IRUGO, barometer_show_pressure, NULL, 0);
> +
> +static ssize_t barometer_show_id_version(struct device *dev,
> +		struct device_attribute *da, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmp085_data *data = indio_dev->dev_data;
Doesn't really matter, but we do have a helper function for this
(and at somepoint I'll clean all the direct reads out of the tree)
struct bmp085_data *data = iio_dev_get_devdata(indio_dev); 
> +
> +	return sprintf(buf, "%x_%x\n", data->chip_id, data->chip_version);
> +}
> +static IIO_DEV_ATTR_REV(barometer_show_id_version);
> +
> +static ssize_t barometer_show_oss(struct device *dev,
> +		struct device_attribute *da, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct bmp085_data *data = indio_dev->dev_data;
> +
> +	return sprintf(buf, "%d\n", data->oss);
> +}
So is oss (which is sampling frequency) either 1Hz or 2Hz?
(I haven't looked at datasheet but under the abi that's what this is giving us).
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO, barometer_show_oss, NULL);
> +
> +static IIO_CONST_ATTR_TEMP_SCALE("0.1");
No real problem with this.  Personally I'd probably just do
the trivial amount of fixed point arithmetic in the temperature
output.

sprintf(buf, "%d.%d\n", temp/10, temp%10);
> +
> +static struct attribute *bmp085_attributes[] = {
> +	&iio_dev_attr_temp_raw.dev_attr.attr,
> +	&iio_dev_attr_baro_pressure.dev_attr.attr,
> +	&iio_dev_attr_revision.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> +	&iio_const_attr_temp_scale.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group bmp085_attr_group = {
> +	.attrs = bmp085_attributes,
> +};
> +
> +/**************************************************************************
> + * Calibration data processing
> + **************************************************************************/
> +
> +static int bmp085_init_client(struct i2c_client *client)
> +{
> +	struct bmp085_data *data = i2c_get_clientdata(client);
> +	int i;
> +
> +	i = bmp085_read(client, BMP085_REG_CHIP_ID, 1, &data->chip_id);
> +	if (i < 0)
> +		dev_warn(&client->dev, "Chip ID not read\n");
> +
> +	i = bmp085_read(client, BMP085_REG_VERSION, 1, &data->chip_version);
> +	if (i < 0)
> +		dev_warn(&client->dev, "Version not read\n");
> +
> +	i = bmp085_read(client, BMP085_REG_PROM, BMP085_PROM_LENGTH,
> +			data->data);
> +	if (i < 0)
> +		dev_warn(&client->dev, "Unable to read %d bytes from address "
> +				"%#x\n", BMP085_PROM_LENGTH, BMP085_REG_PROM);
> +
> +	data->ac1 = (data->data[0] << 8) | data->data[1];
> +	data->ac2 = (data->data[2] << 8) | data->data[3];
> +	data->ac3 = (data->data[4] << 8) | data->data[5];
> +	data->ac4 = (data->data[6] << 8) | data->data[7];
> +	data->ac5 = (data->data[8] << 8) | data->data[9];
> +	data->ac6 = (data->data[10] << 8) | data->data[11];
> +	data->b1 = (data->data[12] << 8) | data->data[13];
> +	data->b2 = (data->data[14] << 8) | data->data[15];
> +	data->mb = (data->data[16] << 8) | data->data[17];
> +	data->mc = (data->data[18] << 8) | data->data[19];
> +	data->md = (data->data[20] << 8) | data->data[21];
> +
> +	return 0;
> +}
> +
> +static struct i2c_driver bmp085_drv;
Why is this here? 

> +static int bmp085_probe(struct i2c_client *client,
> +		const struct i2c_device_id *id)
> +{
> +	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +	struct bmp085_data *data;
> +	struct bmp085_data *data2;
> +	int status = 0;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> +				I2C_FUNC_SMBUS_WORD_DATA))
> +		return -EIO;
> +
> +	/* Allocate driver data */
> +	data = kzalloc(sizeof(struct bmp085_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	if ((oss < 0) || (oss > 3)) {
> +		status = -EINVAL;
> +		goto err;
> +	}
> +	data->oss = oss;
> +
> +	data->client = client;
> +	i2c_set_clientdata(client, data);
> +	data2 = i2c_get_clientdata(client);
Guessing the above is dead debug code?

> +
> +	/* Initialize the BMP085 chip */
> +	bmp085_init_client(client);
> +
> +	__mutex_init(&data->bmp085_lock, "bmp085_lock", NULL);
Why the underscore form?  I've not seen this before.
> +
> +	/* Register with IIO */
> +	data->indio_dev = iio_allocate_device();
> +	if (data->indio_dev == NULL) {
> +		status = -ENOMEM;
> +		goto err;
> +	}
> +
> +	data->indio_dev->dev.parent = &client->dev;
> +	data->indio_dev->attrs = &bmp085_attr_group;
> +	data->indio_dev->dev_data = (void *)(data);
> +	data->indio_dev->driver_module = THIS_MODULE;
> +	data->indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	status = iio_device_register(data->indio_dev);
> +	if (status < 0)
> +		goto err_iio;
> +
Remove this as it's not needed.  
> +	dev_info(&client->dev, "driver enabled\n");
> +
> +	return 0;
> +
> +err_iio:
> +	kfree(data->indio_dev);
> +err:
> +	kfree(data);
> +	return status;
> +}
> +
> +static int __devexit bmp085_remove(struct i2c_client *client)
> +{
> +	struct bmp085_data *data = i2c_get_clientdata(client);
> +
> +	if (mutex_is_locked(&data->bmp085_lock))
> +		mutex_unlock(&data->bmp085_lock);
Something weird is occuring if you can get here without the lock
being unlocked.
> +
> +	iio_device_unregister(data->indio_dev);
> +	iio_free_device(data->indio_dev);
> +
> +	kfree(data);
> +
> +	dev_info(&client->dev, "driver removed\n");
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id bmp085_id[] = {
> +	{ "bmp085", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, bmp085_id);
> +
> +static struct i2c_driver bmp085_drv = {
> +	.driver = {
> +		.name =  "bmp085",
> +		.owner = THIS_MODULE,
> +	},
> +	.suspend = NULL,
> +	.resume = NULL,
> +	.probe = bmp085_probe,
> +	.remove = __devexit_p(bmp085_remove),
> +	.id_table = bmp085_id,
> +};
> +
> +/*-------------------------------------------------------------------------*/
> +
> +static int __init bmp085_init_module(void)
> +{
Get rid of tis debug.
> +	printk(KERN_INFO"bmp085 loading...\n");
> +
> +	return i2c_add_driver(&bmp085_drv);
> +}
> +
> +static void __exit bmp085_exit_module(void)
> +{
> +	i2c_del_driver(&bmp085_drv);
> +}
> +
> +MODULE_AUTHOR("Matthias Brugger <matthias.brugger@iis.fraunhofer.de>");
> +MODULE_DESCRIPTION("I2c device driver for BMP085 barometererator sensor");
> +MODULE_LICENSE("GPL");
> +
> +module_init(bmp085_init_module);
> +module_exit(bmp085_exit_module);
> diff --git a/drivers/staging/iio/barometer/bmp085.h b/drivers/staging/iio/barometer/bmp085.h
> new file mode 100644
> index 0000000..5ed2fb1
> --- /dev/null
> +++ b/drivers/staging/iio/barometer/bmp085.h
> @@ -0,0 +1,73 @@
> +#ifndef BMP085_H
> +#define BMP085_H
> +
> +#include "../iio.h"
> +#include "baro.h"
> +
> +#define BMP085_REG_CONV		0xF6 /* Temperature/pressure value UT or UP */
> +#define BMP085_REG_CONV_XLS	0xF8
> +
> +#define BMP085_REG_PROM		0xAA
> +#define BMP085_PROM_LENGTH	22
> +
> +#define BMP085_REG_AC1		0xAA
> +#define BMP085_REG_AC2		0xAC
> +#define BMP085_REG_AC3		0xAE
> +#define BMP085_REG_AC4		0xB0
> +#define BMP085_REG_AC5		0xB2
> +#define BMP085_REG_AC6		0xB4
> +#define BMP085_REG_B1		0xB6
> +#define BMP085_REG_B2		0xB8
> +#define BMP085_REG_MB		0xBA
> +#define BMP085_REG_MC		0xBC
> +#define BMP085_REG_MD		0xBE
> +
> +#define BMP085_START_CONV	0xF4
> +
> +#define BMP085_START_TEMP	0x2E  /* wait 4.5 ms */
> +
> +#define BMP085_START_PRESS_OSRS0 0x34 /* wait 4.5 ms */
> +#define BMP085_START_PRESS_OSRS1 0x74 /* wait 7.5 ms */
> +#define BMP085_START_PRESS_OSRS2 0xB4 /* wait 13.5 ms */
> +#define BMP085_START_PRESS_OSRS3 0xF4 /* wait 25.5 ms */
> +
> +#define BMP085_REG_CHIP_ID	0xD0
> +#define BMP085_REG_VERSION	0xD1
> +#define BMP085_CHIP_ID		0x55
> +
Ideally this structure would have some documentation (kernel doc)
to make reviewing the driver easier.

> +struct bmp085_data {
> +	struct i2c_client *client;
> +	struct iio_dev *indio_dev;
> +
> +	struct mutex bmp085_lock;
> +
> +	int oss;
> +	long temp;
Why long?  Looking at the code this always looks to be
16 bit to me, so s16 would be more appropraite.

> +	long pressure;
> +
> +	short ac1;
> +	short ac2;
> +	short ac3;
> +	unsigned short ac4;
> +	unsigned short ac5;
> +	unsigned short ac6;
> +
> +	short b1;
> +	short b2;
> +	long b5;
> +
> +	short mb;
> +	short mc;
> +	short md;
> +
> +	unsigned long ut;
> +	unsigned long up;
> +
> +	u8 chip_id;
> +	u8 chip_version;
> +
> +	unsigned char data[22];
> +};
> +
> +
> +#endif

