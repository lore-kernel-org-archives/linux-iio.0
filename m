Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:44972 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756447Ab0KST13 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Nov 2010 14:27:29 -0500
Message-ID: <4CE6D125.7050801@cam.ac.uk>
Date: Fri, 19 Nov 2010 19:33:57 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Matthias Brugger <matthias.bgg@gmail.com>
CC: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org, Matthias Brugger <mensch0815@gmail.com>,
	"Datta, Shubhrajyoti" <shubhrajyoti@ti.com>,
	Christoph Mair <christoph.mair@gmail.com>
Subject: Re: [PATCH] iio - add support for bmp085 barometer
References: <4CCADE59.9070702@gmail.com>
In-Reply-To: <4CCADE59.9070702@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/10 15:46, Matthias Brugger wrote:
> This patch adds support for the Bosch Sensortec bmp085 digital
> barometer to the iio subsystem.
Hi Matthias,

Pretty clean driver.  Various minor comments inline.

The controversial thing about this driver is that it is (I think)
the first time we are going to have a driver in iio for a device
that already has a driver elsewhere in the kernel tree.  (in misc).
This makes me rather uncomfortable...

One crucial thing is that we need a todo file listing anything that
driver does that this one does not. I would also like to get some
feedback on this from the author of the existing driver. I have
cc'd him.  At a very quick glance, the key thing that driver does
that isn't present here is that it ensures there is a recent enough
temperature measurement in driver.  Otherwise they are in many ways
pretty similar. Obviously I'm happy to have barometric pressure sensors
in IIO but I don't want to step on anyones toes and things will get
'interesting' when we move out of staging. The existing driver
almost certainly has a userspace so any changes are going to cause
pain and will need to be done slowly and carefully.

As a general rule please cc anyone who has commented on previous
patches (added).
>=20
> Signed-off-by: Matthias Brugger <m_brugger@web.de>
> ---
>  drivers/staging/iio/Kconfig            |    1 +
>  drivers/staging/iio/Makefile           |    1 +
>  drivers/staging/iio/barometer/Kconfig  |   12 +
>  drivers/staging/iio/barometer/Makefile |    5 +
>  drivers/staging/iio/barometer/baro.h   |    8 +
>  drivers/staging/iio/barometer/bmp085.c |  398
> ++++++++++++++++++++++++++++++++
>  drivers/staging/iio/barometer/bmp085.h |  108 +++++++++
>  7 files changed, 533 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/barometer/Kconfig
>  create mode 100644 drivers/staging/iio/barometer/Makefile
>  create mode 100644 drivers/staging/iio/barometer/baro.h
>  create mode 100644 drivers/staging/iio/barometer/bmp085.c
>  create mode 100644 drivers/staging/iio/barometer/bmp085.h
>=20
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfi=
g
> index ed48815..d5ca09a 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -46,6 +46,7 @@ source "drivers/staging/iio/gyro/Kconfig"
>  source "drivers/staging/iio/imu/Kconfig"
>  source "drivers/staging/iio/light/Kconfig"
>  source "drivers/staging/iio/magnetometer/Kconfig"
> +source "drivers/staging/iio/barometer/Kconfig"
This is supposed to be in alphabetical order. Please maintain
that... (it may have slipped at some point of course!)
>=20
>  source "drivers/staging/iio/trigger/Kconfig"
>=20
> diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makef=
ile
> index e909674..73112b2 100644
> --- a/drivers/staging/iio/Makefile
> +++ b/drivers/staging/iio/Makefile
> @@ -16,3 +16,4 @@ obj-y +=3D imu/
>  obj-y +=3D light/
>  obj-y +=3D trigger/
>  obj-y +=3D magnetometer/
> +obj-y +=3D barometer/
> diff --git a/drivers/staging/iio/barometer/Kconfig
> b/drivers/staging/iio/barometer/Kconfig
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
> diff --git a/drivers/staging/iio/barometer/Makefile
> b/drivers/staging/iio/barometer/Makefile
> new file mode 100644
> index 0000000..3234d96
> --- /dev/null
> +++ b/drivers/staging/iio/barometer/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for digital barometer sensor drivers
> +#
> +
> +obj-$(CONFIG_BMP085) +=3D bmp085.o
> diff --git a/drivers/staging/iio/barometer/baro.h
> b/drivers/staging/iio/barometer/baro.h
> new file mode 100644
> index 0000000..a25e4cd
> --- /dev/null
> +++ b/drivers/staging/iio/barometer/baro.h
> @@ -0,0 +1,8 @@
> +
> +#include "../sysfs.h"
> +
> +/* Barometer types of attribute */
> +
Why allow for a _store?  I doubt we'll have an pressure causing devices
anytime soon...

