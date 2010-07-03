Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47483 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754896Ab0GCT1M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 3 Jul 2010 15:27:12 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o63JR8HO013131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-iio@vger.kernel.org>; Sat, 3 Jul 2010 14:27:10 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o63JR7LL029823
	for <linux-iio@vger.kernel.org>; Sun, 4 Jul 2010 00:57:07 +0530 (IST)
From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Sun, 4 Jul 2010 00:57:06 +0530
Subject: [RFC] [PATCH] digital compass hmc5843
Message-ID: <0680EC522D0CC943BC586913CF3768C003B360349F@dbde02.ent.ti.com>
Content-Type: multipart/mixed;
	boundary="_002_0680EC522D0CC943BC586913CF3768C003B360349Fdbde02enttico_"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--_002_0680EC522D0CC943BC586913CF3768C003B360349Fdbde02enttico_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


- Changing the interface to suit the standards

TODO
- Documentation for the interface provided
- Gauss is reported in millig


Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/staging/iio/Kconfig                |    1 +
 drivers/staging/iio/Makefile               |    1 +
 drivers/staging/iio/magnetometer/Kconfig   |   15 +
 drivers/staging/iio/magnetometer/Makefile  |    5 +
 drivers/staging/iio/magnetometer/hmc5843.c |  598 ++++++++++++++++++++++++=
++++
 5 files changed, 620 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/magnetometer/Kconfig
 create mode 100644 drivers/staging/iio/magnetometer/Makefile
 create mode 100644 drivers/staging/iio/magnetometer/hmc5843.c

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index b0e6244..569b938 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -44,6 +44,7 @@ source "drivers/staging/iio/adc/Kconfig"
 source "drivers/staging/iio/gyro/Kconfig"
 source "drivers/staging/iio/imu/Kconfig"
 source "drivers/staging/iio/light/Kconfig"
+source "drivers/staging/iio/magnetometer/Kconfig"

 source "drivers/staging/iio/trigger/Kconfig"

diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 3502b39..10d1f6b 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -14,5 +14,6 @@ obj-y +=3D adc/
 obj-y +=3D gyro/
 obj-y +=3D imu/
 obj-y +=3D light/
+obj-y +=3D magnetometer/

 obj-y +=3D trigger/
