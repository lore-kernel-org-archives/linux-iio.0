Return-Path: <matthias.bgg9ab33xy531gmail.com@bounce.antispameurope.com>
Message-ID: <4CB74682.4050504@gmail.com>
Date: Thu, 14 Oct 2010 20:05:54 +0200
From: Matthias Brugger <matthias.bgg@gmail.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
        matthias <mensch0815@googlemail.com>
Subject: [RFC 2/2] ii - add support for bmp085 barometer
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

This patch adds support for the bmp085 digital barometer.
It is not yet complete for merge, as it has loads of comments and a define statement.

Signed-off-by: Matthias Brugger <mensch0815@gmail.com>

---
 drivers/staging/iio/barometer/Kconfig  |    7 +
 drivers/staging/iio/barometer/Makefile |    1 +
 drivers/staging/iio/barometer/bmp085.c |  448 ++++++++++++++++++++++++++++++++
 drivers/staging/iio/barometer/bmp085.h |   78 ++++++
 4 files changed, 534 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/barometer/bmp085.c
 create mode 100644 drivers/staging/iio/barometer/bmp085.h

diff --git a/drivers/staging/iio/barometer/Kconfig b/drivers/staging/iio/barometer/Kconfig
index 588325c..d5942e9 100644
--- a/drivers/staging/iio/barometer/Kconfig
+++ b/drivers/staging/iio/barometer/Kconfig
@@ -3,3 +3,10 @@
 #
 comment "Digital barometer sensors"
 
+config BMP085
+
+	tristate "BMP085 Barometer Sensor I2C driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Bosch Sensortec BMP085,
+	  digital barometer sensor.
diff --git a/drivers/staging/iio/barometer/Makefile b/drivers/staging/iio/barometer/Makefile
index 2963d72..6f20b29 100644
--- a/drivers/staging/iio/barometer/Makefile
+++ b/drivers/staging/iio/barometer/Makefile
@@ -2,3 +2,4 @@
 # Makefile for digital gyroscope sensor drivers
 #
 
