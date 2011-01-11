Return-Path: <stigge@antcom.de>
Message-ID: <4D2C8348.2090606@antcom.de>
Date: Tue, 11 Jan 2011 17:20:24 +0100
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Greg KH <greg@kroah.com>, devel@driverdev.osuosl.org,
 linux-iio@vger.kernel.org,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: Linux driver for MAX517/518/519
References: <4D29C64E.4040806@antcom.de> <4D2A373B.6060901@cam.ac.uk>
In-Reply-To: <4D2A373B.6060901@cam.ac.uk>
Content-Type: multipart/mixed;
 boundary="------------010409050902020205030301"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------010409050902020205030301
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 01/09/2011 11:31 PM, Jonathan Cameron wrote:
> Pretty clean and nice driver so it was an easy review and should
> be trivial to fix up for a merge.

Thanks for your review!

I'm attaching my update. Some notes:

* I used the attributes out1_* how I found it in the other DAC driver
already available
* suspend doesn't need the protective #ifdefs
* As for other drivers, drivers/staging/iio/dac/max517.h needs to go to
include/linux/iio as soon as available

I think I addressed everything from your notes. Let me know if there is
still some blocker.

Thanks in advance!

Roland


--------------010409050902020205030301
Content-Type: text/x-patch;
 name="max517.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="max517.patch"

IIO Driver for Maxim MAX517, MAX518 and MAX519 DAC

Signed-off-by: Roland Stigge <stigge@antcom.de>
diff --git a/drivers/staging/iio/Documentation/dac/max517 b/drivers/staging/iio/Documentation/dac/max517
new file mode 100644
index 0000000..e60ec2f
--- /dev/null
+++ b/drivers/staging/iio/Documentation/dac/max517
@@ -0,0 +1,41 @@
+Kernel driver max517
+====================
+
+Supported chips:
+  * Maxim MAX517, MAX518, MAX519
+    Prefix: 'max517'
+    Datasheet: Publicly available at the Maxim website
+               http://www.maxim-ic.com/
+
+Author:
+        Roland Stigge <stigge@antcom.de>
+
+Description
+-----------
+
+The Maxim MAX517/518/519 is an 8-bit DAC on the I2C bus. The following table
+shows the different feature sets of the variants MAX517, MAX518 and MAX519:
+
+Feature                              MAX517 MAX518 MAX519
+--------------------------------------------------------------------------
+One output channel                   X
+Two output channels                         X      X
+Simultaneous output updates                 X      X
+Supply voltage as reference                 X
+Separate reference input             X
+Reference input for each DAC                       X
+
+Via the iio sysfs interface, there are three attributes available: out1_raw,
+out2_raw and out12_raw. With out1_raw and out2_raw, the current output values
+(0..255) of the DACs can be written to the device. out12_raw can be used to set
+both output channel values simultaneously.
+
+With MAX517, only out1_raw is available.
+
+Via out1_scale (and where appropriate, out2_scale), the current scaling factor
+in mV can be read.
+
+When the operating system goes to a power down state, the Power Down function
+of the chip is activated, reducing the supply current to 4uA.
+
+On power-up, the device is in 0V-output state.
diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
index 9191bd2..2120904 100644
--- a/drivers/staging/iio/dac/Kconfig
+++ b/drivers/staging/iio/dac/Kconfig
@@ -19,3 +19,13 @@ config AD5446
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5446.
+
+config MAX517
+	tristate "Maxim MAX517/518/519 DAC driver"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the Maxim chips MAX517,
+	  MAX518 and MAX519 (I2C 8-Bit DACs with rail-to-rail outputs).
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called max517.
diff --git a/drivers/staging/iio/dac/Makefile b/drivers/staging/iio/dac/Makefile
index 7cf331b..1197aef 100644
--- a/drivers/staging/iio/dac/Makefile
+++ b/drivers/staging/iio/dac/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_AD5624R_SPI) += ad5624r_spi.o
 obj-$(CONFIG_AD5446) += ad5446.o
