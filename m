Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:38977 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478AbbKJLJQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 10 Nov 2015 06:09:16 -0500
Date: Tue, 10 Nov 2015 12:09:12 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Florian Lobmaier <Florian.Lobmaier@ams.com>
cc: "jic23@kernel.org" <jic23@kernel.org>,
	Elitsa Polizoeva <Elitsa.Polizoeva@ams.com>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH V1 1/1] iio: as6200: add AS6200 temperature sensor driver
 from ams AG
In-Reply-To: <09675593925c4a6c99982b21fae3640a@SUX5071.office.amsiag.com>
Message-ID: <alpine.DEB.2.02.1511101149110.24843@pmeerw.net>
References: <09675593925c4a6c99982b21fae3640a@SUX5071.office.amsiag.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="324295856-1509692475-1447153753=:24843"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--324295856-1509692475-1447153753=:24843
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT


> The AS6200 is a compact temperature sensor chip with I2C interface.
> Add a driver to support the AS6200 temperature sensor.

a link to the datasheet would be nice

temperature sensors are often found in the hwmon subsystem, there is some 
overlap between IIO and hwmon

some rework of the driver is needed, try to expose chip features via 
standard IIO mechanisms (e.g. conversion rate via SAMPLE_FREQ)
 
some more comments below

regards, p.

> Signed-off-by: Elitsa Polizoeva <elitsa.polizoeva@ams.com>
> Signed-off-by: Florian Lobmaier <florian.lobmaier@ams.com>
> ---
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index 21feaa4..dc5dba8 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -3,6 +3,16 @@
>  #
>  menu "Temperature sensors"
>  
> +config AS6200
> +	tristate "ams AG AS6200 temperature sensor"
> +	depends on I2C
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
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index 40710a8..c0c9a9a 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -2,5 +2,6 @@
>  # Makefile for industrial I/O temperature drivers
>  #
>  
> +obj-$(CONFIG_AS6200) += as6200.o
>  obj-$(CONFIG_MLX90614) += mlx90614.o
>  obj-$(CONFIG_TMP006) += tmp006.o
> diff --git a/drivers/iio/temperature/as6200.c b/drivers/iio/temperature/as6200.c
> new file mode 100644
> index 0000000..fab1916
> --- /dev/null
> +++ b/drivers/iio/temperature/as6200.c
> @@ -0,0 +1,942 @@
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
> +
> +/*
> + * Addresses to scan
> + * The slave address can be selected from a pool of four
> + * different address settings by connecting the input
> + * pin ADD0 of AS6200 to an appropriate signal as below:
> + * GND        0x48;
> + * VDD        0x49;
> + * SDA        0x4A;
> + * SCL        0x4B;
> + * If ADD0 pin is left unconnected, default address is
> + * 0x49
> +*/
> +static const unsigned short normal_i2c[] = {0x48, 0x49, 0x4a,

use as6200_ prefix here as well

> +	0x4b, I2C_CLIENT_END };
> +
> +static const char * const as6200_conv_rates[] = { "4", "1", "0.25", "0.125" };
> +static const char * const as6200_consec_faults[] = { "1", "2", "4", "6" };
> +
> +enum as6200_conf_fld {dw, al, cr, sm, im, pol, cf, ss};
> +
> +/* AS6200 registers */
> +#define REG_TVAL	0x00

AS6200_ prefix

