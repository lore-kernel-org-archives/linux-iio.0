Return-Path: <Florian.Lobmaier@ams.com>
From: Florian Lobmaier <Florian.Lobmaier@ams.com>
To: "jic23@kernel.org" <jic23@kernel.org>
CC: Elitsa Polizoeva <Elitsa.Polizoeva@ams.com>, "knaack.h@gmx.de"
	<knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net"
	<pmeerw@pmeerw.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: [PATCH V1 1/1] iio: as6200: add AS6200 temperature sensor driver from
 ams AG
Date: Tue, 10 Nov 2015 09:38:54 +0000
Message-ID: <09675593925c4a6c99982b21fae3640a@SUX5071.office.amsiag.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

The AS6200 is a compact temperature sensor chip with I2C interface.

Add a driver to support the AS6200 temperature sensor.

Signed-off-by: Elitsa Polizoeva <elitsa.polizoeva@ams.com>
Signed-off-by: Florian Lobmaier <florian.lobmaier@ams.com>
---
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kcon=
fig
index 21feaa4..dc5dba8 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -3,6 +3,16 @@
 #
 menu "Temperature sensors"
=20
+config AS6200
+	tristate "ams AG AS6200 temperature sensor"
+	depends on I2C
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
index 0000000..fab1916
--- /dev/null
+++ b/drivers/iio/temperature/as6200.c
@@ -0,0 +1,942 @@
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
+
+/*
+ * Addresses to scan
+ * The slave address can be selected from a pool of four
+ * different address settings by connecting the input
+ * pin ADD0 of AS6200 to an appropriate signal as below:
+ * GND        0x48;
+ * VDD        0x49;
+ * SDA        0x4A;
+ * SCL        0x4B;
+ * If ADD0 pin is left unconnected, default address is
+ * 0x49
+*/
+static const unsigned short normal_i2c[] =3D {0x48, 0x49, 0x4a,
+	0x4b, I2C_CLIENT_END };
+
+static const char * const as6200_conv_rates[] =3D { "4", "1", "0.25", "0.1=
25" };
+static const char * const as6200_consec_faults[] =3D { "1", "2", "4", "6" =
};
+
+enum as6200_conf_fld {dw, al, cr, sm, im, pol, cf, ss};
+
+/* AS6200 registers */
+#define REG_TVAL	0x00
+#define REG_CONFIG	0x01
+#define REG_TLOW	0x02
+#define REG_THIGH	0x03
+
+static const struct i2c_device_id as6200_id[] =3D {
+	{ "as6200", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, as6200_id);
+
+struct as6200_data {
+	struct mutex update_lock;
+	struct i2c_client *client;
+	int irqn;
+	char valid; /* !=3D0 if following fields are valid */
+
+	/* chip configuration */
+	u16 dw;  /* 0:12-bit or 1:13-bit conversion mode */
+	u16 al;  /* alert bit */
+	u16 cr;  /* conversion rate */
+	u16 sm;  /* continuous or sleep mode */
+	u16 im;  /* comparator or interrupt mode */
+	u16 pol; /* polarity bit */
+	u16 cf;  /* consecutive faults */
+	u16 ss;  /* single shot conversion */
+
+	/* registers */
+	u16 config;
+	u16 thigh;
+	u16 tlow;
+	u16 tval;
+};
+
+static int as6200_read_reg(struct i2c_client *client,
+	u8 reg_num, u16 *reg_val)
+{
+	int err =3D 0;
+	char tx_buf[1];
+	char rx_buf[2];
+
+	if ((reg_num >=3D 0) & (reg_num <=3D 3)) {
+		tx_buf[0] =3D reg_num;
+		err =3D i2c_master_send(client, tx_buf, 1);
+		if (err =3D=3D 1)
+			err =3D i2c_master_recv(client, rx_buf, 2);
+		if (err =3D=3D 2) {
+			*reg_val =3D rx_buf[0];
+			*reg_val =3D *reg_val << 8;
+			*reg_val =3D *reg_val | rx_buf[1];
+		}
+		return err;
+	} else {
+		return -EINVAL;
+	}
+}
+
+static int as6200_write_reg(struct i2c_client *client,
+	u8 reg_num, const u16 reg_val)
+{
+	int err =3D 0;
+	char buf[3];
+
+	if ((reg_num >=3D 0) & (reg_num <=3D 3)) {
+		buf[0] =3D reg_num;
+		buf[1] =3D (char)((reg_val & 0xff00) >> 8);
+		buf[2] =3D (char)(reg_val & 0x00ff);
+		err =3D i2c_master_send(client, buf, 3);
+		return err;
+	} else {
+		return -EINVAL;
+	}
+}
+
+static u16 as6200_setConfig(struct i2c_client *client,
+	enum as6200_conf_fld fld, u16 val)
+{
+	struct as6200_data *data =3D i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+	switch (fld) {
+	case dw:
+		data->dw =3D val;
+		break;
+	case al:
+		data->al =3D val;
+		break;
+	case cr:
+		data->cr =3D val;
+		break;
+	case sm:
+		data->sm =3D val;
+		break;
+	case im:
+		data->im =3D val;
+		break;
+	case pol:
+		data->pol =3D val;
+		break;
+	case cf:
+		data->cf =3D val;
+		break;
+	case ss:
+		data->ss =3D val;
+		break;
+	}
+	data->config =3D (data->dw << 4) |
+				   (data->al << 5) |
+				   (data->cr << 6) |
+				   (data->sm << 8) |
+				   (data->im << 9) |
+				   (data->pol << 10) |
+				   (data->cf << 11) |
+				   (data->ss << 15);
+	mutex_unlock(&data->update_lock);
+	return data->config;
+}
+
+static int as6200_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *channel, int *val,
+			    int *val2, long mask)
+{
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	int err =3D 0;
+	u16 reg_val =3D 0;
+	s32 ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (channel->type =3D=3D IIO_TEMP) {
+			err =3D as6200_read_reg(client, REG_TVAL, &reg_val);
+			ret =3D reg_val;
+			*val =3D sign_extend32(ret, 15) >> 4;
+		}
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (channel->type =3D=3D IIO_TEMP) {
+			*val =3D 62;
+			*val2 =3D 500000;
+		}
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+static irqreturn_t alert_isr(int irq, void *dev_id)
+{
+	dev_warn(dev_id, "Temperature outside of limits!");
+	return IRQ_HANDLED;
+}
+
+static int setupIRQ(struct iio_dev *indio_dev, bool set_gpio, u8 pol)
+{
+	int err;
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct device *dev =3D &data->client->dev;
+	int gpio =3D -1;
+	int irq_num;
+	int irq_trig;
+
+	if (pol =3D=3D 1)
+		irq_trig =3D IRQF_TRIGGER_RISING;
+	else
+		irq_trig =3D IRQF_TRIGGER_FALLING;
+
+	if (set_gpio) {
+		gpio =3D of_get_named_gpio_flags(dev->of_node,
+			"as6200,irq-gpio", 0, 0);
+		err =3D gpio_request(gpio, "as6200_irq");
+		if (err) {
+			dev_info(dev, "%s: requesting gpio %d failed\n",
+				as6200_id[0].name, gpio);
+			return err;
+		}
+		err =3D gpio_direction_input(gpio);
+		if (err) {
+			dev_info(dev, "%s: gpio %d cannot apply direction\n",
+					as6200_id[0].name, gpio);
+			return err;
+		}
+	}
+	irq_num =3D gpio_to_irq(gpio);
+	dev_info(dev, "%s: registering for IRQ %d\n",
+			as6200_id[0].name, irq_num);
+	err =3D request_irq(irq_num, alert_isr, irq_trig,
+			as6200_id[0].name, dev);
+	if (err) {
+		dev_info(dev, "%s: error requesting irq %d\n",
+			as6200_id[0].name, err);
+		return err;
+	}
+	dev_info(dev, "%s: registered for IRQ %d\n",
+			as6200_id[0].name, irq_num);
+	mutex_lock(&data->update_lock);
+	data->irqn =3D irq_num;
+	mutex_unlock(&data->update_lock);
+
+	return 0;
+}
+
+static ssize_t as6200_show_thigh(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	s16 reg_val =3D 0;
+	int err =3D 0;
+	int val;
+
+	err =3D as6200_read_reg(client, REG_THIGH, &reg_val);
+	reg_val =3D reg_val >> 4;
+	val =3D (625 * reg_val) / 10000;
+	return sprintf(buf, "%d%cC\n", val, (unsigned char)(248));
+}
+
+static ssize_t as6200_show_tlow(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	s16 reg_val =3D 0x00;
+	int err =3D 0;
+	int val;
+
+	err =3D as6200_read_reg(client, REG_TLOW, &reg_val);
+	reg_val =3D reg_val >> 4;
+	val =3D (625 * reg_val) / 10000;
+	return sprintf(buf, "%d%cC\n", val, (unsigned char)(248));
+}
+
+static ssize_t as6200_show_thigh_reg(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	u16 reg_val =3D 0;
+	int err =3D 0;
+
+	err =3D as6200_read_reg(client, REG_THIGH, &reg_val);
+	return sprintf(buf, "%hX\n", reg_val);
+}
+
+static ssize_t as6200_show_tlow_reg(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	u16 reg_val =3D 0x00;
+	int err =3D 0;
+
+	err =3D as6200_read_reg(client, REG_TLOW, &reg_val);
+	return sprintf(buf, "%hX\n", reg_val);
+}
+
+static ssize_t as6200_show_config(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	u16 reg_val =3D 0x00;
+	int err =3D 0;
+
+	err =3D as6200_read_reg(client, REG_CONFIG, &reg_val);
+	return sprintf(buf, "%hX\n", reg_val);
+}
+
+static ssize_t as6200_show_dw(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	u16 reg_val =3D 0x00;
+	int err =3D 0;
+
+	err =3D as6200_read_reg(client, REG_CONFIG, &reg_val);
+	reg_val =3D (reg_val & 0x0010) >> 4;
+	if (reg_val =3D=3D 0)
+		return sprintf(buf, "12-bit\n");
+	else if (reg_val =3D=3D 1)
+		return sprintf(buf, "13-bit\n");
+	else
+		return sprintf(buf, "invalid\n");
+}
+
+static ssize_t as6200_show_al(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	u16 reg_val =3D 0x00;
+	int err =3D 0;
+	u16 pol =3D 0;
+
+	err =3D as6200_read_reg(client, REG_CONFIG, &reg_val);
+	pol =3D (reg_val & 0x0400) >> 10;
+	reg_val =3D (reg_val & 0x0020) >> 5;
+	if (pol =3D=3D 1) {
+		if (reg_val =3D=3D 0)
+			return sprintf(buf, "off\n");
+		else if (reg_val =3D=3D 1)
+			return sprintf(buf, "on\n");
+		else
+			return sprintf(buf, "invalid\n");
+	} else if (pol =3D=3D 0) {
+		if (reg_val =3D=3D 0)
+			return sprintf(buf, "on\n");
+		else if (reg_val =3D=3D 1)
+			return sprintf(buf, "off\n");
+		else
+			return sprintf(buf, "invalid\n");
+	} else
+		return sprintf(buf, "invalid\n");
+}
+
+static ssize_t as6200_show_cr(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	u16 reg_val =3D 0x00;
+	int err =3D 0;
+
+	err =3D as6200_read_reg(client, REG_CONFIG, &reg_val);
+	reg_val =3D reg_val >> 6;
+	switch (reg_val) {
+	case 0:
+		return sprintf(buf, "4s\n");
+	case 1:
+		return sprintf(buf, "1s\n");
+	case 2:
+		return sprintf(buf, "250ms\n");
+	case 3:
+		return sprintf(buf, "125ms\n");
+	}
+	return sprintf(buf, "invalid\n");
+}
+
+static ssize_t as6200_show_sm(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	u16 reg_val =3D 0x00;
+	int err =3D 0;
+
+	err =3D as6200_read_reg(client, REG_CONFIG, &reg_val);
+	return sprintf(buf, "%hX\n", (reg_val & 0x0100) >> 8);
+}
+
+static ssize_t as6200_show_im(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	u16 reg_val =3D 0x00;
+	int err =3D 0;
+
+	err =3D as6200_read_reg(client, REG_CONFIG, &reg_val);
+	return sprintf(buf, "%hX\n", (reg_val & 0x0200) >> 9);
+}
+
+static ssize_t as6200_show_pol(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	u16 reg_val =3D 0x00;
+	int err =3D 0;
+
+	err =3D as6200_read_reg(client, REG_CONFIG, &reg_val);
+	return sprintf(buf, "%hX\n", (reg_val & 0x0400) >> 10);
+}
+
+static ssize_t as6200_show_cf(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	u16 reg_val =3D 0x00;
+	int err =3D 0;
+
+	err =3D as6200_read_reg(client, REG_CONFIG, &reg_val);
+	reg_val =3D (reg_val & 0x1800) >> 11;
+	switch (reg_val) {
+	case 0:
+		return sprintf(buf, "1\n");
+	case 1:
+		return sprintf(buf, "2\n");
+	case 2:
+		return sprintf(buf, "4\n");
+	case 3:
+		return sprintf(buf, "6\n");
+	}
+	return sprintf(buf, "invalid\n");
+}
+
+static ssize_t as6200_show_ss(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	u16 reg_val =3D 0x00;
+	int err =3D 0;
+
+	err =3D as6200_read_reg(client, REG_CONFIG, &reg_val);
+	return sprintf(buf, "%hX\n", (reg_val & 0x8000) >> 15);
+}
+
+static ssize_t as6200_set_thigh(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	int err =3D 0;
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	s16 reg_val;
+	int val;
+
+	err =3D kstrtoint(buf, 0, &val);
+	if (err =3D=3D 0) {
+		if ((val < -40) | (val > 150)) {
+			dev_info(&client->dev,
+				"Value for THIGH is invalid min =3D -40%cC, max =3D 150=B0C, val =3D %=
d=B0C",
+				(unsigned char)(248), val);
+			return count;
+		}
+		val =3D (val * 10000) / 625;
+		reg_val =3D val << 4;
+		err =3D as6200_write_reg(client, REG_THIGH, reg_val);
+	} else
+		dev_info(&client->dev,
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
+	int err =3D 0;
+	s16 reg_val;
+	int val;
+
+	err =3D kstrtoint(buf, 0, &val);
+	if (err =3D=3D 0) {
+		if ((val < -40) | (val > 150)) {
+			dev_info(&client->dev,
+				"Value for THIGH is invalid min =3D -40%cC, max =3D 150=B0C, val =3D %=
d=B0C",
+				(unsigned char)(248), val);
+			return count;
+		}
+		val =3D (val * 10000) / 625;
+		reg_val =3D val << 4;
+		err =3D as6200_write_reg(client, REG_TLOW, reg_val);
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
+	int err =3D 0;
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	u16 reg_val;
+
+	err =3D kstrtou16(buf, 0, &reg_val);
+	if (err =3D=3D 0)
+		err =3D as6200_write_reg(client, REG_THIGH, reg_val);
+	else
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
+	int err =3D 0;
+	u16 reg_val;
+
+	err =3D kstrtou16(buf, 0, &reg_val);
+	if (err =3D=3D 0)
+		err =3D as6200_write_reg(client, REG_TLOW, reg_val);
+	else
+		dev_info(&client->dev,
+			"Converting value for TLOW failed, err =3D %hx",
+			err);
+	return count;
+}
+
+static ssize_t as6200_set_config(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	int err =3D 0;
+	u16 reg_val;
+
+	err =3D kstrtou16(buf, 0, &reg_val);
+	if (err =3D=3D 0)
+		err =3D as6200_write_reg(client, REG_CONFIG, reg_val);
+	else
+		dev_info(&client->dev,
+			"Converting value for CONFIG failed, err =3D %hx",
+			err);
+	return count;
+}
+
+static ssize_t as6200_set_dw(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	int err;
+	u16 val;
+	u16 new_conf;
+
+	err =3D kstrtou16(buf, 0, &val);
+	if (err =3D=3D 0) {
+		if ((val !=3D 12) && (val !=3D 13)) {
+			dev_info(&client->dev,
+				"Value for data width not valid, val =3D %hx",
+				val);
+			return count;
+		}
+		if (val =3D=3D 12)
+			new_conf =3D as6200_setConfig(client, dw, 0);
+		else if (val =3D=3D 13)
+			new_conf =3D as6200_setConfig(client, dw, 1);
+		err =3D as6200_write_reg(client, REG_CONFIG, new_conf);
+	} else
+		dev_info(&client->dev,
+			"Converting value for DW field failed, err =3D %hx",
+			err);
+	return count;
+}
+
+static ssize_t as6200_set_cr(struct device *dev,
+struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
+	struct as6200_data *data =3D iio_priv(indio_dev);
+	struct i2c_client *client =3D data->client;
+	int err;
+	u16 val;
+	u16 new_conf;
+
+	err =3D kstrtou16(buf, 0, &val);
+	if (err =3D=3D 0) {
+		switch (val) {
+		case 4:
+			new_conf =3D as6200_setConfig(client, cr, 0);
+			break;
+		case 1:
+			new_conf =3D as6200_setConfig(client, cr, 1);
+			break;
+		case 250:
+			new_conf =3D as6200_setConfig(client, cr, 2);
+			break;
+		case 125:
+			new_conf =3D as6200_setConfig(client, cr, 3);
+			break;
+		default:
+			dev_info(&client->dev,
+				"Invalid value for CR field, val =3D %hx",
+				val);
+			return count;
+		}
+		err =3D as6200_write_reg(client, REG_CONFIG, new_conf);
+	} else
+		dev_info(&client->dev,
+			"Converting value for CR field failed, err =3D %hx",
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
+	u16 new_conf;
+
+	err =3D kstrtou16(buf, 0, &val);
+	if (err =3D=3D 0) {
+		new_conf =3D as6200_setConfig(client, sm, val);
+		err =3D as6200_write_reg(client, REG_CONFIG, new_conf);
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
+	u16 new_conf;
+
+	err =3D kstrtou16(buf, 0, &val);
+	if (err =3D=3D 0) {
+		new_conf =3D as6200_setConfig(client, im, val);
+		err =3D as6200_write_reg(client, REG_CONFIG, new_conf);
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
+	int irq_num =3D data->irqn;
+	u16 val;
+	u16 new_conf;
+
+	err =3D kstrtou16(buf, 0, &val);
+	if (err =3D=3D 0) {
+		free_irq(irq_num, dev);
+		new_conf =3D as6200_setConfig(client, pol, val);
+		err =3D as6200_write_reg(client, REG_CONFIG, new_conf);
+		setupIRQ(indio_dev, false, val);
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
+	u16 new_conf;
+
+	err =3D kstrtou16(buf, 0, &val);
+	if (err =3D=3D 0) {
+		switch (val) {
+		case 1:
+			new_conf =3D as6200_setConfig(client, cf, 0);
+			break;
+		case 2:
+			new_conf =3D as6200_setConfig(client, cf, 1);
+			break;
+		case 4:
+			new_conf =3D as6200_setConfig(client, cf, 2);
+			break;
+		case 6:
+			new_conf =3D as6200_setConfig(client, cf, 3);
+			break;
+		default:
+			dev_info(&client->dev,
+				"Value for CF field invalid, val =3D %hx", val);
+			return count;
+		}
+		err =3D as6200_write_reg(client, REG_CONFIG, new_conf);
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
+	u16 new_conf;
+
+	err =3D kstrtou16(buf, 0, &val);
+	if (err =3D=3D 0) {
+		new_conf =3D as6200_setConfig(client, ss, val);
+		err =3D as6200_write_reg(client, REG_CONFIG, new_conf);
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
+static IIO_DEVICE_ATTR(config, S_IWUSR | S_IRUGO, as6200_show_config,
+	as6200_set_config, 0);
+static IIO_DEVICE_ATTR(dw, S_IWUSR | S_IRUGO, as6200_show_dw,
+	as6200_set_dw, 0);
+static IIO_DEVICE_ATTR(al, S_IRUGO, as6200_show_al, NULL, 0);
+static IIO_DEVICE_ATTR(cr, S_IWUSR | S_IRUGO, as6200_show_cr,
+	as6200_set_cr, 0);
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
+static struct attribute *as6200_attrs[] =3D {
+	&iio_dev_attr_thigh.dev_attr.attr,
+	&iio_dev_attr_tlow.dev_attr.attr,
+	&iio_dev_attr_thigh_reg.dev_attr.attr,
+	&iio_dev_attr_tlow_reg.dev_attr.attr,
+	&iio_dev_attr_config.dev_attr.attr,
+	&iio_dev_attr_dw.dev_attr.attr,
+	&iio_dev_attr_al.dev_attr.attr,
+	&iio_dev_attr_cr.dev_attr.attr,
+	&iio_dev_attr_sm.dev_attr.attr,
+	&iio_dev_attr_im.dev_attr.attr,
+	&iio_dev_attr_pol.dev_attr.attr,
+	&iio_dev_attr_cf.dev_attr.attr,
+	&iio_dev_attr_ss.dev_attr.attr,
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
+			BIT(IIO_CHAN_INFO_SCALE),
+	}
+};
+
+static const struct iio_info as6200_info =3D {
+	.read_raw =3D as6200_read_raw,
+	.attrs =3D &as6200_attr_group,
+	.driver_module =3D THIS_MODULE,
+};
+
+static int as6200_detect(struct i2c_client *client,
+	struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter =3D client->adapter;
+	const char *name =3D NULL;
+	char tx_buf[1];
+	char rx_buf[2];
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C |
+	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
+		return -ENODEV;
+	tx_buf[0] =3D 0x03;
+	i2c_master_send(client, tx_buf, 1);
+	i2c_master_recv(client, rx_buf, 2);
+	if (rx_buf[0] !=3D 0x40 && rx_buf[1] !=3D 0xA0)
+		return -ENODEV;
+
+	name =3D "as6200";
+
+	strlcpy(info->type, name, I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static void initClientData(struct as6200_data *data)
+{
+	data->dw =3D 0;
+	data->al =3D 1;
+	data->cr =3D 2; /* 250ms */
+	data->sm =3D 0; /* continuous or sleep mode */
+	data->im =3D 0; /* comparator */
+	data->pol =3D 0; /* alert irq active low */
+	data->cf =3D 0;  /* 1 consecutive faults */
+	data->ss =3D 0;  /* single shot conversion */
+
+	/* registers */
+	data->config =3D 0x40A0; /* reflect above settings */
+	data->thigh =3D 0x4B00;
+	data->tlow =3D 0x5000;
+}
+
+static int as6200_probe(struct i2c_client *client,
+	const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev =3D NULL;
+	struct as6200_data *data =3D NULL;
+
+	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
+
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data =3D iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client =3D client;
+
+	indio_dev->dev.parent =3D &client->dev;
+	indio_dev->name =3D dev_name(&client->dev);
+	indio_dev->modes =3D INDIO_DIRECT_MODE;
+	indio_dev->info =3D &as6200_info;
+
+	indio_dev->channels =3D as6200_channels;
+	indio_dev->num_channels =3D ARRAY_SIZE(as6200_channels);
+
+	initClientData(data);
+	mutex_init(&data->update_lock);
+	setupIRQ(indio_dev, true, 0);
+
+	return iio_device_register(indio_dev);
+}
+
+static int as6200_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct as6200_data *data;
+	int irq_num;
+
+	indio_dev =3D i2c_get_clientdata(client);
+	data =3D iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	irq_num =3D data->irqn;
+	free_irq(irq_num, &client->dev);
+	gpio_free(49);
+	return 0;
+}
+
+static struct i2c_driver as6200_driver =3D {
+	.driver =3D {
+		.name =3D "as6200",
+		.owner =3D THIS_MODULE,
+	},
+	.probe =3D as6200_probe,
+	.remove =3D as6200_remove,
+	.id_table =3D as6200_id,
+	.detect	=3D as6200_detect,
+	.address_list =3D normal_i2c,
+};
+
+static int __init as6200_init(void)
+{
+	return i2c_add_driver(&as6200_driver);
+}
+
+static void __exit as6200_exit(void)
+{
+	i2c_del_driver(&as6200_driver);
+}
+module_init(as6200_init);
+module_exit(as6200_exit);
+
+MODULE_DESCRIPTION("ams AS6200 temperature sensor");
+MODULE_AUTHOR("Elitsa Polizoeva <elitsa.polizoeva@ams.com>");
+MODULE_AUTHOR("Florian Lobmaier <florian.lobmaier@ams.com>");
+MODULE_LICENSE("GPL");
