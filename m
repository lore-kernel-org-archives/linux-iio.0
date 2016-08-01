Return-Path: <Florian.Lobmaier@ams.com>
From: Florian Lobmaier <Florian.Lobmaier@ams.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: "jic23@kernel.org" <jic23@kernel.org>, Elitsa Polizoeva
	<Elitsa.Polizoeva@ams.com>, "knaack.h@gmx.de" <knaack.h@gmx.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Lars-Peter Clausen
	<lars@metafoo.de>
Subject: RE: [PATCH V3 1/1] iio: as6200: add AS6200 temperature sensor driver
 from ams AG
Date: Mon, 1 Aug 2016 08:05:37 +0000
Message-ID: <74d7c447fc1d442c95e8044c900beead@SUX5076.office.amsiag.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hello Peter,

Thanks for the feedback. We changed all open items accordingly.=20
One item regarding the free_irq in as6200_set_pol function we did not under=
stand: your feedback was " so irq is invalid here, but remove() would free =
it again?". This is true that free_irq would be called twice if the as6200_=
setup_irq function would fail afterwards. But is this a problem? If you cou=
ld give us a hint how to overcome the problem it would be great.
We removed the config sysfs file which allowed to write the complete config=
 register.

Br,
Florian

Signed-off-by: Elitsa Polizoeva <elitsa.polizoeva@ams.com>
Signed-off-by: Florian Lobmaier <florian.lobmaier@ams.com>
---
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kcon=
fig
index 21feaa4..d82e80f 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -3,6 +3,17 @@
 #
 menu "Temperature sensors"
=20
+config AS6200
+	tristate "ams AG AS6200 temperature sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for the AS6200 temperature
+	  sensor from ams AG.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called as6200.
+
 config MLX90614
 	tristate "MLX90614 contact-less infrared sensor"
 	depends on I2C
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Mak=
efile
index 40710a8..c0c9a9a 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -2,5 +2,6 @@
 # Makefile for industrial I/O temperature drivers
 #
=20
+obj-$(CONFIG_AS6200) +=3D as6200.o
 obj-$(CONFIG_MLX90614) +=3D mlx90614.o
 obj-$(CONFIG_TMP006) +=3D tmp006.o