> +#define REG_CONFIG	0x01
> +#define REG_TLOW	0x02
> +#define REG_THIGH	0x03
> +
> +static const struct i2c_device_id as6200_id[] = {
> +	{ "as6200", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, as6200_id);
> +
> +struct as6200_data {
> +	struct mutex update_lock;
> +	struct i2c_client *client;
> +	int irqn;
> +	char valid; /* !=0 if following fields are valid */

bool?

> +
> +	/* chip configuration */
> +	u16 dw;  /* 0:12-bit or 1:13-bit conversion mode */

expose via writig _SCALE

> +	u16 al;  /* alert bit */
> +	u16 cr;  /* conversion rate */

expose via IIO SAMPLE_FREQ

> +	u16 sm;  /* continuous or sleep mode */
> +	u16 im;  /* comparator or interrupt mode */
> +	u16 pol; /* polarity bit */
> +	u16 cf;  /* consecutive faults */
> +	u16 ss;  /* single shot conversion */
> +
> +	/* registers */
> +	u16 config;
> +	u16 thigh;
> +	u16 tlow;
> +	u16 tval;

consider using regmap

> +};
> +
> +static int as6200_read_reg(struct i2c_client *client,
> +	u8 reg_num, u16 *reg_val)
> +{
> +	int err = 0;
> +	char tx_buf[1];
> +	char rx_buf[2];
> +
> +	if ((reg_num >= 0) & (reg_num <= 3)) {
> +		tx_buf[0] = reg_num;

why not use i2c_smbus_read_word_swapped()?

> +		err = i2c_master_send(client, tx_buf, 1);
> +		if (err == 1)
> +			err = i2c_master_recv(client, rx_buf, 2);
> +		if (err == 2) {
> +			*reg_val = rx_buf[0];
> +			*reg_val = *reg_val << 8;
> +			*reg_val = *reg_val | rx_buf[1];

*regval = (rx_buf[0] << 8) | rx_buf[1];

> +		}
> +		return err;
> +	} else {
> +		return -EINVAL;
> +	}
> +}
> +
> +static int as6200_write_reg(struct i2c_client *client,
> +	u8 reg_num, const u16 reg_val)
> +{
> +	int err = 0;
> +	char buf[3];
> +
> +	if ((reg_num >= 0) & (reg_num <= 3)) {
> +		buf[0] = reg_num;
> +		buf[1] = (char)((reg_val & 0xff00) >> 8);
> +		buf[2] = (char)(reg_val & 0x00ff);
> +		err = i2c_master_send(client, buf, 3);
> +		return err;
> +	} else {
> +		return -EINVAL;
> +	}
> +}
> +
> +static u16 as6200_setConfig(struct i2c_client *client,

no CamelCase, _set_config() is customary

> +	enum as6200_conf_fld fld, u16 val)
> +{
> +	struct as6200_data *data = i2c_get_clientdata(client);
> +
> +	mutex_lock(&data->update_lock);
> +	switch (fld) {
> +	case dw:
> +		data->dw = val;
> +		break;
> +	case al:
> +		data->al = val;
> +		break;
> +	case cr:
> +		data->cr = val;
> +		break;
> +	case sm:
> +		data->sm = val;
> +		break;
> +	case im:
> +		data->im = val;
> +		break;
> +	case pol:
> +		data->pol = val;
> +		break;
> +	case cf:
> +		data->cf = val;
> +		break;
> +	case ss:
> +		data->ss = val;
> +		break;
> +	}
> +	data->config = (data->dw << 4) |
> +				   (data->al << 5) |
> +				   (data->cr << 6) |
> +				   (data->sm << 8) |
> +				   (data->im << 9) |
> +				   (data->pol << 10) |
> +				   (data->cf << 11) |
> +				   (data->ss << 15);
> +	mutex_unlock(&data->update_lock);
> +	return data->config;
> +}
> +
> +static int as6200_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int *val,
> +			    int *val2, long mask)
> +{
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	int err = 0;
> +	u16 reg_val = 0;
> +	s32 ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (channel->type == IIO_TEMP) {
> +			err = as6200_read_reg(client, REG_TVAL, &reg_val);

error handling missing?

> +			ret = reg_val;
> +			*val = sign_extend32(ret, 15) >> 4;
> +		}

else?

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (channel->type == IIO_TEMP) {
> +			*val = 62;
> +			*val2 = 500000;
> +		}

else?

> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		break;
> +	}
> +	return -EINVAL;
> +}
> +
> +static irqreturn_t alert_isr(int irq, void *dev_id)

as6200_ prefix

> +{
> +	dev_warn(dev_id, "Temperature outside of limits!");
> +	return IRQ_HANDLED;
> +}
> +
> +static int setupIRQ(struct iio_dev *indio_dev, bool set_gpio, u8 pol)