\ No newline at end of file
diff --git a/drivers/staging/iio/magnetometer/Kconfig b/drivers/staging/iio=
/magnetometer/Kconfig
new file mode 100644
index 0000000..6c67981
--- /dev/null
+++ b/drivers/staging/iio/magnetometer/Kconfig
@@ -0,0 +1,15 @@
+#
+# Magnetometer sensors
+#
+comment "Magnetometer sensors"
+
+config SENSORS_HMC5843
+       tristate "Honeywell HMC5843 3-Axis Magnetometer"
+       depends on I2C
+       help
+         Say Y here to add support for the Honeywell HMC 5843 3-Axis
+         Magnetometer (digital compass).
+
+         To compile this driver as a module, choose M here: the module
+         will be called hmc5843
+
diff --git a/drivers/staging/iio/magnetometer/Makefile b/drivers/staging/ii=
o/magnetometer/Makefile
new file mode 100644
index 0000000..f9bfb2e
--- /dev/null
+++ b/drivers/staging/iio/magnetometer/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for industrial I/O Magnetometer sensors
+#
+
+obj-$(CONFIG_SENSORS_HMC5843)  +=3D hmc5843.o
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/i=
io/magnetometer/hmc5843.c
new file mode 100644
index 0000000..a143793
--- /dev/null
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -0,0 +1,598 @@
+/*  Copyright (c) 2010  Shubhrajyoti Datta <shubhrajyoti@ti.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include "../iio.h"
+#include "../sysfs.h"
+#include "magnet.h"
+
+#define HMC5843_I2C_ADDRESS                    0x1E
+
+#define HMC5843_CONFIG_REG_A                   0x00
+#define HMC5843_CONFIG_REG_B                   0x01
+#define HMC5843_MODE_REG                       0x02
+#define HMC5843_DATA_OUT_X_MSB_REG             0x03
+#define HMC5843_DATA_OUT_X_LSB_REG             0x04
+#define HMC5843_DATA_OUT_Y_MSB_REG             0x05
+#define HMC5843_DATA_OUT_Y_LSB_REG             0x06
+#define HMC5843_DATA_OUT_Z_MSB_REG             0x07
+#define HMC5843_DATA_OUT_Z_LSB_REG             0x08
+#define HMC5843_STATUS_REG                     0x09
+#define HMC5843_ID_REG_A                       0x0A
+#define HMC5843_ID_REG_B                       0x0B
+#define HMC5843_ID_REG_C                       0x0C
+
+#define HMC5843_ID_REG_LENGTH                  0x03
+#define HMC5843_ID_STRING                      "H43"
+
+/*
+ * Range settings in  (+-)Ga
+ * */
+#define RANGE_GAIN_OFFSET                      0x05
+
+#define        RANGE_0_7                               0x00
+#define        RANGE_1_0                               0x01 /* default */
+#define        RANGE_1_5                               0x02
+#define        RANGE_2_0                               0x03
+#define        RANGE_3_2                               0x04
+#define        RANGE_3_8                               0x05
+#define        RANGE_4_5                               0x06
+#define        RANGE_6_5                               0x07 /* Not recomme=
nded */
+
+/*
+ * Device status
+ */
+#define        DATA_READY                              0x01
+#define        DATA_OUTPUT_LOCK                        0x02
+#define        VOLTAGE_REGULATOR_ENABLED               0x04
+
+/*
+ * Mode register configuration
+ */
+#define        MODE_CONVERSION_CONTINUOUS              0x00
+#define        MODE_CONVERSION_SINGLE                  0x01
+#define        MODE_IDLE                               0x02
+#define        MODE_SLEEP                              0x03
+
+/* Minimum Data Output Rate in 1/10 Hz  */
+#define RATE_OFFSET                            0x02
+#define RATE_BITMASK                           0x1C
+#define        RATE_5                                  0x00
+#define        RATE_10                                 0x01
+#define        RATE_20                                 0x02
+#define        RATE_50                                 0x03
+#define        RATE_100                                0x04
+#define        RATE_200                                0x05
+#define        RATE_500                                0x06
+#define        RATE_NOT_USED                           0x07
+
+/*
+ * Device Configutration
+ */
+#define        CONF_NORMAL                             0x00
+#define        CONF_POSITIVE_BIAS                      0x01
+#define        CONF_NEGATIVE_BIAS                      0x02
+#define        CONF_NOT_USED                           0x03
+#define        MEAS_CONF_MASK                          0x03
+
+static const int regval_to_counts_per_mg[] =3D {
+       1620,
+       1300,
+       970,
+       780,
+       530,
+       460,
+       390,
+       280
+};
+static const int regval_to_input_field_mg[] =3D {
+       700,
+       1000,
+       1500,
+       2000,
+       3200,
+       3800,
+       4500,
+       6500
+};
+static const char *regval_to_samp_freq[] =3D {
+       "0.5",
+       "1",
+       "2",
+       "5",
+       "10",
+       "20",
+       "50",
+};
+
+/* Addresses to scan: 0x1E */
+static const unsigned short normal_i2c[] =3D { HMC5843_I2C_ADDRESS,
+                                                       I2C_CLIENT_END };
+
+/* Each client has this additional data */
+struct hmc5843_data {
+       struct iio_dev  *indio_dev;
+       u8              rate;
+       u8              meas_conf;
+       u8              operating_mode;
+       u8              range;
+};
+
+static void hmc5843_init_client(struct i2c_client *client);
+
+static s32 hmc5843_configure(struct i2c_client *client,
+                                      u8 operating_mode)
+{
+       /* The lower two bits contain the current conversion mode */
+       return i2c_smbus_write_byte_data(client,
+                                       HMC5843_MODE_REG,
+                                       (operating_mode & 0x03));
+}
+
+/* Return the measurement value from the  specified channel */
+static ssize_t hmc5843_read_measurement(struct device *dev,
+               struct device_attribute *attr,
+               char *buf)
+{
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct i2c_client *client =3D to_i2c_client(indio_dev->dev.parent);
+       s16 coordinate_val;
+       struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
+       s32 result;
+
+       result =3D i2c_smbus_read_byte_data(client, HMC5843_STATUS_REG);
+       while (!(result & DATA_READY))
+               result =3D i2c_smbus_read_byte_data(client, HMC5843_STATUS_=
REG);
+
+       result =3D i2c_smbus_read_word_data(client, this_attr->address);
+       if (result < 0)
+               return -EINVAL;
+
+       coordinate_val  =3D (s16)swab16((u16)result);
+       return sprintf(buf, "%d\n", coordinate_val);
+}
+static IIO_DEV_ATTR_MAGN_X(hmc5843_read_measurement,
+               HMC5843_DATA_OUT_X_MSB_REG);
+static IIO_DEV_ATTR_MAGN_Y(hmc5843_read_measurement,
+               HMC5843_DATA_OUT_Y_MSB_REG);
+static IIO_DEV_ATTR_MAGN_Z(hmc5843_read_measurement,
+               HMC5843_DATA_OUT_Z_MSB_REG);
+/*
+ * From the datasheet
+ * 0 - Continuous-Conversion Mode: In continuous-conversion mode, the
+ * device continuously performs conversions an places the result in the
+ * data register.
+ *
+ * 1 - Single-Conversion Mode : device performs a single measurement,
+ *  sets RDY high and returned to sleep mode
+ *
+ * 2 - Idle Mode :  Device is placed in idle mode.
+ *
+ * 3 - Sleep Mode. Device is placed in sleep mode.
+ *
+ */
+static ssize_t hmc5843_show_operating_mode(struct device *dev,
+                                       struct device_attribute *attr,
+                                       char *buf)
+{
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct i2c_client *client =3D to_i2c_client(indio_dev->dev.parent);
+       struct hmc5843_data *data =3D i2c_get_clientdata(client);
+       return sprintf(buf, "%d\n", data->operating_mode);
+}
+
+static ssize_t hmc5843_set_operating_mode(struct device *dev,
+                               struct device_attribute *attr,
+                               const char *buf,
+                               size_t count)
+{
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct i2c_client *client =3D to_i2c_client(indio_dev->dev.parent);
+       struct hmc5843_data *data =3D i2c_get_clientdata(client);
+       struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
+       unsigned long operating_mode =3D 0;
+       s32 status;
+       int error;
+       error =3D strict_strtoul(buf, 10, &operating_mode);
+       if (error)
+               return error;
+       dev_dbg(dev, "set Conversion mode to %lu\n", operating_mode);
+       if (operating_mode > MODE_SLEEP)
+                       return -EINVAL;
+
+       status =3D i2c_smbus_write_byte_data(client, this_attr->address,
+                                       operating_mode);
+       if (status)
+               return -EINVAL;
+
+       data->operating_mode =3D operating_mode;
+       return count;
+}
+static IIO_DEVICE_ATTR(operating_mode,
+                       S_IWUSR | S_IRUGO,
+                       hmc5843_show_operating_mode,
+                       hmc5843_set_operating_mode,
+                       HMC5843_MODE_REG);
+
+/*
+ * API for setting the measurement configuration to
+ * Normal, Positive bias and Negitive bias
+ * From the datasheet
+ *
+ * Normal measurement configuration (default): In normal measurement
+ * configuration the device follows normal measurement flow. Pins BP and B=
N
+ * are left floating and high impedance.
+ *
+ * Positive bias configuration: In positive bias configuration, a positive
+ * current is forced across the resistive load on pins BP and BN.
+ *
+ * Negative bias configuration. In negative bias configuration, a negative
+ * current is forced across the resistive load on pins BP and BN.
+ *
+ */
+static s32 hmc5843_set_meas_conf(struct i2c_client *client,
+                                     u8 meas_conf)
+{
+       struct hmc5843_data *data =3D i2c_get_clientdata(client);
+       u8 reg_val;
+       reg_val =3D (meas_conf & MEAS_CONF_MASK) |  (data->rate << RATE_OFF=
SET);
+       return i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_A, reg_=
val);
+}
+
+static ssize_t hmc5843_show_measurement_configuration(struct device *dev,
+                                               struct device_attribute *at=
tr,
+                                               char *buf)
+{
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct i2c_client *client =3D to_i2c_client(indio_dev->dev.parent);
+       struct hmc5843_data *data =3D i2c_get_clientdata(client);
+       return sprintf(buf, "%d\n", data->meas_conf);
+}
+
+static ssize_t hmc5843_set_measurement_configuration(struct device *dev,
+                                               struct device_attribute *at=
tr,
+                                               const char *buf,
+                                               size_t count)
+{
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct i2c_client *client =3D to_i2c_client(indio_dev->dev.parent);
+       struct hmc5843_data *data =3D i2c_get_clientdata(client);
+       unsigned long meas_conf =3D 0;
+       int error =3D strict_strtoul(buf, 10, &meas_conf);
+       if (error)
+               return error;
+       dev_dbg(dev, "set mode to %lu\n", meas_conf);
+       if (hmc5843_set_meas_conf(client, meas_conf))
+               return -EINVAL;
+       data->meas_conf =3D meas_conf;
+       return count;
+}
+static IIO_DEVICE_ATTR(meas_conf,
+                       S_IWUSR | S_IRUGO,
+                       hmc5843_show_measurement_configuration,
+                       hmc5843_set_measurement_configuration,
+                       0);
+
+/*
+ * From Datasheet
+ * The table shows the minimum data output
+ * Value       | Minimum data output rate(Hz)
+ * 0           | 0.5
+ * 1           | 1
+ * 2           | 2
+ * 3           | 5
+ * 4           | 10 (default)
+ * 5           | 20
+ * 6           | 50
+ * 7           | Not used
+ *
+ */
+static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("0.5 1 2 5 10 20 50");
+
+static s32 hmc5843_set_rate(struct i2c_client *client,
+                               u8 rate)
+{
+       struct hmc5843_data *data =3D i2c_get_clientdata(client);
+       u8 reg_val;
+
+       reg_val =3D (data->meas_conf) |  (rate << RATE_OFFSET);
+       if (rate >=3D RATE_NOT_USED) {
+               dev_err(&client->dev,
+                       "This data output rate is not supported \n");
+               return -EINVAL;
+       }
+       return i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_A, reg_=
val);
+}
+
+static ssize_t set_sampling_frequency(struct device *dev,
+                                       struct device_attribute *attr,
+                                       const char *buf, size_t count)
+{
+
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct i2c_client *client =3D to_i2c_client(indio_dev->dev.parent);
+       struct hmc5843_data *data =3D i2c_get_clientdata(client);
+       unsigned long rate =3D 0;
+
+       if (strncmp(buf, "0.5" , 3) =3D=3D 0)
+               rate =3D RATE_5;
+       else if (strncmp(buf, "1" , 1) =3D=3D 0)
+               rate =3D RATE_10;
+       else if (strncmp(buf, "2", 1) =3D=3D 0)
+               rate =3D RATE_20;
+       else if (strncmp(buf, "5", 1) =3D=3D 0)
+               rate =3D RATE_50;
+       else if (strncmp(buf, "10", 2) =3D=3D 0)
+               rate =3D RATE_100;
+       else if (strncmp(buf, "20" , 2) =3D=3D 0)
+               rate =3D RATE_200;
+       else if (strncmp(buf, "50" , 2) =3D=3D 0)
+               rate =3D RATE_500;
+       else
+               return -EINVAL;
+
+       dev_dbg(dev, "set rate to %lu\n", rate);
+       if (hmc5843_set_rate(client, rate) =3D=3D -EINVAL)
+               return -EINVAL;
+       data->rate =3D rate;
+       return count;
+}
+
+static ssize_t show_sampling_frequency(struct device *dev,
+                       struct device_attribute *attr, char *buf)
+{
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct i2c_client *client =3D to_i2c_client(indio_dev->dev.parent);
+       struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
+       u32 rate;
+
+       rate =3D i2c_smbus_read_byte_data(client,  this_attr->address);
+       if (rate < 0)
+               return -EINVAL;
+       rate =3D (rate & RATE_BITMASK) >> RATE_OFFSET;
+       return sprintf(buf, "%s\n", regval_to_samp_freq[rate]);
+}
+static IIO_DEVICE_ATTR(sampling_frequency,
+                       S_IWUSR | S_IRUGO,
+                       show_sampling_frequency,
+                       set_sampling_frequency,
+                       HMC5843_CONFIG_REG_A);
+/*
+ * From Datasheet
+ *     Nominal gain settings
+ * Value       | Sensor Input Field Range(Ga)  | Gain(counts/ milli-gauss)
+ *0            |(+-)0.7                        |1620
+ *1            |(+-)1.0                        |1300
+ *2            |(+-)1.5                        |970
+ *3            |(+-)2.0                        |780
+ *4            |(+-)3.2                        |530
+ *5            |(+-)3.8                        |460
+ *6            |(+-)4.5                        |390
+ *7            |(+-)6.5                        |280
+ */
+static ssize_t show_range(struct device *dev,
+                               struct device_attribute *attr,
+                               char *buf)
+{
+       u8 range;
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct i2c_client *client =3D to_i2c_client(indio_dev->dev.parent);
+       struct hmc5843_data *data =3D i2c_get_clientdata(client);
+
+       range =3D data->range;
+       return sprintf(buf, " %d\n", regval_to_input_field_mg[range]);
+}
+
+static ssize_t set_range(struct device *dev,
+                       struct device_attribute *attr,
+                       const char *buf,
+                       size_t count)
+{
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct i2c_client *client =3D to_i2c_client(indio_dev->dev.parent);
+       struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
+       struct hmc5843_data *data =3D i2c_get_clientdata(client);
+       unsigned long range =3D 0;
+       int error;
+
+       error =3D strict_strtoul(buf, 10, &range);
+       if (error)
+               return error;
+       dev_dbg(dev, "set range to %lu\n", range);
+
+       if (range > RANGE_6_5)
+               return -EINVAL;
+
+       data->range =3D range;
+       range =3D range << RANGE_GAIN_OFFSET;
+       if (i2c_smbus_write_byte_data(client, this_attr->address, range) =
=3D=3D
+                                                                       -EI=
NVAL)
+               return -EINVAL;
+
+       return count;
+}
+
+static IIO_DEVICE_ATTR(magn_range,
+                       S_IWUSR | S_IRUGO,
+                       show_range,
+                       set_range,
+                       HMC5843_CONFIG_REG_B);
+
+static ssize_t show_gain(struct device *dev,
+                       struct device_attribute *attr,
+                       char *buf)
+{
+       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+       struct i2c_client *client =3D to_i2c_client(indio_dev->dev.parent);
+       struct hmc5843_data *data =3D i2c_get_clientdata(client);
+       return sprintf(buf, "%d\n", regval_to_counts_per_mg[data->range]);
+}
+static IIO_DEVICE_ATTR(magn_gain, S_IRUGO, show_gain, NULL , 0);
+
+
+static struct attribute *hmc5843_attributes[] =3D {
+       &iio_dev_attr_meas_conf.dev_attr.attr,
+       &iio_dev_attr_operating_mode.dev_attr.attr,
+       &iio_dev_attr_sampling_frequency.dev_attr.attr,
+       &iio_dev_attr_magn_range.dev_attr.attr,
+       &iio_dev_attr_magn_gain.dev_attr.attr,
+       &iio_dev_attr_magn_x_raw.dev_attr.attr,
+       &iio_dev_attr_magn_y_raw.dev_attr.attr,
+       &iio_dev_attr_magn_z_raw.dev_attr.attr,
+       &iio_const_attr_available_sampling_frequency.dev_attr.attr,
+       NULL
+};
+
+static const struct attribute_group hmc5843_group =3D {
+       .attrs =3D hmc5843_attributes,
+};
+
+static int hmc5843_detect(struct i2c_client *client,
+                         struct i2c_board_info *info)
+{
+       unsigned char id_str[HMC5843_ID_REG_LENGTH];
+
+       if (client->addr !=3D HMC5843_I2C_ADDRESS)
+               return -ENODEV;
+
+       if (i2c_smbus_read_i2c_block_data(client, HMC5843_ID_REG_A,
+                               HMC5843_ID_REG_LENGTH, id_str)
+                       !=3D HMC5843_ID_REG_LENGTH)
+               return -ENODEV;
+
+       if (0 !=3D strncmp(id_str, HMC5843_ID_STRING, HMC5843_ID_REG_LENGTH=
))
+               return -ENODEV;
+
+       return 0;
+}
+
+/* Called when we have found a new HMC5843. */
+static void hmc5843_init_client(struct i2c_client *client)
+{
+       struct hmc5843_data *data =3D i2c_get_clientdata(client);
+       hmc5843_set_meas_conf(client, data->meas_conf);
+       hmc5843_set_rate(client, data->rate);
+       hmc5843_configure(client, data->operating_mode);
+       i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_B, data->range=
);
+       pr_info("HMC5843 initialized\n");
+}
+
+static int hmc5843_probe(struct i2c_client *client,
+                        const struct i2c_device_id *id)
+{
+       struct hmc5843_data *data;
+       int err =3D 0;
+
+       data =3D kzalloc(sizeof(struct hmc5843_data), GFP_KERNEL);
+       if (!data) {
+               err =3D -ENOMEM;
+               goto exit;
+       }
+
+       /* default settings at probe */
+
+       data->meas_conf =3D CONF_NORMAL;
+       data->range =3D RANGE_1_0;
+       data->operating_mode =3D MODE_CONVERSION_CONTINUOUS;
+
+       i2c_set_clientdata(client, data);
+
+       /* Initialize the HMC5843 chip */
+       hmc5843_init_client(client);
+
+       data->indio_dev =3D iio_allocate_device();
+       if (!data->indio_dev) {
+               err =3D -ENOMEM;
+               goto exit_free;
+       }
+       data->indio_dev->attrs =3D &hmc5843_group;
+       data->indio_dev->dev.parent =3D &client->dev;
+       data->indio_dev->dev_data =3D (void *)(data);
+       data->indio_dev->driver_module =3D THIS_MODULE;
+       data->indio_dev->modes =3D INDIO_DIRECT_MODE;
+       err =3D iio_device_register(data->indio_dev);
+       if (err)
+               goto exit_free;
+       return 0;
+exit_free:
+       kfree(data);
+exit:
+       return err;
+}
+
+static int hmc5843_remove(struct i2c_client *client)
+{
+       struct hmc5843_data *data =3D i2c_get_clientdata(client);
+        /*  sleep mode to save power */
+       hmc5843_configure(client, MODE_SLEEP);
+       iio_device_unregister(data->indio_dev);
+       sysfs_remove_group(&client->dev.kobj, &hmc5843_group);
+       kfree(i2c_get_clientdata(client));
+       return 0;
+}
+
+static int hmc5843_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+       hmc5843_configure(client, MODE_SLEEP);
+       return 0;
+}
+
+static int hmc5843_resume(struct i2c_client *client)
+{
+       struct hmc5843_data *data =3D i2c_get_clientdata(client);
+       hmc5843_configure(client, data->operating_mode);
+       return 0;
+}
+
+static const struct i2c_device_id hmc5843_id[] =3D {
+       { "hmc5843", 0 },
+       { }
+};
+
+static struct i2c_driver hmc5843_driver =3D {
+       .driver =3D {
+               .name   =3D "hmc5843",
+       },
+       .id_table       =3D hmc5843_id,
+       .probe          =3D hmc5843_probe,
+       .remove         =3D hmc5843_remove,
+       .detect         =3D hmc5843_detect,
+       .address_list   =3D normal_i2c,
+       .suspend        =3D hmc5843_suspend,
+       .resume         =3D hmc5843_resume,
+};
+
+static int __init hmc5843_init(void)
+{
+       return i2c_add_driver(&hmc5843_driver);
+}
+
+static void __exit hmc5843_exit(void)
+{
+       i2c_del_driver(&hmc5843_driver);
+}
+
+MODULE_AUTHOR("Shubhrajyoti Datta <shubhrajyoti@ti.com");
+MODULE_DESCRIPTION("HMC5843 driver");
+MODULE_LICENSE("GPL");
+
+module_init(hmc5843_init);
+module_exit(hmc5843_exit);
--
1.5.4.7