diff --git a/drivers/iio/temperature/as6200.c b/drivers/iio/temperature/as6=
200.c
new file mode 100644
index 0000000..a3873f4
--- /dev/null
+++ b/drivers/iio/temperature/as6200.c
@@ -0,0 +1,747 @@
+/*
+ * Driver for ams AS6200 temperature sensor.
+ *
+ * Sensor supports following 7-bit I2C addresses: 0x48, 0x49, 0x4A, 0x4B
+ *
+ * Copyright (c) 2016 ams AG. All rights reserved.
+ *
+ * Author: Florian Lobmaier <florian.lobmaier@ams.com>
+ * Author: Elitsa Polizoeva <elitsa.polizoeva@ams.com>
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 US=
A
+ */
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/types.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+#include <linux/regmap.h>
+
+static const int as6200_conv_rates[4][2] =3D { {4, 0}, {1, 0},
+					{0, 250000}, {0, 125000} };
+
+static const char * const as6200_consec_faults[] =3D { "1", "2", "4", "6" =
};
+
+/* AS6200 registers */
+#define AS6200_REG_TVAL		0x00
+#define AS6200_REG_CONFIG	0x01
+#define AS6200_REG_TLOW		0x02
+#define AS6200_REG_THIGH	0x03
+#define AS6200_MAX_REGISTER	0x03
+
+#define AS6200_CONFIG_DW_MASK	BIT(4)
+#define AS6200_CONFIG_DW_SHIFT	4
+#define AS6200_CONFIG_AL_MASK	BIT(5)
+#define AS6200_CONFIG_AL_SHIFT	5
+#define AS6200_CONFIG_CR_MASK	GENMASK(7, 6)
+#define AS6200_CONFIG_CR_SHIFT	6
+#define AS6200_CONFIG_SM_MASK	BIT(8)
+#define AS6200_CONFIG_SM_SHIFT	8
+#define AS6200_CONFIG_IM_MASK	BIT(9)
+#define AS6200_CONFIG_IM_SHIFT	9
+#define AS6200_CONFIG_POL_MASK	BIT(10)
+#define AS6200_CONFIG_POL_SHIFT	10
+#define AS6200_CONFIG_CF_MASK	GENMASK(12, 11)
+#define AS6200_CONFIG_CF_SHIFT	11
+#define AS6200_CONFIG_SS_MASK	BIT(15)
+#define AS6200_CONFIG_SS_SHIFT	15
+
+struct as6200_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+};
+
+static const struct regmap_range as6200_readable_ranges[] =3D {
+	regmap_reg_range(AS6200_REG_TVAL, AS6200_REG_THIGH),
+};
+
+static const struct regmap_access_table as6200_readable_table =3D {
+	.yes_ranges =3D as6200_readable_ranges,
+	.n_yes_ranges =3D ARRAY_SIZE(as6200_readable_ranges),
+};
+
+static const struct regmap_range as6200_writable_ranges[] =3D {
+	regmap_reg_range(AS6200_REG_CONFIG, AS6200_REG_THIGH),
+};
+
+static const struct regmap_access_table as6200_writable_table =3D {
+	.yes_ranges =3D as6200_writable_ranges,
+	.n_yes_ranges =3D ARRAY_SIZE(as6200_writable_ranges),
+};
+
+static const struct regmap_range as6200_volatile_ranges[] =3D {
+	regmap_reg_range(AS6200_REG_TVAL, AS6200_REG_TVAL),
+};
+
+static const struct regmap_access_table as6200_volatile_table =3D {
+	.yes_ranges =3D as6200_volatile_ranges,
+	.n_yes_ranges =3D ARRAY_SIZE(as6200_volatile_ranges),
+};
+
+static const struct regmap_config as6200_regmap_config =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 16,
+	.max_register =3D AS6200_MAX_REGISTER,
+	.cache_type =3D REGCACHE_RBTREE,
+	.rd_table =3D &as6200_readable_table,
+	.wr_table =3D &as6200_writable_table,
+	.volatile_table =3D &as6200_volatile_table,
+};
+
+static int as6200_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *channel, int *val,
+			    int *val2, long mask)
+{
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	unsigned int reg_val;
+	int cr, err;
+	s32 ret;
+
+	if (channel->type !=3D IIO_TEMP)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED:
+		err =3D regmap_read(data->regmap, AS6200_REG_TVAL,
+					&reg_val);
+		if (err < 0)
+			return err;
+		ret =3D sign_extend32(reg_val, 15) >> 4;
+		if (mask =3D=3D IIO_CHAN_INFO_PROCESSED)
+			*val =3D (ret * 625) / 10000;
+		else
+			*val =3D ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val =3D 62;
+		*val2 =3D 500000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		err =3D regmap_read(data->regmap, AS6200_REG_CONFIG,
+					&reg_val);
+		if (err < 0)
+			return err;
+		cr =3D (reg_val & AS6200_CONFIG_CR_MASK)
+			>> AS6200_CONFIG_CR_SHIFT;
+		*val =3D as6200_conv_rates[cr][0];
+		*val2 =3D as6200_conv_rates[cr][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+static int as6200_write_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			int val,
+			int val2,
+			long mask)
+{
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	int i;
+	unsigned int config_val;
+	int err =3D 0;
+
+	if (mask !=3D IIO_CHAN_INFO_SAMP_FREQ)
+		return -EINVAL;
+
+	for (i =3D 0; i < ARRAY_SIZE(as6200_conv_rates); i++)
+		if ((val =3D=3D as6200_conv_rates[i][0]) &&
+			(val2 =3D=3D as6200_conv_rates[i][1])) {
+			err =3D regmap_read(data->regmap,
+				AS6200_REG_CONFIG, &config_val);
+			if (err < 0)
+				return err;
+			config_val &=3D ~AS6200_CONFIG_CR_MASK;
+			config_val |=3D i << AS6200_CONFIG_CR_SHIFT;
+
+			return regmap_write(data->regmap, AS6200_REG_CONFIG,
+							config_val);
+		}
+	return -EINVAL;
+}
+
+static irqreturn_t as6200_alert_isr(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev =3D dev_id;
+
+	iio_push_event(indio_dev,
+		IIO_UNMOD_EVENT_CODE(IIO_TEMP,
+					0,
+					IIO_EV_TYPE_THRESH,
+					IIO_EV_DIR_EITHER),
+					iio_get_time_ns());
+	return IRQ_HANDLED;
+}
+
+static int as6200_setup_irq(struct iio_dev *indio_dev, bool pol)
+{
+	int err;
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct device *dev =3D &data->client->dev;
+	int irq_trig;
+
+	if (pol)
+		irq_trig =3D IRQF_TRIGGER_RISING;
+	else
+		irq_trig =3D IRQF_TRIGGER_FALLING;
+
+	err =3D request_irq(data->client->irq, as6200_alert_isr, irq_trig,
+			"as6200", dev);
+	if (err) {
+		dev_err(dev, "error requesting irq %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static ssize_t as6200_show_thigh(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	unsigned int reg_val;
+	int err, val;
+
+	err =3D regmap_read(data->regmap, AS6200_REG_THIGH, &reg_val);
+	if (err < 0)
+		return err;
+	reg_val =3D reg_val >> 4;
+	val =3D (625 * reg_val) / 10000;
+	return sprintf(buf, "%d Degree Celsius\n", val);
+}
+
+static ssize_t as6200_show_tlow(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	unsigned int reg_val;
+	int err, val;
+
+	err =3D regmap_read(data->regmap, AS6200_REG_TLOW, &reg_val);
+	if (err < 0)
+		return err;
+	reg_val =3D reg_val >> 4;
+	val =3D (625 * reg_val) / 10000;
+	return sprintf(buf, "%d Degree Celsius\n", val);
+}
+
+static ssize_t as6200_show_thigh_reg(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	unsigned int reg_val;
+	int err;
+
+	err =3D regmap_read(data->regmap, AS6200_REG_THIGH, &reg_val);
+	if (err < 0)
+		return err;
+	return sprintf(buf, "%hX\n", reg_val);
+}
+
+static ssize_t as6200_show_tlow_reg(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	unsigned int reg_val;
+	int err;
+
+	err =3D regmap_read(data->regmap, AS6200_REG_TLOW, &reg_val);
+	if (err < 0)
+		return err;
+	return sprintf(buf, "%hX\n", reg_val);
+}
+
+static ssize_t as6200_show_al(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	unsigned int reg_val;
+	int err;
+	bool pol, al;
+
+	err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
+	if (err < 0)
+		return err;
+	pol =3D (reg_val & AS6200_CONFIG_POL_MASK) >> AS6200_CONFIG_POL_SHIFT;
+	al =3D (reg_val & AS6200_CONFIG_AL_MASK) >> AS6200_CONFIG_AL_SHIFT;
+	if (pol) {
+		if (al)
+			return sprintf(buf, "on\n");
+		else
+			return sprintf(buf, "off\n");
+	} else {
+		if (al )
+			return sprintf(buf, "off\n");
+		else
+			return sprintf(buf, "on\n");
+	}
+}
+
+static ssize_t as6200_show_sm(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	unsigned int reg_val;
+	int err;
+
+	err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
+	if (err < 0)
+		return err;
+	return sprintf(buf, "%hX\n", (u16)((reg_val & AS6200_CONFIG_SM_MASK)
+					>> AS6200_CONFIG_SM_SHIFT));
+}
+
+static ssize_t as6200_show_im(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	unsigned int reg_val;
+	int err;
+
+	err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
+	if (err < 0)
+		return err;
+	return sprintf(buf, "%hX\n", (u16)((reg_val & AS6200_CONFIG_IM_MASK)
+					>> AS6200_CONFIG_IM_SHIFT));
+}
+
+static ssize_t as6200_show_pol(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	unsigned int reg_val;
+	int err;
+
+	err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
+	if (err < 0)
+		return err;
+	return sprintf(buf, "%hX\n", (u16)((reg_val & AS6200_CONFIG_POL_MASK)
+					 >> AS6200_CONFIG_POL_SHIFT));
+}
+
+static ssize_t as6200_show_cf(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	unsigned int reg_val;
+	int err;
+
+	err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
+	if (err < 0)
+		return err;
+	reg_val =3D (reg_val & AS6200_CONFIG_CF_MASK) >> AS6200_CONFIG_CF_SHIFT;
+	return sprintf(buf, "%s\n", as6200_consec_faults[reg_val]);
+}
+
+static ssize_t as6200_show_ss(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	unsigned int reg_val;
+	int err;
+
+	err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
+	if (err < 0)
+		return err;
+	return sprintf(buf, "%hX\n", (u16)((reg_val & AS6200_CONFIG_SS_MASK)
+					>> AS6200_CONFIG_SS_SHIFT));
+}
+
+static ssize_t as6200_set_thigh(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	s16 reg_val;
+	int err, val;
+
+	err =3D kstrtoint(buf, 0, &val);
+	if (err =3D=3D 0) {
+		if ((val < -40) || (val > 150))
+			return count;
+		val =3D (val * 10000) / 625;
+		reg_val =3D val << 4;
+		err =3D regmap_write(data->regmap, AS6200_REG_THIGH, reg_val);
+		if (err < 0)
+			return err;
+	} else
+		dev_err(&client->dev,
+			"Converting value for THIGH failed, err =3D %hx",
+			err);
+	return count;
+}
+
+static ssize_t as6200_set_tlow(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	s16 reg_val;
+	int err, val;
+
+	err =3D kstrtoint(buf, 0, &val);
+	if (err =3D=3D 0) {
+		if ((val < -40) || (val > 150)) {
+			dev_info(&client->dev,
+				"Value for THIGH is invalid min =3D -40%cC, max =3D 150=B0C, val =3D %=
d=B0C",
+				(unsigned char)(248), val);
+			return -ERANGE;
+		}
+		val =3D (val * 10000) / 625;
+		reg_val =3D val << 4;
+		err =3D regmap_write(data->regmap, AS6200_REG_TLOW, reg_val);
+		if (err < 0)
+			return err;
+	} else
+		dev_info(&client->dev,
+			"Converting value for TLOW failed, err =3D %hx",
+			err);
+	return count;
+}
+
+static ssize_t as6200_set_thigh_reg(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	u16 reg_val;
+	int err;
+
+	err =3D kstrtou16(buf, 0, &reg_val);
+	if (err =3D=3D 0) {
+		err =3D regmap_write(data->regmap, AS6200_REG_THIGH, reg_val);
+		if (err < 0)
+			return err;
+	} else
+		dev_info(&client->dev,
+			"Converting value for THIGH failed, err =3D %hx",
+			err);
+	return count;
+}
+
+static ssize_t as6200_set_tlow_reg(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	int err;
+	u16 reg_val;
+
+	err =3D kstrtou16(buf, 0, &reg_val);
+	if (err =3D=3D 0) {
+		err =3D regmap_write(data->regmap, AS6200_REG_TLOW, reg_val);
+		if (err < 0)
+			return err;
+	} else
+		dev_info(&client->dev,
+			"Converting value for TLOW failed, err =3D %hx",
+			err);
+	return count;
+}
+
+static ssize_t as6200_set_sm(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	int err;
+	u16 val;
+
+	err =3D kstrtou16(buf, 0, &val);
+	if (err =3D=3D 0) {
+		err =3D regmap_update_bits(data->regmap, AS6200_REG_CONFIG,
+			AS6200_CONFIG_SM_MASK, val << AS6200_CONFIG_SM_SHIFT);
+		if (err < 0)
+			return err;
+	} else
+		dev_info(&client->dev,
+			"Converting value for SM field failed, err =3D %hx",
+			err);
+	return count;
+}
+
+static ssize_t as6200_set_im(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	int err;
+	u16 val;
+
+	err =3D kstrtou16(buf, 0, &val);
+	if (err =3D=3D 0) {
+		err =3D regmap_update_bits(data->regmap, AS6200_REG_CONFIG,
+			AS6200_CONFIG_IM_MASK, val << AS6200_CONFIG_IM_SHIFT);
+		if (err < 0)
+			return err;
+	} else
+		dev_info(&client->dev,
+			"Converting value for IM field failed, err =3D %hx",
+			err);
+	return count;
+}
+
+static ssize_t as6200_set_pol(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	int err;
+	u16 val;
+
+	err =3D kstrtou16(buf, 0, &val);
+	if (err =3D=3D 0) {
+		free_irq(client->irq, dev);
+		err =3D regmap_update_bits(data->regmap, AS6200_REG_CONFIG,
+			AS6200_CONFIG_POL_MASK,
+			val << AS6200_CONFIG_POL_SHIFT);
+		if (err < 0)
+			return err;
+		as6200_setup_irq(indio_dev, (bool)val);
+	} else
+		dev_info(&client->dev,
+			"Converting value for POL field failed, err =3D %hx",
+			err);
+	return count;
+}
+
+static ssize_t as6200_set_cf(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	int err;
+	u16 val;
+
+	err =3D kstrtou16(buf, 0, &val);
+	if (err =3D=3D 0) {
+		switch (val) {
+		case 1:
+		case 2:
+		case 4:
+		case 6:
+			err =3D regmap_update_bits(data->regmap,
+				AS6200_REG_CONFIG, AS6200_CONFIG_CF_MASK,
+				val << AS6200_CONFIG_CF_SHIFT);
+			if (err < 0)
+				return err;
+			break;
+		default:
+			dev_info(&client->dev,
+				"Value for CF field invalid, val =3D %hx", val);
+			return count;
+		}
+	} else
+		dev_info(&client->dev,
+			"Converting value for CF field failed, err =3D %hx",
+			err);
+	return count;
+}
+
+static ssize_t as6200_set_ss(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	int err;
+	u16 val;
+
+	err =3D kstrtou16(buf, 0, &val);
+	if (err =3D=3D 0) {
+		err =3D regmap_update_bits(data->regmap, AS6200_REG_CONFIG,
+			AS6200_CONFIG_SS_MASK, val << AS6200_CONFIG_SS_SHIFT);
+		if (err < 0)
+			return err;
+	} else
+		dev_info(&client->dev,
+			"Converting value for SS field failed, err =3D %hx",
+			err);
+	return count;
+}
+
+static IIO_DEVICE_ATTR(thigh, S_IWUSR | S_IRUGO, as6200_show_thigh,
+	as6200_set_thigh, 0);
+static IIO_DEVICE_ATTR(tlow, S_IWUSR | S_IRUGO, as6200_show_tlow,
+	as6200_set_tlow, 0);
+static IIO_DEVICE_ATTR(thigh_reg, S_IWUSR | S_IRUGO, as6200_show_thigh_reg=
,
+	as6200_set_thigh_reg, 0);
+static IIO_DEVICE_ATTR(tlow_reg, S_IWUSR | S_IRUGO, as6200_show_tlow_reg,
+	as6200_set_tlow_reg, 0);
+static IIO_DEVICE_ATTR(al, S_IRUGO, as6200_show_al, NULL, 0);
+static IIO_DEVICE_ATTR(sm, S_IWUSR | S_IRUGO, as6200_show_sm,
+	as6200_set_sm, 0);
+static IIO_DEVICE_ATTR(im, S_IWUSR | S_IRUGO, as6200_show_im,
+	as6200_set_im, 0);
+static IIO_DEVICE_ATTR(pol, S_IWUSR | S_IRUGO, as6200_show_pol,
+	as6200_set_pol, 0);
+static IIO_DEVICE_ATTR(cf, S_IWUSR | S_IRUGO, as6200_show_cf,
+	as6200_set_cf, 0);
+static IIO_DEVICE_ATTR(ss, S_IWUSR | S_IRUGO, as6200_show_ss,
+	as6200_set_ss, 0);
+
+static IIO_CONST_ATTR(sampling_frequency_available, "4 1 0.25 0.125");
+
+static struct attribute *as6200_attrs[] =3D {
+	&iio_dev_attr_thigh.dev_attr.attr,
+	&iio_dev_attr_tlow.dev_attr.attr,
+	&iio_dev_attr_thigh_reg.dev_attr.attr,
+	&iio_dev_attr_tlow_reg.dev_attr.attr,
+	&iio_dev_attr_al.dev_attr.attr,
+	&iio_dev_attr_sm.dev_attr.attr,
+	&iio_dev_attr_im.dev_attr.attr,
+	&iio_dev_attr_pol.dev_attr.attr,
+	&iio_dev_attr_cf.dev_attr.attr,
+	&iio_dev_attr_ss.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute_group as6200_attr_group =3D {
+	.attrs =3D as6200_attrs,
+};
+
+static const struct iio_chan_spec as6200_channels[] =3D {
+	{
+		.type =3D IIO_TEMP,
+		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_PROCESSED) |
+			BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	}
+};
+
+static const struct iio_info as6200_info =3D {
+	.read_raw =3D as6200_read_raw,
+	.write_raw =3D as6200_write_raw,
+	.attrs =3D &as6200_attr_group,
+	.driver_module =3D THIS_MODULE,
+};
+
+static int as6200_i2c_probe(struct i2c_client *client,
+	const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct as6200_data *data;
+	int ret;
+
+	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data =3D iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client =3D client;
+
+	data->regmap =3D devm_regmap_init_i2c(client, &as6200_regmap_config);
+	if (IS_ERR(data->regmap)) {
+		ret =3D PTR_ERR(data->regmap);
+		dev_err(&client->dev, "regmap init failed: %d\n", ret);
+		return ret;
+	}
+
+	indio_dev->dev.parent =3D &client->dev;
+	indio_dev->name =3D id->name;
+	indio_dev->modes =3D INDIO_DIRECT_MODE;
+	indio_dev->info =3D &as6200_info;
+
+	indio_dev->channels =3D as6200_channels;
+	indio_dev->num_channels =3D ARRAY_SIZE(as6200_channels);
+
+	ret =3D as6200_setup_irq(indio_dev, false);
+	if (ret < 0)
+		return ret;
+
+	ret =3D iio_device_register(indio_dev);
+	if (ret < 0)
+		goto cleanup_irq;
+
+	return 0;
+
+cleanup_irq:
+	free_irq(client->irq, &client->dev);
+
+	return ret;
+}
+
+static int as6200_i2c_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+	free_irq(client->irq, &client->dev);
+	return 0;
+}
+
+static const struct of_device_id as6200_of_match[] =3D {
+	{ .compatible =3D "ams,as6200", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, as6200_of_match);
+
+
+static const struct i2c_device_id as6200_i2c_id[] =3D {
+	{ "as6200", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, as6200_id);
+
+static struct i2c_driver as6200_i2c_driver =3D {
+	.driver =3D {
+		.name =3D "as6200",
+		.owner =3D THIS_MODULE,
+		.of_match_table =3D as6200_of_match,
+	},
+	.probe =3D as6200_i2c_probe,
+	.remove =3D as6200_i2c_remove,
+	.id_table =3D as6200_i2c_id,
+};
+
+module_i2c_driver(as6200_i2c_driver);
+
+MODULE_DESCRIPTION("ams AS6200 temperature sensor");
+MODULE_AUTHOR("Florian Lobmaier <florian.lobmaier@ams.com>");
+MODULE_AUTHOR("Elitsa Polizoeva <elitsa.polizoeva@ams.com>");
+MODULE_LICENSE("GPL");

-----Original Message-----
From: Peter Meerwald-Stadler [mailto:pmeerw@pmeerw.net]=20
Sent: Freitag, 29. Juli 2016 08:42
To: Florian Lobmaier <Florian.Lobmaier@ams.com>
Cc: jic23@kernel.org; Elitsa Polizoeva <Elitsa.Polizoeva@ams.com>; knaack.h=
@gmx.de; linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; Lars-Pete=
r Clausen <lars@metafoo.de>
Subject: RE: [PATCH V2 1/1] iio: as6200: add AS6200 temperature sensor driv=
er from ams AG

Hello Florian,

> As requested we can also provide a link to the datasheet of the chip:=20
> http://ams.com/eng/Products/Environmental-Sensors/Temperature-Sensors
> We also tried to cover all points (removed all debug msgs, simpler IRQ=20
> pin config, etc.). Still all the show/store functions for each=20
> configuration bit of the sensor are in. This was a request by our product=
=20
> management. If you suggest to take the show/store functions out=20
> completely for the driver version in the kernel, we would also be fine=20
> with that. We will give them out on request for customers then.

looks a lot better; GPL copyright header missing and private API needs to=20
be documented (or removed, but it really is just for debug?)

more comments below

regards, p.

> Signed-off-by: Elitsa Polizoeva <elitsa.polizoeva@ams.com>
> Signed-off-by: Florian Lobmaier <florian.lobmaier@ams.com>
> ---
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kc=
onfig
> index 21feaa4..d82e80f 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -3,6 +3,17 @@
>  #
>  menu "Temperature sensors"
> =20
> +config AS6200
> +	tristate "ams AG AS6200 temperature sensor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for the AS6200 temperature
> +	  sensor from ams AG.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called as6200.
> +
>  config MLX90614
>  	tristate "MLX90614 contact-less infrared sensor"
>  	depends on I2C
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/M=
akefile
> index 40710a8..c0c9a9a 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -2,5 +2,6 @@
>  # Makefile for industrial I/O temperature drivers
>  #
> =20
> +obj-$(CONFIG_AS6200) +=3D as6200.o
>  obj-$(CONFIG_MLX90614) +=3D mlx90614.o
>  obj-$(CONFIG_TMP006) +=3D tmp006.o
> diff --git a/drivers/iio/temperature/as6200.c b/drivers/iio/temperature/a=
s6200.c
> new file mode 100644
> index 0000000..289e950
> --- /dev/null
> +++ b/drivers/iio/temperature/as6200.c
> @@ -0,0 +1,789 @@

there needs to be a GPL copyright header, not sure if MODULE_LICENSE()=20
below is enough

I find it useful to state the I2C 7-bit chip address here as well

> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +#include <linux/types.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/gpio.h>
> +#include <linux/of_gpio.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +#include <linux/regmap.h>
> +
> +static const int as6200_conv_rates[4][2] =3D { {4, 0}, {1, 0},
> +					{0, 250000}, {0, 125000} };
> +
> +static const char * const as6200_consec_faults[] =3D { "1", "2", "4", "6=
" };
> +
> +/* AS6200 registers */
> +#define AS6200_REG_TVAL		0x00
> +#define AS6200_REG_CONFIG	0x01
> +#define AS6200_REG_TLOW		0x02
> +#define AS6200_REG_THIGH	0x03
> +#define AS6200_MAX_REGISTER	0x03
> +
> +#define AS6200_CONFIG_DW_MASK	BIT(4)
> +#define AS6200_CONFIG_DW_SHIFT	4
> +#define AS6200_CONFIG_AL_MASK	BIT(5)
> +#define AS6200_CONFIG_AL_SHIFT	5
> +#define AS6200_CONFIG_CR_MASK	GENMASK(7, 6)
> +#define AS6200_CONFIG_CR_SHIFT	6
> +#define AS6200_CONFIG_SM_MASK	BIT(8)
> +#define AS6200_CONFIG_SM_SHIFT	8
> +#define AS6200_CONFIG_IM_MASK	BIT(9)
> +#define AS6200_CONFIG_IM_SHIFT	9
> +#define AS6200_CONFIG_POL_MASK	BIT(10)
> +#define AS6200_CONFIG_POL_SHIFT	10
> +#define AS6200_CONFIG_CF_MASK	GENMASK(12, 11)
> +#define AS6200_CONFIG_CF_SHIFT	11
> +#define AS6200_CONFIG_SS_MASK	BIT(15)
> +#define AS6200_CONFIG_SS_SHIFT	15
> +
> +struct as6200_data {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +};
> +
> +static const struct regmap_range as6200_readable_ranges[] =3D {
> +	regmap_reg_range(AS6200_REG_TVAL, AS6200_REG_THIGH),
> +};
> +
> +static const struct regmap_access_table as6200_readable_table =3D {
> +	.yes_ranges =3D as6200_readable_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(as6200_readable_ranges),
> +};
> +
> +static const struct regmap_range as6200_writable_ranges[] =3D {
> +	regmap_reg_range(AS6200_REG_CONFIG, AS6200_REG_THIGH),
> +};
> +
> +static const struct regmap_access_table as6200_writable_table =3D {
> +	.yes_ranges =3D as6200_writable_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(as6200_writable_ranges),
> +};
> +
> +static const struct regmap_range as6200_volatile_ranges[] =3D {
> +	regmap_reg_range(AS6200_REG_TVAL, AS6200_REG_TVAL),
> +};
> +
> +static const struct regmap_access_table as6200_volatile_table =3D {
> +	.yes_ranges =3D as6200_volatile_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(as6200_volatile_ranges),
> +};
> +
> +static const struct regmap_config as6200_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 16,
> +	.max_register =3D AS6200_MAX_REGISTER,
> +	.cache_type =3D REGCACHE_RBTREE,
> +	.rd_table =3D &as6200_readable_table,
> +	.wr_table =3D &as6200_writable_table,
> +	.volatile_table =3D &as6200_volatile_table,
> +};
> +
> +static int as6200_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int *val,
> +			    int *val2, long mask)
> +{
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	int cr;
> +	s32 ret;
> +	int err =3D 0;

err initialization not needed

> +	unsigned int reg_val =3D 0;

reg_val initialization not needed

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +	case IIO_CHAN_INFO_PROCESSED:

I'd suggest the following to save some lines and simplity control flow

if (channel->type !=3D IIO_TEMP)
   return -EINVAL

err =3D regmap_read(data->regmap, AS6200_REG_TVAL, ...
return IIO_VAL_INT;

(and similar below)

> +		if (channel->type =3D=3D IIO_TEMP) {
> +			err =3D regmap_read(data->regmap, AS6200_REG_TVAL,
> +						&reg_val);
> +			if (err < 0)
> +				return err;
> +			ret =3D reg_val;

why this assignment? could do=20
ret =3D sign_extend32(reg_val, 15) >> 4;=20

> +			ret =3D sign_extend32(ret, 15) >> 4;
> +			if (mask =3D=3D IIO_CHAN_INFO_PROCESSED)
> +				*val =3D (ret * 625) / 10000;
> +			else
> +				*val =3D ret;
> +		} else {
> +			break;
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (channel->type =3D=3D IIO_TEMP) {
> +			*val =3D 62;
> +			*val2 =3D 500000;
> +		} else {
> +			break;
> +		}
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (channel->type =3D=3D IIO_TEMP) {
> +			err =3D regmap_read(data->regmap, AS6200_REG_CONFIG,
> +						&reg_val);
> +			if (err < 0)
> +				return err;
> +			cr =3D (reg_val & AS6200_CONFIG_CR_MASK)
> +				>> AS6200_CONFIG_CR_SHIFT;
> +			*val =3D as6200_conv_rates[cr][0];
> +			*val2 =3D as6200_conv_rates[cr][1];
> +		} else {
> +			break;
> +		}
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		break;
> +	}
> +	return -EINVAL;
> +}
> +
> +static int as6200_write_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			int val,
> +			int val2,
> +			long mask)
> +{
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	int i;
> +	unsigned int config_val;
> +	int err =3D 0;
> +
> +	if (mask !=3D IIO_CHAN_INFO_SAMP_FREQ)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(as6200_conv_rates); i++) {
> +		if ((val =3D=3D as6200_conv_rates[i][0]) &&
> +			(val2 =3D=3D as6200_conv_rates[i][1])) {

parenthesis not needed

> +			err =3D regmap_read(data->regmap,
> +				AS6200_REG_CONFIG, &config_val);
> +			if (err < 0)
> +				return err;
> +			config_val &=3D ~AS6200_CONFIG_CR_MASK;
> +			config_val |=3D i << AS6200_CONFIG_CR_SHIFT;
> +
> +			return regmap_write(data->regmap, AS6200_REG_CONFIG,
> +							config_val);
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
> +static irqreturn_t as6200_alert_isr(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev =3D dev_id;
> +
> +	iio_push_event(indio_dev,
> +		IIO_UNMOD_EVENT_CODE(IIO_TEMP,
> +					0,
> +					IIO_EV_TYPE_THRESH,
> +					IIO_EV_DIR_EITHER),
> +					iio_get_time_ns());
> +	return IRQ_HANDLED;
> +}
> +
> +static int as6200_setup_irq(struct iio_dev *indio_dev, bool set_gpio, u8=
 pol)
> +{
> +	int err;
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	struct device *dev =3D &data->client->dev;
> +	int irq_trig;
> +

set_gpio not used?
pol could be bool?

> +	if (pol =3D=3D 1)
> +		irq_trig =3D IRQF_TRIGGER_RISING;
> +	else
> +		irq_trig =3D IRQF_TRIGGER_FALLING;
> +
> +	err =3D request_irq(data->client->irq, as6200_alert_isr, irq_trig,
> +			"as6200", dev);
> +	if (err) {
> +		dev_err(dev, "error requesting irq %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t as6200_show_thigh(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{

maybe common code could be split out

> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	unsigned int reg_val =3D 0;
> +	int err =3D 0;

init not needed

> +	int val;
> +
> +	err =3D regmap_read(data->regmap, AS6200_REG_THIGH, &reg_val);
> +	if (err < 0)
> +		return err;
> +	reg_val =3D reg_val >> 4;
> +	val =3D (625 * reg_val) / 10000;
> +	return sprintf(buf, "%d%cC\n", val, (unsigned char)(248));

this tries to outputs the extended ASCII =B0 character (degree), this makes=
=20
little sense, most terminals are utf-8 and I'm not sure what the policy is=
=20
WRT non-ASCII

> +}
> +
> +static ssize_t as6200_show_tlow(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	unsigned int reg_val =3D 0x00;
> +	int err =3D 0;
> +	int val;
> +
> +	err =3D regmap_read(data->regmap, AS6200_REG_TLOW, &reg_val);
> +	if (err < 0)
> +		return err;
> +	reg_val =3D reg_val >> 4;
> +	val =3D (625 * reg_val) / 10000;
> +	return sprintf(buf, "%d%cC\n", val, (unsigned char)(248));
> +}
> +
> +static ssize_t as6200_show_thigh_reg(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	unsigned int reg_val =3D 0;
> +	int err =3D 0;
> +
> +	err =3D regmap_read(data->regmap, AS6200_REG_THIGH, &reg_val);
> +	if (err < 0)
> +		return err;
> +	return sprintf(buf, "%hX\n", reg_val);
> +}
> +
> +static ssize_t as6200_show_tlow_reg(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	unsigned int reg_val =3D 0x00;
> +	int err =3D 0;
> +
> +	err =3D regmap_read(data->regmap, AS6200_REG_TLOW, &reg_val);
> +	if (err < 0)
> +		return err;
> +	return sprintf(buf, "%hX\n", reg_val);
> +}
> +
> +static ssize_t as6200_show_config(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	unsigned int reg_val =3D 0x00;
> +	int err =3D 0;
> +
> +	err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> +	if (err < 0)
> +		return err;
> +	return sprintf(buf, "%hX\n", reg_val);
> +}
> +
> +static ssize_t as6200_show_al(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	unsigned int reg_val =3D 0x00;
> +	int err =3D 0;
> +	u16 pol =3D 0;

init not needed

> +
> +	err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> +	if (err < 0)
> +		return err;
> +	pol =3D (reg_val & AS6200_CONFIG_POL_MASK) >> AS6200_CONFIG_POL_SHIFT;
> +	reg_val =3D (reg_val & AS6200_CONFIG_AL_MASK) >> AS6200_CONFIG_AL_SHIFT=
;
> +	if (pol =3D=3D 1) {
> +		if (reg_val =3D=3D 0)
> +			return sprintf(buf, "off\n");
> +		else if (reg_val =3D=3D 1)
> +			return sprintf(buf, "on\n");

AL_MASK is a bit, I don't see how reg_val can end up different from 0/1

maybe use a bool for pol?



> +		else
> +			return sprintf(buf, "invalid\n");
> +	} else if (pol =3D=3D 0) {
> +		if (reg_val =3D=3D 0)
> +			return sprintf(buf, "on\n");
> +		else if (reg_val =3D=3D 1)
> +			return sprintf(buf, "off\n");
> +		else
> +			return sprintf(buf, "invalid\n");
> +	} else
> +		return sprintf(buf, "invalid\n");
> +}
> +
> +static ssize_t as6200_show_sm(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	unsigned int reg_val =3D 0x00;
> +	int err =3D 0;
> +
> +	err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> +	if (err < 0)
> +		return err;
> +	return sprintf(buf, "%hX\n", (reg_val & AS6200_CONFIG_SM_MASK)
> +					>> AS6200_CONFIG_SM_SHIFT);
> +}
> +
> +static ssize_t as6200_show_im(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	unsigned int reg_val =3D 0x00;
> +	int err =3D 0;
> +
> +	err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> +	if (err < 0)
> +		return err;
> +	return sprintf(buf, "%hX\n", (reg_val & AS6200_CONFIG_IM_MASK)
> +					>> AS6200_CONFIG_IM_SHIFT);
> +}
> +
> +static ssize_t as6200_show_pol(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	unsigned int reg_val =3D 0x00;
> +	int err =3D 0;
> +
> +	err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> +	if (err < 0)
> +		return err;
> +	return sprintf(buf, "%hX\n", (reg_val & AS6200_CONFIG_POL_MASK)
> +					 >> AS6200_CONFIG_POL_SHIFT);
> +}
> +
> +static ssize_t as6200_show_cf(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	unsigned int reg_val =3D 0x00;
> +	int err =3D 0;
> +
> +	err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> +	if (err < 0)
> +		return err;
> +	reg_val =3D (reg_val & AS6200_CONFIG_CF_MASK) >> AS6200_CONFIG_CF_SHIFT=
;

could index into consec_faults array of strings to avoid the switch=20
statement?

> +	switch (reg_val) {
> +	case 0:
> +		return sprintf(buf, "1\n");
> +	case 1:
> +		return sprintf(buf, "2\n");
> +	case 2:
> +		return sprintf(buf, "4\n");
> +	case 3:
> +		return sprintf(buf, "6\n");
> +	}
> +	return sprintf(buf, "invalid\n");
> +}
> +
> +static ssize_t as6200_show_ss(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	unsigned int reg_val =3D 0x00;
> +	int err =3D 0;
> +
> +	err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> +	if (err < 0)
> +		return err;
> +	return sprintf(buf, "%hX\n", (reg_val & AS6200_CONFIG_SS_MASK)
> +					>> AS6200_CONFIG_SS_SHIFT);
> +}
> +
> +static ssize_t as6200_set_thigh(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	int err =3D 0;
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	struct i2c_client *client =3D data->client;
> +	s16 reg_val;
> +	int val;
> +
> +	err =3D kstrtoint(buf, 0, &val);
> +	if (err =3D=3D 0) {
> +		if ((val < -40) | (val > 150))

should be ||

> +			return count;
> +		val =3D (val * 10000) / 625;
> +		reg_val =3D val << 4;
> +		err =3D regmap_write(data->regmap, AS6200_REG_THIGH, reg_val);
> +		if (err < 0)
> +			return err;
> +	} else
> +		dev_info(&client->dev,

use dev_err if it is an error

> +			"Converting value for THIGH failed, err =3D %hx",
> +			err);
> +	return count;
> +}
> +
> +static ssize_t as6200_set_tlow(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	struct i2c_client *client =3D data->client;
> +	int err =3D 0;
> +	s16 reg_val;
> +	int val;
> +
> +	err =3D kstrtoint(buf, 0, &val);
> +	if (err =3D=3D 0) {
> +		if ((val < -40) | (val > 150)) {
> +			dev_info(&client->dev,
> +				"Value for THIGH is invalid min =3D -40%cC, max =3D 150=B0C, val =3D=
 %d=B0C",
> +				(unsigned char)(248), val);

this should return an error code I think, not count

> +			return count;
> +		}
> +		val =3D (val * 10000) / 625;
> +		reg_val =3D val << 4;
> +		err =3D regmap_write(data->regmap, AS6200_REG_TLOW, reg_val);
> +		if (err < 0)
> +			return err;
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for TLOW failed, err =3D %hx",
> +			err);
> +	return count;
> +}
> +
> +static ssize_t as6200_set_thigh_reg(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	int err =3D 0;
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	struct i2c_client *client =3D data->client;
> +	u16 reg_val;
> +
> +	err =3D kstrtou16(buf, 0, &reg_val);
> +	if (err =3D=3D 0) {
> +		err =3D regmap_write(data->regmap, AS6200_REG_THIGH, reg_val);
> +		if (err < 0)
> +			return err;
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for THIGH failed, err =3D %hx",
> +			err);
> +	return count;
> +}
> +
> +static ssize_t as6200_set_tlow_reg(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	struct i2c_client *client =3D data->client;
> +	int err =3D 0;
> +	u16 reg_val;
> +
> +	err =3D kstrtou16(buf, 0, &reg_val);
> +	if (err =3D=3D 0) {
> +		err =3D regmap_write(data->regmap, AS6200_REG_TLOW, reg_val);
> +		if (err < 0)
> +			return err;
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for TLOW failed, err =3D %hx",
> +			err);
> +	return count;
> +}
> +
> +static ssize_t as6200_set_configreg(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	struct i2c_client *client =3D data->client;
> +	int err =3D 0;
> +	u16 reg_val;

what sense makes a driver abstraction if you allow to set any value=20
imaginable anyways?

try to reduce code by splitting out common functions

> +
> +	err =3D kstrtou16(buf, 0, &reg_val);
> +	if (err =3D=3D 0) {
> +		err =3D regmap_write(data->regmap, AS6200_REG_CONFIG, reg_val);
> +		if (err < 0)
> +			return err;
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for CONFIG failed, err =3D %hx",
> +			err);
> +	return count;
> +}
> +

drop newline

> +
> +static ssize_t as6200_set_sm(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	struct i2c_client *client =3D data->client;
> +	int err;
> +	u16 val;
> +
> +	err =3D kstrtou16(buf, 0, &val);
> +	if (err =3D=3D 0) {
> +		err =3D regmap_update_bits(data->regmap, AS6200_REG_CONFIG,
> +			AS6200_CONFIG_SM_MASK, val << AS6200_CONFIG_SM_SHIFT);
> +		if (err < 0)
> +			return err;
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for SM field failed, err =3D %hx",
> +			err);
> +	return count;
> +}
> +
> +static ssize_t as6200_set_im(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	struct i2c_client *client =3D data->client;
> +	int err;
> +	u16 val;
> +
> +	err =3D kstrtou16(buf, 0, &val);
> +	if (err =3D=3D 0) {
> +		err =3D regmap_update_bits(data->regmap, AS6200_REG_CONFIG,
> +			AS6200_CONFIG_IM_MASK, val << AS6200_CONFIG_IM_SHIFT);
> +		if (err < 0)
> +			return err;
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for IM field failed, err =3D %hx",
> +			err);
> +	return count;
> +}
> +
> +static ssize_t as6200_set_pol(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	struct i2c_client *client =3D data->client;
> +	int err;
> +	u16 val;
> +
> +	err =3D kstrtou16(buf, 0, &val);
> +	if (err =3D=3D 0) {
> +		free_irq(client->irq, dev);
> +		err =3D regmap_update_bits(data->regmap, AS6200_REG_CONFIG,
> +			AS6200_CONFIG_POL_MASK,
> +			val << AS6200_CONFIG_POL_SHIFT);
> +		if (err < 0)

so irq is invalid here, but remove() would free it again?

> +			return err;
> +		as6200_setup_irq(indio_dev, false, val);
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for POL field failed, err =3D %hx",
> +			err);
> +	return count;
> +}
> +
> +static ssize_t as6200_set_cf(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	struct i2c_client *client =3D data->client;
> +	int err;
> +	u16 val;
> +
> +	err =3D kstrtou16(buf, 0, &val);
> +	if (err =3D=3D 0) {
> +		switch (val) {
> +		case 1:
> +		case 2:
> +		case 4:
> +		case 6:
> +			err =3D regmap_update_bits(data->regmap,
> +				AS6200_REG_CONFIG, AS6200_CONFIG_CF_MASK,
> +				val << AS6200_CONFIG_CF_SHIFT);
> +			if (err < 0)
> +				return err;
> +			break;
> +		default:
> +			dev_info(&client->dev,
> +				"Value for CF field invalid, val =3D %hx", val);
> +			return count;
> +		}
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for CF field failed, err =3D %hx",
> +			err);
> +	return count;
> +}
> +
> +static ssize_t as6200_set_ss(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +	struct as6200_data *data =3D iio_priv(indio_dev);
> +	struct i2c_client *client =3D data->client;
> +	int err;
> +	u16 val;
> +
> +	err =3D kstrtou16(buf, 0, &val);
> +	if (err =3D=3D 0) {
> +		err =3D regmap_update_bits(data->regmap, AS6200_REG_CONFIG,
> +			AS6200_CONFIG_SS_MASK, val << AS6200_CONFIG_SS_SHIFT);
> +		if (err < 0)
> +			return err;
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for SS field failed, err =3D %hx",
> +			err);
> +	return count;
> +}
> +
> +static IIO_DEVICE_ATTR(thigh, S_IWUSR | S_IRUGO, as6200_show_thigh,
> +	as6200_set_thigh, 0);
> +static IIO_DEVICE_ATTR(tlow, S_IWUSR | S_IRUGO, as6200_show_tlow,
> +	as6200_set_tlow, 0);
> +static IIO_DEVICE_ATTR(thigh_reg, S_IWUSR | S_IRUGO, as6200_show_thigh_r=
eg,
> +	as6200_set_thigh_reg, 0);
> +static IIO_DEVICE_ATTR(tlow_reg, S_IWUSR | S_IRUGO, as6200_show_tlow_reg=
,
> +	as6200_set_tlow_reg, 0);
> +static IIO_DEVICE_ATTR(config, S_IWUSR | S_IRUGO, as6200_show_config,
> +	as6200_set_configreg, 0);
> +static IIO_DEVICE_ATTR(al, S_IRUGO, as6200_show_al, NULL, 0);
> +static IIO_DEVICE_ATTR(sm, S_IWUSR | S_IRUGO, as6200_show_sm,
> +	as6200_set_sm, 0);
> +static IIO_DEVICE_ATTR(im, S_IWUSR | S_IRUGO, as6200_show_im,
> +	as6200_set_im, 0);
> +static IIO_DEVICE_ATTR(pol, S_IWUSR | S_IRUGO, as6200_show_pol,
> +	as6200_set_pol, 0);
> +static IIO_DEVICE_ATTR(cf, S_IWUSR | S_IRUGO, as6200_show_cf,
> +	as6200_set_cf, 0);
> +static IIO_DEVICE_ATTR(ss, S_IWUSR | S_IRUGO, as6200_show_ss,
> +	as6200_set_ss, 0);
> +
> +static IIO_CONST_ATTR(sampling_frequency_available, "4 1 0.25 0.125");
> +
> +static struct attribute *as6200_attrs[] =3D {
> +	&iio_dev_attr_thigh.dev_attr.attr,
> +	&iio_dev_attr_tlow.dev_attr.attr,
> +	&iio_dev_attr_thigh_reg.dev_attr.attr,
> +	&iio_dev_attr_tlow_reg.dev_attr.attr,
> +	&iio_dev_attr_config.dev_attr.attr,
> +	&iio_dev_attr_al.dev_attr.attr,
> +	&iio_dev_attr_sm.dev_attr.attr,
> +	&iio_dev_attr_im.dev_attr.attr,
> +	&iio_dev_attr_pol.dev_attr.attr,
> +	&iio_dev_attr_cf.dev_attr.attr,
> +	&iio_dev_attr_ss.dev_attr.attr,
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group as6200_attr_group =3D {
> +	.attrs =3D as6200_attrs,
> +};
> +
> +static const struct iio_chan_spec as6200_channels[] =3D {
> +	{
> +		.type =3D IIO_TEMP,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_PROCESSED) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	}
> +};
> +
> +static const struct iio_info as6200_info =3D {
> +	.read_raw =3D as6200_read_raw,
> +	.write_raw =3D as6200_write_raw,
> +	.attrs =3D &as6200_attr_group,
> +	.driver_module =3D THIS_MODULE,
> +};
> +
> +static int as6200_i2c_probe(struct i2c_client *client,
> +	const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct as6200_data *data;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client =3D client;
> +
> +	data->regmap =3D devm_regmap_init_i2c(client, &as6200_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		ret =3D PTR_ERR(data->regmap);
> +		dev_err(&client->dev, "regmap init failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	indio_dev->dev.parent =3D &client->dev;
> +	indio_dev->name =3D id->name;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->info =3D &as6200_info;
> +
> +	indio_dev->channels =3D as6200_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(as6200_channels);
> +
> +	ret =3D as6200_setup_irq(indio_dev, true, 0);
> +	if (ret < 0)

if setup_irq() fails, irq has not been requested and no cleanup is needed

> +		goto cleanup_irq;
> +
> +	return iio_device_register(indio_dev);

however, if iio_device_register() fails, the irq needs to be freed

> +
> +cleanup_irq:
> +	free_irq(client->irq, &client->dev);
> +
> +	return ret;
> +}
> +
> +static int as6200_i2c_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +	free_irq(client->irq, &client->dev);
> +	return 0;
> +}
> +
> +static const struct of_device_id as6200_of_match[] =3D {
> +	{ .compatible =3D "ams,as6200", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, as6200_of_match);
> +
> +
> +static const struct i2c_device_id as6200_i2c_id[] =3D {
> +	{ "as6200", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, as6200_id);
> +
> +static struct i2c_driver as6200_i2c_driver =3D {
> +	.driver =3D {
> +		.name =3D "as6200",
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D as6200_of_match,
> +	},
> +	.probe =3D as6200_i2c_probe,
> +	.remove =3D as6200_i2c_remove,
> +	.id_table =3D as6200_i2c_id,
> +};
> +
> +module_i2c_driver(as6200_i2c_driver);
> +
> +MODULE_DESCRIPTION("ams AS6200 temperature sensor");
> +MODULE_AUTHOR("Elitsa Polizoeva <elitsa.polizoeva@ams.com>");
> +MODULE_AUTHOR("Florian Lobmaier <florian.lobmaier@ams.com>");
> +MODULE_LICENSE("GPL");
>=20
> -----Original Message-----
> From: Peter Meerwald-Stadler [mailto:pmeerw@pmeerw.net]=20
> Sent: Dienstag, 21. Juni 2016 15:12
> To: Florian Lobmaier <Florian.Lobmaier@ams.com>
> Cc: jic23@kernel.org; Elitsa Polizoeva <Elitsa.Polizoeva@ams.com>; knaack=
.h@gmx.de; linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; Lars-Pe=
ter Clausen <lars@metafoo.de>
> Subject: RE: [PATCH V1 1/1] iio: as6200: add AS6200 temperature sensor dr=
iver from ams AG
>=20
>=20
> > Finally we got a Datasheet which we can release and share with you.=20
> > Thanks for the feedback, we tried to integrate most of the feedback in=
=20
> > the driver. Some proprietary API is still present as all features of=20
> > the chip should be reachable. If there are any features we could use=20
> > from the iio framework we overlooked, please let us know.
>=20
> can you provide a link to the datasheet? I almost missed the attached doc=
ument...
>=20
> more comments below, there still seems to be many issues; I stopped revie=
wing at some point where I noticed that previous comments have not beed add=
ressed
>=20
> thanks, regards, p.
>=20
> > Signed-off-by: Elitsa Polizoeva <elitsa.polizoeva@ams.com>
> > Signed-off-by: Florian Lobmaier <florian.lobmaier@ams.com>
> > ---
> > diff --git a/drivers/iio/temperature/Kconfig=20
> > b/drivers/iio/temperature/Kconfig index 21feaa4..d82e80f 100644
> > --- a/drivers/iio/temperature/Kconfig
> > +++ b/drivers/iio/temperature/Kconfig
> > @@ -3,6 +3,17 @@
> >  #
> >  menu "Temperature sensors"
> > =20
> > +config AS6200
> > +tristate "ams AG AS6200 temperature sensor"
> > +depends on I2C
> > +select REGMAP_I2C
> > +help
> > +  If you say yes here you get support for the AS6200 temperature
> > +  sensor from ams AG.
> > +
> > +  This driver can also be built as a module. If so, the module will =20
> > + be called as6200.
> > +
> >  config MLX90614
> >  tristate "MLX90614 contact-less infrared sensor"
> >  depends on I2C
> > diff --git a/drivers/iio/temperature/Makefile=20
> > b/drivers/iio/temperature/Makefile
> > index 40710a8..c0c9a9a 100644
> > --- a/drivers/iio/temperature/Makefile
> > +++ b/drivers/iio/temperature/Makefile
> > @@ -2,5 +2,6 @@
> >  # Makefile for industrial I/O temperature drivers  #
> > =20
> > +obj-$(CONFIG_AS6200) +=3D as6200.o
> >  obj-$(CONFIG_MLX90614) +=3D mlx90614.o
> >  obj-$(CONFIG_TMP006) +=3D tmp006.o
> > diff --git a/drivers/iio/temperature/as6200.c=20
> > b/drivers/iio/temperature/as6200.c
> > new file mode 100644
> > index 0000000..5e37227
> > --- /dev/null
> > +++ b/drivers/iio/temperature/as6200.c
> > @@ -0,0 +1,808 @@
>=20
> it is customary to put the GPL license statement here
>=20
> > +#include <linux/module.h>
> > +#include <linux/device.h>
> > +#include <linux/init.h>
> > +#include <linux/slab.h>
> > +#include <linux/i2c.h>
> > +#include <linux/err.h>
> > +#include <linux/types.h>
> > +#include <linux/irq.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/gpio.h>
> > +#include <linux/of_gpio.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/events.h>
> > +#include <linux/regmap.h>
> > +
> > +/* to support regmap define in version 3.12 */
> > +/* supported officially in kernel 3.13 and later */
>=20
> please remove these comments, not relevant for mainline and not a proper =
multi-line comment
>=20
> > +#define regmap_reg_range(low, high) { .range_min =3D low, .range_max =
=3D=20
> > +high, }
>=20
> as6200_ prefix needed
>=20
> > +
> > +static const int as6200_conv_rates[4][2] =3D { {4, 0}, {1, 0}, {0,=20
> > +250000}, {0, 125000} };
> > +
> > +static const char * const as6200_consec_faults[] =3D { "1", "2", "4",=
=20
> > +"6" };
> > +
> > +/* AS6200 registers */
> > +#define AS6200_REG_TVAL0x00
> > +#define AS6200_REG_CONFIG0x01
> > +#define AS6200_REG_TLOW0x02
> > +#define AS6200_REG_THIGH0x03
> > +#define AS6200_MAX_REGISTER0x03
> > +
> > +#define AS6200_CONFIG_DW_MASK0x0010
>=20
> could use GENMASK() or BIT() macros to make it clearer which bits are rel=
evant
>=20
> > +#define AS6200_CONFIG_DW_SHIFT4
> > +#define AS6200_CONFIG_AL_MASK0x0020
> > +#define AS6200_CONFIG_AL_SHIFT5
> > +#define AS6200_CONFIG_CR_MASK0x00C0
> > +#define AS6200_CONFIG_CR_SHIFT6
> > +#define AS6200_CONFIG_SM_MASK0x0100
> > +#define AS6200_CONFIG_SM_SHIFT8
> > +#define AS6200_CONFIG_IM_MASK0x0200
> > +#define AS6200_CONFIG_IM_SHIFT9
> > +#define AS6200_CONFIG_POL_MASK0x0400
> > +#define AS6200_CONFIG_POL_SHIFT10
> > +#define AS6200_CONFIG_CF_MASK0x1800
> > +#define AS6200_CONFIG_CF_SHIFT11
> > +#define AS6200_CONFIG_SS_MASK0x8000
> > +#define AS6200_CONFIG_SS_SHIFT15
> > +
> > +struct as6200_data {
> > +struct mutex update_lock;
>=20
> mutex used anywhere?
>=20
> > +struct i2c_client *client;
> > +int irqn;
> > +unsigned long irq_flags;
>=20
> irq_flags not used
>=20
> > +int gpio;
> > +char valid; /* !=3D0 if following fields are valid */ struct regmap=20
> > +*regmap; };
> > +
>=20
> drop newline
>=20
> > +
> > +static const struct regmap_range as6200_readable_ranges[] =3D {=20
> > +regmap_reg_range(AS6200_REG_TVAL, AS6200_REG_THIGH), };
>=20
> add newline (here and below: one newline please)
>=20
> > +static const struct regmap_access_table as6200_readable_table =3D {=20
> > +.yes_ranges =3D as6200_readable_ranges, .n_yes_ranges =3D=20
> > +ARRAY_SIZE(as6200_readable_ranges),
> > +};
> > +
> > +static const struct regmap_range as6200_writable_ranges[] =3D {=20
> > +regmap_reg_range(AS6200_REG_CONFIG, AS6200_REG_THIGH), }; static=20
> > +const struct regmap_access_table as6200_writable_table =3D {=20
> > +.yes_ranges =3D as6200_writable_ranges, .n_yes_ranges =3D=20
> > +ARRAY_SIZE(as6200_writable_ranges),
> > +};
> > +
> > +static const struct regmap_range as6200_volatile_ranges[] =3D {=20
> > +regmap_reg_range(AS6200_REG_TVAL, AS6200_REG_TVAL), }; static const=20
> > +struct regmap_access_table as6200_volatile_table =3D { .yes_ranges =3D=
=20
> > +as6200_volatile_ranges, .n_yes_ranges =3D=20
> > +ARRAY_SIZE(as6200_volatile_ranges),
> > +};
> > +static const struct regmap_config as6200_regmap_config =3D { .reg_bits=
=20
> > +=3D 8, .val_bits =3D 16, .max_register =3D AS6200_MAX_REGISTER, .cache=
_type=20
> > +=3D REGCACHE_RBTREE, .rd_table =3D &as6200_readable_table, .wr_table =
=3D=20
> > +&as6200_writable_table, .volatile_table =3D &as6200_volatile_table, };
> > +
> > +
> > +static int as6200_read_raw(struct iio_dev *indio_dev,
> > +    struct iio_chan_spec const *channel, int *val,
> > +    int *val2, long mask)
> > +{
> > +struct as6200_data *data =3D iio_priv(indio_dev); struct i2c_client=20
> > +*client =3D data->client; int err =3D 0; unsigned int reg_val =3D 0; i=
nt cr=20
> > +=3D 0;
> > +s32 ret =3D 0;
>=20
> try to avoid unnecessary initialization
>=20
> > +
> > +switch (mask) {
> > +case IIO_CHAN_INFO_RAW:
> > +if (channel->type =3D=3D IIO_TEMP) {
> > +err =3D regmap_read(data->regmap, AS6200_REG_TVAL, &reg_val);
>=20
> error checking?
>=20
> > +ret =3D reg_val;
> > +*val =3D sign_extend32(ret, 15) >> 4;
> > +} else {
> > +break;
> > +}
> > +return IIO_VAL_INT;
> > +case IIO_CHAN_INFO_PROCESSED:
> > +if (channel->type =3D=3D IIO_TEMP) {
> > +err =3D regmap_read(data->regmap, AS6200_REG_TVAL, &reg_val); ret =3D=
=20
> > +sign_extend32(ret, 15) >> 4; *val =3D (ret * 625) / 10000; } else {=20
> > +break; } return IIO_VAL_INT;
>=20
> I suggest to drop _INFO_PROCESSED as _RAW + _SCALE offers equivalent info=
rmation; _PROCESSED is not in the chan_spec?!
>=20
> otherwise, the code path are rather similar and could be combined
>=20
> > +case IIO_CHAN_INFO_SCALE:
> > +if (channel->type =3D=3D IIO_TEMP) {
> > +*val =3D 62;
> > +*val2 =3D 500000;
> > +} else {
> > +break;
> > +}
> > +return IIO_VAL_INT_PLUS_MICRO;
> > +case IIO_CHAN_INFO_SAMP_FREQ:
> > +if (channel->type =3D=3D IIO_TEMP) {
> > +dev_info(&client->dev, "get CR from reg");
>=20
> debug message, please remove
>=20
> > +err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val); cr =3D=
=20
> > +(reg_val & AS6200_CONFIG_CR_MASK)
> > +>> AS6200_CONFIG_CR_SHIFT;
> > +*val =3D as6200_conv_rates[cr][0];
> > +*val2 =3D as6200_conv_rates[cr][1];
> > +} else {
> > +break;
> > +}
> > +return IIO_VAL_INT_PLUS_MICRO;
> > +default:
> > +break;
> > +}
> > +return -EINVAL;
> > +}
> > +
> > +static int as6200_write_raw(struct iio_dev *indio_dev, struct=20
> > +iio_chan_spec const *chan, int val, int val2, long mask) { struct=20
> > +as6200_data *data =3D iio_priv(indio_dev); int i; unsigned int=20
> > +config_val;
> > +
> > +if (mask !=3D IIO_CHAN_INFO_SAMP_FREQ)
> > +return -EINVAL;
> > +
> > +for (i =3D 0; i < ARRAY_SIZE(as6200_conv_rates); i++) { if ((val =3D=
=3D=20
> > +as6200_conv_rates[i][0]) &&
> > +(val2 =3D=3D as6200_conv_rates[i][1])) {
> > +regmap_read(data->regmap,
> > +AS6200_REG_CONFIG, &config_val);
> > +config_val &=3D ~AS6200_CONFIG_CR_MASK; config_val |=3D i <<=20
> > +AS6200_CONFIG_CR_SHIFT;
> > +
> > +return regmap_write(data->regmap, AS6200_REG_CONFIG, config_val); } }=
=20
> > +return -EINVAL; }
> > +
> > +static irqreturn_t as6200_alert_isr(int irq, void *dev_id) { struct=20
> > +iio_dev *indio_dev =3D dev_id;
> > +
> > +iio_push_event(indio_dev,
> > +IIO_UNMOD_EVENT_CODE(IIO_TEMP,
> > +0,
> > +IIO_EV_TYPE_THRESH,
> > +IIO_EV_DIR_EITHER),
> > +iio_get_time_ns());
> > +return IRQ_HANDLED;
> > +}
> > +
> > +static int as6200_setup_irq(struct iio_dev *indio_dev, bool set_gpio,=
=20
> > +u8 pol) { int err; struct as6200_data *data =3D iio_priv(indio_dev);=20
> > +struct device *dev =3D &data->client->dev; int gpio =3D -1; int irq_nu=
m;=20
> > +int irq_trig;
> > +
> > +if (pol =3D=3D 1)
> > +irq_trig =3D IRQF_TRIGGER_RISING;
> > +else
> > +irq_trig =3D IRQF_TRIGGER_FALLING;
> > +
> > +if (set_gpio) {
> > +gpio =3D of_get_named_gpio_flags(dev->of_node,
> > +"as6200,irq-gpio", 0, 0);
> > +err =3D gpio_request(gpio, "as6200_irq"); if (err) { dev_err(dev,=20
> > +"requesting gpio %d failed\n", gpio); return err; } err =3D=20
> > +gpio_direction_input(gpio); if (err) { dev_err(dev, "gpio %d cannot=20
> > +apply direction\n", gpio); return err; } }
> > +data->gpio =3D gpio;
> > +irq_num =3D gpio_to_irq(gpio);
> > +err =3D request_irq(irq_num, as6200_alert_isr, irq_trig, "as6200",=20
> > +dev); if (err) { dev_err(dev, "error requesting irq %d\n", err);=20
> > +return err; }
> > +data->irqn =3D irq_num;
> > +
> > +return 0;
> > +}
> > +
> > +static ssize_t as6200_show_thigh(struct device *dev, struct=20
> > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev =3D=20
> > +dev_to_iio_dev(dev); struct as6200_data *data =3D iio_priv(indio_dev);=
=20
> > +unsigned int reg_val =3D 0; int err =3D 0; int val;
> > +
> > +err =3D regmap_read(data->regmap, AS6200_REG_THIGH, &reg_val); reg_val=
=20
> > +=3D reg_val >> 4; val =3D (625 * reg_val) / 10000; return sprintf(buf,=
=20
> > +"%d%cC\n", val, (unsigned char)(248)); }
> > +
> > +static ssize_t as6200_show_tlow(struct device *dev, struct=20
> > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev =3D=20
> > +dev_to_iio_dev(dev); struct as6200_data *data =3D iio_priv(indio_dev);=
=20
> > +unsigned int reg_val =3D 0x00; int err =3D 0; int val;
> > +
> > +err =3D regmap_read(data->regmap, AS6200_REG_TLOW, &reg_val); reg_val =
=3D=20
> > +reg_val >> 4; val =3D (625 * reg_val) / 10000; return sprintf(buf,=20
> > +"%d%cC\n", val, (unsigned char)(248)); }
> > +
> > +static ssize_t as6200_show_thigh_reg(struct device *dev, struct=20
> > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev =3D=20
> > +dev_to_iio_dev(dev); struct as6200_data *data =3D iio_priv(indio_dev);=
=20
> > +unsigned int reg_val =3D 0; int err =3D 0;
> > +
> > +err =3D regmap_read(data->regmap, AS6200_REG_THIGH, &reg_val); return=
=20
> > +sprintf(buf, "%hX\n", reg_val); }
> > +
> > +static ssize_t as6200_show_tlow_reg(struct device *dev, struct=20
> > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev =3D=20
> > +dev_to_iio_dev(dev); struct as6200_data *data =3D iio_priv(indio_dev);=
=20
> > +unsigned int reg_val =3D 0x00; int err =3D 0;
> > +
> > +err =3D regmap_read(data->regmap, AS6200_REG_TLOW, &reg_val); return=20
> > +sprintf(buf, "%hX\n", reg_val); }
> > +
> > +static ssize_t as6200_show_config(struct device *dev, struct=20
> > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev =3D=20
> > +dev_to_iio_dev(dev); struct as6200_data *data =3D iio_priv(indio_dev);=
=20
> > +unsigned int reg_val =3D 0x00; int err =3D 0;
> > +
> > +err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val); return=
=20
> > +sprintf(buf, "%hX\n", reg_val); }
> > +
> > +static ssize_t as6200_show_al(struct device *dev, struct=20
> > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev =3D=20
> > +dev_to_iio_dev(dev); struct as6200_data *data =3D iio_priv(indio_dev);=
=20
> > +unsigned int reg_val =3D 0x00; int err =3D 0;
> > +u16 pol =3D 0;
> > +
> > +err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val); pol =
=3D=20
> > +(reg_val & AS6200_CONFIG_POL_MASK) >> AS6200_CONFIG_POL_SHIFT;=20
> > +reg_val =3D (reg_val & AS6200_CONFIG_AL_MASK) >>=20
> > +AS6200_CONFIG_AL_SHIFT; if (pol =3D=3D 1) { if (reg_val =3D=3D 0) retu=
rn=20
> > +sprintf(buf, "off\n"); else if (reg_val =3D=3D 1) return sprintf(buf,=
=20
> > +"on\n"); else return sprintf(buf, "invalid\n"); } else if (pol =3D=3D =
0)=20
> > +{ if (reg_val =3D=3D 0) return sprintf(buf, "on\n"); else if (reg_val =
=3D=3D=20
> > +1) return sprintf(buf, "off\n"); else return sprintf(buf,=20
> > +"invalid\n"); } else return sprintf(buf, "invalid\n"); }
> > +
> > +static ssize_t as6200_show_sm(struct device *dev, struct=20
> > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev =3D=20
> > +dev_to_iio_dev(dev); struct as6200_data *data =3D iio_priv(indio_dev);=
=20
> > +unsigned int reg_val =3D 0x00; int err =3D 0;
> > +
> > +err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val); return=
=20
> > +sprintf(buf, "%hX\n", (reg_val & AS6200_CONFIG_SM_MASK)
> > +>> AS6200_CONFIG_SM_SHIFT);
> > +}
> > +
> > +static ssize_t as6200_show_im(struct device *dev, struct=20
> > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev =3D=20
> > +dev_to_iio_dev(dev); struct as6200_data *data =3D iio_priv(indio_dev);=
=20
> > +unsigned int reg_val =3D 0x00; int err =3D 0;
> > +
> > +err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val); return=
=20
> > +sprintf(buf, "%hX\n", (reg_val & AS6200_CONFIG_IM_MASK)
> > +>> AS6200_CONFIG_IM_SHIFT);
> > +}
> > +
> > +static ssize_t as6200_show_pol(struct device *dev, struct=20
> > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev =3D=20
> > +dev_to_iio_dev(dev); struct as6200_data *data =3D iio_priv(indio_dev);=
=20
> > +unsigned int reg_val =3D 0x00; int err =3D 0;
> > +
> > +err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val); return=
=20
> > +sprintf(buf, "%hX\n", (reg_val & AS6200_CONFIG_POL_MASK)
> > + >> AS6200_CONFIG_POL_SHIFT);
> > +}
> > +
> > +static ssize_t as6200_show_cf(struct device *dev, struct=20
> > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev =3D=20
> > +dev_to_iio_dev(dev); struct as6200_data *data =3D iio_priv(indio_dev);=
=20
> > +unsigned int reg_val =3D 0x00; int err =3D 0;
> > +
> > +err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val); reg_va=
l=20
> > +=3D (reg_val & AS6200_CONFIG_CF_MASK) >> AS6200_CONFIG_CF_SHIFT; switc=
h=20
> > +(reg_val) { case 0:
> > +return sprintf(buf, "1\n");
> > +case 1:
> > +return sprintf(buf, "2\n");
> > +case 2:
> > +return sprintf(buf, "4\n");
> > +case 3:
> > +return sprintf(buf, "6\n");
> > +}
> > +return sprintf(buf, "invalid\n");
> > +}
> > +
> > +static ssize_t as6200_show_ss(struct device *dev, struct=20
> > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev =3D=20
> > +dev_to_iio_dev(dev); struct as6200_data *data =3D iio_priv(indio_dev);=
=20
> > +unsigned int reg_val =3D 0x00; int err =3D 0;
> > +
> > +err =3D regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val); return=
=20
> > +sprintf(buf, "%hX\n", (reg_val & AS6200_CONFIG_SS_MASK)
> > +>> AS6200_CONFIG_SS_SHIFT);
> > +}
> > +
> > +static ssize_t as6200_set_thigh(struct device *dev, struct=20
> > +device_attribute *attr, const char *buf, size_t count) { int err =3D 0=
;=20
> > +struct iio_dev *indio_dev =3D dev_to_iio_dev(dev); struct as6200_data=
=20
> > +*data =3D iio_priv(indio_dev); struct i2c_client *client =3D=20
> > +data->client;
> > +s16 reg_val;
> > +int val;
> > +
> > +err =3D kstrtoint(buf, 0, &val);
> > +if (err =3D=3D 0) {
> > +if ((val < -40) | (val > 150))
> > +return count;
> > +val =3D (val * 10000) / 625;
> > +reg_val =3D val << 4;
> > +err =3D regmap_write(data->regmap, AS6200_REG_THIGH, reg_val); } else=
=20
> > +dev_info(&client->dev, "Converting value for THIGH failed, err =3D=20
> > +%hx", err); return count; }
> > +
> > +static ssize_t as6200_set_tlow(struct device *dev, struct=20
> > +device_attribute *attr, const char *buf, size_t count) { struct=20
> > +iio_dev *indio_dev =3D dev_to_iio_dev(dev); struct as6200_data *data =
=3D=20
> > +iio_priv(indio_dev); struct i2c_client *client =3D data->client; int=20
> > +err =3D 0;
> > +s16 reg_val;
> > +int val;
> > +
> > +err =3D kstrtoint(buf, 0, &val);
> > +if (err =3D=3D 0) {
> > +if ((val < -40) | (val > 150)) {
> > +dev_info(&client->dev,
> > +"Value for THIGH is invalid min =3D -40%cC, max =3D 150=B0C, val =3D %=
d=B0C",=20
> > +(unsigned char)(248), val); return count; } val =3D (val * 10000) /=20
> > +625; reg_val =3D val << 4; err =3D regmap_write(data->regmap,=20
> > +AS6200_REG_TLOW, reg_val); } else dev_info(&client->dev, "Converting=20
> > +value for TLOW failed, err =3D %hx", err); return count; }
> > +
> > +static ssize_t as6200_set_thigh_reg(struct device *dev, struct=20
> > +device_attribute *attr, const char *buf, size_t count) { int err =3D 0=
;=20
> > +struct iio_dev *indio_dev =3D dev_to_iio_dev(dev); struct as6200_data=
=20
> > +*data =3D iio_priv(indio_dev); struct i2c_client *client =3D=20
> > +data->client;
> > +u16 reg_val;
> > +
> > +err =3D kstrtou16(buf, 0, &reg_val);
> > +if (err =3D=3D 0)
> > +err =3D regmap_write(data->regmap, AS6200_REG_THIGH, reg_val); else=20
> > +dev_info(&client->dev, "Converting value for THIGH failed, err =3D=20
> > +%hx", err); return count; }
> > +
> > +static ssize_t as6200_set_tlow_reg(struct device *dev, struct=20
> > +device_attribute *attr, const char *buf, size_t count) { struct=20
> > +iio_dev *indio_dev =3D dev_to_iio_dev(dev); struct as6200_data *data =
=3D=20
> > +iio_priv(indio_dev); struct i2c_client *client =3D data->client; int=20
> > +err =3D 0;
> > +u16 reg_val;
> > +
> > +err =3D kstrtou16(buf, 0, &reg_val);
> > +if (err =3D=3D 0)
> > +err =3D regmap_write(data->regmap, AS6200_REG_TLOW, reg_val); else=20
> > +dev_info(&client->dev, "Converting value for TLOW failed, err =3D %hx"=
,=20
> > +err); return count; }
> > +
> > +static ssize_t as6200_set_configreg(struct device *dev, struct=20
> > +device_attribute *attr, const char *buf, size_t count) { struct=20
> > +iio_dev *indio_dev =3D dev_to_iio_dev(dev); struct as6200_data *data =
=3D=20
> > +iio_priv(indio_dev); struct i2c_client *client =3D data->client; int=20
> > +err =3D 0;
> > +u16 reg_val;
> > +
> > +err =3D kstrtou16(buf, 0, &reg_val);
> > +if (err =3D=3D 0)
> > +err =3D regmap_write(data->regmap, AS6200_REG_CONFIG, reg_val); else=20
> > +dev_info(&client->dev, "Converting value for CONFIG failed, err =3D=20
> > +%hx", err); return count; }
> > +
> > +
> > +static ssize_t as6200_set_sm(struct device *dev, struct=20
> > +device_attribute *attr, const char *buf, size_t count) { struct=20
> > +iio_dev *indio_dev =3D dev_to_iio_dev(dev); struct as6200_data *data =
=3D=20
> > +iio_priv(indio_dev); struct i2c_client *client =3D data->client; int=20
> > +err;
> > +u16 val;
> > +
> > +err =3D kstrtou16(buf, 0, &val);
> > +if (err =3D=3D 0) {
> > +err =3D regmap_update_bits(data->regmap, AS6200_REG_CONFIG,=20
> > +AS6200_CONFIG_SM_MASK, val << AS6200_CONFIG_SM_SHIFT); } else=20
> > +dev_info(&client->dev, "Converting value for SM field failed, err =3D=
=20
> > +%hx", err); return count; }
> > +
> > +static ssize_t as6200_set_im(struct device *dev, struct=20
> > +device_attribute *attr, const char *buf, size_t count) { struct=20
> > +iio_dev *indio_dev =3D dev_to_iio_dev(dev); struct as6200_data *data =
=3D=20
> > +iio_priv(indio_dev); struct i2c_client *client =3D data->client; int=20
> > +err;
> > +u16 val;
> > +
> > +err =3D kstrtou16(buf, 0, &val);
> > +if (err =3D=3D 0) {
> > +err =3D regmap_update_bits(data->regmap, AS6200_REG_CONFIG,=20
> > +AS6200_CONFIG_IM_MASK, val << AS6200_CONFIG_IM_SHIFT); } else=20
> > +dev_info(&client->dev, "Converting value for IM field failed, err =3D=
=20
> > +%hx", err); return count; }
> > +
> > +static ssize_t as6200_set_pol(struct device *dev, struct=20
> > +device_attribute *attr, const char *buf, size_t count) { struct=20
> > +iio_dev *indio_dev =3D dev_to_iio_dev(dev); struct as6200_data *data =
=3D=20
> > +iio_priv(indio_dev); struct i2c_client *client =3D data->client; int=20
> > +err; int irq_num =3D data->irqn;
> > +u16 val;
> > +
> > +err =3D kstrtou16(buf, 0, &val);
> > +if (err =3D=3D 0) {
> > +free_irq(irq_num, dev);
> > +err =3D regmap_update_bits(data->regmap, AS6200_REG_CONFIG,=20
> > +AS6200_CONFIG_POL_MASK, val << AS6200_CONFIG_POL_SHIFT);=20
> > +as6200_setup_irq(indio_dev, false, val); } else=20
> > +dev_info(&client->dev, "Converting value for POL field failed, err =3D=
=20
> > +%hx", err); return count; }
> > +
> > +static ssize_t as6200_set_cf(struct device *dev, struct=20
> > +device_attribute *attr, const char *buf, size_t count) { struct=20
> > +iio_dev *indio_dev =3D dev_to_iio_dev(dev); struct as6200_data *data =
=3D=20
> > +iio_priv(indio_dev); struct i2c_client *client =3D data->client; int=20
> > +err;
> > +u16 val;
> > +
> > +err =3D kstrtou16(buf, 0, &val);
> > +if (err =3D=3D 0) {
> > +switch (val) {
> > +case 1:
> > +case 2:
> > +case 4:
> > +case 6:
> > +err =3D regmap_update_bits(data->regmap, AS6200_REG_CONFIG,=20
> > +AS6200_CONFIG_CF_MASK, val << AS6200_CONFIG_CF_SHIFT); break;
> > +default:
> > +dev_info(&client->dev,
> > +"Value for CF field invalid, val =3D %hx", val); return count; } } els=
e=20
> > +dev_info(&client->dev, "Converting value for CF field failed, err =3D=
=20
> > +%hx", err); return count; }
> > +
> > +static ssize_t as6200_set_ss(struct device *dev, struct=20
> > +device_attribute *attr, const char *buf, size_t count) { struct=20
> > +iio_dev *indio_dev =3D dev_to_iio_dev(dev); struct as6200_data *data =
=3D=20
> > +iio_priv(indio_dev); struct i2c_client *client =3D data->client; int=20
> > +err;
> > +u16 val;
> > +
> > +err =3D kstrtou16(buf, 0, &val);
> > +if (err =3D=3D 0) {
> > +err =3D regmap_update_bits(data->regmap, AS6200_REG_CONFIG,=20
> > +AS6200_CONFIG_SS_MASK, val << AS6200_CONFIG_SS_SHIFT); } else=20
> > +dev_info(&client->dev, "Converting value for SS field failed, err =3D=
=20
> > +%hx", err); return count; }
> > +
> > +static IIO_DEVICE_ATTR(thigh, S_IWUSR | S_IRUGO, as6200_show_thigh,=20
> > +as6200_set_thigh, 0); static IIO_DEVICE_ATTR(tlow, S_IWUSR | S_IRUGO,=
=20
> > +as6200_show_tlow, as6200_set_tlow, 0); static=20
> > +IIO_DEVICE_ATTR(thigh_reg, S_IWUSR | S_IRUGO, as6200_show_thigh_reg,=20
> > +as6200_set_thigh_reg, 0); static IIO_DEVICE_ATTR(tlow_reg, S_IWUSR |=20
> > +S_IRUGO, as6200_show_tlow_reg, as6200_set_tlow_reg, 0); static=20
> > +IIO_DEVICE_ATTR(config, S_IWUSR | S_IRUGO, as6200_show_config,=20
> > +as6200_set_configreg, 0); static IIO_DEVICE_ATTR(al, S_IRUGO,=20
> > +as6200_show_al, NULL, 0); static IIO_DEVICE_ATTR(sm, S_IWUSR |=20
> > +S_IRUGO, as6200_show_sm, as6200_set_sm, 0); static=20
> > +IIO_DEVICE_ATTR(im, S_IWUSR | S_IRUGO, as6200_show_im, as6200_set_im,=
=20
> > +0); static IIO_DEVICE_ATTR(pol, S_IWUSR | S_IRUGO, as6200_show_pol,=20
> > +as6200_set_pol, 0); static IIO_DEVICE_ATTR(cf, S_IWUSR | S_IRUGO,=20
> > +as6200_show_cf, as6200_set_cf, 0); static IIO_DEVICE_ATTR(ss, S_IWUSR=
=20
> > +| S_IRUGO, as6200_show_ss, as6200_set_ss, 0);
> > +
> > +static IIO_CONST_ATTR(sampling_frequency_available, "4 1 0.25=20
> > +0.125");
> > +
> > +static struct attribute *as6200_attrs[] =3D {=20
> > +&iio_dev_attr_thigh.dev_attr.attr,
> > +&iio_dev_attr_tlow.dev_attr.attr,
> > +&iio_dev_attr_thigh_reg.dev_attr.attr,
> > +&iio_dev_attr_tlow_reg.dev_attr.attr,
> > +&iio_dev_attr_config.dev_attr.attr,
> > +&iio_dev_attr_al.dev_attr.attr,
> > +&iio_dev_attr_sm.dev_attr.attr,
> > +&iio_dev_attr_im.dev_attr.attr,
> > +&iio_dev_attr_pol.dev_attr.attr,
> > +&iio_dev_attr_cf.dev_attr.attr,
> > +&iio_dev_attr_ss.dev_attr.attr,
> > +&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> > +NULL,
> > +};
> > +
> > +static struct attribute_group as6200_attr_group =3D { .attrs =3D=20
> > +as6200_attrs, };
> > +
> > +static const struct iio_chan_spec as6200_channels[] =3D { { .type =3D=
=20
> > +IIO_TEMP, .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |=20
> > +BIT(IIO_CHAN_INFO_SCALE), .info_mask_shared_by_type =3D=20
> > +BIT(IIO_CHAN_INFO_SAMP_FREQ), } };
> > +
> > +static const struct iio_info as6200_info =3D { .read_raw =3D=20
> > +as6200_read_raw, .write_raw =3D as6200_write_raw, .attrs =3D=20
> > +&as6200_attr_group, .driver_module =3D THIS_MODULE, };
> > +
> > +static int as6200_i2c_of_probe(struct i2c_client *i2c, struct=20
> > +as6200_data *as6200) { struct device_node *np =3D i2c->dev.of_node;=20
> > +struct irq_data *irq_data;
> > +
> > +if (!np) {
> > +dev_err(&i2c->dev, "Device Tree not found\n"); return -EINVAL; }
> > +
> > +irq_data =3D irq_get_irq_data(i2c->irq);
>=20
> what is this good for?
>=20
> > +if (!irq_data) {
> > +dev_err(&i2c->dev, "Invalid IRQ: %d\n", i2c->irq); return -EINVAL; }
> > +
> > +as6200->irq_flags =3D irqd_get_trigger_type(irq_data);
> > +dev_dbg(&i2c->dev, "IRQ flags are 0x%08lx\n", as6200->irq_flags);=20
> > +return 0; }
> > +
> > +static int as6200_i2c_probe(struct i2c_client *client, const struct=20
> > +i2c_device_id *id) { struct iio_dev *indio_dev; struct as6200_data=20
> > +*data; int ret;
> > +
> > +indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data)); if=20
> > +(!indio_dev) return -ENOMEM;
> > +
> > +data =3D iio_priv(indio_dev);
> > +i2c_set_clientdata(client, indio_dev);
> > +data->client =3D client;
> > +
> > +ret =3D as6200_i2c_of_probe(client, data); if (ret < 0) return ret;
> > +
> > +data->regmap =3D devm_regmap_init_i2c(client, &as6200_regmap_config);
> > +if (IS_ERR(data->regmap)) {
> > +ret =3D PTR_ERR(data->regmap);
> > +dev_err(&client->dev, "regmap init failed: %d\n", ret); return ret; }
> > +
> > +indio_dev->dev.parent =3D &client->dev; indio_dev->name =3D id->name;=
=20
> > +indio_dev->modes =3D INDIO_DIRECT_MODE; indio_dev->info =3D &as6200_in=
fo;
> > +
> > +indio_dev->channels =3D as6200_channels; indio_dev->num_channels =3D=20
> > +ARRAY_SIZE(as6200_channels);
> > +
> > +mutex_init(&data->update_lock);
> > +ret =3D as6200_setup_irq(indio_dev, true, 0);
> > +
>=20
> no newline here
>=20
> > +if (ret < 0)
> > +goto cleanup_gpio_irq;
> > +
> > +return iio_device_register(indio_dev);
> > +
> > +cleanup_gpio_irq:
> > +free_irq(data->irqn, &client->dev);
> > +gpio_free(data->gpio);
> > +
> > +return ret;
> > +}
> > +
> > +static int as6200_i2c_remove(struct i2c_client *client) { struct=20
> > +iio_dev *indio_dev; struct as6200_data *data;
> > +
> > +indio_dev =3D i2c_get_clientdata(client); data =3D iio_priv(indio_dev)=
;
>=20
> most drivers do that via initialization, not assignment for conciseness
>=20
> > +
> > +iio_device_unregister(indio_dev);
> > +free_irq(data->irqn, &client->dev);
> > +gpio_free(data->gpio);
> > +return 0;
> > +}
> > +
> > +static const struct of_device_id as6200_of_match[] =3D { { .compatible=
=20
> > +=3D "ams,as6200", }, {}, }; MODULE_DEVICE_TABLE(of, as6200_of_match);
> > +
> > +
> > +static const struct i2c_device_id as6200_i2c_id[] =3D { { "as6200", 0=
=20
> > +}, { } }; MODULE_DEVICE_TABLE(i2c, as6200_id);
> > +
> > +static struct i2c_driver as6200_i2c_driver =3D { .driver =3D { .name =
=3D=20
> > +"as6200", .owner =3D THIS_MODULE, .of_match_table =3D as6200_of_match,=
 },=20
> > +.probe =3D as6200_i2c_probe, .remove =3D as6200_i2c_remove, .id_table =
=3D=20
> > +as6200_i2c_id, };
> > +
> > +module_i2c_driver(as6200_i2c_driver);
> > +
> > +MODULE_DESCRIPTION("ams AS6200 temperature sensor");=20
> > +MODULE_AUTHOR("Elitsa Polizoeva <elitsa.polizoeva@ams.com>");=20
> > +MODULE_AUTHOR("Florian Lobmaier <florian.lobmaier@ams.com>");=20
> > +MODULE_LICENSE("GPL");
> >=20
> > -----Original Message-----
> > From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> > Sent: Dienstag, 10. November 2015 12:52
> > To: Florian Lobmaier <Florian.Lobmaier@ams.com>; jic23@kernel.org
> > Cc: Elitsa Polizoeva <Elitsa.Polizoeva@ams.com>; knaack.h@gmx.de;=20
> > pmeerw@pmeerw.net; linux-kernel@vger.kernel.org;=20
> > linux-iio@vger.kernel.org
> > Subject: Re: [PATCH V1 1/1] iio: as6200: add AS6200 temperature sensor=
=20
> > driver from ams AG
> >=20
> > On 11/10/2015 10:38 AM, Florian Lobmaier wrote:
> > > The AS6200 is a compact temperature sensor chip with I2C interface.
> > >=20
> > > Add a driver to support the AS6200 temperature sensor.
> > >=20
> > > Signed-off-by: Elitsa Polizoeva <elitsa.polizoeva@ams.com>
> > > Signed-off-by: Florian Lobmaier <florian.lobmaier@ams.com>
> >=20
> > Hi,
> >=20
> > Thanks for the patch.
> >=20
> > As Peter already said this patch introduces a lot of custom ABI, none o=
f which is documented and most of which is probably not acceptable since. T=
he whole idea of a framework is that you expose the capabilities of a devic=
e through a standard device independent ABI, this allows to write generic a=
pplications and libraries that can manage the devices through this ABI.
> > This allows to leverage existing developments rather than starting from=
 scratch each time. If your device uses a complete custom ABI there is not =
much point of having a driver in the first place since any application need=
s device specific knowledge anyway to talk to the driver, in this case you =
could just directly implement the I2C communication in the application.
> >=20
> > Please also consider reading and following Documentation/CodingStyle
> >=20
> > [...]
> > > +static int as6200_read_reg(struct i2c_client *client,
> > > +u8 reg_num, u16 *reg_val)
> > > +{
> > > +int err =3D 0;
> > > +char tx_buf[1];
> > > +char rx_buf[2];
> > > +
> > > +if ((reg_num >=3D 0) & (reg_num <=3D 3)) { tx_buf[0] =3D reg_num; er=
r =3D=20
> > > +i2c_master_send(client, tx_buf, 1); if (err =3D=3D 1) err =3D=20
> > > +i2c_master_recv(client, rx_buf, 2);
> >=20
> > This is not thread safe. Another thread could interrupt between
> > i2c_master_send() and i2c_master_recv() and cause undefined behavior.=20
> > Use
> > i2c_smbus_read_word_swapped() which makes sure that the I2C communicati=
on happens atomically.
> >=20
> > > +if (err =3D=3D 2) {
> > > +*reg_val =3D rx_buf[0];
> > > +*reg_val =3D *reg_val << 8;
> > > +*reg_val =3D *reg_val | rx_buf[1];
> > > +}
> > > +return err;
> > > +} else {
> > > +return -EINVAL;
> > > +}
> > > +}
> > [...]
> > > +
> > > +static irqreturn_t alert_isr(int irq, void *dev_id) {=20
> > > +dev_warn(dev_id, "Temperature outside of limits!");
> >=20
> > Please use IIO threshold events for this. Such out-of-band communicatio=
n is really not acceptable.
> >=20
> > > +return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int setupIRQ(struct iio_dev *indio_dev, bool set_gpio, u8=20
> > > +pol) { int err; struct as6200_data *data =3D iio_priv(indio_dev);=20
> > > +struct device *dev =3D &data->client->dev; int gpio =3D -1; int=20
> > > +irq_num; int irq_trig;
> > > +
> > > +if (pol =3D=3D 1)
> > > +irq_trig =3D IRQF_TRIGGER_RISING;
> > > +else
> > > +irq_trig =3D IRQF_TRIGGER_FALLING;
> > > +
> > > +if (set_gpio) {
> > > +gpio =3D of_get_named_gpio_flags(dev->of_node,
> > > +"as6200,irq-gpio", 0, 0);
> > > +err =3D gpio_request(gpio, "as6200_irq"); if (err) { dev_info(dev, "=
%s:=20
> > > +requesting gpio %d failed\n", as6200_id[0].name, gpio); return err;=
=20
> > > +} err =3D gpio_direction_input(gpio); if (err) { dev_info(dev, "%s:=
=20
> > > +gpio %d cannot apply direction\n", as6200_id[0].name, gpio); return=
=20
> > > +err; } } irq_num =3D gpio_to_irq(gpio); dev_info(dev, "%s:=20
> > > +registering for IRQ %d\n", as6200_id[0].name, irq_num);
> >=20
> > Please drop all these dev_info(). That's just noise in the boot log, im=
agine every driver did this you wouldn't be able to spot the critical infor=
mation.
> >=20
> > > +err =3D request_irq(irq_num, alert_isr, irq_trig, as6200_id[0].name,=
=20
> > > +dev);
> >=20
> > Don't do all the GPIO translation. This pin is only used as a interrupt=
, so specify it directly as an interrupt and use it that way as well.
> >=20
> > > +if (err) {
> > > +dev_info(dev, "%s: error requesting irq %d\n", as6200_id[0].name,=20
> > > +err);
> >=20
> > For errors use dev_err. Also the as6200_id[0].name is redundant since d=
ev_info/dev_err already prefixes the message with the device name.
> >=20
> > > +return err;
> > > +}
> > > +dev_info(dev, "%s: registered for IRQ %d\n", as6200_id[0].name,=20
> > > +irq_num); mutex_lock(&data->update_lock);
> > > +data->irqn =3D irq_num;
> > > +mutex_unlock(&data->update_lock);
> >=20
> > What exactly is protect by that mutex here?
> >=20
> > > +
> > > +return 0;
> > > +}
> > > +
> > [...]
> > > +if (err =3D=3D 0) {
> > > +if ((val < -40) | (val > 150)) {
> > > +dev_info(&client->dev,
> > > +"Value for THIGH is invalid min =3D -40%cC, max =3D 150=B0C, val =3D=
 %d=B0C",=20
> > > +(unsigned char)(248), val);
> >=20
> > Please no out-of-band error reporting.
> >=20
> > > +return count;
> > > +}
> > > +val =3D (val * 10000) / 625;
> > > +reg_val =3D val << 4;
> > [...]
> > > +static int as6200_probe(struct i2c_client *client, const struct=20
> > > +i2c_device_id *id) { struct iio_dev *indio_dev =3D NULL; struct=20
> > > +as6200_data *data =3D NULL;
> >=20
> > No need to initialize those here with dummy, this will just hide warnin=
gs in case you forgot to initialize them with actual data.
> >=20
> > > +
> > > +indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> > > +
> > > +if (!indio_dev)
> > > +return -ENOMEM;
> > > +
> > > +data =3D iio_priv(indio_dev);
> > > +i2c_set_clientdata(client, indio_dev);
> > > +data->client =3D client;
> > > +
> > > +indio_dev->dev.parent =3D &client->dev; indio_dev->name =3D=20
> > > +dev_name(&client->dev);
> >=20
> > use id->name for this. dev_name() contains things like the I2C bus and =
device address, etc. Whereas the IIO device name should describe the type o=
f device.
> >=20
> > > +indio_dev->modes =3D INDIO_DIRECT_MODE; indio_dev->info =3D=20
> > > +&as6200_info;
> > > +
> > > +indio_dev->channels =3D as6200_channels; indio_dev->num_channels =3D=
=20
> > > +ARRAY_SIZE(as6200_channels);
> > > +
> > > +initClientData(data);
> > > +mutex_init(&data->update_lock);
> > > +setupIRQ(indio_dev, true, 0);
> > > +
> > > +return iio_device_register(indio_dev);
> >=20
> > Error handling is missing here, you need to free the resources that wer=
e acquired in case of an error.
> >=20
> > > +}
> > > +
> > [...]
> >=20
> >=20
> >=20
>=20
>=20

--=20

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