as6200_ prefix, naming

> +{
> +	int err;
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
> +	int gpio = -1;
> +	int irq_num;
> +	int irq_trig;
> +
> +	if (pol == 1)
> +		irq_trig = IRQF_TRIGGER_RISING;
> +	else
> +		irq_trig = IRQF_TRIGGER_FALLING;
> +
> +	if (set_gpio) {
> +		gpio = of_get_named_gpio_flags(dev->of_node,
> +			"as6200,irq-gpio", 0, 0);
> +		err = gpio_request(gpio, "as6200_irq");
> +		if (err) {
> +			dev_info(dev, "%s: requesting gpio %d failed\n",
> +				as6200_id[0].name, gpio);
> +			return err;
> +		}
> +		err = gpio_direction_input(gpio);
> +		if (err) {
> +			dev_info(dev, "%s: gpio %d cannot apply direction\n",
> +					as6200_id[0].name, gpio);
> +			return err;
> +		}
> +	}
> +	irq_num = gpio_to_irq(gpio);
> +	dev_info(dev, "%s: registering for IRQ %d\n",
> +			as6200_id[0].name, irq_num);
> +	err = request_irq(irq_num, alert_isr, irq_trig,
> +			as6200_id[0].name, dev);
> +	if (err) {
> +		dev_info(dev, "%s: error requesting irq %d\n",
> +			as6200_id[0].name, err);
> +		return err;
> +	}
> +	dev_info(dev, "%s: registered for IRQ %d\n",
> +			as6200_id[0].name, irq_num);
> +	mutex_lock(&data->update_lock);
> +	data->irqn = irq_num;
> +	mutex_unlock(&data->update_lock);
> +
> +	return 0;
> +}
> +
> +static ssize_t as6200_show_thigh(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{

consider iio events

> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	s16 reg_val = 0;
> +	int err = 0;
> +	int val;
> +
> +	err = as6200_read_reg(client, REG_THIGH, &reg_val);
> +	reg_val = reg_val >> 4;
> +	val = (625 * reg_val) / 10000;
> +	return sprintf(buf, "%d%cC\n", val, (unsigned char)(248));
> +}
> +
> +static ssize_t as6200_show_tlow(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	s16 reg_val = 0x00;
> +	int err = 0;
> +	int val;
> +
> +	err = as6200_read_reg(client, REG_TLOW, &reg_val);
> +	reg_val = reg_val >> 4;
> +	val = (625 * reg_val) / 10000;
> +	return sprintf(buf, "%d%cC\n", val, (unsigned char)(248));
> +}
> +
> +static ssize_t as6200_show_thigh_reg(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	u16 reg_val = 0;
> +	int err = 0;
> +
> +	err = as6200_read_reg(client, REG_THIGH, &reg_val);
> +	return sprintf(buf, "%hX\n", reg_val);
> +}
> +
> +static ssize_t as6200_show_tlow_reg(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	u16 reg_val = 0x00;
> +	int err = 0;
> +
> +	err = as6200_read_reg(client, REG_TLOW, &reg_val);
> +	return sprintf(buf, "%hX\n", reg_val);
> +}
> +
> +static ssize_t as6200_show_config(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	u16 reg_val = 0x00;
> +	int err = 0;
> +
> +	err = as6200_read_reg(client, REG_CONFIG, &reg_val);
> +	return sprintf(buf, "%hX\n", reg_val);
> +}
> +
> +static ssize_t as6200_show_dw(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	u16 reg_val = 0x00;
> +	int err = 0;
> +
> +	err = as6200_read_reg(client, REG_CONFIG, &reg_val);
> +	reg_val = (reg_val & 0x0010) >> 4;
> +	if (reg_val == 0)
> +		return sprintf(buf, "12-bit\n");
> +	else if (reg_val == 1)
> +		return sprintf(buf, "13-bit\n");
> +	else
> +		return sprintf(buf, "invalid\n");
> +}
> +
> +static ssize_t as6200_show_al(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	u16 reg_val = 0x00;
> +	int err = 0;
> +	u16 pol = 0;
> +
> +	err = as6200_read_reg(client, REG_CONFIG, &reg_val);
> +	pol = (reg_val & 0x0400) >> 10;
> +	reg_val = (reg_val & 0x0020) >> 5;
> +	if (pol == 1) {
> +		if (reg_val == 0)
> +			return sprintf(buf, "off\n");
> +		else if (reg_val == 1)
> +			return sprintf(buf, "on\n");
> +		else
> +			return sprintf(buf, "invalid\n");
> +	} else if (pol == 0) {
> +		if (reg_val == 0)
> +			return sprintf(buf, "on\n");
> +		else if (reg_val == 1)
> +			return sprintf(buf, "off\n");
> +		else
> +			return sprintf(buf, "invalid\n");
> +	} else
> +		return sprintf(buf, "invalid\n");
> +}
> +
> +static ssize_t as6200_show_cr(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	u16 reg_val = 0x00;
> +	int err = 0;
> +
> +	err = as6200_read_reg(client, REG_CONFIG, &reg_val);
> +	reg_val = reg_val >> 6;
> +	switch (reg_val) {
> +	case 0:
> +		return sprintf(buf, "4s\n");
> +	case 1:
> +		return sprintf(buf, "1s\n");
> +	case 2:
> +		return sprintf(buf, "250ms\n");
> +	case 3:
> +		return sprintf(buf, "125ms\n");
> +	}
> +	return sprintf(buf, "invalid\n");
> +}
> +
> +static ssize_t as6200_show_sm(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	u16 reg_val = 0x00;
> +	int err = 0;
> +
> +	err = as6200_read_reg(client, REG_CONFIG, &reg_val);
> +	return sprintf(buf, "%hX\n", (reg_val & 0x0100) >> 8);
> +}
> +
> +static ssize_t as6200_show_im(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	u16 reg_val = 0x00;
> +	int err = 0;
> +
> +	err = as6200_read_reg(client, REG_CONFIG, &reg_val);
> +	return sprintf(buf, "%hX\n", (reg_val & 0x0200) >> 9);
> +}
> +
> +static ssize_t as6200_show_pol(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	u16 reg_val = 0x00;
> +	int err = 0;
> +
> +	err = as6200_read_reg(client, REG_CONFIG, &reg_val);
> +	return sprintf(buf, "%hX\n", (reg_val & 0x0400) >> 10);
> +}
> +
> +static ssize_t as6200_show_cf(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	u16 reg_val = 0x00;
> +	int err = 0;
> +
> +	err = as6200_read_reg(client, REG_CONFIG, &reg_val);
> +	reg_val = (reg_val & 0x1800) >> 11;
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
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	u16 reg_val = 0x00;
> +	int err = 0;
> +
> +	err = as6200_read_reg(client, REG_CONFIG, &reg_val);
> +	return sprintf(buf, "%hX\n", (reg_val & 0x8000) >> 15);
> +}
> +
> +static ssize_t as6200_set_thigh(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	int err = 0;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	s16 reg_val;
> +	int val;
> +
> +	err = kstrtoint(buf, 0, &val);
> +	if (err == 0) {
> +		if ((val < -40) | (val > 150)) {
> +			dev_info(&client->dev,
> +				"Value for THIGH is invalid min = -40%cC, max = 150°C, val = %d°C",
> +				(unsigned char)(248), val);
> +			return count;
> +		}
> +		val = (val * 10000) / 625;
> +		reg_val = val << 4;
> +		err = as6200_write_reg(client, REG_THIGH, reg_val);
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for THIGH failed, err = %hx",
> +			err);
> +	return count;
> +}
> +
> +static ssize_t as6200_set_tlow(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	int err = 0;
> +	s16 reg_val;
> +	int val;
> +
> +	err = kstrtoint(buf, 0, &val);
> +	if (err == 0) {
> +		if ((val < -40) | (val > 150)) {
> +			dev_info(&client->dev,
> +				"Value for THIGH is invalid min = -40%cC, max = 150°C, val = %d°C",
> +				(unsigned char)(248), val);
> +			return count;
> +		}
> +		val = (val * 10000) / 625;
> +		reg_val = val << 4;
> +		err = as6200_write_reg(client, REG_TLOW, reg_val);
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for TLOW failed, err = %hx",
> +			err);
> +	return count;
> +}
> +
> +static ssize_t as6200_set_thigh_reg(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	int err = 0;
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	u16 reg_val;
> +
> +	err = kstrtou16(buf, 0, &reg_val);
> +	if (err == 0)
> +		err = as6200_write_reg(client, REG_THIGH, reg_val);
> +	else
> +		dev_info(&client->dev,
> +			"Converting value for THIGH failed, err = %hx",
> +			err);
> +	return count;
> +}
> +
> +static ssize_t as6200_set_tlow_reg(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	int err = 0;
> +	u16 reg_val;
> +
> +	err = kstrtou16(buf, 0, &reg_val);
> +	if (err == 0)
> +		err = as6200_write_reg(client, REG_TLOW, reg_val);
> +	else
> +		dev_info(&client->dev,
> +			"Converting value for TLOW failed, err = %hx",
> +			err);
> +	return count;
> +}
> +
> +static ssize_t as6200_set_config(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	int err = 0;
> +	u16 reg_val;
> +
> +	err = kstrtou16(buf, 0, &reg_val);
> +	if (err == 0)
> +		err = as6200_write_reg(client, REG_CONFIG, reg_val);
> +	else
> +		dev_info(&client->dev,
> +			"Converting value for CONFIG failed, err = %hx",
> +			err);
> +	return count;
> +}
> +
> +static ssize_t as6200_set_dw(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	int err;
> +	u16 val;
> +	u16 new_conf;
> +
> +	err = kstrtou16(buf, 0, &val);
> +	if (err == 0) {
> +		if ((val != 12) && (val != 13)) {
> +			dev_info(&client->dev,
> +				"Value for data width not valid, val = %hx",
> +				val);
> +			return count;
> +		}
> +		if (val == 12)
> +			new_conf = as6200_setConfig(client, dw, 0);
> +		else if (val == 13)
> +			new_conf = as6200_setConfig(client, dw, 1);
> +		err = as6200_write_reg(client, REG_CONFIG, new_conf);
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for DW field failed, err = %hx",
> +			err);
> +	return count;
> +}
> +
> +static ssize_t as6200_set_cr(struct device *dev,
> +struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	int err;
> +	u16 val;
> +	u16 new_conf;
> +
> +	err = kstrtou16(buf, 0, &val);
> +	if (err == 0) {
> +		switch (val) {
> +		case 4:
> +			new_conf = as6200_setConfig(client, cr, 0);
> +			break;
> +		case 1:
> +			new_conf = as6200_setConfig(client, cr, 1);
> +			break;
> +		case 250:
> +			new_conf = as6200_setConfig(client, cr, 2);
> +			break;
> +		case 125:
> +			new_conf = as6200_setConfig(client, cr, 3);
> +			break;
> +		default:
> +			dev_info(&client->dev,
> +				"Invalid value for CR field, val = %hx",
> +				val);
> +			return count;
> +		}
> +		err = as6200_write_reg(client, REG_CONFIG, new_conf);
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for CR field failed, err = %hx",
> +			err);
> +	return count;
> +}
> +
> +static ssize_t as6200_set_sm(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	int err;
> +	u16 val;
> +	u16 new_conf;
> +
> +	err = kstrtou16(buf, 0, &val);
> +	if (err == 0) {
> +		new_conf = as6200_setConfig(client, sm, val);
> +		err = as6200_write_reg(client, REG_CONFIG, new_conf);
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for SM field failed, err = %hx",
> +			err);
> +	return count;
> +}
> +
> +static ssize_t as6200_set_im(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	int err;
> +	u16 val;
> +	u16 new_conf;
> +
> +	err = kstrtou16(buf, 0, &val);
> +	if (err == 0) {
> +		new_conf = as6200_setConfig(client, im, val);
> +		err = as6200_write_reg(client, REG_CONFIG, new_conf);
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for IM field failed, err = %hx",
> +			err);
> +	return count;
> +}
> +
> +static ssize_t as6200_set_pol(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	int err;
> +	int irq_num = data->irqn;
> +	u16 val;
> +	u16 new_conf;
> +
> +	err = kstrtou16(buf, 0, &val);
> +	if (err == 0) {
> +		free_irq(irq_num, dev);
> +		new_conf = as6200_setConfig(client, pol, val);
> +		err = as6200_write_reg(client, REG_CONFIG, new_conf);
> +		setupIRQ(indio_dev, false, val);
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for POL field failed, err = %hx",
> +			err);
> +	return count;
> +}
> +
> +static ssize_t as6200_set_cf(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	int err;
> +	u16 val;
> +	u16 new_conf;
> +
> +	err = kstrtou16(buf, 0, &val);
> +	if (err == 0) {
> +		switch (val) {
> +		case 1:
> +			new_conf = as6200_setConfig(client, cf, 0);
> +			break;
> +		case 2:
> +			new_conf = as6200_setConfig(client, cf, 1);
> +			break;
> +		case 4:
> +			new_conf = as6200_setConfig(client, cf, 2);
> +			break;
> +		case 6:
> +			new_conf = as6200_setConfig(client, cf, 3);
> +			break;
> +		default:
> +			dev_info(&client->dev,
> +				"Value for CF field invalid, val = %hx", val);
> +			return count;
> +		}
> +		err = as6200_write_reg(client, REG_CONFIG, new_conf);
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for CF field failed, err = %hx",
> +			err);
> +	return count;
> +}
> +
> +static ssize_t as6200_set_ss(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	int err;
> +	u16 val;
> +	u16 new_conf;
> +
> +	err = kstrtou16(buf, 0, &val);
> +	if (err == 0) {
> +		new_conf = as6200_setConfig(client, ss, val);
> +		err = as6200_write_reg(client, REG_CONFIG, new_conf);
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for SS field failed, err = %hx",
> +			err);
> +	return count;
> +}
> +
> +static IIO_DEVICE_ATTR(thigh, S_IWUSR | S_IRUGO, as6200_show_thigh,
> +	as6200_set_thigh, 0);
> +static IIO_DEVICE_ATTR(tlow, S_IWUSR | S_IRUGO, as6200_show_tlow,
> +	as6200_set_tlow, 0);
> +static IIO_DEVICE_ATTR(thigh_reg, S_IWUSR | S_IRUGO, as6200_show_thigh_reg,
> +	as6200_set_thigh_reg, 0);
> +static IIO_DEVICE_ATTR(tlow_reg, S_IWUSR | S_IRUGO, as6200_show_tlow_reg,
> +	as6200_set_tlow_reg, 0);
> +static IIO_DEVICE_ATTR(config, S_IWUSR | S_IRUGO, as6200_show_config,
> +	as6200_set_config, 0);
> +static IIO_DEVICE_ATTR(dw, S_IWUSR | S_IRUGO, as6200_show_dw,
> +	as6200_set_dw, 0);
> +static IIO_DEVICE_ATTR(al, S_IRUGO, as6200_show_al, NULL, 0);
> +static IIO_DEVICE_ATTR(cr, S_IWUSR | S_IRUGO, as6200_show_cr,
> +	as6200_set_cr, 0);
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
> +static struct attribute *as6200_attrs[] = {
> +	&iio_dev_attr_thigh.dev_attr.attr,
> +	&iio_dev_attr_tlow.dev_attr.attr,
> +	&iio_dev_attr_thigh_reg.dev_attr.attr,
> +	&iio_dev_attr_tlow_reg.dev_attr.attr,
> +	&iio_dev_attr_config.dev_attr.attr,
> +	&iio_dev_attr_dw.dev_attr.attr,
> +	&iio_dev_attr_al.dev_attr.attr,
> +	&iio_dev_attr_cr.dev_attr.attr,
> +	&iio_dev_attr_sm.dev_attr.attr,
> +	&iio_dev_attr_im.dev_attr.attr,
> +	&iio_dev_attr_pol.dev_attr.attr,
> +	&iio_dev_attr_cf.dev_attr.attr,
> +	&iio_dev_attr_ss.dev_attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group as6200_attr_group = {
> +	.attrs = as6200_attrs,
> +};
> +
> +static const struct iio_chan_spec as6200_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +	}
> +};
> +
> +static const struct iio_info as6200_info = {
> +	.read_raw = as6200_read_raw,
> +	.attrs = &as6200_attr_group,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int as6200_detect(struct i2c_client *client,
> +	struct i2c_board_info *info)
> +{
> +	struct i2c_adapter *adapter = client->adapter;
> +	const char *name = NULL;
> +	char tx_buf[1];
> +	char rx_buf[2];
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C |
> +	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
> +		return -ENODEV;
> +	tx_buf[0] = 0x03;
> +	i2c_master_send(client, tx_buf, 1);
> +	i2c_master_recv(client, rx_buf, 2);
> +	if (rx_buf[0] != 0x40 && rx_buf[1] != 0xA0)
> +		return -ENODEV;
> +
> +	name = "as6200";
> +
> +	strlcpy(info->type, name, I2C_NAME_SIZE);
> +
> +	return 0;
> +}
> +
> +static void initClientData(struct as6200_data *data)
> +{
> +	data->dw = 0;
> +	data->al = 1;
> +	data->cr = 2; /* 250ms */
> +	data->sm = 0; /* continuous or sleep mode */

use bool or enum?

> +	data->im = 0; /* comparator */
> +	data->pol = 0; /* alert irq active low */
> +	data->cf = 0;  /* 1 consecutive faults */
> +	data->ss = 0;  /* single shot conversion */
> +
> +	/* registers */
> +	data->config = 0x40A0; /* reflect above settings */
> +	data->thigh = 0x4B00;
> +	data->tlow = 0x5000;
> +}
> +
> +static int as6200_probe(struct i2c_client *client,
> +	const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev = NULL;
> +	struct as6200_data *data = NULL;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));

