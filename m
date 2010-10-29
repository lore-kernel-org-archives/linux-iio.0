Return-Path: <matthias.bgg9ab33xy531gmail.com@bounce.antispameurope.com>
Message-ID: <4CCADE59.9070702@gmail.com>
Date: Fri, 29 Oct 2010 16:46:49 +0200
From: Matthias Brugger <matthias.bgg@gmail.com>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: devel@driverdev.osuosl.org, Jonathan Cameron <jic23@cam.ac.uk>,
        linux-iio@vger.kernel.org, mensch0815@gmail.com
Subject: [PATCH] iio - add support for bmp085 barometer
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

This patch adds support for the Bosch Sensortec bmp085 digital
barometer to the iio subsystem.

Signed-off-by: Matthias Brugger <m_brugger@web.de>
---
 drivers/staging/iio/Kconfig            |    1 +
 drivers/staging/iio/Makefile           |    1 +
 drivers/staging/iio/barometer/Kconfig  |   12 +
 drivers/staging/iio/barometer/Makefile |    5 +
 drivers/staging/iio/barometer/baro.h   |    8 +
 drivers/staging/iio/barometer/bmp085.c |  398
++++++++++++++++++++++++++++++++
 drivers/staging/iio/barometer/bmp085.h |  108 +++++++++
 7 files changed, 533 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/barometer/Kconfig
 create mode 100644 drivers/staging/iio/barometer/Makefile
 create mode 100644 drivers/staging/iio/barometer/baro.h
 create mode 100644 drivers/staging/iio/barometer/bmp085.c
 create mode 100644 drivers/staging/iio/barometer/bmp085.h

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index ed48815..d5ca09a 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -46,6 +46,7 @@ source "drivers/staging/iio/gyro/Kconfig"
 source "drivers/staging/iio/imu/Kconfig"
 source "drivers/staging/iio/light/Kconfig"
 source "drivers/staging/iio/magnetometer/Kconfig"
+source "drivers/staging/iio/barometer/Kconfig"

 source "drivers/staging/iio/trigger/Kconfig"

diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index e909674..73112b2 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -16,3 +16,4 @@ obj-y +=3D imu/
 obj-y +=3D light/
 obj-y +=3D trigger/
 obj-y +=3D magnetometer/
