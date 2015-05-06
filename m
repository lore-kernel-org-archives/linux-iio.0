Return-Path: <tiberiu.a.breana@intel.com>
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, Jonathan Cameron
	<jic23@jic23.retrosnub.co.uk>
Subject: RE: [PATCH] iio: accel: Add support for Sensortek STK8312
Date: Wed, 6 May 2015 13:12:58 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F402212AABD@IRSMSX109.ger.corp.intel.com>
References: <1430832038-21653-1-git-send-email-tiberiu.a.breana@intel.com>,<3C33160C-AC5A-4EAB-925A-FDD14D36F12C@jic23.retrosnub.co.uk>
In-Reply-To: <3C33160C-AC5A-4EAB-925A-FDD14D36F12C@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Thanks for the reviews.=0A=
=0A=
The accelerometer has 3 measurement ranges:=0A=
-1.5g - +1.5g (6 bit, signed)=0A=
-6g - +6g (8 bit, signed)=0A=
-16g - +16g (8 bit, signed)=0A=
=0A=
scale1 =3D 1.5 * 9.81 / 31 ~=3D 0.4747=0A=
scale2 =3D 6 * 9.81 / 127 ~=3D 0.4634=0A=
scale3 =3D 16 * 9.81 / 127 ~=3D 1.2359=0A=
=0A=
Thus the resulting, non-monotonic scales.=0A=
I'll upload v2 with the rest of the suggested changes.=0A=
=0A=
Regards,=0A=
Tiberiu=0A=
________________________________________=0A=
From: linux-iio-owner@vger.kernel.org [linux-iio-owner@vger.kernel.org] on =
behalf of Jonathan Cameron [jic23@jic23.retrosnub.co.uk]=0A=
Sent: Tuesday, May 05, 2015 4:43 PM=0A=
To: Breana, Tiberiu A; linux-iio@vger.kernel.org=0A=
Cc: Jonathan Cameron=0A=
Subject: Re: [PATCH] iio: accel: Add support for Sensortek STK8312=0A=
=0A=
On 5 May 2015 14:20:38 GMT+01:00, Tiberiu Breana <tiberiu.a.breana@intel.co=
m> wrote:=0A=
>Minimal implementation of an IIO driver for the Sensortek=0A=
>STK8312 3-axis accelerometer.=0A=
>Datasheet:=0A=
>http://www.syi-group.com/uploadpic/data/201361817562681623.pdf=0A=
>=0A=
>Includes:=0A=
>- ACPI support;=0A=
>- read_raw for x,y,z axes;=0A=
>- reading and setting the scale (range) parameter.=0A=
>- power management=0A=
>=0A=
>Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>=0A=
=0A=
Looks good. Will take another look when not stuck with only my phone (and a=
 case of broken circuit boards) whilst my laptop is in the hold of the plan=