drop newline here

> +
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = dev_name(&client->dev);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &as6200_info;
> +
> +	indio_dev->channels = as6200_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(as6200_channels);
> +
> +	initClientData(data);
> +	mutex_init(&data->update_lock);
> +	setupIRQ(indio_dev, true, 0);
> +
> +	return iio_device_register(indio_dev);
> +}
> +
> +static int as6200_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct as6200_data *data;
> +	int irq_num;
> +
> +	indio_dev = i2c_get_clientdata(client);
> +	data = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	irq_num = data->irqn;

drop irq_num

> +	free_irq(irq_num, &client->dev);
> +	gpio_free(49);

magic 49?

> +	return 0;
> +}
> +
> +static struct i2c_driver as6200_driver = {
> +	.driver = {
> +		.name = "as6200",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = as6200_probe,
> +	.remove = as6200_remove,
> +	.id_table = as6200_id,
> +	.detect	= as6200_detect,
> +	.address_list = normal_i2c,

i2c device are generally not auto-detected; drop .detect, .address_list

> +};
> +
> +static int __init as6200_init(void)
> +{
> +	return i2c_add_driver(&as6200_driver);
> +}
> +
> +static void __exit as6200_exit(void)
> +{
> +	i2c_del_driver(&as6200_driver);
> +}
> +module_init(as6200_init);
> +module_exit(as6200_exit);

use module_i2c_driver()

> +
> +MODULE_DESCRIPTION("ams AS6200 temperature sensor");
> +MODULE_AUTHOR("Elitsa Polizoeva <elitsa.polizoeva@ams.com>");
> +MODULE_AUTHOR("Florian Lobmaier <florian.lobmaier@ams.com>");
> +MODULE_LICENSE("GPL");
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
--324295856-1509692475-1447153753=:24843--