+obj-y +=3D barometer/
diff --git a/drivers/staging/iio/barometer/Kconfig
b/drivers/staging/iio/barometer/Kconfig
new file mode 100644
index 0000000..d5942e9
--- /dev/null
+++ b/drivers/staging/iio/barometer/Kconfig
@@ -0,0 +1,12 @@
+#
+# IIO Digital Barometer Sensor drivers configuration
+#
+comment "Digital barometer sensors"
+
+config BMP085
+
+	tristate "BMP085 Barometer Sensor I2C driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Bosch Sensortec BMP085,
+	  digital barometer sensor.
diff --git a/drivers/staging/iio/barometer/Makefile
b/drivers/staging/iio/barometer/Makefile
new file mode 100644
index 0000000..3234d96
--- /dev/null
+++ b/drivers/staging/iio/barometer/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for digital barometer sensor drivers
+#
+
+obj-$(CONFIG_BMP085) +=3D bmp085.o
diff --git a/drivers/staging/iio/barometer/baro.h
b/drivers/staging/iio/barometer/baro.h
new file mode 100644
index 0000000..a25e4cd
--- /dev/null
+++ b/drivers/staging/iio/barometer/baro.h
@@ -0,0 +1,8 @@
+
+#include "../sysfs.h"
+
+/* Barometer types of attribute */
+
+#define IIO_DEV_ATTR_BARO_PRESSURE(_mode, _show, _store, _addr)	\
+	IIO_DEVICE_ATTR(baro_pressure_input, _mode, _show, NULL, _addr)
+
diff --git a/drivers/staging/iio/barometer/bmp085.c
b/drivers/staging/iio/barometer/bmp085.c
new file mode 100644
index 0000000..580bd57
--- /dev/null
+++ b/drivers/staging/iio/barometer/bmp085.c
@@ -0,0 +1,398 @@
+/**
+ * Bosch Sensortec BMP085 Digital Pressure Sensor
+ *
+ * Written by: Matthias Brugger <m_brugger@web.de>
+ *
+ * Copyright (C) 2010 Fraunhofer Institute for Integrated Circuits
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the
+ * Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/time.h>
+#include <linux/mutex.h>
+
+#include "bmp085.h"
+
+int oss =3D 3;
+module_param(oss, int , S_IRUSR);
+MODULE_PARM_DESC(oss, "Oversampling setting [0-3]");
+
+/***********************************************************************=
***
+ * Calculation of temperature and pressure
+
*************************************************************************=
*/
+static short bmp085_calc_temperature(struct i2c_client *client,
+	       unsigned long ut)
+{
+	struct bmp085_data *data =3D i2c_get_clientdata(client);
+	long x1, x2;
+	short temp;
+
+	x1 =3D ((long) ut - (long) data->ac6) * (long) data->ac5 >> 15;
+	x2 =3D ((long) data->mc << 11) / (x1 + data->md);
+	data->b5 =3D x1 + x2;
+	temp =3D ((data->b5 + 8) >> 4);
+
+	return temp;
+}
+
+static long bmp085_calc_pressure(struct i2c_client *client,
unsigned long up)
+{
+	struct bmp085_data *data =3D i2c_get_clientdata(client);
+	long b6, x1, x2, x3, b3;
+	unsigned long b4, b7;
+	long pressure, p;
+	long tmp;
+
+	b6 =3D data->b5 - 4000;
+	x1 =3D (data->b2 * (b6 * b6 / (1<<12))) / (1<<11);
+	x2 =3D data->ac2 * b6 / (1<<11);
+	x3 =3D x1 + x2;
+	b3 =3D (((data->ac1 * 4 + x3) << data->oss) + 2) / 4;
+
+	x1 =3D data->ac3 * b6 / (1<<13);
+	x2 =3D (data->b1 * ((b6 * b6) / (1<<12))) / (1<<16);
+	x3 =3D ((x1 + x2) + 2) / (1<<2);
+	b4 =3D data->ac4 * (unsigned long) (x3 + 32768) / (1<<15);
+	b7 =3D ((unsigned long)up - b3) * (50000 >> data->oss);
+
+	if (b7 < 0x80000000)
+		p =3D (b7 * 2) / b4;
+	else
+		p =3D (b7 / b4) * 2;
+	tmp =3D (p / (1<<8)) * (p / (1<<8));
+	x1 =3D (tmp * 3038) / (1<<16);
+	x2 =3D (-7357 * p) / (1<<16);
+	pressure =3D p + ((x1 + x2 + 3791) / (1<<4));
+
+	return pressure;
+}
+
+/***********************************************************************=
***
+ * Digital interface to sensor
+
*************************************************************************=
*/
+
+static short bmp085_read_temp(struct i2c_client *client)
+{
+	s32 ret;
+	short temp;
+	struct bmp085_data *data =3D i2c_get_clientdata(client);
+
+	mutex_lock(&data->bmp085_lock);
+	ret =3D i2c_smbus_write_byte_data(client, BMP085_START_CONV,
+		       BMP085_START_TEMP);
+	mutex_unlock(&data->bmp085_lock);
+	if (ret < 0) {
+		dev_warn(&client->dev, "starting temperature conversation "
+			       "failed\n");
+		return ret;
+	}
+
+	msleep(5);
+	ret =3D i2c_smbus_read_i2c_block_data(client, BMP085_REG_CONV, 2,
+			data->data);
+	if (ret < 0) {
+		dev_warn(&client->dev, "reading ut failed, value is %#x\n"
+				, ret);
+		return ret;
+	}
+
+	data->ut =3D (data->data[0] << 8) | data->data[1];
+
+	temp =3D bmp085_calc_temperature(client, data->ut);
+
+	return temp;
+}
+
+static long bmp085_read_pressure(struct i2c_client *client)
+{
+	unsigned long up =3D 0;
+	int ret;
+	u8 xlsb, ret1, ret2;
+	long pressure;
+	u8 reg;
+	int time_delay[4] =3D {5, 8, 14, 26};
+	struct bmp085_data *data =3D i2c_get_clientdata(client);
+
+	if (data->oss =3D=3D 0)
+		reg =3D BMP085_START_PRESS_OSRS0;
+	else if (data->oss =3D=3D 1)
+		reg =3D BMP085_START_PRESS_OSRS1;
+	else if (data->oss =3D=3D 2)
+		reg =3D BMP085_START_PRESS_OSRS2;
+	else if (data->oss =3D=3D 3)
+		reg =3D BMP085_START_PRESS_OSRS3;
+	else {
+		dev_warn(&client->dev, "undefined oss value, use oss =3D 0\n");
+		data->oss =3D 0;
+		reg =3D BMP085_START_PRESS_OSRS0;
+	}
+
+	mutex_lock(&data->bmp085_lock);
+	ret =3D i2c_smbus_write_byte_data(client, BMP085_START_CONV, reg);
+	mutex_unlock(&data->bmp085_lock);
+	if (ret < 0)
+		return ret;
+
+	msleep(time_delay[data->oss]);
+
+	mutex_lock(&data->bmp085_lock);
+	ret1 =3D i2c_smbus_read_byte_data(client, 0xf6);
+	ret2 =3D i2c_smbus_read_byte_data(client, 0xf7);
+	xlsb =3D i2c_smbus_read_byte_data(client, 0xf8);
+	mutex_unlock(&data->bmp085_lock);
+
+	up =3D (((unsigned long) ret1 << 16) | ((unsigned long) ret2 << 8)
+				| (unsigned long) xlsb) >> (8 - data->oss);
+	data->up =3D up;
+
+	pressure =3D bmp085_calc_pressure(client, up);
+
+	return pressure;
+}
+
+/***********************************************************************=
***
+ * sysfs attributes
+
*************************************************************************=
*/
+static ssize_t barometer_show_temp(struct device *dev,
+		struct device_attribute *da, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+	struct bmp085_data *data =3D indio_dev->dev_data;
+	struct i2c_client *client =3D data->client;
+	long status;
+
+	status =3D bmp085_read_temp(client);
+	if (status < 0)
+		dev_warn(&client->dev, "error reading temperature: %ld\n",
+				status);
+
+	data->temp =3D status;
+
+	return sprintf(buf, "%d\n", data->temp);
+}
+static IIO_DEV_ATTR_TEMP_RAW(barometer_show_temp);
+
+/**
+ * In standard mode, the temperature has to be read every second
before the
+ * pressure can be read. We leave this semantics to the userspace,
if later
+ * on a trigger based reading will be implemented, this should be
taken into
+ * account.
+ */
+static ssize_t barometer_show_pressure(struct device *dev,
+		struct device_attribute *da, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+	struct bmp085_data *data =3D iio_dev_get_devdata(indio_dev);
+	struct i2c_client *client =3D data->client;
+	long status;
+
+	status =3D bmp085_read_pressure(client);
+	if (status < 0)
+		dev_warn(&client->dev, "error reading pressure: %ld\n", status);
+
+	data->pressure =3D status;
+
+	return sprintf(buf, "%ld\n", data->pressure);
+}
+static IIO_DEV_ATTR_BARO_PRESSURE(S_IRUGO, barometer_show_pressure,
NULL, 0);
+
+static ssize_t barometer_show_id_version(struct device *dev,
+		struct device_attribute *da, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+	struct bmp085_data *data =3D iio_dev_get_devdata(indio_dev);
+
+	return sprintf(buf, "%x_%x\n", data->chip_id, data->chip_version);
+}
+static IIO_DEV_ATTR_REV(barometer_show_id_version);
+
+static ssize_t barometer_show_oss(struct device *dev,
+		struct device_attribute *da, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+	struct bmp085_data *data =3D iio_dev_get_devdata(indio_dev);
+
+	return sprintf(buf, "%d\n", data->oss);
+}
+static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO, barometer_show_oss, NULL);
+
+static IIO_CONST_ATTR_TEMP_SCALE("0.1");
+
+static struct attribute *bmp085_attributes[] =3D {
+	&iio_dev_attr_temp_raw.dev_attr.attr,
+	&iio_dev_attr_baro_pressure_input.dev_attr.attr,
+	&iio_dev_attr_revision.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_const_attr_temp_scale.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group bmp085_attr_group =3D {
+	.attrs =3D bmp085_attributes,
+};
+
+/***********************************************************************=
***
+ * Calibration data processing
+
*************************************************************************=
*/
+
+static int bmp085_init_client(struct i2c_client *client)
+{
+	struct bmp085_data *data =3D i2c_get_clientdata(client);
+	int i;
+
+	i =3D i2c_smbus_read_i2c_block_data(client, BMP085_REG_CHIP_ID, 1,
+			&data->chip_id);
+	if (i < 0)
+		dev_warn(&client->dev, "Chip ID not read\n");
+
+	i =3D i2c_smbus_read_i2c_block_data(client, BMP085_REG_VERSION, 1,
+			&data->chip_version);
+	if (i < 0)
+		dev_warn(&client->dev, "Version not read\n");
+
+	i =3D i2c_smbus_read_i2c_block_data(client, BMP085_REG_PROM,
BMP085_PROM_LENGTH,
+			data->data);
+	if (i < 0)
+		dev_warn(&client->dev, "Unable to read %d bytes from address "
+				"%#x\n", BMP085_PROM_LENGTH, BMP085_REG_PROM);
+
+	data->ac1 =3D (data->data[0] << 8) | data->data[1];
+	data->ac2 =3D (data->data[2] << 8) | data->data[3];
+	data->ac3 =3D (data->data[4] << 8) | data->data[5];
+	data->ac4 =3D (data->data[6] << 8) | data->data[7];
+	data->ac5 =3D (data->data[8] << 8) | data->data[9];
+	data->ac6 =3D (data->data[10] << 8) | data->data[11];
+	data->b1 =3D (data->data[12] << 8) | data->data[13];
+	data->b2 =3D (data->data[14] << 8) | data->data[15];
+	data->mb =3D (data->data[16] << 8) | data->data[17];
+	data->mc =3D (data->data[18] << 8) | data->data[19];
+	data->md =3D (data->data[20] << 8) | data->data[21];
+
+	return 0;
+}
+
+static int bmp085_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter =3D to_i2c_adapter(client->dev.parent);
+	struct bmp085_data *data;
+	int status =3D 0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				I2C_FUNC_SMBUS_WORD_DATA))
+		return -EIO;
+
+	/* Allocate driver data */
+	data =3D kzalloc(sizeof(struct bmp085_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	if ((oss < 0) || (oss > 3)) {
+		status =3D -EINVAL;
+		goto err;
+	}
+	data->oss =3D oss;
+
+	data->client =3D client;
+	i2c_set_clientdata(client, data);
+
+	/* Initialize the BMP085 chip */
+	bmp085_init_client(client);
+
+	mutex_init(&data->bmp085_lock);
+
+	/* Register with IIO */
+	data->indio_dev =3D iio_allocate_device();
+	if (data->indio_dev =3D=3D NULL) {
+		status =3D -ENOMEM;
+		goto err;
+	}
+
+	data->indio_dev->dev.parent =3D &client->dev;
+	data->indio_dev->attrs =3D &bmp085_attr_group;
+	data->indio_dev->dev_data =3D (void *)(data);
+	data->indio_dev->driver_module =3D THIS_MODULE;
+	data->indio_dev->modes =3D INDIO_DIRECT_MODE;
+
+	status =3D iio_device_register(data->indio_dev);
+	if (status < 0)
+		goto err_iio;
+
+	return 0;
+
+err_iio:
+	kfree(data->indio_dev);
+err:
+	kfree(data);
+	return status;
+}
+
+static int __devexit bmp085_remove(struct i2c_client *client)
+{
+	struct bmp085_data *data =3D i2c_get_clientdata(client);
+
+	iio_device_unregister(data->indio_dev);
+	iio_free_device(data->indio_dev);
+
+	kfree(data);
+
+	return 0;
+}
+
+static const struct i2c_device_id bmp085_id[] =3D {
+	{ "bmp085", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, bmp085_id);
+
+static struct i2c_driver bmp085_drv =3D {
+	.driver =3D {
+		.name =3D  "bmp085",
+		.owner =3D THIS_MODULE,
+	},
+	.suspend =3D NULL,
+	.resume =3D NULL,
+	.probe =3D bmp085_probe,
+	.remove =3D __devexit_p(bmp085_remove),
+	.id_table =3D bmp085_id,
+};
+
+/*----------------------------------------------------------------------=
---*/
+
+static int __init bmp085_init_module(void)
+{
+	printk(KERN_INFO"bmp085 loading...\n");
+
+	return i2c_add_driver(&bmp085_drv);
+}
+
+static void __exit bmp085_exit_module(void)
+{
+	i2c_del_driver(&bmp085_drv);
+}
+
+MODULE_AUTHOR("Matthias Brugger <matthias.brugger@iis.fraunhofer.de>");
+MODULE_DESCRIPTION("I2c device driver for BMP085 barometererator
sensor");
+MODULE_LICENSE("GPL");
+
+module_init(bmp085_init_module);
+module_exit(bmp085_exit_module);
diff --git a/drivers/staging/iio/barometer/bmp085.h
b/drivers/staging/iio/barometer/bmp085.h
new file mode 100644
index 0000000..aec2ee4
--- /dev/null
+++ b/drivers/staging/iio/barometer/bmp085.h
@@ -0,0 +1,108 @@
+#ifndef BMP085_H
+#define BMP085_H
+
+#include "../iio.h"
+#include "baro.h"
+
+#define BMP085_REG_CONV		0xF6 /* Temperature/pressure value UT or UP */
+#define BMP085_REG_CONV_XLS	0xF8
+
+#define BMP085_REG_PROM		0xAA
+#define BMP085_PROM_LENGTH	22
+
+#define BMP085_REG_AC1		0xAA
+#define BMP085_REG_AC2		0xAC
+#define BMP085_REG_AC3		0xAE
+#define BMP085_REG_AC4		0xB0
+#define BMP085_REG_AC5		0xB2
+#define BMP085_REG_AC6		0xB4
+#define BMP085_REG_B1		0xB6
+#define BMP085_REG_B2		0xB8
+#define BMP085_REG_MB		0xBA
+#define BMP085_REG_MC		0xBC
+#define BMP085_REG_MD		0xBE
+
+#define BMP085_START_CONV	0xF4
+
+#define BMP085_START_TEMP	0x2E  /* wait 4.5 ms */
+
+#define BMP085_START_PRESS_OSRS0 0x34 /* wait 4.5 ms */
+#define BMP085_START_PRESS_OSRS1 0x74 /* wait 7.5 ms */
+#define BMP085_START_PRESS_OSRS2 0xB4 /* wait 13.5 ms */
+#define BMP085_START_PRESS_OSRS3 0xF4 /* wait 25.5 ms */
+
+#define BMP085_REG_CHIP_ID	0xD0
+#define BMP085_REG_VERSION	0xD1
+#define BMP085_CHIP_ID		0x55
+
+/*
+ * data structure for every sensor
+ *
+ * @client		i2c client
+ * @ indio_dev		iio device representation
+ *
+ * @bmp085_lock		mutex to synchronize parallel reads and writes
+ *
+ * @oss			oversampling setting, determines how accurate the chip works
+ * @temp		holding actual temperature in 0.1=B0C
+ * @pressure		holding actual pressure in pascal
+ *
+ * @ac1			calibration value read at start-up
+ * @ac2			calibration value read at start-up
+ * @ac3			calibration value read at start-up
+ * @ac4			calibration value read at start-up
+ * @ac5			calibration value read at start-up
+ * @ac6			calibration value read at start-up
+ *
+ * @b1			calibration value read at start-up
+ * @b2			calibration value read at start-up
+ * @b3			calibration value read at start-up
+ *
+ * @mb			calibration value read at start-up
+ * @mc			calibration value read at start-up
+ * @md			calibration value read at start-up
+ *
+ * @ut			raw data to compute temperature
+ * @up			raw data to compute pressure
+ *
+ * @chip_id		id of the chip
+ * @chip_version	version of the chip
+ *
+ * @data		array to read initial calib data as a bulk
+ */
+struct bmp085_data {
+	struct i2c_client *client;
+	struct iio_dev *indio_dev;
+
+	struct mutex bmp085_lock;
+
+	int oss;
+	s16 temp;
+	long pressure;
+
+	short ac1;
+	short ac2;
+	short ac3;
+	unsigned short ac4;
+	unsigned short ac5;
+	unsigned short ac6;
+
+	short b1;
+	short b2;
+	long b5;
+
+	short mb;
+	short mc;
+	short md;
+
+	unsigned long ut;
+	unsigned long up;
+
+	u8 chip_id;
+	u8 chip_version;
+
+	unsigned char data[22];
+};
+
+
+#endif
--=20
1.5.6.5