e...=0A=
>---=0A=
> drivers/iio/accel/Kconfig   |  11 ++=0A=
> drivers/iio/accel/Makefile  |   2 +=0A=
>drivers/iio/accel/stk8312.c | 375=0A=
>++++++++++++++++++++++++++++++++++++++++++++=0A=
> 3 files changed, 388 insertions(+)=0A=
> create mode 100644 drivers/iio/accel/stk8312.c=0A=
>=0A=
>diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig=0A=
>index 7c9a9a9..8bd8ccb 100644=0A=
>--- a/drivers/iio/accel/Kconfig=0A=
>+++ b/drivers/iio/accel/Kconfig=0A=
>@@ -136,4 +136,15 @@ config MMA9553=0A=
>=0A=
>         To compile this driver as a module, choose M here: the module=0A=
>         will be called mma9553.=0A=
>+=0A=
>+config STK8312=0A=
>+      tristate "Sensortek STK8312 3-Axis Accelerometer Driver"=0A=
>+      depends on I2C=0A=
>+      help=0A=
>+        Say yes here to get support for the Sensortek STK8312 3-axis=0A=
>+        accelerometer.=0A=
>+=0A=
>+        Choosing M will build the driver as a module. If so, the module=
=0A=
>+        will be called stk8312.=0A=
>+=0A=
> endmenu=0A=
>diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile=0A=
>index 99d89e4..8b327c1 100644=0A=
>--- a/drivers/iio/accel/Makefile=0A=
>+++ b/drivers/iio/accel/Makefile=0A=
>@@ -14,6 +14,8 @@ obj-$(CONFIG_MMA9551_CORE)   +=3D mma9551_core.o=0A=
> obj-$(CONFIG_MMA9551)         +=3D mma9551.o=0A=
> obj-$(CONFIG_MMA9553)         +=3D mma9553.o=0A=
>=0A=
>+obj-$(CONFIG_STK8312)         +=3D stk8312.o=0A=
>+=0A=
> obj-$(CONFIG_IIO_SSP_SENSORS_COMMONS) +=3D ssp_accel_sensor.o=0A=
>=0A=
> obj-$(CONFIG_IIO_ST_ACCEL_3AXIS) +=3D st_accel.o=0A=
>diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c=0A=
>new file mode 100644=0A=
>index 0000000..ff27e6b=0A=
>--- /dev/null=0A=
>+++ b/drivers/iio/accel/stk8312.c=0A=
>@@ -0,0 +1,375 @@=0A=
>+/**=0A=
>+ * Sensortek STK8312 3-Axis Accelerometer=0A=
>+ *=0A=
>+ * Copyright (c) 2015, Intel Corporation.=0A=
>+ *=0A=
>+ * This file is subject to the terms and conditions of version 2 of=0A=
>+ * the GNU General Public License. See the file COPYING in the main=0A=
>+ * directory of this archive for more details.=0A=
>+ *=0A=
>+ * IIO driver for STK8312; 7-bit I2C address: 0x3D.=0A=
>+ */=0A=
>+=0A=
>+#include <linux/acpi.h>=0A=
>+#include <linux/i2c.h>=0A=
>+#include <linux/kernel.h>=0A=
>+#include <linux/module.h>=0A=
>+#include <linux/delay.h>=0A=
>+#include <linux/iio/iio.h>=0A=
>+#include <linux/iio/sysfs.h>=0A=
>+=0A=
>+#define STK8312_REG_XOUT              0x00=0A=
>+#define STK8312_REG_YOUT              0x01=0A=
>+#define STK8312_REG_ZOUT              0x02=0A=
>+#define STK8312_REG_MODE              0x07=0A=
>+#define STK8312_REG_STH                       0x13=0A=
>+#define STK8312_REG_RESET             0x20=0A=
>+=0A=
>+#define STK8312_MODE_ACTIVE           1=0A=
>+#define STK8312_MODE_STANDBY          0=0A=
>+#define STK8312_MODE_MASK             0x01=0A=
>+#define STK8312_RNG_MASK              0xC0=0A=
>+#define STK8312_ALERT_MASK            0x40=0A=
>+#define STK8312_DATA6_MASK            0x3F=0A=
>+#define STK8312_RNG_SHIFT             6=0A=
>+#define STK8312_READ_RETRIES          16=0A=
>+=0A=
>+#define STK8312_DRIVER_NAME           "stk8312"=0A=
>+=0A=
>+#define STK8312_SCALE_AVAIL           "0.4747 0.4632 1.2354"=0A=
>+=0A=
>+static const int stk8312_scale_table[][2] =3D {=0A=
>+      {0, 474700}, {0, 463200}, {1, 235400}=0A=
>+};=0A=
>+=0A=
>+#define STK8312_ACCEL_CHANNEL(axis) {                         \=0A=
>+      .type =3D IIO_ACCEL,                                      \=0A=
>+      .modified =3D 1,                                          \=0A=
>+      .channel2 =3D IIO_MOD_##axis,                             \=0A=
>+      .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),           \=0A=
>+      .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),   \=0A=
>+}=0A=
>+=0A=
>+static const struct iio_chan_spec stk8312_channels[] =3D {=0A=
>+      STK8312_ACCEL_CHANNEL(X),=0A=
>+      STK8312_ACCEL_CHANNEL(Y),=0A=
>+      STK8312_ACCEL_CHANNEL(Z),=0A=
>+};=0A=
>+=0A=
>+struct stk8312_data {=0A=
>+      struct i2c_client *client;=0A=
>+      struct mutex lock;=0A=
>+      int range;=0A=
>+      u8 mode;=0A=
>+};=0A=
>+=0A=
>+static IIO_CONST_ATTR(in_accel_scale_available, STK8312_SCALE_AVAIL);=0A=
>+=0A=
>+static struct attribute *stk8312_attributes[] =3D {=0A=
>+      &iio_const_attr_in_accel_scale_available.dev_attr.attr,=0A=
>+      NULL,=0A=
>+};=0A=
>+=0A=
>+static const struct attribute_group stk8312_attribute_group =3D {=0A=
>+      .attrs =3D stk8312_attributes=0A=
>+};=0A=
>+=0A=
>+static int stk8312_set_mode(struct stk8312_data *data, u8 mode)=0A=
>+{=0A=
>+      int ret;=0A=
>+      u8 masked_reg;=0A=
>+      struct i2c_client *client =3D data->client;=0A=
>+=0A=
>+      if (mode > 1)=0A=
>+              return -EINVAL;=0A=
>+      else if (mode =3D=3D data->mode)=0A=
>+              return 0;=0A=
>+=0A=
>+      ret =3D i2c_smbus_read_byte_data(client, STK8312_REG_MODE);=0A=
>+      if (ret < 0) {=0A=
>+              dev_err(&client->dev, "register read failed\n");=0A=
>+              return ret;=0A=
>+      }=0A=
>+      masked_reg =3D ret & (~STK8312_MODE_MASK);=0A=
>+      masked_reg |=3D mode;=0A=
>+=0A=
>+      ret =3D i2c_smbus_write_byte_data(client, STK8312_REG_MODE,=0A=
>+                                      masked_reg);=0A=
>+      if (ret < 0)=0A=
>+              dev_err(&client->dev, "failed to change sensor mode\n");=0A=
>+      else=0A=
>+              data->mode =3D mode;=0A=
>+=0A=
>+      return ret;=0A=
>+}=0A=
>+=0A=
>+static int stk8312_set_range(struct stk8312_data *data, u8 range)=0A=
>+{=0A=
>+      int ret;=0A=
>+      int masked_reg;=0A=
>+      u8 mode;=0A=
>+      struct i2c_client *client =3D data->client;=0A=
>+=0A=
>+      if (range < 0 || range > 2)=0A=
>+              return -EINVAL;=0A=
>+=0A=
>+      if (range =3D=3D data->range)=0A=
>+              return 0;=0A=
>+=0A=
>+      mode =3D data->mode;=0A=
>+      /* We need to go in standby mode to modify registers */=0A=
>+      ret =3D stk8312_set_mode(data, STK8312_MODE_STANDBY);=0A=
>+      if (ret < 0)=0A=
>+              return ret;=0A=
>+=0A=
>+      ret =3D i2c_smbus_read_byte_data(client, STK8312_REG_STH);=0A=
>+      if (ret < 0) {=0A=
>+              dev_err(&client->dev, "register read failed\n");=0A=
>+              return ret;=0A=
>+      }=0A=
>+=0A=
>+      masked_reg =3D ret & (~STK8312_RNG_MASK);=0A=
>+      masked_reg |=3D range << STK8312_RNG_SHIFT;=0A=
>+=0A=
>+      ret =3D i2c_smbus_write_byte_data(client, STK8312_REG_STH, masked_r=
eg);=0A=
>+      if (ret < 0)=0A=
>+              dev_err(&client->dev, "failed to change sensor range\n");=
=0A=
>+      else=0A=
>+              data->range =3D range;=0A=
>+=0A=
>+      return stk8312_set_mode(data, mode);=0A=
>+}=0A=
>+=0A=
>+static int stk8312_read_accel(struct stk8312_data *data, int axis)=0A=
>+{=0A=
>+      int ret;=0A=
>+      u8 reg;=0A=
>+      int retries =3D STK8312_READ_RETRIES;=0A=
>+      struct i2c_client *client =3D data->client;=0A=
>+=0A=
>+      switch (axis) {=0A=
>+      case IIO_MOD_X:=0A=
>+              reg =3D STK8312_REG_XOUT;=0A=
>+              break;=0A=
>+      case IIO_MOD_Y:=0A=
>+              reg =3D STK8312_REG_YOUT;=0A=
>+              break;=0A=
>+      case IIO_MOD_Z:=0A=
>+              reg =3D STK8312_REG_ZOUT;=0A=
>+              break;=0A=
>+      default:=0A=
>+              return -EINVAL;=0A=
>+      }=0A=
>+=0A=
>+      ret =3D i2c_smbus_read_byte_data(client, reg);=0A=
>+      if (ret < 0) {=0A=
>+              dev_err(&client->dev, "register read failed\n");=0A=
>+              return ret;=0A=
>+      }=0A=
>+      if (data->range =3D=3D 0) {=0A=
>+              /* 6bit mode */=0A=
>+              while (retries--) {=0A=
>+                      if (ret & STK8312_ALERT_MASK) {=0A=
>+                              /* The register is being updated. Try again=
. */=0A=
>+                              msleep(20);=0A=
>+                              ret =3D i2c_smbus_read_byte_data(client, re=
g);=0A=
>+                              if (ret < 0) {=0A=
>+                                      dev_err(&data->client->dev,=0A=
>+                                              "register read failed\n");=
=0A=
>+                                      return ret;=0A=
>+                              }=0A=
>+                      } else {=0A=
>+                              ret &=3D STK8312_DATA6_MASK;=0A=
>+                              return sign_extend32(ret, 5);=0A=
>+                      }=0A=
>+              }=0A=
>+              dev_err(&data->client->dev,=0A=
>+                              "register read failed, data not ready\n");=
=0A=
>+              return -EIO;=0A=
>+      }=0A=
>+      /* 8bit mode */=0A=
>+      return sign_extend32(ret, 7);=0A=
>+}=0A=
>+=0A=
>+static int stk8312_read_raw(struct iio_dev *indio_dev,=0A=
>+                          struct iio_chan_spec const *chan,=0A=
>+                          int *val, int *val2, long mask)=0A=
>+{=0A=
>+      struct stk8312_data *data =3D iio_priv(indio_dev);=0A=
>+=0A=
>+      if (chan->type !=3D IIO_ACCEL)=0A=
>+              return -EINVAL;=0A=
>+=0A=
>+      switch (mask) {=0A=
>+      case IIO_CHAN_INFO_RAW:=0A=
>+              mutex_lock(&data->lock);=0A=
>+              *val =3D stk8312_read_accel(data, chan->channel2);=0A=
>+              mutex_unlock(&data->lock);=0A=
>+              return IIO_VAL_INT;=0A=
>+      case IIO_CHAN_INFO_SCALE:=0A=
>+              *val =3D stk8312_scale_table[data->range][0];=0A=
>+              *val2 =3D stk8312_scale_table[data->range][1];=0A=
>+              return IIO_VAL_INT_PLUS_MICRO;=0A=
>+      }=0A=
>+=0A=
>+      return -EINVAL;=0A=
>+}=0A=
>+=0A=
>+static int stk8312_write_raw(struct iio_dev *indio_dev,=0A=
>+                           struct iio_chan_spec const *chan,=0A=
>+                           int val, int val2, long mask)=0A=
>+{=0A=
>+      int i;=0A=
>+      int index =3D -1;=0A=
>+      int ret;=0A=
>+      struct stk8312_data *data =3D iio_priv(indio_dev);=0A=
>+=0A=
>+      switch (mask) {=0A=
>+      case IIO_CHAN_INFO_SCALE:=0A=
>+              for (i =3D 0; i < ARRAY_SIZE(stk8312_scale_table); i++)=0A=
>+                      if (val =3D=3D stk8312_scale_table[i][0] &&=0A=
>+                          val2 =3D=3D stk8312_scale_table[i][1]) {=0A=
>+                              index =3D i;=0A=
>+                              break;=0A=
>+                      }=0A=
>+              if (index < 0)=0A=
>+                      return -EINVAL;=0A=
>+=0A=
>+              mutex_lock(&data->lock);=0A=
>+              ret =3D stk8312_set_range(data, index);=0A=
>+              mutex_unlock(&data->lock);=0A=
>+=0A=
>+              return ret;=0A=
>+      }=0A=
>+=0A=
>+      return -EINVAL;=0A=
>+}=0A=
>+=0A=
>+static const struct iio_info stk8312_info =3D {=0A=
>+      .driver_module          =3D THIS_MODULE,=0A=
>+      .read_raw               =3D stk8312_read_raw,=0A=
>+      .write_raw              =3D stk8312_write_raw,=0A=
>+      .attrs                  =3D &stk8312_attribute_group,=0A=
>+};=0A=
>+=0A=
>+static int stk8312_init(struct iio_dev *indio_dev)=0A=
>+{=0A=
>+      int ret;=0A=
>+      struct stk8312_data *data =3D iio_priv(indio_dev);=0A=
>+      struct i2c_client *client =3D data->client;=0A=
>+=0A=
>+      /* A software reset is recommended at power-on */=0A=
>+      ret =3D i2c_smbus_write_byte_data(data->client, STK8312_REG_RESET,=
=0A=
>0x00);=0A=
>+      if (ret < 0)=0A=
>+              dev_err(&client->dev, "failed to reset sensor");=0A=
>+=0A=
>+      ret =3D stk8312_set_mode(data, STK8312_MODE_ACTIVE);=0A=
>+      if (ret < 0)=0A=
>+              dev_err(&client->dev, "failed to enable sensor");=0A=
>+=0A=
>+      return ret;=0A=
>+}=0A=
>+=0A=
>+static int stk8312_probe(struct i2c_client *client,=0A=
>+                       const struct i2c_device_id *id)=0A=
>+{=0A=
>+      int ret;=0A=
>+      struct iio_dev *indio_dev;=0A=
>+      struct stk8312_data *data;=0A=
>+=0A=
>+      indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));=
=0A=
>+      if (!indio_dev) {=0A=
>+              dev_err(&client->dev, "iio allocation failed!\n");=0A=
>+              return -ENOMEM;=0A=
>+      }=0A=
>+=0A=
>+      data =3D iio_priv(indio_dev);=0A=
>+      data->client =3D client;=0A=
>+      i2c_set_clientdata(client, indio_dev);=0A=
>+      mutex_init(&data->lock);=0A=
>+=0A=
>+      indio_dev->dev.parent =3D &client->dev;=0A=
>+      indio_dev->info =3D &stk8312_info;=0A=
>+      indio_dev->name =3D STK8312_DRIVER_NAME;=0A=
>+      indio_dev->modes =3D INDIO_DIRECT_MODE;=0A=
>+      indio_dev->channels =3D stk8312_channels;=0A=
>+      indio_dev->num_channels =3D ARRAY_SIZE(stk8312_channels);=0A=
>+=0A=
>+      ret =3D stk8312_init(indio_dev);=0A=
>+      if (ret < 0) {=0A=
>+              dev_err(&client->dev, "sensor initialization failed\n");=0A=
>+              return ret;=0A=
>+      }=0A=
>+=0A=
>+      ret =3D iio_device_register(indio_dev);=0A=
>+      if (ret < 0) {=0A=
>+              dev_err(&client->dev, "device_register failed\n");=0A=
>+              stk8312_set_mode(data, STK8312_MODE_STANDBY);=0A=
>+      }=0A=
>+=0A=
>+      return ret;=0A=
>+}=0A=
>+=0A=
>+static int stk8312_remove(struct i2c_client *client)=0A=
>+{=0A=
>+      struct iio_dev *indio_dev =3D i2c_get_clientdata(client);=0A=
>+=0A=
>+      iio_device_unregister(indio_dev);=0A=
>+=0A=
>+      return stk8312_set_mode(iio_priv(indio_dev), STK8312_MODE_STANDBY);=
=0A=
>+}=0A=
>+=0A=
>+#ifdef CONFIG_PM_SLEEP=0A=
>+static int stk8312_suspend(struct device *dev)=0A=
>+{=0A=
>+      struct stk8312_data *data;=0A=
>+=0A=
>+      data =3D iio_priv(i2c_get_clientdata(to_i2c_client(dev)));=0A=
>+=0A=
>+      return stk8312_set_mode(data, STK8312_MODE_STANDBY);=0A=
>+}=0A=
>+=0A=
>+static int stk8312_resume(struct device *dev)=0A=
>+{=0A=
>+      struct stk8312_data *data;=0A=
>+=0A=
>+      data =3D iio_priv(i2c_get_clientdata(to_i2c_client(dev)));=0A=
>+=0A=
>+      return stk8312_set_mode(data, STK8312_MODE_ACTIVE);=0A=
>+}=0A=
>+=0A=
>+static SIMPLE_DEV_PM_OPS(stk8312_pm_ops, stk8312_suspend,=0A=
>stk8312_resume);=0A=
>+=0A=
>+#define STK8312_PM_OPS (&stk8312_pm_ops)=0A=
>+#else=0A=
>+#define STK8312_PM_OPS NULL=0A=
>+#endif=0A=
>+=0A=
>+static const struct i2c_device_id stk8312_i2c_id[] =3D {=0A=
>+      {"STK8312", 0},=0A=
>+      {}=0A=
>+};=0A=
>+=0A=
>+static const struct acpi_device_id stk8312_acpi_id[] =3D {=0A=
>+      {"STK8312", 0},=0A=
>+      {}=0A=
>+};=0A=
>+=0A=
>+MODULE_DEVICE_TABLE(acpi, stk8312_acpi_id);=0A=
>+=0A=
>+static struct i2c_driver stk8312_driver =3D {=0A=
>+      .driver =3D {=0A=
>+              .name =3D "stk8312",=0A=
>+              .pm =3D STK8312_PM_OPS,=0A=
>+              .acpi_match_table =3D ACPI_PTR(stk8312_acpi_id),=0A=
>+      },=0A=
>+      .probe =3D            stk8312_probe,=0A=
>+      .remove =3D           stk8312_remove,=0A=
>+      .id_table =3D         stk8312_i2c_id,=0A=
>+};=0A=
>+=0A=
>+module_i2c_driver(stk8312_driver);=0A=
>+=0A=
>+MODULE_AUTHOR("Tiberiu Breana <tiberiu.a.breana@intel.com>");=0A=
>+MODULE_DESCRIPTION("STK8312 3-Axis Accelerometer driver");=0A=
>+MODULE_LICENSE("GPL v2");=0A=
=0A=
--=0A=
Sent from my Android device with K-9 Mail. Please excuse my brevity.=0A=
--=0A=
To unsubscribe from this list: send the line "unsubscribe linux-iio" in=0A=
the body of a message to majordomo@vger.kernel.org=0A=
More majordomo info at  http://vger.kernel.org/majordomo-info.html=0A=