+obj-$(CONFIG_MAX517) += max517.o
diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
new file mode 100644
index 0000000..5c57523
--- /dev/null
+++ b/drivers/staging/iio/dac/max517.c
@@ -0,0 +1,294 @@
+/*
+ *  max517.c - Support for Maxim MAX517, MAX518 and MAX519
+ *
+ *  Copyright (C) 2010, 2011 Roland Stigge <stigge@antcom.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+
+#include "../iio.h"
+#include "dac.h"
+
+#include "max517.h"
+
+#define MAX517_DRV_NAME	"max517"
+
+/* Commands */
+#define COMMAND_CHANNEL0	0x00
+#define COMMAND_CHANNEL1	0x01 /* for MAX518 and MAX519 */
+#define COMMAND_PD		0x08 /* Power Down */
+
+enum max517_device_ids {
+	ID_MAX517,
+	ID_MAX518,
+	ID_MAX519,
+};
+
+struct max517_data {
+	struct iio_dev		*indio_dev;
+	unsigned short		vref_mv[2];
+};
+
+/*
+ * channel: bit 0: channel 1
+ *          bit 1: channel 2
+ * (this way, it's possible to set both channels at once)
+ */
+static ssize_t max517_set_value(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count, int channel)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 outbuf[4]; /* 1x or 2x command + value */
+	int outbuf_size = 0;
+	int res;
+	long val;
+
+	res = strict_strtol(buf, 10, &val);
+
+	if (res)
+		return res;
+
+	if (val < 0 || val > 255)
+		return -EINVAL;
+
+	if (channel & 1) {
+		outbuf[outbuf_size++] = COMMAND_CHANNEL0;
+		outbuf[outbuf_size++] = val;
+	}
+	if (channel & 2) {
+		outbuf[outbuf_size++] = COMMAND_CHANNEL1;
+		outbuf[outbuf_size++] = val;
+	}
+
+	/*
+	 * At this point, there are always 1 or 2 two-byte commands in
+	 * outbuf. With 2 commands, the device can set two outputs
+	 * simultaneously, latching the values upon the end of the I2C
+	 * transfer.
+	 */
+
+	res = i2c_master_send(client, outbuf, outbuf_size);
+	if (res < 0)
+		return res;
+
+	return count;
+}
+
+static ssize_t max517_set_value_1(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	return max517_set_value(dev, attr, buf, count, 1);
+}
+static IIO_DEV_ATTR_OUT_RAW(1, max517_set_value_1, 0);
+
+static ssize_t max517_set_value_2(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	return max517_set_value(dev, attr, buf, count, 2);
+}
+static IIO_DEV_ATTR_OUT_RAW(2, max517_set_value_2, 1);
+
+static ssize_t max517_set_value_both(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	return max517_set_value(dev, attr, buf, count, 3);
+}
+static IIO_DEV_ATTR_OUT_RAW(12, max517_set_value_both, -1);
+
+static ssize_t max517_show_scale(struct device *dev,
+				struct device_attribute *attr,
+				char *buf, int channel)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct max517_data *data = iio_dev_get_devdata(dev_info);
+	/* Corresponds to Vref / 2^(bits) */
+	unsigned int scale_uv = (data->vref_mv[channel - 1] * 1000) >> 8;
+
+	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
+}
+
+static ssize_t max517_show_scale1(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	return max517_show_scale(dev, attr, buf, 1);
+}
+static IIO_DEVICE_ATTR(out1_scale, S_IRUGO, max517_show_scale1, NULL, 0);
+
+static ssize_t max517_show_scale2(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	return max517_show_scale(dev, attr, buf, 2);
+}
+static IIO_DEVICE_ATTR(out2_scale, S_IRUGO, max517_show_scale2, NULL, 0);
+
+/* On MAX517 variant, we have two outputs */
+static struct attribute *max517_attributes[] = {
+	&iio_dev_attr_out1_raw.dev_attr.attr,
+	&iio_dev_attr_out1_scale.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group max517_attribute_group = {
+	.attrs = max517_attributes,
+};
+
+/* On MAX518 and MAX518 variant, we have two outputs */
+static struct attribute *max518_attributes[] = {
+	&iio_dev_attr_out1_raw.dev_attr.attr,
+	&iio_dev_attr_out1_scale.dev_attr.attr,
+	&iio_dev_attr_out2_raw.dev_attr.attr,
+	&iio_dev_attr_out2_scale.dev_attr.attr,
+	&iio_dev_attr_out12_raw.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group max518_attribute_group = {
+	.attrs = max518_attributes,
+};
+
+static int max517_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	u8 outbuf = COMMAND_PD;
+
+	return i2c_master_send(client, &outbuf, 1);
+}
+
+static int max517_resume(struct i2c_client *client)
+{
+	u8 outbuf = 0;
+
+	return i2c_master_send(client, &outbuf, 1);
+}
+
+static int max517_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct max517_data *data;
+	struct max517_platform_data *platform_data = client->dev.platform_data;
+	int err;
+
+	data = kzalloc(sizeof(struct max517_data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	i2c_set_clientdata(client, data);
+
+	data->indio_dev = iio_allocate_device();
+	if (data->indio_dev == NULL) {
+		err = -ENOMEM;
+		goto exit_free_data;
+	}
+
+	/* establish that the iio_dev is a child of the i2c device */
+	data->indio_dev->dev.parent = &client->dev;
+
+	/* reduced attribute set for MAX517 */
+	if (id->driver_data == ID_MAX517)
+		data->indio_dev->attrs = &max517_attribute_group;
+	else
+		data->indio_dev->attrs = &max518_attribute_group;
+	data->indio_dev->dev_data = (void *)(data);
+	data->indio_dev->driver_module = THIS_MODULE;
+	data->indio_dev->modes = INDIO_DIRECT_MODE;
+
+	/*
+	 * Reference voltage on MAX518 is 5V, else take vref_mv from
+	 * platform_data
+	 */
+	if (id->driver_data == ID_MAX518)
+		data->vref_mv[0] = data->vref_mv[1] = 5000; /* mV */
+	else
+		if (platform_data) {
+			data->vref_mv[0] = platform_data->vref_mv[0];
+			data->vref_mv[1] = platform_data->vref_mv[1];
+		} else /* 5V by default */
+			data->vref_mv[0] = data->vref_mv[1] = 5000;
+
+	err = iio_device_register(data->indio_dev);
+	if (err)
+		goto exit_free_device;
+
+	dev_info(&client->dev, "DAC registered\n");
+
+	return 0;
+
+exit_free_device:
+	iio_free_device(data->indio_dev);
+exit_free_data:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int max517_remove(struct i2c_client *client)
+{
+	struct max517_data *data = i2c_get_clientdata(client);
+
+	iio_free_device(data->indio_dev);
+	kfree(data);
+
+	return 0;
+}
+
+static const struct i2c_device_id max517_id[] = {
+	{ "max517", ID_MAX517 },
+	{ "max518", ID_MAX518 },
+	{ "max519", ID_MAX519 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max517_id);
+
+static struct i2c_driver max517_driver = {
+	.driver = {
+		.name	= MAX517_DRV_NAME,
+	},
+	.probe		= max517_probe,
+	.remove		= max517_remove,
+	.suspend	= max517_suspend,
+	.resume		= max517_resume,
+	.id_table	= max517_id,
+};
+
+static int __init max517_init(void)
+{
+	return i2c_add_driver(&max517_driver);
+}
+
+static void __exit max517_exit(void)
+{
+	i2c_del_driver(&max517_driver);
+}
+
+MODULE_AUTHOR("Roland Stigge <stigge@antcom.de>");
+MODULE_DESCRIPTION("MAX517/MAX518/MAX519 8-bit DAC");
+MODULE_LICENSE("GPL");
+
+module_init(max517_init);
+module_exit(max517_exit);
diff --git a/drivers/staging/iio/dac/max517.h b/drivers/staging/iio/dac/max517.h
new file mode 100644
index 0000000..8106cf2
--- /dev/null
+++ b/drivers/staging/iio/dac/max517.h
@@ -0,0 +1,19 @@
+/*
+ * MAX517 DAC driver
+ *
+ * Copyright 2011 Roland Stigge <stigge@antcom.de>
+ *
+ * Licensed under the GPL-2 or later.
+ */
+#ifndef IIO_DAC_MAX517_H_
+#define IIO_DAC_MAX517_H_
+
+/*
+ * TODO: struct max517_platform_data needs to go into include/linux/iio
+ */
+
+struct max517_platform_data {
+	u16				vref_mv[2];
+};
+
+#endif /* IIO_DAC_MAX517_H_ */

--------------010409050902020205030301--