+obj-$(CONFIG_BMP085) += bmp085.o
diff --git a/drivers/staging/iio/barometer/bmp085.c b/drivers/staging/iio/barometer/bmp085.c
new file mode 100644
index 0000000..45abe98
--- /dev/null
+++ b/drivers/staging/iio/barometer/bmp085.c
@@ -0,0 +1,448 @@
+/**
+ * Bosch Sensortec BMP085 Digital Pressure Sensor
+ *
+ * Written by: Matthias Brugger <matthias.brugger@iis.fraunhofer.de>
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
+
+//#define BMP085_TEST 
+#undef BMP085_TEST 
+
+int oss = 3;
+module_param(oss, int , S_IRUSR);
+MODULE_PARM_DESC(oss, "Oversampling setting [0-3]");
+
+/************************************************************************** 
+ * Calcualtion of temperature and pressure
+ **************************************************************************/
+static short bmp085_calc_temperature(struct i2c_client *client, unsigned long ut)
+{
+	struct bmp085_data *data = i2c_get_clientdata(client);
+	long x1, x2;
+	short temp;
+
+	x1 = ((long) ut - (long) data->ac6) * (long) data->ac5 >> 15;
+	x2 = ((long) data->mc << 11) / (x1 + data->md);
+	data->b5 = x1 + x2;
+	temp = ((data->b5 + 8) >> 4);
+
+//	dev_info(&client->dev, "ut %ld\n", ut);
+//	dev_info(&client->dev, "x1 %ld - x2 %ld - b5 %ld\n", x1, x2, data->b5);
+
+	return temp;
+}
+
+static long bmp085_calc_pressure(struct i2c_client *client, unsigned long up)
+{
+	struct bmp085_data *data = i2c_get_clientdata(client);
+	long b6, x1, x2, x3, b3;
+	unsigned long b4, b7;
+	long pressure, p;
+	long tmp;
+
+//	dev_info(&client->dev, "up %ld\n", up);
+
+	b6 = data->b5 - 4000;
+	x1 = (data->b2 * (b6 * b6 / (1<<12))) / (1<<11);
+	x2 = data->ac2 * b6 / (1<<11);
+	x3 = x1 + x2;
+	b3 = (((data->ac1 * 4 + x3) << data->oss) + 2) / 4;
+//	dev_info(&client->dev, "b6 %ld - x1 %ld - x2 %ld - x3 %ld - b3 %ld\n", b6, x1, x2, x3, b3);
+
+	x1 = data->ac3 * b6 / (1<<13);
+	x2 = (data->b1 * ((b6 * b6) / (1<<12))) / (1<<16);
+	x3 = ((x1 + x2) + 2) / (1<<2);
+	b4 = data->ac4 * (unsigned long) (x3 + 32768) / (1<<15);
+	b7 = ((unsigned long)up - b3) * (50000 >> data->oss);
+
+//	dev_info(&client->dev, "x1 %ld - x2 %ld - x3 %ld - b4 %lu - b7 %lu\n", x1, x2, x3, b4, b7);
+
+	if(b7 < 0x80000000)
+		p = (b7 * 2) / b4;
+	else
+		p = (b7 / b4) * 2;
+	tmp = (p / (1<<8)) * (p / (1<<8));
+	x1 = (tmp * 3038) / (1<<16);
+	x2 = (-7357 * p) / (1<<16);
+	pressure = p + ( (x1 + x2 + 3791) / (1<<4) );
+
+//	dev_info(&client->dev, "p %ld - tmp %ld -  x1 %ld - x2 %ld - pressure %ld\n", p, tmp, x1, x2, pressure);
+//	dev_info(&client->dev, "pressure %ld\n", pressure);
+
+	return pressure;   
+}
+
+/************************************************************************** 
+ * Digital interface to sensor
+ **************************************************************************/
+
+static ssize_t bmp085_read(struct i2c_client* client, u8 reg, size_t count, unsigned char* buffer)
+{
+	int rc;
+	rc = i2c_smbus_read_i2c_block_data(client, reg, count, buffer);
+	if (rc < 0)
+			return -EIO;
+
+	return count;
+}
+
+static short bmp085_read_temp(struct i2c_client* client)
+{
+	s32 ret;
+	short temp;
+	struct bmp085_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->bmp085_lock);
+	ret = i2c_smbus_write_byte_data(client, BMP085_START_CONV, BMP085_START_TEMP);
+	mutex_unlock(&data->bmp085_lock);
+	if (ret < 0) {
+		dev_warn(&client->dev, "starting temperature conversation failed\n");
+		return ret;
+	}
+
+	mdelay(5);
+	ret = bmp085_read(client, BMP085_REG_CONV, 2, data->data);
+	if (ret < 0) {
+		dev_warn(&client->dev, "reading ut failed, value is %#x\n", ret);
+		return ret;
+	}
+
+	data->ut = (data->data[0] << 8) | data->data[1];
+#ifdef BMP085_TEST
+	ret = 27898;
+#endif
+
+	temp = bmp085_calc_temperature(client, data->ut);
+
+	//dev_info(&client->dev, "temp: %d\n", temp);
+
+	return temp;
+}
+
+static long bmp085_read_pressure(struct i2c_client *client)
+{
+	unsigned long up = 0;
+	int ret;
+	u8 xlsb, ret1, ret2;
+	long pressure; 
+	u8 reg;
+	int time_delay[4] = {5, 8, 14, 26}; /* TODO should be 4.5, 7.5, 13.5, 25.5 ms */
+	struct bmp085_data *data = i2c_get_clientdata(client);
+
+	if (data->oss == 0)
+		reg = BMP085_START_PRESS_OSRS0;
+	else if (data->oss == 1)
+		reg = BMP085_START_PRESS_OSRS1;
+	else if (data->oss == 2)
+		reg = BMP085_START_PRESS_OSRS2;
+	else if (data->oss ==3)
+		reg = BMP085_START_PRESS_OSRS3;
+	else {
+		dev_warn(&client->dev, "undefined oss value, use oss = 0\n");
+		data->oss = 0;
+		reg = BMP085_START_PRESS_OSRS0;
+	}
+
+	mutex_lock(&data->bmp085_lock);
+	ret = i2c_smbus_write_byte_data(client, BMP085_START_CONV, reg);
+	mutex_unlock(&data->bmp085_lock);
+	if (ret < 0)
+		return ret;
+
+	/* don't bloody do that, we should do reschedule() (?) */
+	mdelay(time_delay[data->oss]);
+
+	mutex_lock(&data->bmp085_lock);
+	ret1 = i2c_smbus_read_byte_data(client, 0xf6);
+	ret2 = i2c_smbus_read_byte_data(client, 0xf7);
+	xlsb = i2c_smbus_read_byte_data(client, 0xf8);
+	mutex_unlock(&data->bmp085_lock);
+
+	up = (((unsigned long) ret1 << 16) | ((unsigned long) ret2 << 8) | (unsigned long) xlsb) >> (8 - data->oss);
+	data->up = up;
+
+//	dev_info(&client->dev, "ret %#x, ret1 %#x, ret2 %#x, xlsb %#x, oss %d\n", up, ret1, ret2, xlsb, oss);
+//	dev_info(&client->dev, "ret %lu - ret1 %d, ret2 %d, xlsb %d, oss %d\n", up, ret1, ret2, xlsb, oss);
+
+#ifdef BMP085_TEST   
+	ret = 23843;
+#endif
+
+	pressure = bmp085_calc_pressure(client, up);
+	data->pressure = pressure;
+
+	//dev_info(&client->dev, "pressure %ld\n", pressure);
+
+	return pressure;
+}
+
+/************************************************************************** 
+ * sysfs attributes 
+ **************************************************************************/
+static ssize_t barometer_show_temp (struct device *dev, struct device_attribute* da, char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bmp085_data *data = indio_dev->dev_data;
+	struct i2c_client *client = data->client;
+	long status;
+
+	status = bmp085_read_temp(client);
+	if (status < 0)
+		dev_warn(&client->dev, "error reading temperature: %ld\n", status);
+	
+	data->temp = status;
+
+	return sprintf(buf, "%ld\n", data->temp);
+}
+static IIO_DEV_ATTR_TEMP_RAW(barometer_show_temp);
+
+static ssize_t barometer_show_pressure(struct device *dev, struct device_attribute* da, char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bmp085_data *data = indio_dev->dev_data;
+	struct i2c_client *client = data->client;
+	long status;
+
+	status = bmp085_read_pressure(client);
+	if (status < 0)
+		dev_warn(&client->dev, "error reading pressure: %ld\n", status);
+
+	data->pressure = status;
+
+	return sprintf(buf, "%ld\n", data->pressure);
+}
+static IIO_DEV_ATTR_BARO_PRESSURE(S_IRUGO, barometer_show_pressure, NULL, 0);
+
+static ssize_t barometer_show_id_version(struct device *dev, struct device_attribute* da, char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bmp085_data *data = indio_dev->dev_data;
+
+	return sprintf(buf, "%x_%x\n", data->chip_id, data->chip_version);
+}
+static IIO_DEV_ATTR_REV(barometer_show_id_version);
+
+static ssize_t barometer_show_oss(struct device *dev, struct device_attribute* da, char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bmp085_data *data = indio_dev->dev_data;
+
+	return sprintf(buf, "%d\n", data->oss);
+}
+static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO, barometer_show_oss, NULL);
+
+static struct attribute *bmp085_attributes[] = {
+	&iio_dev_attr_temp_raw.dev_attr.attr,
+	&iio_dev_attr_baro_pressure.dev_attr.attr,
+	&iio_dev_attr_revision.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group bmp085_attr_group = {
+	.attrs = bmp085_attributes,
+};
+
+/************************************************************************** 
+ * Calibration data processing
+ **************************************************************************/
+
+static int bmp085_init_client(struct i2c_client* client)
+{
+	struct bmp085_data *data = i2c_get_clientdata(client);
+	int i;
+	
+	i = bmp085_read(client, BMP085_REG_CHIP_ID, 1, &data->chip_id);
+	if (i < 0)
+		dev_warn(&client->dev, "Chip ID not read\n");
+	
+	i = bmp085_read(client, BMP085_REG_VERSION, 1, &data->chip_version);
+	if (i < 0)
+		dev_warn(&client->dev, "Version not read\n");
+
+//	dev_info(&client->dev, "Chip ID = %#x, Chip Version = %#x\n", data->chip_id, data->chip_version);
+
+	i = bmp085_read(client, BMP085_REG_PROM, BMP085_PROM_LENGTH, data->data);
+	if (i < 0)
+		dev_warn(&client->dev, "Unable to read %d bytes from address %#x\n", BMP085_PROM_LENGTH, BMP085_REG_PROM);
+
+	data->ac1 = (data->data[0] << 8) | data->data[1];
+	data->ac2 = (data->data[2] << 8) | data->data[3];
+	data->ac3 = (data->data[4] << 8) | data->data[5];
+	data->ac4 = (data->data[6] << 8) | data->data[7];
+	data->ac5 = (data->data[8] << 8) | data->data[9];
+	data->ac6 = (data->data[10] << 8) | data->data[11];
+	data->b1 = (data->data[12] << 8) | data->data[13];
+	data->b2 = (data->data[14] << 8) | data->data[15];
+	data->mb = (data->data[16] << 8) | data->data[17];
+	data->mc = (data->data[18] << 8) | data->data[19];
+	data->md = (data->data[20] << 8) | data->data[21];
+
+#ifdef BMP085_TEST
+	data->ac1 = 408;
+	data->ac2 = -72;
+	data->ac3 = -14383;
+	data->ac4 = 32741;
+	data->ac5 = 32757;
+	data->ac6 = 23153;
+	data->b1 = 6190;
+	data->b2 = 4;
+	data->mb = -32768;
+	data->mc = -8711;
+	data->md = 2868;
+#endif
+	//dev_info(&client->dev, "AC1 %#x - AC2 %#x - AC3 %#x - AC4 %#x - AC5 %#x - AC6 %#x\n", data->ac1, data->ac2, data->ac3, data->ac4, data->ac5, data->ac6);
+	//dev_info(&client->dev, "B1 %#x - B2 %#x - MB %#x - MC %#x - MD %#x\n", data->b1, data->b2, data->mb, data->mc, data->md);
+
+	//dev_info(&client->dev, "AC1 %d - AC2 %d - AC3 %d - AC4 %u - AC5 %u - AC6 %u\n", data->ac1, data->ac2, data->ac3, data->ac4, data->ac5, data->ac6);
+	//dev_info(&client->dev, "B1 %d - B2 %d - MB %d - MC %d - MD %d\n", data->b1, data->b2, data->mb, data->mc, data->md);
+	return 0;
+}
+
+static struct i2c_driver bmp085_drv;
+static int bmp085_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
+	struct bmp085_data *data;
+	struct bmp085_data *data2;
+	int status = 0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA)) 
+		return -EIO;
+
+	/* Allocate driver data */
+	data = kzalloc(sizeof(struct bmp085_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	if((oss < 0) || (oss > 3))
+	{
+		status = -EINVAL;
+		goto err;
+	}
+	data->oss = oss;
+
+#ifdef BMP085_TEST
+	data->oss = 0;
+#endif
+
+	data->client = client;
+	i2c_set_clientdata(client, data);
+	data2 = i2c_get_clientdata(client);
+
+	/* Initialize the BMP085 chip */
+	bmp085_init_client(client);
+
+	__mutex_init(&data->bmp085_lock, "bmp085_lock", NULL); 
+
+	/* Register with IIO */
+	data->indio_dev = iio_allocate_device();
+	if (data->indio_dev == NULL) {
+		status = -ENOMEM;
+		goto err;
+	}
+
+	data->indio_dev->dev.parent = &client->dev;
+	data->indio_dev->attrs = &bmp085_attr_group;
+	data->indio_dev->dev_data = (void *)(data);
+	data->indio_dev->driver_module = THIS_MODULE;
+	data->indio_dev->modes = INDIO_DIRECT_MODE;
+
+	status = iio_device_register(data->indio_dev);
+	if (status < 0)
+		goto err_iio;
+
+	dev_info(&client->dev, "driver enabled\n");
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
+	struct bmp085_data *data = i2c_get_clientdata(client);
+
+	if(mutex_is_locked(&data->bmp085_lock))
+		mutex_unlock(&data->bmp085_lock);
+
+	iio_device_unregister(data->indio_dev);
+	iio_free_device(data->indio_dev);
+
+	kfree(data);
+
+	dev_info(&client->dev, "driver removed\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id bmp085_id[] = {
+	{ "bmp085", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, bmp085_id);
+
+static struct i2c_driver bmp085_drv = {
+	.driver = {
+		.name =  "bmp085",
+		.owner = THIS_MODULE,
+	},
+	.suspend = NULL,
+	.resume = NULL,
+	.probe = bmp085_probe,
+	.remove = __devexit_p(bmp085_remove),
+	.id_table = bmp085_id,
+};
+
+/*-------------------------------------------------------------------------*/
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
+MODULE_DESCRIPTION("I2c device driver for BMP085 barometererator sensor");
+MODULE_LICENSE("GPL");
+
+module_init(bmp085_init_module);
+module_exit(bmp085_exit_module);
diff --git a/drivers/staging/iio/barometer/bmp085.h b/drivers/staging/iio/barometer/bmp085.h
new file mode 100644
index 0000000..5f96de5
--- /dev/null
+++ b/drivers/staging/iio/barometer/bmp085.h
@@ -0,0 +1,78 @@
+#ifndef BMP085_H
+#define BMP085_H
+
+#include "../iio.h"
+#include "baro.h"
+
+#define BMP085_REG_CONV		0xF6 /* Temperature or pressure value UT or UP */
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
+struct bmp085_data {
+	struct i2c_client *client;
+	struct iio_dev *indio_dev;
+
+	struct timer_list temp_trigger;
+	struct timer_list press_trigger;
+	struct work_struct temp_wq;
+	struct work_struct press_wq;
+
+	struct mutex bmp085_lock;
+
+	int oss;
+	long temp;
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
-- 
1.5.6.5