> +#define IIO_DEV_ATTR_BARO_PRESSURE(_mode, _show, _store, _addr)	\
> +	IIO_DEVICE_ATTR(baro_pressure_input, _mode, _show, NULL, _addr)
> +
> diff --git a/drivers/staging/iio/barometer/bmp085.c
> b/drivers/staging/iio/barometer/bmp085.c
> new file mode 100644
> index 0000000..580bd57
> --- /dev/null
> +++ b/drivers/staging/iio/barometer/bmp085.c
> @@ -0,0 +1,398 @@
> +/**
> + * Bosch Sensortec BMP085 Digital Pressure Sensor
> + *
> + * Written by: Matthias Brugger <m_brugger@web.de>
> + *
> + * Copyright (C) 2010 Fraunhofer Institute for Integrated Circuits
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
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
> +int oss =3D 3;
> +module_param(oss, int , S_IRUSR);
> +MODULE_PARM_DESC(oss, "Oversampling setting [0-3]");
Is there a reason why this cannot be changed whilst running?
If not, then it should have a sysfs interface and not be a module param=
eter.
Also, it ought to be separately configurable if one has several of thes=
e devices...
> +
> +/*******************************************************************=
*******
> + * Calculation of temperature and pressure
> +
> *********************************************************************=
*****/
> +static short bmp085_calc_temperature(struct i2c_client *client,
> +	       unsigned long ut)
> +{
> +	struct bmp085_data *data =3D i2c_get_clientdata(client);
> +	long x1, x2;
> +	short temp;
> +
> +	x1 =3D ((long) ut - (long) data->ac6) * (long) data->ac5 >> 15;
> +	x2 =3D ((long) data->mc << 11) / (x1 + data->md);
> +	data->b5 =3D x1 + x2;
> +	temp =3D ((data->b5 + 8) >> 4);
> +
> +	return temp;
combine last two lines and get rid of temp
> +}
> +
> +static long bmp085_calc_pressure(struct i2c_client *client,
> unsigned long up)
> +{
> +	struct bmp085_data *data =3D i2c_get_clientdata(client);
> +	long b6, x1, x2, x3, b3;
> +	unsigned long b4, b7;
> +	long pressure, p;
> +	long tmp;
> +
> +	b6 =3D data->b5 - 4000;
> +	x1 =3D (data->b2 * (b6 * b6 / (1<<12))) / (1<<11);
> +	x2 =3D data->ac2 * b6 / (1<<11);
> +	x3 =3D x1 + x2;
> +	b3 =3D (((data->ac1 * 4 + x3) << data->oss) + 2) / 4;
> +
> +	x1 =3D data->ac3 * b6 / (1<<13);
> +	x2 =3D (data->b1 * ((b6 * b6) / (1<<12))) / (1<<16);
> +	x3 =3D ((x1 + x2) + 2) / (1<<2);
> +	b4 =3D data->ac4 * (unsigned long) (x3 + 32768) / (1<<15);
> +	b7 =3D ((unsigned long)up - b3) * (50000 >> data->oss);
> +
> +	if (b7 < 0x80000000)
> +		p =3D (b7 * 2) / b4;
> +	else
> +		p =3D (b7 / b4) * 2;
> +	tmp =3D (p / (1<<8)) * (p / (1<<8));
> +	x1 =3D (tmp * 3038) / (1<<16);
> +	x2 =3D (-7357 * p) / (1<<16);
> +	pressure =3D p + ((x1 + x2 + 3791) / (1<<4));
> +
> +	return pressure;
combine last two lines and loose unused temp variable 'pressure'.
> +}
> +
This sort of general comment isn't terribly useful, so I would get rid
of them... Just adds uniformative lines to the driver.
> +/*******************************************************************=
*******
> + * Digital interface to sensor
> +
> *********************************************************************=
*****/
> +
> +static short bmp085_read_temp(struct i2c_client *client)
> +{
> +	s32 ret;
> +	short temp;
> +	struct bmp085_data *data =3D i2c_get_clientdata(client);
> +
> +	mutex_lock(&data->bmp085_lock);
> +	ret =3D i2c_smbus_write_byte_data(client, BMP085_START_CONV,
> +		       BMP085_START_TEMP);
> +	mutex_unlock(&data->bmp085_lock);
> +	if (ret < 0) {
> +		dev_warn(&client->dev, "starting temperature conversation "
> +			       "failed\n");
> +		return ret;
> +	}
> +
> +	msleep(5);
> +	ret =3D i2c_smbus_read_i2c_block_data(client, BMP085_REG_CONV, 2,
> +			data->data);
> +	if (ret < 0) {
> +		dev_warn(&client->dev, "reading ut failed, value is %#x\n"
> +				, ret);
> +		return ret;
> +	}
> +
> +	data->ut =3D (data->data[0] << 8) | data->data[1];
Ideally use relevant endianess function. It'll be cheaper when this
happens to be the correct way round.
> +
> +	temp =3D bmp085_calc_temperature(client, data->ut);
> +
> +	return temp;
Combine last two lines.
> +}
> +
> +static long bmp085_read_pressure(struct i2c_client *client)
> +{
> +	unsigned long up =3D 0;
> +	int ret;
> +	u8 xlsb, ret1, ret2;
> +	long pressure;
> +	u8 reg;
> +	int time_delay[4] =3D {5, 8, 14, 26};
> +	struct bmp085_data *data =3D i2c_get_clientdata(client);
> +
This becomes cleaner using the macro defs suggested below.
> +	if (data->oss =3D=3D 0)
> +		reg =3D BMP085_START_PRESS_OSRS0;
> +	else if (data->oss =3D=3D 1)
> +		reg =3D BMP085_START_PRESS_OSRS1;
> +	else if (data->oss =3D=3D 2)
> +		reg =3D BMP085_START_PRESS_OSRS2;
> +	else if (data->oss =3D=3D 3)
> +		reg =3D BMP085_START_PRESS_OSRS3;
> +	else {
> +		dev_warn(&client->dev, "undefined oss value, use oss =3D 0\n");
> +		data->oss =3D 0;
> +		reg =3D BMP085_START_PRESS_OSRS0;
Don't think this can happen (As you protect against other values).
So don't bother checking.
> +	}
> +
> +	mutex_lock(&data->bmp085_lock);
> +	ret =3D i2c_smbus_write_byte_data(client, BMP085_START_CONV, reg);
> +	mutex_unlock(&data->bmp085_lock);
Do you want to allow others to talk to the device whilst it is
capturing?  If not, I'd keep the mutex.
> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(time_delay[data->oss]);
> +
> +	mutex_lock(&data->bmp085_lock);
> +	ret1 =3D i2c_smbus_read_byte_data(client, 0xf6);
> +	ret2 =3D i2c_smbus_read_byte_data(client, 0xf7);
> +	xlsb =3D i2c_smbus_read_byte_data(client, 0xf8);
All of these can return errors. Ideally these would be handled.
> +	mutex_unlock(&data->bmp085_lock);
> +
> +	up =3D (((unsigned long) ret1 << 16) | ((unsigned long) ret2 << 8)
> +				| (unsigned long) xlsb) >> (8 - data->oss);
> +	data->up =3D up;
Write directly to data->up rather than having an intermediate store.
> +
> +	pressure =3D bmp085_calc_pressure(client, up);
> +
> +	return pressure;
Combine last two lines.
> +}
> +
> +/*******************************************************************=
*******
> + * sysfs attributes
> +
> *********************************************************************=
*****/
> +static ssize_t barometer_show_temp(struct device *dev,
> +		struct device_attribute *da, char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct bmp085_data *data =3D indio_dev->dev_data;
> +	struct i2c_client *client =3D data->client;
> +	long status;
> +
> +	status =3D bmp085_read_temp(client);
> +	if (status < 0)
> +		dev_warn(&client->dev, "error reading temperature: %ld\n",
> +				status);
It's an error, respond as such by returning this up to userspace.
> +
> +	data->temp =3D status;
Don't seem to use data->temp so don't bothering caching it.
> +
> +	return sprintf(buf, "%d\n", data->temp);
> +}
> +static IIO_DEV_ATTR_TEMP_RAW(barometer_show_temp);
> +
> +/**
> + * In standard mode, the temperature has to be read every second
> before the
> + * pressure can be read. We leave this semantics to the userspace,
> if later
> + * on a trigger based reading will be implemented, this should be
> taken into
> + * account.
Ouch. That's nasty. We probably want to have a think about how to ensur=
e
this happens... Perhaps keep a copy of last read time of the temperatur=
e
and return an error if we try to read the pressure when it won't be val=
id?
> + */
> +static ssize_t barometer_show_pressure(struct device *dev,
> +		struct device_attribute *da, char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct bmp085_data *data =3D iio_dev_get_devdata(indio_dev);
> +	struct i2c_client *client =3D data->client;
> +	long status;
> +
> +	status =3D bmp085_read_pressure(client);
> +	if (status < 0)
> +		dev_warn(&client->dev, "error reading pressure: %ld\n", status);
It's an error, should go all the way to userspace.
> +
> +	data->pressure =3D status;
Why cache this?  It isn't used anywhere else.
> +
> +	return sprintf(buf, "%ld\n", data->pressure);
> +}
> +static IIO_DEV_ATTR_BARO_PRESSURE(S_IRUGO, barometer_show_pressure,
> NULL, 0);
> +
> +static ssize_t barometer_show_id_version(struct device *dev,
> +		struct device_attribute *da, char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct bmp085_data *data =3D iio_dev_get_devdata(indio_dev);
> +
> +	return sprintf(buf, "%x_%x\n", data->chip_id, data->chip_version);
> +}
> +static IIO_DEV_ATTR_REV(barometer_show_id_version);
> +
> +static ssize_t barometer_show_oss(struct device *dev,
> +		struct device_attribute *da, char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct bmp085_data *data =3D iio_dev_get_devdata(indio_dev);
> +
> +	return sprintf(buf, "%d\n", data->oss);
> +}
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO, barometer_show_oss, NULL);
I don't think the output here is in Hz...  looks like a value between
0 and 3 to me.
> +
> +static IIO_CONST_ATTR_TEMP_SCALE("0.1");
> +
> +static struct attribute *bmp085_attributes[] =3D {
> +	&iio_dev_attr_temp_raw.dev_attr.attr,
> +	&iio_dev_attr_baro_pressure_input.dev_attr.attr,
> +	&iio_dev_attr_revision.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> +	&iio_const_attr_temp_scale.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group bmp085_attr_group =3D {
> +	.attrs =3D bmp085_attributes,
> +};
> +
> +/*******************************************************************=
*******
> + * Calibration data processing
> +
> *********************************************************************=
*****/
> +
> +static int bmp085_init_client(struct i2c_client *client)
> +{
> +	struct bmp085_data *data =3D i2c_get_clientdata(client);
> +	int i;
> +
> +	i =3D i2c_smbus_read_i2c_block_data(client, BMP085_REG_CHIP_ID, 1,
> +			&data->chip_id);
> +	if (i < 0)
> +		dev_warn(&client->dev, "Chip ID not read\n");
> +
> +	i =3D i2c_smbus_read_i2c_block_data(client, BMP085_REG_VERSION, 1,
> +			&data->chip_version);
> +	if (i < 0)
> +		dev_warn(&client->dev, "Version not read\n");
If this happens, can it indicate anything other than a hardware fault?
If not make the function return an error and ensure the probe fails.
Same is true of the chip id above.
> +
> +	i =3D i2c_smbus_read_i2c_block_data(client, BMP085_REG_PROM,
> BMP085_PROM_LENGTH,
> +			data->data);
> +	if (i < 0)
> +		dev_warn(&client->dev, "Unable to read %d bytes from address "
> +				"%#x\n", BMP085_PROM_LENGTH, BMP085_REG_PROM);
> +
These are 16 bit aligned, so I'd prefer to see the endianess macros
used rather than long hand conversion as done here.

> +	data->ac1 =3D (data->data[0] << 8) | data->data[1];
> +	data->ac2 =3D (data->data[2] << 8) | data->data[3];
> +	data->ac3 =3D (data->data[4] << 8) | data->data[5];
> +	data->ac4 =3D (data->data[6] << 8) | data->data[7];
> +	data->ac5 =3D (data->data[8] << 8) | data->data[9];
> +	data->ac6 =3D (data->data[10] << 8) | data->data[11];
> +	data->b1 =3D (data->data[12] << 8) | data->data[13];
> +	data->b2 =3D (data->data[14] << 8) | data->data[15];
> +	data->mb =3D (data->data[16] << 8) | data->data[17];
> +	data->mc =3D (data->data[18] << 8) | data->data[19];
> +	data->md =3D (data->data[20] << 8) | data->data[21];
> +
> +	return 0;
> +}
> +
> +static int bmp085_probe(struct i2c_client *client,
> +		const struct i2c_device_id *id)
> +{
> +	struct i2c_adapter *adapter =3D to_i2c_adapter(client->dev.parent);
> +	struct bmp085_data *data;
> +	int status =3D 0;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> +				I2C_FUNC_SMBUS_WORD_DATA))
> +		return -EIO;
> +
> +	/* Allocate driver data */
> +	data =3D kzalloc(sizeof(struct bmp085_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
I think this should be earlier.  Perhaps in init rather than probe?
> +	if ((oss < 0) || (oss > 3)) {
> +		status =3D -EINVAL;
> +		goto err;
> +	}
> +	data->oss =3D oss;
> +
> +	data->client =3D client;
> +	i2c_set_clientdata(client, data);
> +
> +	/* Initialize the BMP085 chip */
> +	bmp085_init_client(client);
> +
> +	mutex_init(&data->bmp085_lock);
> +
> +	/* Register with IIO */
> +	data->indio_dev =3D iio_allocate_device();
> +	if (data->indio_dev =3D=3D NULL) {
> +		status =3D -ENOMEM;
> +		goto err;
> +	}
> +
> +	data->indio_dev->dev.parent =3D &client->dev;
> +	data->indio_dev->attrs =3D &bmp085_attr_group;
> +	data->indio_dev->dev_data =3D (void *)(data);
> +	data->indio_dev->driver_module =3D THIS_MODULE;
> +	data->indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	status =3D iio_device_register(data->indio_dev);
> +	if (status < 0)
> +		goto err_iio;
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
> +	struct bmp085_data *data =3D i2c_get_clientdata(client);
> +
> +	iio_device_unregister(data->indio_dev);
> +	iio_free_device(data->indio_dev);
> +
> +	kfree(data);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id bmp085_id[] =3D {
> +	{ "bmp085", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, bmp085_id);
> +
> +static struct i2c_driver bmp085_drv =3D {
> +	.driver =3D {
> +		.name =3D  "bmp085",
> +		.owner =3D THIS_MODULE,
> +	},
> +	.suspend =3D NULL,
> +	.resume =3D NULL,
> +	.probe =3D bmp085_probe,
> +	.remove =3D __devexit_p(bmp085_remove),
> +	.id_table =3D bmp085_id,
> +};
> +
> +/*------------------------------------------------------------------=
-------*/
> +
> +static int __init bmp085_init_module(void)
> +{
> +	printk(KERN_INFO"bmp085 loading...\n");
This message is of no interest to anyone...
> +
> +	return i2c_add_driver(&bmp085_drv);
> +}
> +
> +static void __exit bmp085_exit_module(void)
> +{
> +	i2c_del_driver(&bmp085_drv);
> +}
> +
> +MODULE_AUTHOR("Matthias Brugger <matthias.brugger@iis.fraunhofer.de>=
");
> +MODULE_DESCRIPTION("I2c device driver for BMP085 barometererator
> sensor");
> +MODULE_LICENSE("GPL");
> +
> +module_init(bmp085_init_module);
> +module_exit(bmp085_exit_module);
> diff --git a/drivers/staging/iio/barometer/bmp085.h
> b/drivers/staging/iio/barometer/bmp085.h
> new file mode 100644
> index 0000000..aec2ee4
> --- /dev/null
> +++ b/drivers/staging/iio/barometer/bmp085.h
> @@ -0,0 +1,108 @@
> +#ifndef BMP085_H
> +#define BMP085_H
> +
> +#include "../iio.h"
> +#include "baro.h"
> +
> +#define BMP085_REG_CONV		0xF6 /* Temperature/pressure value UT or UP=
 */
> +#define BMP085_REG_CONV_XLS	0xF8
> +
> +#define BMP085_REG_PROM		0xAA
Personally I'd not bother with this definition and just use BMP085_REG_=
AC1
whenever you need it as that's the first element.
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
This naming is a little confusing... Isn't this the control
register address, and hence should be BMP085_REG_something?
> +
> +#define BMP085_START_TEMP	0x2E  /* wait 4.5 ms */
> +
> +#define BMP085_START_PRESS_OSRS0 0x34 /* wait 4.5 ms */
I'd prefer to see these broken out.  So

#define BMP085_START_PRESS(a) (0x34 | ((a) << 6))

then use, BMP085_START_PRESS(1) and similar for the various
options.

> +#define BMP085_START_PRESS_OSRS1 0x74 /* wait 7.5 ms */
> +#define BMP085_START_PRESS_OSRS2 0xB4 /* wait 13.5 ms */
> +#define BMP085_START_PRESS_OSRS3 0xF4 /* wait 25.5 ms */
> +
> +#define BMP085_REG_CHIP_ID	0xD0
> +#define BMP085_REG_VERSION	0xD1

Doesn't seem to be used so don't bother defining it.
> +#define BMP085_CHIP_ID		0x55
> +
> +/*
> + * data structure for every sensor
> + *
> + * @client		i2c client
> + * @ indio_dev		iio device representation
Extra space after @
> + *
> + * @bmp085_lock		mutex to synchronize parallel reads and writes
> + *
> + * @oss			oversampling setting, determines how accurate the chip wor=
ks
> + * @temp		holding actual temperature in 0.1=B0C
> + * @pressure		holding actual pressure in pascal
> + *
> + * @ac1			calibration value read at start-up
> + * @ac2			calibration value read at start-up
> + * @ac3			calibration value read at start-up
> + * @ac4			calibration value read at start-up
> + * @ac5			calibration value read at start-up
> + * @ac6			calibration value read at start-up
> + *
> + * @b1			calibration value read at start-up
> + * @b2			calibration value read at start-up
> + * @b3			calibration value read at start-up
> + *
> + * @mb			calibration value read at start-up
> + * @mc			calibration value read at start-up
> + * @md			calibration value read at start-up
> + *
> + * @ut			raw data to compute temperature
> + * @up			raw data to compute pressure
Could give these two more meaningful names...
> + *
> + * @chip_id		id of the chip
> + * @chip_version	version of the chip
> + *
> + * @data		array to read initial calib data as a bulk
> + */
> +struct bmp085_data {
> +	struct i2c_client *client;
> +	struct iio_dev *indio_dev;
> +
> +	struct mutex bmp085_lock;
> +
> +	int oss;
> +	s16 temp;
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