--_002_0680EC522D0CC943BC586913CF3768C003B360349Fdbde02enttico_
Content-Type: application/octet-stream;
	name="0001-Add-support-for-the-Digital-compass.patch"
Content-Description: 0001-Add-support-for-the-Digital-compass.patch
Content-Disposition: attachment;
	filename="0001-Add-support-for-the-Digital-compass.patch"; size=19577;
	creation-date="Sat, 03 Jul 2010 17:10:09 GMT";
	modification-date="Sat, 03 Jul 2010 17:10:09 GMT"
Content-Transfer-Encoding: base64

RnJvbSBhMzc4MGFhNjgxNTYzZjk5MWI5ZjY4YTkwNWJkMzEzYTdhNGIwM2Q1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaHViaHJhanlvdGkgRCA8c2h1YmhyYWp5b3RpQHRpLmNvbT4K
RGF0ZTogU2F0LCAzIEp1bCAyMDEwIDE2OjAzOjU1ICswNTMwClN1YmplY3Q6IFtSRkNdIFtQQVRD
SF0gZGlnaXRhbCBjb21wYXNzIGhtYzU4NDMKQWRkaW5nIHN1cHBvcnQgZm9yIHRoZSBIb25leXdl
bGwgSE1DNTg0My4gVGhlIGludGVyZmFjZSB0byB0aGUgZGV2aWNlIGlzIGkyYy4KCi0gQ2hhbmdp
bmcgdGhlIGludGVyZmFjZSB0byBzdWl0IHRoZSBzdGFuZGFyZHMKClRPRE8KLSBEb2N1bWVudGF0
aW9uIGZvciB0aGUgaW50ZXJmYWNlIHByb3ZpZGVkCi0gR2F1c3MgaXMgcmVwb3J0ZWQgaW4gbWls
bGlnCgoKU2lnbmVkLW9mZi1ieTogU2h1YmhyYWp5b3RpIEQgPHNodWJocmFqeW90aUB0aS5jb20+
Ci0tLQogZHJpdmVycy9zdGFnaW5nL2lpby9LY29uZmlnICAgICAgICAgICAgICAgIHwgICAgMSAr
CiBkcml2ZXJzL3N0YWdpbmcvaWlvL01ha2VmaWxlICAgICAgICAgICAgICAgfCAgICAxICsKIGRy
aXZlcnMvc3RhZ2luZy9paW8vbWFnbmV0b21ldGVyL0tjb25maWcgICB8ICAgMTUgKwogZHJpdmVy
cy9zdGFnaW5nL2lpby9tYWduZXRvbWV0ZXIvTWFrZWZpbGUgIHwgICAgNSArCiBkcml2ZXJzL3N0
YWdpbmcvaWlvL21hZ25ldG9tZXRlci9obWM1ODQzLmMgfCAgNTk4ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysKIDUgZmlsZXMgY2hhbmdlZCwgNjIwIGluc2VydGlvbnMoKyksIDAgZGVsZXRp
b25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zdGFnaW5nL2lpby9tYWduZXRvbWV0
ZXIvS2NvbmZpZwogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3RhZ2luZy9paW8vbWFnbmV0
b21ldGVyL01ha2VmaWxlCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zdGFnaW5nL2lpby9t
YWduZXRvbWV0ZXIvaG1jNTg0My5jCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2lpby9L
Y29uZmlnIGIvZHJpdmVycy9zdGFnaW5nL2lpby9LY29uZmlnCmluZGV4IGIwZTYyNDQuLjU2OWI5
MzggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3RhZ2luZy9paW8vS2NvbmZpZworKysgYi9kcml2ZXJz
L3N0YWdpbmcvaWlvL0tjb25maWcKQEAgLTQ0LDYgKzQ0LDcgQEAgc291cmNlICJkcml2ZXJzL3N0
YWdpbmcvaWlvL2FkYy9LY29uZmlnIgogc291cmNlICJkcml2ZXJzL3N0YWdpbmcvaWlvL2d5cm8v
S2NvbmZpZyIKIHNvdXJjZSAiZHJpdmVycy9zdGFnaW5nL2lpby9pbXUvS2NvbmZpZyIKIHNvdXJj
ZSAiZHJpdmVycy9zdGFnaW5nL2lpby9saWdodC9LY29uZmlnIgorc291cmNlICJkcml2ZXJzL3N0
YWdpbmcvaWlvL21hZ25ldG9tZXRlci9LY29uZmlnIgogCiBzb3VyY2UgImRyaXZlcnMvc3RhZ2lu
Zy9paW8vdHJpZ2dlci9LY29uZmlnIgogCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvaWlv
L01ha2VmaWxlIGIvZHJpdmVycy9zdGFnaW5nL2lpby9NYWtlZmlsZQppbmRleCAzNTAyYjM5Li4x
MGQxZjZiIDEwMDY0NAotLS0gYS9kcml2ZXJzL3N0YWdpbmcvaWlvL01ha2VmaWxlCisrKyBiL2Ry
aXZlcnMvc3RhZ2luZy9paW8vTWFrZWZpbGUKQEAgLTE0LDUgKzE0LDYgQEAgb2JqLXkgKz0gYWRj
Lwogb2JqLXkgKz0gZ3lyby8KIG9iai15ICs9IGltdS8KIG9iai15ICs9IGxpZ2h0Lworb2JqLXkg
Kz0gbWFnbmV0b21ldGVyLwogCiBvYmoteSArPSB0cmlnZ2VyLwpcIE5vIG5ld2xpbmUgYXQgZW5k
IG9mIGZpbGUKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9paW8vbWFnbmV0b21ldGVyL0tj
b25maWcgYi9kcml2ZXJzL3N0YWdpbmcvaWlvL21hZ25ldG9tZXRlci9LY29uZmlnCm5ldyBmaWxl
IG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjZjNjc5ODEKLS0tIC9kZXYvbnVsbAorKysgYi9k
cml2ZXJzL3N0YWdpbmcvaWlvL21hZ25ldG9tZXRlci9LY29uZmlnCkBAIC0wLDAgKzEsMTUgQEAK
KyMKKyMgTWFnbmV0b21ldGVyIHNlbnNvcnMKKyMKK2NvbW1lbnQgIk1hZ25ldG9tZXRlciBzZW5z
b3JzIgorCitjb25maWcgU0VOU09SU19ITUM1ODQzCisJdHJpc3RhdGUgIkhvbmV5d2VsbCBITUM1
ODQzIDMtQXhpcyBNYWduZXRvbWV0ZXIiCisJZGVwZW5kcyBvbiBJMkMKKwloZWxwCisJICBTYXkg
WSBoZXJlIHRvIGFkZCBzdXBwb3J0IGZvciB0aGUgSG9uZXl3ZWxsIEhNQyA1ODQzIDMtQXhpcwor
CSAgTWFnbmV0b21ldGVyIChkaWdpdGFsIGNvbXBhc3MpLgorCisJICBUbyBjb21waWxlIHRoaXMg
ZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2UgTSBoZXJlOiB0aGUgbW9kdWxlCisJICB3aWxsIGJl
IGNhbGxlZCBobWM1ODQzCisKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9paW8vbWFnbmV0
b21ldGVyL01ha2VmaWxlIGIvZHJpdmVycy9zdGFnaW5nL2lpby9tYWduZXRvbWV0ZXIvTWFrZWZp
bGUKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uZjliZmIyZQotLS0gL2Rldi9u
dWxsCisrKyBiL2RyaXZlcnMvc3RhZ2luZy9paW8vbWFnbmV0b21ldGVyL01ha2VmaWxlCkBAIC0w
LDAgKzEsNSBAQAorIworIyBNYWtlZmlsZSBmb3IgaW5kdXN0cmlhbCBJL08gTWFnbmV0b21ldGVy
IHNlbnNvcnMKKyMKKworb2JqLSQoQ09ORklHX1NFTlNPUlNfSE1DNTg0MykJKz0gaG1jNTg0My5v
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvaWlvL21hZ25ldG9tZXRlci9obWM1ODQzLmMg
Yi9kcml2ZXJzL3N0YWdpbmcvaWlvL21hZ25ldG9tZXRlci9obWM1ODQzLmMKbmV3IGZpbGUgbW9k
ZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uYTE0Mzc5MwotLS0gL2Rldi9udWxsCisrKyBiL2RyaXZl
cnMvc3RhZ2luZy9paW8vbWFnbmV0b21ldGVyL2htYzU4NDMuYwpAQCAtMCwwICsxLDU5OCBAQAor
LyogIENvcHlyaWdodCAoYykgMjAxMCAgU2h1YmhyYWp5b3RpIERhdHRhIDxzaHViaHJhanlvdGlA
dGkuY29tPgorCisgICAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVk
aXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyAgICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhl
IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQorICAgIHRoZSBGcmVl
IFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9y
CisgICAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKworICAgIFRoaXMgcHJv
Z3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAor
ICAgIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdh
cnJhbnR5IG9mCisgICAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxB
UiBQVVJQT1NFLiAgU2VlIHRoZQorICAgIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBt
b3JlIGRldGFpbHMuCisKKyAgICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRo
ZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQorICAgIGFsb25nIHdpdGggdGhpcyBwcm9ncmFt
OyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlCisgICAgRm91bmRhdGlvbiwgSW5j
LiwgNjc1IE1hc3MgQXZlLCBDYW1icmlkZ2UsIE1BIDAyMTM5LCBVU0EuCisqLworCisjaW5jbHVk
ZSA8bGludXgvbW9kdWxlLmg+CisjaW5jbHVkZSA8bGludXgvaW5pdC5oPgorI2luY2x1ZGUgPGxp
bnV4L2kyYy5oPgorI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KKyNpbmNsdWRlIDxsaW51eC90eXBl
cy5oPgorI2luY2x1ZGUgIi4uL2lpby5oIgorI2luY2x1ZGUgIi4uL3N5c2ZzLmgiCisjaW5jbHVk
ZSAibWFnbmV0LmgiCisKKyNkZWZpbmUgSE1DNTg0M19JMkNfQUREUkVTUwkJCTB4MUUKKworI2Rl
ZmluZSBITUM1ODQzX0NPTkZJR19SRUdfQQkJCTB4MDAKKyNkZWZpbmUgSE1DNTg0M19DT05GSUdf
UkVHX0IJCQkweDAxCisjZGVmaW5lIEhNQzU4NDNfTU9ERV9SRUcJCQkweDAyCisjZGVmaW5lIEhN
QzU4NDNfREFUQV9PVVRfWF9NU0JfUkVHCQkweDAzCisjZGVmaW5lIEhNQzU4NDNfREFUQV9PVVRf
WF9MU0JfUkVHCQkweDA0CisjZGVmaW5lIEhNQzU4NDNfREFUQV9PVVRfWV9NU0JfUkVHCQkweDA1
CisjZGVmaW5lIEhNQzU4NDNfREFUQV9PVVRfWV9MU0JfUkVHCQkweDA2CisjZGVmaW5lIEhNQzU4
NDNfREFUQV9PVVRfWl9NU0JfUkVHCQkweDA3CisjZGVmaW5lIEhNQzU4NDNfREFUQV9PVVRfWl9M
U0JfUkVHCQkweDA4CisjZGVmaW5lIEhNQzU4NDNfU1RBVFVTX1JFRwkJCTB4MDkKKyNkZWZpbmUg
SE1DNTg0M19JRF9SRUdfQQkJCTB4MEEKKyNkZWZpbmUgSE1DNTg0M19JRF9SRUdfQgkJCTB4MEIK
KyNkZWZpbmUgSE1DNTg0M19JRF9SRUdfQwkJCTB4MEMKKworI2RlZmluZSBITUM1ODQzX0lEX1JF
R19MRU5HVEgJCQkweDAzCisjZGVmaW5lIEhNQzU4NDNfSURfU1RSSU5HCQkJIkg0MyIKKworLyoK
KyAqIFJhbmdlIHNldHRpbmdzIGluICAoKy0pR2EKKyAqICovCisjZGVmaW5lIFJBTkdFX0dBSU5f
T0ZGU0VUCQkJMHgwNQorCisjZGVmaW5lCVJBTkdFXzBfNwkJCQkweDAwCisjZGVmaW5lCVJBTkdF
XzFfMAkJCQkweDAxIC8qIGRlZmF1bHQgKi8KKyNkZWZpbmUJUkFOR0VfMV81CQkJCTB4MDIKKyNk
ZWZpbmUJUkFOR0VfMl8wCQkJCTB4MDMKKyNkZWZpbmUJUkFOR0VfM18yCQkJCTB4MDQKKyNkZWZp
bmUJUkFOR0VfM184CQkJCTB4MDUKKyNkZWZpbmUJUkFOR0VfNF81CQkJCTB4MDYKKyNkZWZpbmUJ
UkFOR0VfNl81CQkJCTB4MDcgLyogTm90IHJlY29tbWVuZGVkICovCisKKy8qCisgKiBEZXZpY2Ug
c3RhdHVzCisgKi8KKyNkZWZpbmUJREFUQV9SRUFEWSAgCQkJCTB4MDEKKyNkZWZpbmUJREFUQV9P
VVRQVVRfTE9DSyAgCQkJMHgwMgorI2RlZmluZQlWT0xUQUdFX1JFR1VMQVRPUl9FTkFCTEVEICAJ
CTB4MDQKKworLyoKKyAqIE1vZGUgcmVnaXN0ZXIgY29uZmlndXJhdGlvbgorICovCisjZGVmaW5l
CU1PREVfQ09OVkVSU0lPTl9DT05USU5VT1VTCQkweDAwCisjZGVmaW5lCU1PREVfQ09OVkVSU0lP
Tl9TSU5HTEUJCQkweDAxCisjZGVmaW5lCU1PREVfSURMRQkJCQkweDAyCisjZGVmaW5lCU1PREVf
U0xFRVAJCQkJMHgwMworCisvKiBNaW5pbXVtIERhdGEgT3V0cHV0IFJhdGUgaW4gMS8xMCBIeiAg
Ki8KKyNkZWZpbmUgUkFURV9PRkZTRVQJCQkJMHgwMgorI2RlZmluZSBSQVRFX0JJVE1BU0sJCQkJ
MHgxQworI2RlZmluZQlSQVRFXzUJCQkJCTB4MDAKKyNkZWZpbmUJUkFURV8xMAkJCQkJMHgwMQor
I2RlZmluZQlSQVRFXzIwCQkJCQkweDAyCisjZGVmaW5lCVJBVEVfNTAJCQkJCTB4MDMKKyNkZWZp
bmUJUkFURV8xMDAJCQkJMHgwNAorI2RlZmluZQlSQVRFXzIwMAkJCQkweDA1CisjZGVmaW5lCVJB
VEVfNTAwCQkJCTB4MDYKKyNkZWZpbmUJUkFURV9OT1RfVVNFRAkJCQkweDA3CisKKy8qCisgKiBE
ZXZpY2UgQ29uZmlndXRyYXRpb24KKyAqLworI2RlZmluZQlDT05GX05PUk1BTCAgCQkJCTB4MDAK
KyNkZWZpbmUJQ09ORl9QT1NJVElWRV9CSUFTCQkJMHgwMQorI2RlZmluZQlDT05GX05FR0FUSVZF
X0JJQVMJCQkweDAyCisjZGVmaW5lCUNPTkZfTk9UX1VTRUQJCQkJMHgwMworI2RlZmluZQlNRUFT
X0NPTkZfTUFTSwkJCQkweDAzCisKK3N0YXRpYyBjb25zdCBpbnQgcmVndmFsX3RvX2NvdW50c19w
ZXJfbWdbXSA9IHsKKwkxNjIwLAorCTEzMDAsCisJOTcwLAorCTc4MCwKKwk1MzAsCisJNDYwLAor
CTM5MCwKKwkyODAKK307CitzdGF0aWMgY29uc3QgaW50IHJlZ3ZhbF90b19pbnB1dF9maWVsZF9t
Z1tdID0geworCTcwMCwKKwkxMDAwLAorCTE1MDAsCisJMjAwMCwKKwkzMjAwLAorCTM4MDAsCisJ
NDUwMCwKKwk2NTAwCit9Oworc3RhdGljIGNvbnN0IGNoYXIgKnJlZ3ZhbF90b19zYW1wX2ZyZXFb
XSA9IHsKKwkiMC41IiwKKwkiMSIsCisJIjIiLAorCSI1IiwKKwkiMTAiLAorCSIyMCIsCisJIjUw
IiwKK307CisKKy8qIEFkZHJlc3NlcyB0byBzY2FuOiAweDFFICovCitzdGF0aWMgY29uc3QgdW5z
aWduZWQgc2hvcnQgbm9ybWFsX2kyY1tdID0geyBITUM1ODQzX0kyQ19BRERSRVNTLAorCQkJCQkJ
CUkyQ19DTElFTlRfRU5EIH07CisKKy8qIEVhY2ggY2xpZW50IGhhcyB0aGlzIGFkZGl0aW9uYWwg
ZGF0YSAqLworc3RydWN0IGhtYzU4NDNfZGF0YSB7CisJc3RydWN0IGlpb19kZXYJKmluZGlvX2Rl
djsKKwl1OAkJcmF0ZTsKKwl1OAkJbWVhc19jb25mOworCXU4CQlvcGVyYXRpbmdfbW9kZTsKKwl1
OAkJcmFuZ2U7Cit9OworCitzdGF0aWMgdm9pZCBobWM1ODQzX2luaXRfY2xpZW50KHN0cnVjdCBp
MmNfY2xpZW50ICpjbGllbnQpOworCitzdGF0aWMgczMyIGhtYzU4NDNfY29uZmlndXJlKHN0cnVj
dCBpMmNfY2xpZW50ICpjbGllbnQsCisJCQkJICAgICAgIHU4IG9wZXJhdGluZ19tb2RlKQorewor
CS8qIFRoZSBsb3dlciB0d28gYml0cyBjb250YWluIHRoZSBjdXJyZW50IGNvbnZlcnNpb24gbW9k
ZSAqLworCXJldHVybiBpMmNfc21idXNfd3JpdGVfYnl0ZV9kYXRhKGNsaWVudCwKKwkJCQkJSE1D
NTg0M19NT0RFX1JFRywKKwkJCQkJKG9wZXJhdGluZ19tb2RlICYgMHgwMykpOworfQorCisvKiBS
ZXR1cm4gdGhlIG1lYXN1cmVtZW50IHZhbHVlIGZyb20gdGhlICBzcGVjaWZpZWQgY2hhbm5lbCAq
Lworc3RhdGljIHNzaXplX3QgaG1jNTg0M19yZWFkX21lYXN1cmVtZW50KHN0cnVjdCBkZXZpY2Ug
KmRldiwKKwkJc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCisJCWNoYXIgKmJ1ZikKK3sK
KwlzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7CisJc3Ry
dWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHRvX2kyY19jbGllbnQoaW5kaW9fZGV2LT5kZXYucGFy
ZW50KTsKKwlzMTYgY29vcmRpbmF0ZV92YWw7CisJc3RydWN0IGlpb19kZXZfYXR0ciAqdGhpc19h
dHRyID0gdG9faWlvX2Rldl9hdHRyKGF0dHIpOworCXMzMiByZXN1bHQ7CisKKwlyZXN1bHQgPSBp
MmNfc21idXNfcmVhZF9ieXRlX2RhdGEoY2xpZW50LCBITUM1ODQzX1NUQVRVU19SRUcpOworCXdo
aWxlICghKHJlc3VsdCAmIERBVEFfUkVBRFkpKQorCQlyZXN1bHQgPSBpMmNfc21idXNfcmVhZF9i
eXRlX2RhdGEoY2xpZW50LCBITUM1ODQzX1NUQVRVU19SRUcpOworCisJcmVzdWx0ID0gaTJjX3Nt
YnVzX3JlYWRfd29yZF9kYXRhKGNsaWVudCwgdGhpc19hdHRyLT5hZGRyZXNzKTsKKwlpZiAocmVz
dWx0IDwgMCkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwljb29yZGluYXRlX3ZhbAk9IChzMTYpc3dh
YjE2KCh1MTYpcmVzdWx0KTsKKwlyZXR1cm4gc3ByaW50ZihidWYsICIlZFxuIiwgY29vcmRpbmF0
ZV92YWwpOworfQorc3RhdGljIElJT19ERVZfQVRUUl9NQUdOX1goaG1jNTg0M19yZWFkX21lYXN1
cmVtZW50LAorCQlITUM1ODQzX0RBVEFfT1VUX1hfTVNCX1JFRyk7CitzdGF0aWMgSUlPX0RFVl9B
VFRSX01BR05fWShobWM1ODQzX3JlYWRfbWVhc3VyZW1lbnQsCisJCUhNQzU4NDNfREFUQV9PVVRf
WV9NU0JfUkVHKTsKK3N0YXRpYyBJSU9fREVWX0FUVFJfTUFHTl9aKGhtYzU4NDNfcmVhZF9tZWFz
dXJlbWVudCwKKwkJSE1DNTg0M19EQVRBX09VVF9aX01TQl9SRUcpOworLyoKKyAqIEZyb20gdGhl
IGRhdGFzaGVldAorICogMCAtIENvbnRpbnVvdXMtQ29udmVyc2lvbiBNb2RlOiBJbiBjb250aW51
b3VzLWNvbnZlcnNpb24gbW9kZSwgdGhlCisgKiBkZXZpY2UgY29udGludW91c2x5IHBlcmZvcm1z
IGNvbnZlcnNpb25zIGFuIHBsYWNlcyB0aGUgcmVzdWx0IGluIHRoZQorICogZGF0YSByZWdpc3Rl
ci4KKyAqCisgKiAxIC0gU2luZ2xlLUNvbnZlcnNpb24gTW9kZSA6IGRldmljZSBwZXJmb3JtcyBh
IHNpbmdsZSBtZWFzdXJlbWVudCwKKyAqICBzZXRzIFJEWSBoaWdoIGFuZCByZXR1cm5lZCB0byBz
bGVlcCBtb2RlCisgKgorICogMiAtIElkbGUgTW9kZSA6ICBEZXZpY2UgaXMgcGxhY2VkIGluIGlk
bGUgbW9kZS4KKyAqCisgKiAzIC0gU2xlZXAgTW9kZS4gRGV2aWNlIGlzIHBsYWNlZCBpbiBzbGVl
cCBtb2RlLgorICoKKyAqLworc3RhdGljIHNzaXplX3QgaG1jNTg0M19zaG93X29wZXJhdGluZ19t
b2RlKHN0cnVjdCBkZXZpY2UgKmRldiwKKwkJCQkJc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0
dHIsCisJCQkJCWNoYXIgKmJ1ZikKK3sKKwlzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2ID0gZGV2
X2dldF9kcnZkYXRhKGRldik7CisJc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHRvX2kyY19j
bGllbnQoaW5kaW9fZGV2LT5kZXYucGFyZW50KTsKKwlzdHJ1Y3QgaG1jNTg0M19kYXRhICpkYXRh
ID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7CisJcmV0dXJuIHNwcmludGYoYnVmLCAiJWRc
biIsIGRhdGEtPm9wZXJhdGluZ19tb2RlKTsKK30KKworc3RhdGljIHNzaXplX3QgaG1jNTg0M19z
ZXRfb3BlcmF0aW5nX21vZGUoc3RydWN0IGRldmljZSAqZGV2LAorCQkJCXN0cnVjdCBkZXZpY2Vf
YXR0cmlidXRlICphdHRyLAorCQkJCWNvbnN0IGNoYXIgKmJ1ZiwKKwkJCQlzaXplX3QgY291bnQp
Cit7CisJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOwor
CXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQgPSB0b19pMmNfY2xpZW50KGluZGlvX2Rldi0+ZGV2
LnBhcmVudCk7CisJc3RydWN0IGhtYzU4NDNfZGF0YSAqZGF0YSA9IGkyY19nZXRfY2xpZW50ZGF0
YShjbGllbnQpOworCXN0cnVjdCBpaW9fZGV2X2F0dHIgKnRoaXNfYXR0ciA9IHRvX2lpb19kZXZf
YXR0cihhdHRyKTsKKwl1bnNpZ25lZCBsb25nIG9wZXJhdGluZ19tb2RlID0gMDsKKwlzMzIgc3Rh
dHVzOworCWludCBlcnJvcjsKKwllcnJvciA9IHN0cmljdF9zdHJ0b3VsKGJ1ZiwgMTAsICZvcGVy
YXRpbmdfbW9kZSk7CisJaWYgKGVycm9yKQorCQlyZXR1cm4gZXJyb3I7CisJZGV2X2RiZyhkZXYs
ICJzZXQgQ29udmVyc2lvbiBtb2RlIHRvICVsdVxuIiwgb3BlcmF0aW5nX21vZGUpOworCWlmIChv
cGVyYXRpbmdfbW9kZSA+IE1PREVfU0xFRVApCisJCQlyZXR1cm4gLUVJTlZBTDsKKworCXN0YXR1
cyA9IGkyY19zbWJ1c193cml0ZV9ieXRlX2RhdGEoY2xpZW50LCB0aGlzX2F0dHItPmFkZHJlc3Ms
CisJCQkJCW9wZXJhdGluZ19tb2RlKTsKKwlpZiAoc3RhdHVzKQorCQlyZXR1cm4gLUVJTlZBTDsK
KworCWRhdGEtPm9wZXJhdGluZ19tb2RlID0gb3BlcmF0aW5nX21vZGU7CisJcmV0dXJuIGNvdW50
OworfQorc3RhdGljIElJT19ERVZJQ0VfQVRUUihvcGVyYXRpbmdfbW9kZSwKKwkJCVNfSVdVU1Ig
fCBTX0lSVUdPLAorCQkJaG1jNTg0M19zaG93X29wZXJhdGluZ19tb2RlLAorCQkJaG1jNTg0M19z
ZXRfb3BlcmF0aW5nX21vZGUsCisJCQlITUM1ODQzX01PREVfUkVHKTsKKworLyoKKyAqIEFQSSBm
b3Igc2V0dGluZyB0aGUgbWVhc3VyZW1lbnQgY29uZmlndXJhdGlvbiB0bworICogTm9ybWFsLCBQ
b3NpdGl2ZSBiaWFzIGFuZCBOZWdpdGl2ZSBiaWFzCisgKiBGcm9tIHRoZSBkYXRhc2hlZXQKKyAq
CisgKiBOb3JtYWwgbWVhc3VyZW1lbnQgY29uZmlndXJhdGlvbiAoZGVmYXVsdCk6IEluIG5vcm1h
bCBtZWFzdXJlbWVudAorICogY29uZmlndXJhdGlvbiB0aGUgZGV2aWNlIGZvbGxvd3Mgbm9ybWFs
IG1lYXN1cmVtZW50IGZsb3cuIFBpbnMgQlAgYW5kIEJOCisgKiBhcmUgbGVmdCBmbG9hdGluZyBh
bmQgaGlnaCBpbXBlZGFuY2UuCisgKgorICogUG9zaXRpdmUgYmlhcyBjb25maWd1cmF0aW9uOiBJ
biBwb3NpdGl2ZSBiaWFzIGNvbmZpZ3VyYXRpb24sIGEgcG9zaXRpdmUKKyAqIGN1cnJlbnQgaXMg
Zm9yY2VkIGFjcm9zcyB0aGUgcmVzaXN0aXZlIGxvYWQgb24gcGlucyBCUCBhbmQgQk4uCisgKgor
ICogTmVnYXRpdmUgYmlhcyBjb25maWd1cmF0aW9uLiBJbiBuZWdhdGl2ZSBiaWFzIGNvbmZpZ3Vy
YXRpb24sIGEgbmVnYXRpdmUKKyAqIGN1cnJlbnQgaXMgZm9yY2VkIGFjcm9zcyB0aGUgcmVzaXN0
aXZlIGxvYWQgb24gcGlucyBCUCBhbmQgQk4uCisgKgorICovCitzdGF0aWMgczMyIGhtYzU4NDNf
c2V0X21lYXNfY29uZihzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LAorCQkJCSAgICAgIHU4IG1l
YXNfY29uZikKK3sKKwlzdHJ1Y3QgaG1jNTg0M19kYXRhICpkYXRhID0gaTJjX2dldF9jbGllbnRk
YXRhKGNsaWVudCk7CisJdTggcmVnX3ZhbDsKKwlyZWdfdmFsID0gKG1lYXNfY29uZiAmIE1FQVNf
Q09ORl9NQVNLKSB8ICAoZGF0YS0+cmF0ZSA8PCBSQVRFX09GRlNFVCk7CisJcmV0dXJuIGkyY19z
bWJ1c193cml0ZV9ieXRlX2RhdGEoY2xpZW50LCBITUM1ODQzX0NPTkZJR19SRUdfQSwgcmVnX3Zh
bCk7Cit9CisKK3N0YXRpYyBzc2l6ZV90IGhtYzU4NDNfc2hvd19tZWFzdXJlbWVudF9jb25maWd1
cmF0aW9uKHN0cnVjdCBkZXZpY2UgKmRldiwKKwkJCQkJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRl
ICphdHRyLAorCQkJCQkJY2hhciAqYnVmKQoreworCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYg
PSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKKwlzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gdG9f
aTJjX2NsaWVudChpbmRpb19kZXYtPmRldi5wYXJlbnQpOworCXN0cnVjdCBobWM1ODQzX2RhdGEg
KmRhdGEgPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsKKwlyZXR1cm4gc3ByaW50ZihidWYs
ICIlZFxuIiwgZGF0YS0+bWVhc19jb25mKTsKK30KKworc3RhdGljIHNzaXplX3QgaG1jNTg0M19z
ZXRfbWVhc3VyZW1lbnRfY29uZmlndXJhdGlvbihzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCQkJCQlz
dHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwKKwkJCQkJCWNvbnN0IGNoYXIgKmJ1ZiwKKwkJ
CQkJCXNpemVfdCBjb3VudCkKK3sKKwlzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2ID0gZGV2X2dl
dF9kcnZkYXRhKGRldik7CisJc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCA9IHRvX2kyY19jbGll
bnQoaW5kaW9fZGV2LT5kZXYucGFyZW50KTsKKwlzdHJ1Y3QgaG1jNTg0M19kYXRhICpkYXRhID0g
aTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7CisJdW5zaWduZWQgbG9uZyBtZWFzX2NvbmYgPSAw
OworCWludCBlcnJvciA9IHN0cmljdF9zdHJ0b3VsKGJ1ZiwgMTAsICZtZWFzX2NvbmYpOworCWlm
IChlcnJvcikKKwkJcmV0dXJuIGVycm9yOworCWRldl9kYmcoZGV2LCAic2V0IG1vZGUgdG8gJWx1
XG4iLCBtZWFzX2NvbmYpOworCWlmIChobWM1ODQzX3NldF9tZWFzX2NvbmYoY2xpZW50LCBtZWFz
X2NvbmYpKQorCQlyZXR1cm4gLUVJTlZBTDsKKwlkYXRhLT5tZWFzX2NvbmYgPSBtZWFzX2NvbmY7
CisJcmV0dXJuIGNvdW50OworfQorc3RhdGljIElJT19ERVZJQ0VfQVRUUihtZWFzX2NvbmYsCisJ
CQlTX0lXVVNSIHwgU19JUlVHTywKKwkJCWhtYzU4NDNfc2hvd19tZWFzdXJlbWVudF9jb25maWd1
cmF0aW9uLAorCQkJaG1jNTg0M19zZXRfbWVhc3VyZW1lbnRfY29uZmlndXJhdGlvbiwKKwkJCTAp
OworCisvKgorICogRnJvbSBEYXRhc2hlZXQKKyAqIFRoZSB0YWJsZSBzaG93cyB0aGUgbWluaW11
bSBkYXRhIG91dHB1dAorICogVmFsdWUJfCBNaW5pbXVtIGRhdGEgb3V0cHV0IHJhdGUoSHopCisg
KiAwCQl8IDAuNQorICogMQkJfCAxCisgKiAyCQl8IDIKKyAqIDMJCXwgNQorICogNAkJfCAxMCAo
ZGVmYXVsdCkKKyAqIDUJCXwgMjAKKyAqIDYJCXwgNTAKKyAqIDcJCXwgTm90IHVzZWQKKyAqCisg
Ki8KK3N0YXRpYyBJSU9fQ09OU1RfQVRUUl9BVkFJTF9TQU1QX0ZSRVEoIjAuNSAxIDIgNSAxMCAy
MCA1MCIpOworCitzdGF0aWMgczMyIGhtYzU4NDNfc2V0X3JhdGUoc3RydWN0IGkyY19jbGllbnQg
KmNsaWVudCwKKwkJCQl1OCByYXRlKQoreworCXN0cnVjdCBobWM1ODQzX2RhdGEgKmRhdGEgPSBp
MmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsKKwl1OCByZWdfdmFsOworCisJcmVnX3ZhbCA9IChk
YXRhLT5tZWFzX2NvbmYpIHwgIChyYXRlIDw8IFJBVEVfT0ZGU0VUKTsKKwlpZiAocmF0ZSA+PSBS
QVRFX05PVF9VU0VEKSB7CisJCWRldl9lcnIoJmNsaWVudC0+ZGV2LAorCQkJIlRoaXMgZGF0YSBv
dXRwdXQgcmF0ZSBpcyBub3Qgc3VwcG9ydGVkIFxuIik7CisJCXJldHVybiAtRUlOVkFMOworCX0K
KwlyZXR1cm4gaTJjX3NtYnVzX3dyaXRlX2J5dGVfZGF0YShjbGllbnQsIEhNQzU4NDNfQ09ORklH
X1JFR19BLCByZWdfdmFsKTsKK30KKworc3RhdGljIHNzaXplX3Qgc2V0X3NhbXBsaW5nX2ZyZXF1
ZW5jeShzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCQkJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICph
dHRyLAorCQkJCQljb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3VudCkKK3sKKworCXN0cnVjdCBp
aW9fZGV2ICppbmRpb19kZXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKKwlzdHJ1Y3QgaTJjX2Ns
aWVudCAqY2xpZW50ID0gdG9faTJjX2NsaWVudChpbmRpb19kZXYtPmRldi5wYXJlbnQpOworCXN0
cnVjdCBobWM1ODQzX2RhdGEgKmRhdGEgPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsKKwl1
bnNpZ25lZCBsb25nIHJhdGUgPSAwOworCisJaWYgKHN0cm5jbXAoYnVmLCAiMC41IiAsIDMpID09
IDApCisJCXJhdGUgPSBSQVRFXzU7CisJZWxzZSBpZiAoc3RybmNtcChidWYsICIxIiAsIDEpID09
IDApCisJCXJhdGUgPSBSQVRFXzEwOworCWVsc2UgaWYgKHN0cm5jbXAoYnVmLCAiMiIsIDEpID09
IDApCisJCXJhdGUgPSBSQVRFXzIwOworCWVsc2UgaWYgKHN0cm5jbXAoYnVmLCAiNSIsIDEpID09
IDApCisJCXJhdGUgPSBSQVRFXzUwOworCWVsc2UgaWYgKHN0cm5jbXAoYnVmLCAiMTAiLCAyKSA9
PSAwKQorCQlyYXRlID0gUkFURV8xMDA7CisJZWxzZSBpZiAoc3RybmNtcChidWYsICIyMCIgLCAy
KSA9PSAwKQorCQlyYXRlID0gUkFURV8yMDA7CisJZWxzZSBpZiAoc3RybmNtcChidWYsICI1MCIg
LCAyKSA9PSAwKQorCQlyYXRlID0gUkFURV81MDA7CisJZWxzZQorCQlyZXR1cm4gLUVJTlZBTDsK
KworCWRldl9kYmcoZGV2LCAic2V0IHJhdGUgdG8gJWx1XG4iLCByYXRlKTsKKwlpZiAoaG1jNTg0
M19zZXRfcmF0ZShjbGllbnQsIHJhdGUpID09IC1FSU5WQUwpCisJCXJldHVybiAtRUlOVkFMOwor
CWRhdGEtPnJhdGUgPSByYXRlOworCXJldHVybiBjb3VudDsKK30KKworc3RhdGljIHNzaXplX3Qg
c2hvd19zYW1wbGluZ19mcmVxdWVuY3koc3RydWN0IGRldmljZSAqZGV2LAorCQkJc3RydWN0IGRl
dmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikKK3sKKwlzdHJ1Y3QgaWlvX2RldiAqaW5k
aW9fZGV2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7CisJc3RydWN0IGkyY19jbGllbnQgKmNsaWVu
dCA9IHRvX2kyY19jbGllbnQoaW5kaW9fZGV2LT5kZXYucGFyZW50KTsKKwlzdHJ1Y3QgaWlvX2Rl
dl9hdHRyICp0aGlzX2F0dHIgPSB0b19paW9fZGV2X2F0dHIoYXR0cik7CisJdTMyIHJhdGU7CisK
KwlyYXRlID0gaTJjX3NtYnVzX3JlYWRfYnl0ZV9kYXRhKGNsaWVudCwgIHRoaXNfYXR0ci0+YWRk
cmVzcyk7CisJaWYgKHJhdGUgPCAwKQorCQlyZXR1cm4gLUVJTlZBTDsKKwlyYXRlID0gKHJhdGUg
JiBSQVRFX0JJVE1BU0spID4+IFJBVEVfT0ZGU0VUOworCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVz
XG4iLCByZWd2YWxfdG9fc2FtcF9mcmVxW3JhdGVdKTsKK30KK3N0YXRpYyBJSU9fREVWSUNFX0FU
VFIoc2FtcGxpbmdfZnJlcXVlbmN5LAorCQkJU19JV1VTUiB8IFNfSVJVR08sCisJCQlzaG93X3Nh
bXBsaW5nX2ZyZXF1ZW5jeSwKKwkJCXNldF9zYW1wbGluZ19mcmVxdWVuY3ksCisJCQlITUM1ODQz
X0NPTkZJR19SRUdfQSk7CisvKgorICogRnJvbSBEYXRhc2hlZXQKKyAqCU5vbWluYWwgZ2FpbiBz
ZXR0aW5ncworICogVmFsdWUJfCBTZW5zb3IgSW5wdXQgRmllbGQgUmFuZ2UoR2EpCXwgR2Fpbihj
b3VudHMvIG1pbGxpLWdhdXNzKQorICowCQl8KCstKTAuNwkJCXwxNjIwCisgKjEJCXwoKy0pMS4w
CQkJfDEzMDAKKyAqMgkJfCgrLSkxLjUJCQl8OTcwCisgKjMJCXwoKy0pMi4wCQkJfDc4MAorICo0
CQl8KCstKTMuMgkJCXw1MzAKKyAqNQkJfCgrLSkzLjgJCQl8NDYwCisgKjYJCXwoKy0pNC41CQkJ
fDM5MAorICo3CQl8KCstKTYuNQkJCXwyODAKKyAqLworc3RhdGljIHNzaXplX3Qgc2hvd19yYW5n
ZShzdHJ1Y3QgZGV2aWNlICpkZXYsCisJCQkJc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIs
CisJCQkJY2hhciAqYnVmKQoreworCXU4IHJhbmdlOworCXN0cnVjdCBpaW9fZGV2ICppbmRpb19k
ZXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKKwlzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0g
dG9faTJjX2NsaWVudChpbmRpb19kZXYtPmRldi5wYXJlbnQpOworCXN0cnVjdCBobWM1ODQzX2Rh
dGEgKmRhdGEgPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsKKworCXJhbmdlID0gZGF0YS0+
cmFuZ2U7CisJcmV0dXJuIHNwcmludGYoYnVmLCAiICVkXG4iLCByZWd2YWxfdG9faW5wdXRfZmll
bGRfbWdbcmFuZ2VdKTsKK30KKworc3RhdGljIHNzaXplX3Qgc2V0X3JhbmdlKHN0cnVjdCBkZXZp
Y2UgKmRldiwKKwkJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLAorCQkJY29uc3QgY2hh
ciAqYnVmLAorCQkJc2l6ZV90IGNvdW50KQoreworCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYg
PSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKKwlzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50ID0gdG9f
aTJjX2NsaWVudChpbmRpb19kZXYtPmRldi5wYXJlbnQpOworCXN0cnVjdCBpaW9fZGV2X2F0dHIg
KnRoaXNfYXR0ciA9IHRvX2lpb19kZXZfYXR0cihhdHRyKTsKKwlzdHJ1Y3QgaG1jNTg0M19kYXRh
ICpkYXRhID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCk7CisJdW5zaWduZWQgbG9uZyByYW5n
ZSA9IDA7CisJaW50IGVycm9yOworCisJZXJyb3IgPSBzdHJpY3Rfc3RydG91bChidWYsIDEwLCAm
cmFuZ2UpOworCWlmIChlcnJvcikKKwkJcmV0dXJuIGVycm9yOworCWRldl9kYmcoZGV2LCAic2V0
IHJhbmdlIHRvICVsdVxuIiwgcmFuZ2UpOworCisJaWYgKHJhbmdlID4gUkFOR0VfNl81KQorCQly
ZXR1cm4gLUVJTlZBTDsKKworCWRhdGEtPnJhbmdlID0gcmFuZ2U7CisJcmFuZ2UgPSByYW5nZSA8
PCBSQU5HRV9HQUlOX09GRlNFVDsKKwlpZiAoaTJjX3NtYnVzX3dyaXRlX2J5dGVfZGF0YShjbGll
bnQsIHRoaXNfYXR0ci0+YWRkcmVzcywgcmFuZ2UpID09CisJCQkJCQkJCQktRUlOVkFMKQorCQly
ZXR1cm4gLUVJTlZBTDsKKworCXJldHVybiBjb3VudDsKK30KKworc3RhdGljIElJT19ERVZJQ0Vf
QVRUUihtYWduX3JhbmdlLAorCQkJU19JV1VTUiB8IFNfSVJVR08sCisJCQlzaG93X3JhbmdlLAor
CQkJc2V0X3JhbmdlLAorCQkJSE1DNTg0M19DT05GSUdfUkVHX0IpOworCitzdGF0aWMgc3NpemVf
dCBzaG93X2dhaW4oc3RydWN0IGRldmljZSAqZGV2LAorCQkJc3RydWN0IGRldmljZV9hdHRyaWJ1
dGUgKmF0dHIsCisJCQljaGFyICpidWYpCit7CisJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9
IGRldl9nZXRfZHJ2ZGF0YShkZXYpOworCXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQgPSB0b19p
MmNfY2xpZW50KGluZGlvX2Rldi0+ZGV2LnBhcmVudCk7CisJc3RydWN0IGhtYzU4NDNfZGF0YSAq
ZGF0YSA9IGkyY19nZXRfY2xpZW50ZGF0YShjbGllbnQpOworCXJldHVybiBzcHJpbnRmKGJ1Ziwg
IiVkXG4iLCByZWd2YWxfdG9fY291bnRzX3Blcl9tZ1tkYXRhLT5yYW5nZV0pOworfQorc3RhdGlj
IElJT19ERVZJQ0VfQVRUUihtYWduX2dhaW4sIFNfSVJVR08sIHNob3dfZ2FpbiwgTlVMTCAsIDAp
OworCisKK3N0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpobWM1ODQzX2F0dHJpYnV0ZXNbXSA9IHsK
KwkmaWlvX2Rldl9hdHRyX21lYXNfY29uZi5kZXZfYXR0ci5hdHRyLAorCSZpaW9fZGV2X2F0dHJf
b3BlcmF0aW5nX21vZGUuZGV2X2F0dHIuYXR0ciwKKwkmaWlvX2Rldl9hdHRyX3NhbXBsaW5nX2Zy
ZXF1ZW5jeS5kZXZfYXR0ci5hdHRyLAorCSZpaW9fZGV2X2F0dHJfbWFnbl9yYW5nZS5kZXZfYXR0
ci5hdHRyLAorCSZpaW9fZGV2X2F0dHJfbWFnbl9nYWluLmRldl9hdHRyLmF0dHIsCisJJmlpb19k
ZXZfYXR0cl9tYWduX3hfcmF3LmRldl9hdHRyLmF0dHIsCisJJmlpb19kZXZfYXR0cl9tYWduX3lf
cmF3LmRldl9hdHRyLmF0dHIsCisJJmlpb19kZXZfYXR0cl9tYWduX3pfcmF3LmRldl9hdHRyLmF0
dHIsCisJJmlpb19jb25zdF9hdHRyX2F2YWlsYWJsZV9zYW1wbGluZ19mcmVxdWVuY3kuZGV2X2F0
dHIuYXR0ciwKKwlOVUxMCit9OworCitzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91
cCBobWM1ODQzX2dyb3VwID0geworCS5hdHRycyA9IGhtYzU4NDNfYXR0cmlidXRlcywKK307CisK
K3N0YXRpYyBpbnQgaG1jNTg0M19kZXRlY3Qoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwKKwkJ
CSAgc3RydWN0IGkyY19ib2FyZF9pbmZvICppbmZvKQoreworCXVuc2lnbmVkIGNoYXIgaWRfc3Ry
W0hNQzU4NDNfSURfUkVHX0xFTkdUSF07CisKKwlpZiAoY2xpZW50LT5hZGRyICE9IEhNQzU4NDNf
STJDX0FERFJFU1MpCisJCXJldHVybiAtRU5PREVWOworCisJaWYgKGkyY19zbWJ1c19yZWFkX2ky
Y19ibG9ja19kYXRhKGNsaWVudCwgSE1DNTg0M19JRF9SRUdfQSwKKwkJCQlITUM1ODQzX0lEX1JF
R19MRU5HVEgsIGlkX3N0cikKKwkJCSE9IEhNQzU4NDNfSURfUkVHX0xFTkdUSCkKKwkJcmV0dXJu
IC1FTk9ERVY7CisKKwlpZiAoMCAhPSBzdHJuY21wKGlkX3N0ciwgSE1DNTg0M19JRF9TVFJJTkcs
IEhNQzU4NDNfSURfUkVHX0xFTkdUSCkpCisJCXJldHVybiAtRU5PREVWOworCisJcmV0dXJuIDA7
Cit9CisKKy8qIENhbGxlZCB3aGVuIHdlIGhhdmUgZm91bmQgYSBuZXcgSE1DNTg0My4gKi8KK3N0
YXRpYyB2b2lkIGhtYzU4NDNfaW5pdF9jbGllbnQoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCkK
K3sKKwlzdHJ1Y3QgaG1jNTg0M19kYXRhICpkYXRhID0gaTJjX2dldF9jbGllbnRkYXRhKGNsaWVu
dCk7CisJaG1jNTg0M19zZXRfbWVhc19jb25mKGNsaWVudCwgZGF0YS0+bWVhc19jb25mKTsKKwlo
bWM1ODQzX3NldF9yYXRlKGNsaWVudCwgZGF0YS0+cmF0ZSk7CisJaG1jNTg0M19jb25maWd1cmUo
Y2xpZW50LCBkYXRhLT5vcGVyYXRpbmdfbW9kZSk7CisJaTJjX3NtYnVzX3dyaXRlX2J5dGVfZGF0
YShjbGllbnQsIEhNQzU4NDNfQ09ORklHX1JFR19CLCBkYXRhLT5yYW5nZSk7CisJcHJfaW5mbygi
SE1DNTg0MyBpbml0aWFsaXplZFxuIik7Cit9CisKK3N0YXRpYyBpbnQgaG1jNTg0M19wcm9iZShz
dHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LAorCQkJIGNvbnN0IHN0cnVjdCBpMmNfZGV2aWNlX2lk
ICppZCkKK3sKKwlzdHJ1Y3QgaG1jNTg0M19kYXRhICpkYXRhOworCWludCBlcnIgPSAwOworCisJ
ZGF0YSA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBobWM1ODQzX2RhdGEpLCBHRlBfS0VSTkVMKTsK
KwlpZiAoIWRhdGEpIHsKKwkJZXJyID0gLUVOT01FTTsKKwkJZ290byBleGl0OworCX0KKworCS8q
IGRlZmF1bHQgc2V0dGluZ3MgYXQgcHJvYmUgKi8KKworCWRhdGEtPm1lYXNfY29uZiA9IENPTkZf
Tk9STUFMOworCWRhdGEtPnJhbmdlID0gUkFOR0VfMV8wOworCWRhdGEtPm9wZXJhdGluZ19tb2Rl
ID0gTU9ERV9DT05WRVJTSU9OX0NPTlRJTlVPVVM7CisKKwlpMmNfc2V0X2NsaWVudGRhdGEoY2xp
ZW50LCBkYXRhKTsKKworCS8qIEluaXRpYWxpemUgdGhlIEhNQzU4NDMgY2hpcCAqLworCWhtYzU4
NDNfaW5pdF9jbGllbnQoY2xpZW50KTsKKworCWRhdGEtPmluZGlvX2RldiA9IGlpb19hbGxvY2F0
ZV9kZXZpY2UoKTsKKwlpZiAoIWRhdGEtPmluZGlvX2RldikgeworCQllcnIgPSAtRU5PTUVNOwor
CQlnb3RvIGV4aXRfZnJlZTsKKwl9CisJZGF0YS0+aW5kaW9fZGV2LT5hdHRycyA9ICZobWM1ODQz
X2dyb3VwOworCWRhdGEtPmluZGlvX2Rldi0+ZGV2LnBhcmVudCA9ICZjbGllbnQtPmRldjsKKwlk
YXRhLT5pbmRpb19kZXYtPmRldl9kYXRhID0gKHZvaWQgKikoZGF0YSk7CisJZGF0YS0+aW5kaW9f
ZGV2LT5kcml2ZXJfbW9kdWxlID0gVEhJU19NT0RVTEU7CisJZGF0YS0+aW5kaW9fZGV2LT5tb2Rl
cyA9IElORElPX0RJUkVDVF9NT0RFOworCWVyciA9IGlpb19kZXZpY2VfcmVnaXN0ZXIoZGF0YS0+
aW5kaW9fZGV2KTsKKwlpZiAoZXJyKQorCQlnb3RvIGV4aXRfZnJlZTsKKwlyZXR1cm4gMDsKK2V4
aXRfZnJlZToKKwlrZnJlZShkYXRhKTsKK2V4aXQ6CisJcmV0dXJuIGVycjsKK30KKworc3RhdGlj
IGludCBobWM1ODQzX3JlbW92ZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQoreworCXN0cnVj
dCBobWM1ODQzX2RhdGEgKmRhdGEgPSBpMmNfZ2V0X2NsaWVudGRhdGEoY2xpZW50KTsKKwkgLyog
IHNsZWVwIG1vZGUgdG8gc2F2ZSBwb3dlciAqLworCWhtYzU4NDNfY29uZmlndXJlKGNsaWVudCwg
TU9ERV9TTEVFUCk7CisJaWlvX2RldmljZV91bnJlZ2lzdGVyKGRhdGEtPmluZGlvX2Rldik7CisJ
c3lzZnNfcmVtb3ZlX2dyb3VwKCZjbGllbnQtPmRldi5rb2JqLCAmaG1jNTg0M19ncm91cCk7CisJ
a2ZyZWUoaTJjX2dldF9jbGllbnRkYXRhKGNsaWVudCkpOworCXJldHVybiAwOworfQorCitzdGF0
aWMgaW50IGhtYzU4NDNfc3VzcGVuZChzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LCBwbV9tZXNz
YWdlX3QgbWVzZykKK3sKKwlobWM1ODQzX2NvbmZpZ3VyZShjbGllbnQsIE1PREVfU0xFRVApOwor
CXJldHVybiAwOworfQorCitzdGF0aWMgaW50IGhtYzU4NDNfcmVzdW1lKHN0cnVjdCBpMmNfY2xp
ZW50ICpjbGllbnQpCit7CisJc3RydWN0IGhtYzU4NDNfZGF0YSAqZGF0YSA9IGkyY19nZXRfY2xp
ZW50ZGF0YShjbGllbnQpOworCWhtYzU4NDNfY29uZmlndXJlKGNsaWVudCwgZGF0YS0+b3BlcmF0
aW5nX21vZGUpOworCXJldHVybiAwOworfQorCitzdGF0aWMgY29uc3Qgc3RydWN0IGkyY19kZXZp
Y2VfaWQgaG1jNTg0M19pZFtdID0geworCXsgImhtYzU4NDMiLCAwIH0sCisJeyB9Cit9OworCitz
dGF0aWMgc3RydWN0IGkyY19kcml2ZXIgaG1jNTg0M19kcml2ZXIgPSB7CisJLmRyaXZlciA9IHsK
KwkJLm5hbWUJPSAiaG1jNTg0MyIsCisJfSwKKwkuaWRfdGFibGUJPSBobWM1ODQzX2lkLAorCS5w
cm9iZQkJPSBobWM1ODQzX3Byb2JlLAorCS5yZW1vdmUJCT0gaG1jNTg0M19yZW1vdmUsCisJLmRl
dGVjdAkJPSBobWM1ODQzX2RldGVjdCwKKwkuYWRkcmVzc19saXN0CT0gbm9ybWFsX2kyYywKKwku
c3VzcGVuZAk9IGhtYzU4NDNfc3VzcGVuZCwKKwkucmVzdW1lCQk9IGhtYzU4NDNfcmVzdW1lLAor
fTsKKworc3RhdGljIGludCBfX2luaXQgaG1jNTg0M19pbml0KHZvaWQpCit7CisJcmV0dXJuIGky
Y19hZGRfZHJpdmVyKCZobWM1ODQzX2RyaXZlcik7Cit9CisKK3N0YXRpYyB2b2lkIF9fZXhpdCBo
bWM1ODQzX2V4aXQodm9pZCkKK3sKKwlpMmNfZGVsX2RyaXZlcigmaG1jNTg0M19kcml2ZXIpOwor
fQorCitNT0RVTEVfQVVUSE9SKCJTaHViaHJhanlvdGkgRGF0dGEgPHNodWJocmFqeW90aUB0aS5j
b20iKTsKK01PRFVMRV9ERVNDUklQVElPTigiSE1DNTg0MyBkcml2ZXIiKTsKK01PRFVMRV9MSUNF
TlNFKCJHUEwiKTsKKworbW9kdWxlX2luaXQoaG1jNTg0M19pbml0KTsKK21vZHVsZV9leGl0KGht
YzU4NDNfZXhpdCk7Ci0tIAoxLjUuNC43Cgo=

--_002_0680EC522D0CC943BC586913CF3768C003B360349Fdbde02enttico_--
