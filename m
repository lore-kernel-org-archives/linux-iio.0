Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:44264 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146AbcHAKLL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 1 Aug 2016 06:11:11 -0400
Date: Mon, 1 Aug 2016 12:00:08 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Florian Lobmaier <Florian.Lobmaier@ams.com>
cc: "jic23@kernel.org" <jic23@kernel.org>,
	Elitsa Polizoeva <Elitsa.Polizoeva@ams.com>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH V3 1/1] iio: as6200: add AS6200 temperature sensor driver
 from ams AG
In-Reply-To: <74d7c447fc1d442c95e8044c900beead@SUX5076.office.amsiag.com>
Message-ID: <alpine.DEB.2.02.1608011042070.28515@pmeerw.net>
References: <74d7c447fc1d442c95e8044c900beead@SUX5076.office.amsiag.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="324295856-1400631042-1470045608=:28515"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--324295856-1400631042-1470045608=:28515
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hello Florian,

> Thanks for the feedback. We changed all open items accordingly. 
> One item regarding the free_irq in as6200_set_pol function we did not 
> understand: your feedback was " so irq is invalid here, but remove() 
> would free it again?". This is true that free_irq would be called twice 
> if the as6200_setup_irq function would fail afterwards. But is this a 
> problem? If you could give us a hint how to overcome the problem it 
> would be great.

_set_pol():

             free_irq(client->irq, dev); // irq is freed, but client->irq
             err = regmap_update_bits(data->regmap, AS6200_REG_CONFIG,
                     AS6200_CONFIG_POL_MASK,
                     val << AS6200_CONFIG_POL_SHIFT);
             if (err < 0) // here the function can return, with irq still freed
                          // maybe set client->irq = -1 or setup_irq again before returning
                     return err;
             as6200_setup_irq(indio_dev, (bool)val);

> We removed the config sysfs file which allowed to write the complete config register.

still plenty of undocumented private API; have a look at IIO events 
support for threshold to potentially get rid of the private 
functions 

some minor comments below

regards, p.

> Signed-off-by: Elitsa Polizoeva <elitsa.polizoeva@ams.com>
> Signed-off-by: Florian Lobmaier <florian.lobmaier@ams.com>
> ---
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index 21feaa4..d82e80f 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -3,6 +3,17 @@
>  #
>  menu "Temperature sensors"
>  
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
> index 0000000..a3873f4
> --- /dev/null
> +++ b/drivers/iio/temperature/as6200.c
> @@ -0,0 +1,747 @@
> +/*
> + * Driver for ams AS6200 temperature sensor.
> + *
> + * Sensor supports following 7-bit I2C addresses: 0x48, 0x49, 0x4A, 0x4B
> + *
> + * Copyright (c) 2016 ams AG. All rights reserved.
> + *
> + * Author: Florian Lobmaier <florian.lobmaier@ams.com>
> + * Author: Elitsa Polizoeva <elitsa.polizoeva@ams.com>
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
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
> + */

maybe a newline here

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
> +static const int as6200_conv_rates[4][2] = { {4, 0}, {1, 0},
> +					{0, 250000}, {0, 125000} };
> +
> +static const char * const as6200_consec_faults[] = { "1", "2", "4", "6" };
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
> +static const struct regmap_range as6200_readable_ranges[] = {
> +	regmap_reg_range(AS6200_REG_TVAL, AS6200_REG_THIGH),
> +};
> +
> +static const struct regmap_access_table as6200_readable_table = {
> +	.yes_ranges = as6200_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(as6200_readable_ranges),
> +};
> +
> +static const struct regmap_range as6200_writable_ranges[] = {
> +	regmap_reg_range(AS6200_REG_CONFIG, AS6200_REG_THIGH),
> +};
> +
> +static const struct regmap_access_table as6200_writable_table = {
> +	.yes_ranges = as6200_writable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(as6200_writable_ranges),
> +};
> +
> +static const struct regmap_range as6200_volatile_ranges[] = {
> +	regmap_reg_range(AS6200_REG_TVAL, AS6200_REG_TVAL),
> +};
> +
> +static const struct regmap_access_table as6200_volatile_table = {
> +	.yes_ranges = as6200_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(as6200_volatile_ranges),
> +};
> +
> +static const struct regmap_config as6200_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = AS6200_MAX_REGISTER,
> +	.cache_type = REGCACHE_RBTREE,
> +	.rd_table = &as6200_readable_table,
> +	.wr_table = &as6200_writable_table,
> +	.volatile_table = &as6200_volatile_table,
> +};
> +
> +static int as6200_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int *val,
> +			    int *val2, long mask)
> +{
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int cr, err;
> +	s32 ret;
> +
> +	if (channel->type != IIO_TEMP)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +	case IIO_CHAN_INFO_PROCESSED:
> +		err = regmap_read(data->regmap, AS6200_REG_TVAL,
> +					&reg_val);
> +		if (err < 0)
> +			return err;
> +		ret = sign_extend32(reg_val, 15) >> 4;
> +		if (mask == IIO_CHAN_INFO_PROCESSED)
> +			*val = (ret * 625) / 10000;
> +		else
> +			*val = ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 62;
> +		*val2 = 500000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		err = regmap_read(data->regmap, AS6200_REG_CONFIG,
> +					&reg_val);
> +		if (err < 0)
> +			return err;
> +		cr = (reg_val & AS6200_CONFIG_CR_MASK)
> +			>> AS6200_CONFIG_CR_SHIFT;
> +		*val = as6200_conv_rates[cr][0];
> +		*val2 = as6200_conv_rates[cr][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		break;

return -EINVAL;
here and drop it from below

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
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	int i;
> +	unsigned int config_val;
> +	int err = 0;

no need to init err

> +
> +	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(as6200_conv_rates); i++)
> +		if ((val == as6200_conv_rates[i][0]) &&
> +			(val2 == as6200_conv_rates[i][1])) {
> +			err = regmap_read(data->regmap,
> +				AS6200_REG_CONFIG, &config_val);
> +			if (err < 0)
> +				return err;
> +			config_val &= ~AS6200_CONFIG_CR_MASK;
> +			config_val |= i << AS6200_CONFIG_CR_SHIFT;
> +
> +			return regmap_write(data->regmap, AS6200_REG_CONFIG,
> +							config_val);
> +		}
> +	return -EINVAL;
> +}
> +
> +static irqreturn_t as6200_alert_isr(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
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
> +static int as6200_setup_irq(struct iio_dev *indio_dev, bool pol)
> +{
> +	int err;
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
> +	int irq_trig;
> +
> +	if (pol)
> +		irq_trig = IRQF_TRIGGER_RISING;
> +	else
> +		irq_trig = IRQF_TRIGGER_FALLING;
> +
> +	err = request_irq(data->client->irq, as6200_alert_isr, irq_trig,
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
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int err, val;
> +
> +	err = regmap_read(data->regmap, AS6200_REG_THIGH, &reg_val);
> +	if (err < 0)
> +		return err;
> +	reg_val = reg_val >> 4;
> +	val = (625 * reg_val) / 10000;
> +	return sprintf(buf, "%d Degree Celsius\n", val);
> +}
> +

almost the same code for tlow and thigh, maybe a common function?

static ssite_t as6200_show_thres(struct as6200_data *data, char *buf, u8 reg) {
     unsigned int reg_val;
     int err, val;

     err = regmap_read(data->regmap, AS6200_REG_TLOW, &reg_val);
     if (err < 0)
             return err;
     reg_val = reg_val >> 4;
     val = (625 * reg_val) / 10000;
     return sprintf(buf, "%d Degree Celsius\n", val);

}

> +static ssize_t as6200_show_tlow(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);

return as6200_show_thres(data, buf, AS6200_REG_TLOW);

> +}
> +
> +static ssize_t as6200_show_thigh_reg(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int err;
> +
> +	err = regmap_read(data->regmap, AS6200_REG_THIGH, &reg_val);
> +	if (err < 0)
> +		return err;
> +	return sprintf(buf, "%hX\n", reg_val);
> +}
> +
> +static ssize_t as6200_show_tlow_reg(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int err;
> +
> +	err = regmap_read(data->regmap, AS6200_REG_TLOW, &reg_val);
> +	if (err < 0)
> +		return err;
> +	return sprintf(buf, "%hX\n", reg_val);
> +}
> +
> +static ssize_t as6200_show_al(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int err;
> +	bool pol, al;
> +
> +	err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> +	if (err < 0)
> +		return err;
> +	pol = (reg_val & AS6200_CONFIG_POL_MASK) >> AS6200_CONFIG_POL_SHIFT;
> +	al = (reg_val & AS6200_CONFIG_AL_MASK) >> AS6200_CONFIG_AL_SHIFT;
> +	if (pol) {
> +		if (al)
> +			return sprintf(buf, "on\n");
> +		else
> +			return sprintf(buf, "off\n");
> +	} else {
> +		if (al )
> +			return sprintf(buf, "off\n");
> +		else
> +			return sprintf(buf, "on\n");
> +	}
> +}
> +
> +static ssize_t as6200_show_sm(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int err;
> +
> +	err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> +	if (err < 0)
> +		return err;
> +	return sprintf(buf, "%hX\n", (u16)((reg_val & AS6200_CONFIG_SM_MASK)
> +					>> AS6200_CONFIG_SM_SHIFT));
> +}
> +
> +static ssize_t as6200_show_im(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int err;
> +
> +	err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> +	if (err < 0)
> +		return err;
> +	return sprintf(buf, "%hX\n", (u16)((reg_val & AS6200_CONFIG_IM_MASK)
> +					>> AS6200_CONFIG_IM_SHIFT));
> +}
> +
> +static ssize_t as6200_show_pol(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int err;
> +
> +	err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> +	if (err < 0)
> +		return err;
> +	return sprintf(buf, "%hX\n", (u16)((reg_val & AS6200_CONFIG_POL_MASK)
> +					 >> AS6200_CONFIG_POL_SHIFT));
> +}
> +
> +static ssize_t as6200_show_cf(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int err;
> +
> +	err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> +	if (err < 0)
> +		return err;
> +	reg_val = (reg_val & AS6200_CONFIG_CF_MASK) >> AS6200_CONFIG_CF_SHIFT;
> +	return sprintf(buf, "%s\n", as6200_consec_faults[reg_val]);
> +}
> +
> +static ssize_t as6200_show_ss(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int err;
> +
> +	err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> +	if (err < 0)
> +		return err;
> +	return sprintf(buf, "%hX\n", (u16)((reg_val & AS6200_CONFIG_SS_MASK)
> +					>> AS6200_CONFIG_SS_SHIFT));
> +}
> +
> +static ssize_t as6200_set_thigh(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	s16 reg_val;
> +	int err, val;
> +

can't you use the IIO event to configure thresholds

> +	err = kstrtoint(buf, 0, &val);
> +	if (err == 0) {
> +		if ((val < -40) || (val > 150))
> +			return count;
> +		val = (val * 10000) / 625;
> +		reg_val = val << 4;
> +		err = regmap_write(data->regmap, AS6200_REG_THIGH, reg_val);
> +		if (err < 0)
> +			return err;
> +	} else
> +		dev_err(&client->dev,
> +			"Converting value for THIGH failed, err = %hx",
> +			err);
> +	return count;
> +}
> +

try to avoid code duplication

> +static ssize_t as6200_set_tlow(struct device *dev,
> +	struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	s16 reg_val;
> +	int err, val;
> +
> +	err = kstrtoint(buf, 0, &val);
> +	if (err == 0) {
> +		if ((val < -40) || (val > 150)) {
> +			dev_info(&client->dev,
> +				"Value for THIGH is invalid min = -40%cC, max = 150°C, val = %d°C",
> +				(unsigned char)(248), val);
> +			return -ERANGE;
> +		}
> +		val = (val * 10000) / 625;
> +		reg_val = val << 4;
> +		err = regmap_write(data->regmap, AS6200_REG_TLOW, reg_val);
> +		if (err < 0)
> +			return err;
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
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct as6200_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	u16 reg_val;
> +	int err;
> +
> +	err = kstrtou16(buf, 0, &reg_val);
> +	if (err == 0) {
> +		err = regmap_write(data->regmap, AS6200_REG_THIGH, reg_val);
> +		if (err < 0)
> +			return err;
> +	} else
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
> +	int err;
> +	u16 reg_val;
> +
> +	err = kstrtou16(buf, 0, &reg_val);
> +	if (err == 0) {
> +		err = regmap_write(data->regmap, AS6200_REG_TLOW, reg_val);
> +		if (err < 0)
> +			return err;
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for TLOW failed, err = %hx",
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
> +
> +	err = kstrtou16(buf, 0, &val);
> +	if (err == 0) {
> +		err = regmap_update_bits(data->regmap, AS6200_REG_CONFIG,
> +			AS6200_CONFIG_SM_MASK, val << AS6200_CONFIG_SM_SHIFT);
> +		if (err < 0)
> +			return err;
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
> +
> +	err = kstrtou16(buf, 0, &val);
> +	if (err == 0) {
> +		err = regmap_update_bits(data->regmap, AS6200_REG_CONFIG,
> +			AS6200_CONFIG_IM_MASK, val << AS6200_CONFIG_IM_SHIFT);
> +		if (err < 0)
> +			return err;
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
> +	u16 val;
> +
> +	err = kstrtou16(buf, 0, &val);

how about kstrtobool()

> +	if (err == 0) {
> +		free_irq(client->irq, dev);
> +		err = regmap_update_bits(data->regmap, AS6200_REG_CONFIG,
> +			AS6200_CONFIG_POL_MASK,
> +			val << AS6200_CONFIG_POL_SHIFT);
> +		if (err < 0)
> +			return err;
> +		as6200_setup_irq(indio_dev, (bool)val);
> +	} else
> +		dev_info(&client->dev,

dev_err()

> +			"Converting value for POL field failed, err = %hx",
> +			err);

and return an error code

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
> +
> +	err = kstrtou16(buf, 0, &val);
> +	if (err == 0) {
> +		switch (val) {
> +		case 1:
> +		case 2:
> +		case 4:
> +		case 6:
> +			err = regmap_update_bits(data->regmap,
> +				AS6200_REG_CONFIG, AS6200_CONFIG_CF_MASK,
> +				val << AS6200_CONFIG_CF_SHIFT);
> +			if (err < 0)
> +				return err;
> +			break;
> +		default:
> +			dev_info(&client->dev,
> +				"Value for CF field invalid, val = %hx", val);
> +			return count;
> +		}
> +	} else
> +		dev_info(&client->dev,
> +			"Converting value for CF field failed, err = %hx",
> +			err);

error handing still missing?

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
> +
> +	err = kstrtou16(buf, 0, &val);
> +	if (err == 0) {
> +		err = regmap_update_bits(data->regmap, AS6200_REG_CONFIG,
> +			AS6200_CONFIG_SS_MASK, val << AS6200_CONFIG_SS_SHIFT);
> +		if (err < 0)
> +			return err;
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
> +static struct attribute *as6200_attrs[] = {
> +	&iio_dev_attr_thigh.dev_attr.attr,
> +	&iio_dev_attr_tlow.dev_attr.attr,
> +	&iio_dev_attr_thigh_reg.dev_attr.attr,
> +	&iio_dev_attr_tlow_reg.dev_attr.attr,
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
> +static struct attribute_group as6200_attr_group = {
> +	.attrs = as6200_attrs,
> +};
> +
> +static const struct iio_chan_spec as6200_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_PROCESSED) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	}
> +};
> +
> +static const struct iio_info as6200_info = {
> +	.read_raw = as6200_read_raw,
> +	.write_raw = as6200_write_raw,
> +	.attrs = &as6200_attr_group,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int as6200_i2c_probe(struct i2c_client *client,
> +	const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct as6200_data *data;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	data->regmap = devm_regmap_init_i2c(client, &as6200_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		ret = PTR_ERR(data->regmap);
> +		dev_err(&client->dev, "regmap init failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = id->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &as6200_info;
> +
> +	indio_dev->channels = as6200_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(as6200_channels);
> +
> +	ret = as6200_setup_irq(indio_dev, false);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		goto cleanup_irq;
> +
> +	return 0;
> +
> +cleanup_irq:
> +	free_irq(client->irq, &client->dev);
> +
> +	return ret;
> +}
> +
> +static int as6200_i2c_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +	free_irq(client->irq, &client->dev);
> +	return 0;
> +}
> +
> +static const struct of_device_id as6200_of_match[] = {
> +	{ .compatible = "ams,as6200", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, as6200_of_match);
> +

remove newline

> +
> +static const struct i2c_device_id as6200_i2c_id[] = {
> +	{ "as6200", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, as6200_id);
> +
> +static struct i2c_driver as6200_i2c_driver = {
> +	.driver = {
> +		.name = "as6200",
> +		.owner = THIS_MODULE,
> +		.of_match_table = as6200_of_match,
> +	},
> +	.probe = as6200_i2c_probe,
> +	.remove = as6200_i2c_remove,
> +	.id_table = as6200_i2c_id,
> +};
> +
> +module_i2c_driver(as6200_i2c_driver);
> +
> +MODULE_DESCRIPTION("ams AS6200 temperature sensor");
> +MODULE_AUTHOR("Florian Lobmaier <florian.lobmaier@ams.com>");
> +MODULE_AUTHOR("Elitsa Polizoeva <elitsa.polizoeva@ams.com>");
> +MODULE_LICENSE("GPL");
> 
> -----Original Message-----
> From: Peter Meerwald-Stadler [mailto:pmeerw@pmeerw.net] 
> Sent: Freitag, 29. Juli 2016 08:42
> To: Florian Lobmaier <Florian.Lobmaier@ams.com>
> Cc: jic23@kernel.org; Elitsa Polizoeva <Elitsa.Polizoeva@ams.com>; knaack.h@gmx.de; linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; Lars-Peter Clausen <lars@metafoo.de>
> Subject: RE: [PATCH V2 1/1] iio: as6200: add AS6200 temperature sensor driver from ams AG
> 
> Hello Florian,
> 
> > As requested we can also provide a link to the datasheet of the chip: 
> > http://ams.com/eng/Products/Environmental-Sensors/Temperature-Sensors
> > We also tried to cover all points (removed all debug msgs, simpler IRQ 
> > pin config, etc.). Still all the show/store functions for each 
> > configuration bit of the sensor are in. This was a request by our product 
> > management. If you suggest to take the show/store functions out 
> > completely for the driver version in the kernel, we would also be fine 
> > with that. We will give them out on request for customers then.
> 
> looks a lot better; GPL copyright header missing and private API needs to 
> be documented (or removed, but it really is just for debug?)
> 
> more comments below
> 
> regards, p.
> 
> > Signed-off-by: Elitsa Polizoeva <elitsa.polizoeva@ams.com>
> > Signed-off-by: Florian Lobmaier <florian.lobmaier@ams.com>
> > ---
> > diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> > index 21feaa4..d82e80f 100644
> > --- a/drivers/iio/temperature/Kconfig
> > +++ b/drivers/iio/temperature/Kconfig
> > @@ -3,6 +3,17 @@
> >  #
> >  menu "Temperature sensors"
> >  
> > +config AS6200
> > +	tristate "ams AG AS6200 temperature sensor"
> > +	depends on I2C
> > +	select REGMAP_I2C
> > +	help
> > +	  If you say yes here you get support for the AS6200 temperature
> > +	  sensor from ams AG.
> > +
> > +	  This driver can also be built as a module. If so, the module will
> > +	  be called as6200.
> > +
> >  config MLX90614
> >  	tristate "MLX90614 contact-less infrared sensor"
> >  	depends on I2C
> > diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> > index 40710a8..c0c9a9a 100644
> > --- a/drivers/iio/temperature/Makefile
> > +++ b/drivers/iio/temperature/Makefile
> > @@ -2,5 +2,6 @@
> >  # Makefile for industrial I/O temperature drivers
> >  #
> >  
> > +obj-$(CONFIG_AS6200) += as6200.o
> >  obj-$(CONFIG_MLX90614) += mlx90614.o
> >  obj-$(CONFIG_TMP006) += tmp006.o
> > diff --git a/drivers/iio/temperature/as6200.c b/drivers/iio/temperature/as6200.c
> > new file mode 100644
> > index 0000000..289e950
> > --- /dev/null
> > +++ b/drivers/iio/temperature/as6200.c
> > @@ -0,0 +1,789 @@
> 
> there needs to be a GPL copyright header, not sure if MODULE_LICENSE() 
> below is enough
> 
> I find it useful to state the I2C 7-bit chip address here as well
> 
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
> > +static const int as6200_conv_rates[4][2] = { {4, 0}, {1, 0},
> > +					{0, 250000}, {0, 125000} };
> > +
> > +static const char * const as6200_consec_faults[] = { "1", "2", "4", "6" };
> > +
> > +/* AS6200 registers */
> > +#define AS6200_REG_TVAL		0x00
> > +#define AS6200_REG_CONFIG	0x01
> > +#define AS6200_REG_TLOW		0x02
> > +#define AS6200_REG_THIGH	0x03
> > +#define AS6200_MAX_REGISTER	0x03
> > +
> > +#define AS6200_CONFIG_DW_MASK	BIT(4)
> > +#define AS6200_CONFIG_DW_SHIFT	4
> > +#define AS6200_CONFIG_AL_MASK	BIT(5)
> > +#define AS6200_CONFIG_AL_SHIFT	5
> > +#define AS6200_CONFIG_CR_MASK	GENMASK(7, 6)
> > +#define AS6200_CONFIG_CR_SHIFT	6
> > +#define AS6200_CONFIG_SM_MASK	BIT(8)
> > +#define AS6200_CONFIG_SM_SHIFT	8
> > +#define AS6200_CONFIG_IM_MASK	BIT(9)
> > +#define AS6200_CONFIG_IM_SHIFT	9
> > +#define AS6200_CONFIG_POL_MASK	BIT(10)
> > +#define AS6200_CONFIG_POL_SHIFT	10
> > +#define AS6200_CONFIG_CF_MASK	GENMASK(12, 11)
> > +#define AS6200_CONFIG_CF_SHIFT	11
> > +#define AS6200_CONFIG_SS_MASK	BIT(15)
> > +#define AS6200_CONFIG_SS_SHIFT	15
> > +
> > +struct as6200_data {
> > +	struct i2c_client *client;
> > +	struct regmap *regmap;
> > +};
> > +
> > +static const struct regmap_range as6200_readable_ranges[] = {
> > +	regmap_reg_range(AS6200_REG_TVAL, AS6200_REG_THIGH),
> > +};
> > +
> > +static const struct regmap_access_table as6200_readable_table = {
> > +	.yes_ranges = as6200_readable_ranges,
> > +	.n_yes_ranges = ARRAY_SIZE(as6200_readable_ranges),
> > +};
> > +
> > +static const struct regmap_range as6200_writable_ranges[] = {
> > +	regmap_reg_range(AS6200_REG_CONFIG, AS6200_REG_THIGH),
> > +};
> > +
> > +static const struct regmap_access_table as6200_writable_table = {
> > +	.yes_ranges = as6200_writable_ranges,
> > +	.n_yes_ranges = ARRAY_SIZE(as6200_writable_ranges),
> > +};
> > +
> > +static const struct regmap_range as6200_volatile_ranges[] = {
> > +	regmap_reg_range(AS6200_REG_TVAL, AS6200_REG_TVAL),
> > +};
> > +
> > +static const struct regmap_access_table as6200_volatile_table = {
> > +	.yes_ranges = as6200_volatile_ranges,
> > +	.n_yes_ranges = ARRAY_SIZE(as6200_volatile_ranges),
> > +};
> > +
> > +static const struct regmap_config as6200_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 16,
> > +	.max_register = AS6200_MAX_REGISTER,
> > +	.cache_type = REGCACHE_RBTREE,
> > +	.rd_table = &as6200_readable_table,
> > +	.wr_table = &as6200_writable_table,
> > +	.volatile_table = &as6200_volatile_table,
> > +};
> > +
> > +static int as6200_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *channel, int *val,
> > +			    int *val2, long mask)
> > +{
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	int cr;
> > +	s32 ret;
> > +	int err = 0;
> 
> err initialization not needed
> 
> > +	unsigned int reg_val = 0;
> 
> reg_val initialization not needed
> 
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +	case IIO_CHAN_INFO_PROCESSED:
> 
> I'd suggest the following to save some lines and simplity control flow
> 
> if (channel->type != IIO_TEMP)
>    return -EINVAL
> 
> err = regmap_read(data->regmap, AS6200_REG_TVAL, ...
> return IIO_VAL_INT;
> 
> (and similar below)
> 
> > +		if (channel->type == IIO_TEMP) {
> > +			err = regmap_read(data->regmap, AS6200_REG_TVAL,
> > +						&reg_val);
> > +			if (err < 0)
> > +				return err;
> > +			ret = reg_val;
> 
> why this assignment? could do 
> ret = sign_extend32(reg_val, 15) >> 4; 
> 
> > +			ret = sign_extend32(ret, 15) >> 4;
> > +			if (mask == IIO_CHAN_INFO_PROCESSED)
> > +				*val = (ret * 625) / 10000;
> > +			else
> > +				*val = ret;
> > +		} else {
> > +			break;
> > +		}
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		if (channel->type == IIO_TEMP) {
> > +			*val = 62;
> > +			*val2 = 500000;
> > +		} else {
> > +			break;
> > +		}
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		if (channel->type == IIO_TEMP) {
> > +			err = regmap_read(data->regmap, AS6200_REG_CONFIG,
> > +						&reg_val);
> > +			if (err < 0)
> > +				return err;
> > +			cr = (reg_val & AS6200_CONFIG_CR_MASK)
> > +				>> AS6200_CONFIG_CR_SHIFT;
> > +			*val = as6200_conv_rates[cr][0];
> > +			*val2 = as6200_conv_rates[cr][1];
> > +		} else {
> > +			break;
> > +		}
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	default:
> > +		break;
> > +	}
> > +	return -EINVAL;
> > +}
> > +
> > +static int as6200_write_raw(struct iio_dev *indio_dev,
> > +			struct iio_chan_spec const *chan,
> > +			int val,
> > +			int val2,
> > +			long mask)
> > +{
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	int i;
> > +	unsigned int config_val;
> > +	int err = 0;
> > +
> > +	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
> > +		return -EINVAL;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(as6200_conv_rates); i++) {
> > +		if ((val == as6200_conv_rates[i][0]) &&
> > +			(val2 == as6200_conv_rates[i][1])) {
> 
> parenthesis not needed
> 
> > +			err = regmap_read(data->regmap,
> > +				AS6200_REG_CONFIG, &config_val);
> > +			if (err < 0)
> > +				return err;
> > +			config_val &= ~AS6200_CONFIG_CR_MASK;
> > +			config_val |= i << AS6200_CONFIG_CR_SHIFT;
> > +
> > +			return regmap_write(data->regmap, AS6200_REG_CONFIG,
> > +							config_val);
> > +		}
> > +	}
> > +	return -EINVAL;
> > +}
> > +
> > +static irqreturn_t as6200_alert_isr(int irq, void *dev_id)
> > +{
> > +	struct iio_dev *indio_dev = dev_id;
> > +
> > +	iio_push_event(indio_dev,
> > +		IIO_UNMOD_EVENT_CODE(IIO_TEMP,
> > +					0,
> > +					IIO_EV_TYPE_THRESH,
> > +					IIO_EV_DIR_EITHER),
> > +					iio_get_time_ns());
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int as6200_setup_irq(struct iio_dev *indio_dev, bool set_gpio, u8 pol)
> > +{
> > +	int err;
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	struct device *dev = &data->client->dev;
> > +	int irq_trig;
> > +
> 
> set_gpio not used?
> pol could be bool?
> 
> > +	if (pol == 1)
> > +		irq_trig = IRQF_TRIGGER_RISING;
> > +	else
> > +		irq_trig = IRQF_TRIGGER_FALLING;
> > +
> > +	err = request_irq(data->client->irq, as6200_alert_isr, irq_trig,
> > +			"as6200", dev);
> > +	if (err) {
> > +		dev_err(dev, "error requesting irq %d\n", err);
> > +		return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static ssize_t as6200_show_thigh(struct device *dev,
> > +	struct device_attribute *attr, char *buf)
> > +{
> 
> maybe common code could be split out
> 
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	unsigned int reg_val = 0;
> > +	int err = 0;
> 
> init not needed
> 
> > +	int val;
> > +
> > +	err = regmap_read(data->regmap, AS6200_REG_THIGH, &reg_val);
> > +	if (err < 0)
> > +		return err;
> > +	reg_val = reg_val >> 4;
> > +	val = (625 * reg_val) / 10000;
> > +	return sprintf(buf, "%d%cC\n", val, (unsigned char)(248));
> 
> this tries to outputs the extended ASCII ° character (degree), this makes 
> little sense, most terminals are utf-8 and I'm not sure what the policy is 
> WRT non-ASCII
> 
> > +}
> > +
> > +static ssize_t as6200_show_tlow(struct device *dev,
> > +	struct device_attribute *attr, char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	unsigned int reg_val = 0x00;
> > +	int err = 0;
> > +	int val;
> > +
> > +	err = regmap_read(data->regmap, AS6200_REG_TLOW, &reg_val);
> > +	if (err < 0)
> > +		return err;
> > +	reg_val = reg_val >> 4;
> > +	val = (625 * reg_val) / 10000;
> > +	return sprintf(buf, "%d%cC\n", val, (unsigned char)(248));
> > +}
> > +
> > +static ssize_t as6200_show_thigh_reg(struct device *dev,
> > +	struct device_attribute *attr, char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	unsigned int reg_val = 0;
> > +	int err = 0;
> > +
> > +	err = regmap_read(data->regmap, AS6200_REG_THIGH, &reg_val);
> > +	if (err < 0)
> > +		return err;
> > +	return sprintf(buf, "%hX\n", reg_val);
> > +}
> > +
> > +static ssize_t as6200_show_tlow_reg(struct device *dev,
> > +	struct device_attribute *attr, char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	unsigned int reg_val = 0x00;
> > +	int err = 0;
> > +
> > +	err = regmap_read(data->regmap, AS6200_REG_TLOW, &reg_val);
> > +	if (err < 0)
> > +		return err;
> > +	return sprintf(buf, "%hX\n", reg_val);
> > +}
> > +
> > +static ssize_t as6200_show_config(struct device *dev,
> > +	struct device_attribute *attr, char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	unsigned int reg_val = 0x00;
> > +	int err = 0;
> > +
> > +	err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> > +	if (err < 0)
> > +		return err;
> > +	return sprintf(buf, "%hX\n", reg_val);
> > +}
> > +
> > +static ssize_t as6200_show_al(struct device *dev,
> > +	struct device_attribute *attr, char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	unsigned int reg_val = 0x00;
> > +	int err = 0;
> > +	u16 pol = 0;
> 
> init not needed
> 
> > +
> > +	err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> > +	if (err < 0)
> > +		return err;
> > +	pol = (reg_val & AS6200_CONFIG_POL_MASK) >> AS6200_CONFIG_POL_SHIFT;
> > +	reg_val = (reg_val & AS6200_CONFIG_AL_MASK) >> AS6200_CONFIG_AL_SHIFT;
> > +	if (pol == 1) {
> > +		if (reg_val == 0)
> > +			return sprintf(buf, "off\n");
> > +		else if (reg_val == 1)
> > +			return sprintf(buf, "on\n");
> 
> AL_MASK is a bit, I don't see how reg_val can end up different from 0/1
> 
> maybe use a bool for pol?
> 
> 
> 
> > +		else
> > +			return sprintf(buf, "invalid\n");
> > +	} else if (pol == 0) {
> > +		if (reg_val == 0)
> > +			return sprintf(buf, "on\n");
> > +		else if (reg_val == 1)
> > +			return sprintf(buf, "off\n");
> > +		else
> > +			return sprintf(buf, "invalid\n");
> > +	} else
> > +		return sprintf(buf, "invalid\n");
> > +}
> > +
> > +static ssize_t as6200_show_sm(struct device *dev,
> > +	struct device_attribute *attr, char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	unsigned int reg_val = 0x00;
> > +	int err = 0;
> > +
> > +	err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> > +	if (err < 0)
> > +		return err;
> > +	return sprintf(buf, "%hX\n", (reg_val & AS6200_CONFIG_SM_MASK)
> > +					>> AS6200_CONFIG_SM_SHIFT);
> > +}
> > +
> > +static ssize_t as6200_show_im(struct device *dev,
> > +	struct device_attribute *attr, char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	unsigned int reg_val = 0x00;
> > +	int err = 0;
> > +
> > +	err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> > +	if (err < 0)
> > +		return err;
> > +	return sprintf(buf, "%hX\n", (reg_val & AS6200_CONFIG_IM_MASK)
> > +					>> AS6200_CONFIG_IM_SHIFT);
> > +}
> > +
> > +static ssize_t as6200_show_pol(struct device *dev,
> > +	struct device_attribute *attr, char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	unsigned int reg_val = 0x00;
> > +	int err = 0;
> > +
> > +	err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> > +	if (err < 0)
> > +		return err;
> > +	return sprintf(buf, "%hX\n", (reg_val & AS6200_CONFIG_POL_MASK)
> > +					 >> AS6200_CONFIG_POL_SHIFT);
> > +}
> > +
> > +static ssize_t as6200_show_cf(struct device *dev,
> > +	struct device_attribute *attr, char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	unsigned int reg_val = 0x00;
> > +	int err = 0;
> > +
> > +	err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> > +	if (err < 0)
> > +		return err;
> > +	reg_val = (reg_val & AS6200_CONFIG_CF_MASK) >> AS6200_CONFIG_CF_SHIFT;
> 
> could index into consec_faults array of strings to avoid the switch 
> statement?
> 
> > +	switch (reg_val) {
> > +	case 0:
> > +		return sprintf(buf, "1\n");
> > +	case 1:
> > +		return sprintf(buf, "2\n");
> > +	case 2:
> > +		return sprintf(buf, "4\n");
> > +	case 3:
> > +		return sprintf(buf, "6\n");
> > +	}
> > +	return sprintf(buf, "invalid\n");
> > +}
> > +
> > +static ssize_t as6200_show_ss(struct device *dev,
> > +	struct device_attribute *attr, char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	unsigned int reg_val = 0x00;
> > +	int err = 0;
> > +
> > +	err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val);
> > +	if (err < 0)
> > +		return err;
> > +	return sprintf(buf, "%hX\n", (reg_val & AS6200_CONFIG_SS_MASK)
> > +					>> AS6200_CONFIG_SS_SHIFT);
> > +}
> > +
> > +static ssize_t as6200_set_thigh(struct device *dev,
> > +	struct device_attribute *attr, const char *buf, size_t count)
> > +{
> > +	int err = 0;
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	struct i2c_client *client = data->client;
> > +	s16 reg_val;
> > +	int val;
> > +
> > +	err = kstrtoint(buf, 0, &val);
> > +	if (err == 0) {
> > +		if ((val < -40) | (val > 150))
> 
> should be ||
> 
> > +			return count;
> > +		val = (val * 10000) / 625;
> > +		reg_val = val << 4;
> > +		err = regmap_write(data->regmap, AS6200_REG_THIGH, reg_val);
> > +		if (err < 0)
> > +			return err;
> > +	} else
> > +		dev_info(&client->dev,
> 
> use dev_err if it is an error
> 
> > +			"Converting value for THIGH failed, err = %hx",
> > +			err);
> > +	return count;
> > +}
> > +
> > +static ssize_t as6200_set_tlow(struct device *dev,
> > +	struct device_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	struct i2c_client *client = data->client;
> > +	int err = 0;
> > +	s16 reg_val;
> > +	int val;
> > +
> > +	err = kstrtoint(buf, 0, &val);
> > +	if (err == 0) {
> > +		if ((val < -40) | (val > 150)) {
> > +			dev_info(&client->dev,
> > +				"Value for THIGH is invalid min = -40%cC, max = 150°C, val = %d°C",
> > +				(unsigned char)(248), val);
> 
> this should return an error code I think, not count
> 
> > +			return count;
> > +		}
> > +		val = (val * 10000) / 625;
> > +		reg_val = val << 4;
> > +		err = regmap_write(data->regmap, AS6200_REG_TLOW, reg_val);
> > +		if (err < 0)
> > +			return err;
> > +	} else
> > +		dev_info(&client->dev,
> > +			"Converting value for TLOW failed, err = %hx",
> > +			err);
> > +	return count;
> > +}
> > +
> > +static ssize_t as6200_set_thigh_reg(struct device *dev,
> > +	struct device_attribute *attr, const char *buf, size_t count)
> > +{
> > +	int err = 0;
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	struct i2c_client *client = data->client;
> > +	u16 reg_val;
> > +
> > +	err = kstrtou16(buf, 0, &reg_val);
> > +	if (err == 0) {
> > +		err = regmap_write(data->regmap, AS6200_REG_THIGH, reg_val);
> > +		if (err < 0)
> > +			return err;
> > +	} else
> > +		dev_info(&client->dev,
> > +			"Converting value for THIGH failed, err = %hx",
> > +			err);
> > +	return count;
> > +}
> > +
> > +static ssize_t as6200_set_tlow_reg(struct device *dev,
> > +	struct device_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	struct i2c_client *client = data->client;
> > +	int err = 0;
> > +	u16 reg_val;
> > +
> > +	err = kstrtou16(buf, 0, &reg_val);
> > +	if (err == 0) {
> > +		err = regmap_write(data->regmap, AS6200_REG_TLOW, reg_val);
> > +		if (err < 0)
> > +			return err;
> > +	} else
> > +		dev_info(&client->dev,
> > +			"Converting value for TLOW failed, err = %hx",
> > +			err);
> > +	return count;
> > +}
> > +
> > +static ssize_t as6200_set_configreg(struct device *dev,
> > +	struct device_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	struct i2c_client *client = data->client;
> > +	int err = 0;
> > +	u16 reg_val;
> 
> what sense makes a driver abstraction if you allow to set any value 
> imaginable anyways?
> 
> try to reduce code by splitting out common functions
> 
> > +
> > +	err = kstrtou16(buf, 0, &reg_val);
> > +	if (err == 0) {
> > +		err = regmap_write(data->regmap, AS6200_REG_CONFIG, reg_val);
> > +		if (err < 0)
> > +			return err;
> > +	} else
> > +		dev_info(&client->dev,
> > +			"Converting value for CONFIG failed, err = %hx",
> > +			err);
> > +	return count;
> > +}
> > +
> 
> drop newline
> 
> > +
> > +static ssize_t as6200_set_sm(struct device *dev,
> > +	struct device_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	struct i2c_client *client = data->client;
> > +	int err;
> > +	u16 val;
> > +
> > +	err = kstrtou16(buf, 0, &val);
> > +	if (err == 0) {
> > +		err = regmap_update_bits(data->regmap, AS6200_REG_CONFIG,
> > +			AS6200_CONFIG_SM_MASK, val << AS6200_CONFIG_SM_SHIFT);
> > +		if (err < 0)
> > +			return err;
> > +	} else
> > +		dev_info(&client->dev,
> > +			"Converting value for SM field failed, err = %hx",
> > +			err);
> > +	return count;
> > +}
> > +
> > +static ssize_t as6200_set_im(struct device *dev,
> > +	struct device_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	struct i2c_client *client = data->client;
> > +	int err;
> > +	u16 val;
> > +
> > +	err = kstrtou16(buf, 0, &val);
> > +	if (err == 0) {
> > +		err = regmap_update_bits(data->regmap, AS6200_REG_CONFIG,
> > +			AS6200_CONFIG_IM_MASK, val << AS6200_CONFIG_IM_SHIFT);
> > +		if (err < 0)
> > +			return err;
> > +	} else
> > +		dev_info(&client->dev,
> > +			"Converting value for IM field failed, err = %hx",
> > +			err);
> > +	return count;
> > +}
> > +
> > +static ssize_t as6200_set_pol(struct device *dev,
> > +	struct device_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	struct i2c_client *client = data->client;
> > +	int err;
> > +	u16 val;
> > +
> > +	err = kstrtou16(buf, 0, &val);
> > +	if (err == 0) {
> > +		free_irq(client->irq, dev);
> > +		err = regmap_update_bits(data->regmap, AS6200_REG_CONFIG,
> > +			AS6200_CONFIG_POL_MASK,
> > +			val << AS6200_CONFIG_POL_SHIFT);
> > +		if (err < 0)
> 
> so irq is invalid here, but remove() would free it again?
> 
> > +			return err;
> > +		as6200_setup_irq(indio_dev, false, val);
> > +	} else
> > +		dev_info(&client->dev,
> > +			"Converting value for POL field failed, err = %hx",
> > +			err);
> > +	return count;
> > +}
> > +
> > +static ssize_t as6200_set_cf(struct device *dev,
> > +	struct device_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	struct i2c_client *client = data->client;
> > +	int err;
> > +	u16 val;
> > +
> > +	err = kstrtou16(buf, 0, &val);
> > +	if (err == 0) {
> > +		switch (val) {
> > +		case 1:
> > +		case 2:
> > +		case 4:
> > +		case 6:
> > +			err = regmap_update_bits(data->regmap,
> > +				AS6200_REG_CONFIG, AS6200_CONFIG_CF_MASK,
> > +				val << AS6200_CONFIG_CF_SHIFT);
> > +			if (err < 0)
> > +				return err;
> > +			break;
> > +		default:
> > +			dev_info(&client->dev,
> > +				"Value for CF field invalid, val = %hx", val);
> > +			return count;
> > +		}
> > +	} else
> > +		dev_info(&client->dev,
> > +			"Converting value for CF field failed, err = %hx",
> > +			err);
> > +	return count;
> > +}
> > +
> > +static ssize_t as6200_set_ss(struct device *dev,
> > +	struct device_attribute *attr, const char *buf, size_t count)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct as6200_data *data = iio_priv(indio_dev);
> > +	struct i2c_client *client = data->client;
> > +	int err;
> > +	u16 val;
> > +
> > +	err = kstrtou16(buf, 0, &val);
> > +	if (err == 0) {
> > +		err = regmap_update_bits(data->regmap, AS6200_REG_CONFIG,
> > +			AS6200_CONFIG_SS_MASK, val << AS6200_CONFIG_SS_SHIFT);
> > +		if (err < 0)
> > +			return err;
> > +	} else
> > +		dev_info(&client->dev,
> > +			"Converting value for SS field failed, err = %hx",
> > +			err);
> > +	return count;
> > +}
> > +
> > +static IIO_DEVICE_ATTR(thigh, S_IWUSR | S_IRUGO, as6200_show_thigh,
> > +	as6200_set_thigh, 0);
> > +static IIO_DEVICE_ATTR(tlow, S_IWUSR | S_IRUGO, as6200_show_tlow,
> > +	as6200_set_tlow, 0);
> > +static IIO_DEVICE_ATTR(thigh_reg, S_IWUSR | S_IRUGO, as6200_show_thigh_reg,
> > +	as6200_set_thigh_reg, 0);
> > +static IIO_DEVICE_ATTR(tlow_reg, S_IWUSR | S_IRUGO, as6200_show_tlow_reg,
> > +	as6200_set_tlow_reg, 0);
> > +static IIO_DEVICE_ATTR(config, S_IWUSR | S_IRUGO, as6200_show_config,
> > +	as6200_set_configreg, 0);
> > +static IIO_DEVICE_ATTR(al, S_IRUGO, as6200_show_al, NULL, 0);
> > +static IIO_DEVICE_ATTR(sm, S_IWUSR | S_IRUGO, as6200_show_sm,
> > +	as6200_set_sm, 0);
> > +static IIO_DEVICE_ATTR(im, S_IWUSR | S_IRUGO, as6200_show_im,
> > +	as6200_set_im, 0);
> > +static IIO_DEVICE_ATTR(pol, S_IWUSR | S_IRUGO, as6200_show_pol,
> > +	as6200_set_pol, 0);
> > +static IIO_DEVICE_ATTR(cf, S_IWUSR | S_IRUGO, as6200_show_cf,
> > +	as6200_set_cf, 0);
> > +static IIO_DEVICE_ATTR(ss, S_IWUSR | S_IRUGO, as6200_show_ss,
> > +	as6200_set_ss, 0);
> > +
> > +static IIO_CONST_ATTR(sampling_frequency_available, "4 1 0.25 0.125");
> > +
> > +static struct attribute *as6200_attrs[] = {
> > +	&iio_dev_attr_thigh.dev_attr.attr,
> > +	&iio_dev_attr_tlow.dev_attr.attr,
> > +	&iio_dev_attr_thigh_reg.dev_attr.attr,
> > +	&iio_dev_attr_tlow_reg.dev_attr.attr,
> > +	&iio_dev_attr_config.dev_attr.attr,
> > +	&iio_dev_attr_al.dev_attr.attr,
> > +	&iio_dev_attr_sm.dev_attr.attr,
> > +	&iio_dev_attr_im.dev_attr.attr,
> > +	&iio_dev_attr_pol.dev_attr.attr,
> > +	&iio_dev_attr_cf.dev_attr.attr,
> > +	&iio_dev_attr_ss.dev_attr.attr,
> > +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> > +	NULL,
> > +};
> > +
> > +static struct attribute_group as6200_attr_group = {
> > +	.attrs = as6200_attrs,
> > +};
> > +
> > +static const struct iio_chan_spec as6200_channels[] = {
> > +	{
> > +		.type = IIO_TEMP,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +			BIT(IIO_CHAN_INFO_PROCESSED) |
> > +			BIT(IIO_CHAN_INFO_SCALE),
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +	}
> > +};
> > +
> > +static const struct iio_info as6200_info = {
> > +	.read_raw = as6200_read_raw,
> > +	.write_raw = as6200_write_raw,
> > +	.attrs = &as6200_attr_group,
> > +	.driver_module = THIS_MODULE,
> > +};
> > +
> > +static int as6200_i2c_probe(struct i2c_client *client,
> > +	const struct i2c_device_id *id)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct as6200_data *data;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	i2c_set_clientdata(client, indio_dev);
> > +	data->client = client;
> > +
> > +	data->regmap = devm_regmap_init_i2c(client, &as6200_regmap_config);
> > +	if (IS_ERR(data->regmap)) {
> > +		ret = PTR_ERR(data->regmap);
> > +		dev_err(&client->dev, "regmap init failed: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	indio_dev->dev.parent = &client->dev;
> > +	indio_dev->name = id->name;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->info = &as6200_info;
> > +
> > +	indio_dev->channels = as6200_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(as6200_channels);
> > +
> > +	ret = as6200_setup_irq(indio_dev, true, 0);
> > +	if (ret < 0)
> 
> if setup_irq() fails, irq has not been requested and no cleanup is needed
> 
> > +		goto cleanup_irq;
> > +
> > +	return iio_device_register(indio_dev);
> 
> however, if iio_device_register() fails, the irq needs to be freed
> 
> > +
> > +cleanup_irq:
> > +	free_irq(client->irq, &client->dev);
> > +
> > +	return ret;
> > +}
> > +
> > +static int as6200_i2c_remove(struct i2c_client *client)
> > +{
> > +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> > +
> > +	iio_device_unregister(indio_dev);
> > +	free_irq(client->irq, &client->dev);
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id as6200_of_match[] = {
> > +	{ .compatible = "ams,as6200", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, as6200_of_match);
> > +
> > +
> > +static const struct i2c_device_id as6200_i2c_id[] = {
> > +	{ "as6200", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, as6200_id);
> > +
> > +static struct i2c_driver as6200_i2c_driver = {
> > +	.driver = {
> > +		.name = "as6200",
> > +		.owner = THIS_MODULE,
> > +		.of_match_table = as6200_of_match,
> > +	},
> > +	.probe = as6200_i2c_probe,
> > +	.remove = as6200_i2c_remove,
> > +	.id_table = as6200_i2c_id,
> > +};
> > +
> > +module_i2c_driver(as6200_i2c_driver);
> > +
> > +MODULE_DESCRIPTION("ams AS6200 temperature sensor");
> > +MODULE_AUTHOR("Elitsa Polizoeva <elitsa.polizoeva@ams.com>");
> > +MODULE_AUTHOR("Florian Lobmaier <florian.lobmaier@ams.com>");
> > +MODULE_LICENSE("GPL");
> > 
> > -----Original Message-----
> > From: Peter Meerwald-Stadler [mailto:pmeerw@pmeerw.net] 
> > Sent: Dienstag, 21. Juni 2016 15:12
> > To: Florian Lobmaier <Florian.Lobmaier@ams.com>
> > Cc: jic23@kernel.org; Elitsa Polizoeva <Elitsa.Polizoeva@ams.com>; knaack.h@gmx.de; linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org; Lars-Peter Clausen <lars@metafoo.de>
> > Subject: RE: [PATCH V1 1/1] iio: as6200: add AS6200 temperature sensor driver from ams AG
> > 
> > 
> > > Finally we got a Datasheet which we can release and share with you. 
> > > Thanks for the feedback, we tried to integrate most of the feedback in 
> > > the driver. Some proprietary API is still present as all features of 
> > > the chip should be reachable. If there are any features we could use 
> > > from the iio framework we overlooked, please let us know.
> > 
> > can you provide a link to the datasheet? I almost missed the attached document...
> > 
> > more comments below, there still seems to be many issues; I stopped reviewing at some point where I noticed that previous comments have not beed addressed
> > 
> > thanks, regards, p.
> > 
> > > Signed-off-by: Elitsa Polizoeva <elitsa.polizoeva@ams.com>
> > > Signed-off-by: Florian Lobmaier <florian.lobmaier@ams.com>
> > > ---
> > > diff --git a/drivers/iio/temperature/Kconfig 
> > > b/drivers/iio/temperature/Kconfig index 21feaa4..d82e80f 100644
> > > --- a/drivers/iio/temperature/Kconfig
> > > +++ b/drivers/iio/temperature/Kconfig
> > > @@ -3,6 +3,17 @@
> > >  #
> > >  menu "Temperature sensors"
> > >  
> > > +config AS6200
> > > +tristate "ams AG AS6200 temperature sensor"
> > > +depends on I2C
> > > +select REGMAP_I2C
> > > +help
> > > +  If you say yes here you get support for the AS6200 temperature
> > > +  sensor from ams AG.
> > > +
> > > +  This driver can also be built as a module. If so, the module will  
> > > + be called as6200.
> > > +
> > >  config MLX90614
> > >  tristate "MLX90614 contact-less infrared sensor"
> > >  depends on I2C
> > > diff --git a/drivers/iio/temperature/Makefile 
> > > b/drivers/iio/temperature/Makefile
> > > index 40710a8..c0c9a9a 100644
> > > --- a/drivers/iio/temperature/Makefile
> > > +++ b/drivers/iio/temperature/Makefile
> > > @@ -2,5 +2,6 @@
> > >  # Makefile for industrial I/O temperature drivers  #
> > >  
> > > +obj-$(CONFIG_AS6200) += as6200.o
> > >  obj-$(CONFIG_MLX90614) += mlx90614.o
> > >  obj-$(CONFIG_TMP006) += tmp006.o
> > > diff --git a/drivers/iio/temperature/as6200.c 
> > > b/drivers/iio/temperature/as6200.c
> > > new file mode 100644
> > > index 0000000..5e37227
> > > --- /dev/null
> > > +++ b/drivers/iio/temperature/as6200.c
> > > @@ -0,0 +1,808 @@
> > 
> > it is customary to put the GPL license statement here
> > 
> > > +#include <linux/module.h>
> > > +#include <linux/device.h>
> > > +#include <linux/init.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/err.h>
> > > +#include <linux/types.h>
> > > +#include <linux/irq.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/gpio.h>
> > > +#include <linux/of_gpio.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/sysfs.h>
> > > +#include <linux/iio/events.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +/* to support regmap define in version 3.12 */
> > > +/* supported officially in kernel 3.13 and later */
> > 
> > please remove these comments, not relevant for mainline and not a proper multi-line comment
> > 
> > > +#define regmap_reg_range(low, high) { .range_min = low, .range_max = 
> > > +high, }
> > 
> > as6200_ prefix needed
> > 
> > > +
> > > +static const int as6200_conv_rates[4][2] = { {4, 0}, {1, 0}, {0, 
> > > +250000}, {0, 125000} };
> > > +
> > > +static const char * const as6200_consec_faults[] = { "1", "2", "4", 
> > > +"6" };
> > > +
> > > +/* AS6200 registers */
> > > +#define AS6200_REG_TVAL0x00
> > > +#define AS6200_REG_CONFIG0x01
> > > +#define AS6200_REG_TLOW0x02
> > > +#define AS6200_REG_THIGH0x03
> > > +#define AS6200_MAX_REGISTER0x03
> > > +
> > > +#define AS6200_CONFIG_DW_MASK0x0010
> > 
> > could use GENMASK() or BIT() macros to make it clearer which bits are relevant
> > 
> > > +#define AS6200_CONFIG_DW_SHIFT4
> > > +#define AS6200_CONFIG_AL_MASK0x0020
> > > +#define AS6200_CONFIG_AL_SHIFT5
> > > +#define AS6200_CONFIG_CR_MASK0x00C0
> > > +#define AS6200_CONFIG_CR_SHIFT6
> > > +#define AS6200_CONFIG_SM_MASK0x0100
> > > +#define AS6200_CONFIG_SM_SHIFT8
> > > +#define AS6200_CONFIG_IM_MASK0x0200
> > > +#define AS6200_CONFIG_IM_SHIFT9
> > > +#define AS6200_CONFIG_POL_MASK0x0400
> > > +#define AS6200_CONFIG_POL_SHIFT10
> > > +#define AS6200_CONFIG_CF_MASK0x1800
> > > +#define AS6200_CONFIG_CF_SHIFT11
> > > +#define AS6200_CONFIG_SS_MASK0x8000
> > > +#define AS6200_CONFIG_SS_SHIFT15
> > > +
> > > +struct as6200_data {
> > > +struct mutex update_lock;
> > 
> > mutex used anywhere?
> > 
> > > +struct i2c_client *client;
> > > +int irqn;
> > > +unsigned long irq_flags;
> > 
> > irq_flags not used
> > 
> > > +int gpio;
> > > +char valid; /* !=0 if following fields are valid */ struct regmap 
> > > +*regmap; };
> > > +
> > 
> > drop newline
> > 
> > > +
> > > +static const struct regmap_range as6200_readable_ranges[] = { 
> > > +regmap_reg_range(AS6200_REG_TVAL, AS6200_REG_THIGH), };
> > 
> > add newline (here and below: one newline please)
> > 
> > > +static const struct regmap_access_table as6200_readable_table = { 
> > > +.yes_ranges = as6200_readable_ranges, .n_yes_ranges = 
> > > +ARRAY_SIZE(as6200_readable_ranges),
> > > +};
> > > +
> > > +static const struct regmap_range as6200_writable_ranges[] = { 
> > > +regmap_reg_range(AS6200_REG_CONFIG, AS6200_REG_THIGH), }; static 
> > > +const struct regmap_access_table as6200_writable_table = { 
> > > +.yes_ranges = as6200_writable_ranges, .n_yes_ranges = 
> > > +ARRAY_SIZE(as6200_writable_ranges),
> > > +};
> > > +
> > > +static const struct regmap_range as6200_volatile_ranges[] = { 
> > > +regmap_reg_range(AS6200_REG_TVAL, AS6200_REG_TVAL), }; static const 
> > > +struct regmap_access_table as6200_volatile_table = { .yes_ranges = 
> > > +as6200_volatile_ranges, .n_yes_ranges = 
> > > +ARRAY_SIZE(as6200_volatile_ranges),
> > > +};
> > > +static const struct regmap_config as6200_regmap_config = { .reg_bits 
> > > += 8, .val_bits = 16, .max_register = AS6200_MAX_REGISTER, .cache_type 
> > > += REGCACHE_RBTREE, .rd_table = &as6200_readable_table, .wr_table = 
> > > +&as6200_writable_table, .volatile_table = &as6200_volatile_table, };
> > > +
> > > +
> > > +static int as6200_read_raw(struct iio_dev *indio_dev,
> > > +    struct iio_chan_spec const *channel, int *val,
> > > +    int *val2, long mask)
> > > +{
> > > +struct as6200_data *data = iio_priv(indio_dev); struct i2c_client 
> > > +*client = data->client; int err = 0; unsigned int reg_val = 0; int cr 
> > > += 0;
> > > +s32 ret = 0;
> > 
> > try to avoid unnecessary initialization
> > 
> > > +
> > > +switch (mask) {
> > > +case IIO_CHAN_INFO_RAW:
> > > +if (channel->type == IIO_TEMP) {
> > > +err = regmap_read(data->regmap, AS6200_REG_TVAL, &reg_val);
> > 
> > error checking?
> > 
> > > +ret = reg_val;
> > > +*val = sign_extend32(ret, 15) >> 4;
> > > +} else {
> > > +break;
> > > +}
> > > +return IIO_VAL_INT;
> > > +case IIO_CHAN_INFO_PROCESSED:
> > > +if (channel->type == IIO_TEMP) {
> > > +err = regmap_read(data->regmap, AS6200_REG_TVAL, &reg_val); ret = 
> > > +sign_extend32(ret, 15) >> 4; *val = (ret * 625) / 10000; } else { 
> > > +break; } return IIO_VAL_INT;
> > 
> > I suggest to drop _INFO_PROCESSED as _RAW + _SCALE offers equivalent information; _PROCESSED is not in the chan_spec?!
> > 
> > otherwise, the code path are rather similar and could be combined
> > 
> > > +case IIO_CHAN_INFO_SCALE:
> > > +if (channel->type == IIO_TEMP) {
> > > +*val = 62;
> > > +*val2 = 500000;
> > > +} else {
> > > +break;
> > > +}
> > > +return IIO_VAL_INT_PLUS_MICRO;
> > > +case IIO_CHAN_INFO_SAMP_FREQ:
> > > +if (channel->type == IIO_TEMP) {
> > > +dev_info(&client->dev, "get CR from reg");
> > 
> > debug message, please remove
> > 
> > > +err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val); cr = 
> > > +(reg_val & AS6200_CONFIG_CR_MASK)
> > > +>> AS6200_CONFIG_CR_SHIFT;
> > > +*val = as6200_conv_rates[cr][0];
> > > +*val2 = as6200_conv_rates[cr][1];
> > > +} else {
> > > +break;
> > > +}
> > > +return IIO_VAL_INT_PLUS_MICRO;
> > > +default:
> > > +break;
> > > +}
> > > +return -EINVAL;
> > > +}
> > > +
> > > +static int as6200_write_raw(struct iio_dev *indio_dev, struct 
> > > +iio_chan_spec const *chan, int val, int val2, long mask) { struct 
> > > +as6200_data *data = iio_priv(indio_dev); int i; unsigned int 
> > > +config_val;
> > > +
> > > +if (mask != IIO_CHAN_INFO_SAMP_FREQ)
> > > +return -EINVAL;
> > > +
> > > +for (i = 0; i < ARRAY_SIZE(as6200_conv_rates); i++) { if ((val == 
> > > +as6200_conv_rates[i][0]) &&
> > > +(val2 == as6200_conv_rates[i][1])) {
> > > +regmap_read(data->regmap,
> > > +AS6200_REG_CONFIG, &config_val);
> > > +config_val &= ~AS6200_CONFIG_CR_MASK; config_val |= i << 
> > > +AS6200_CONFIG_CR_SHIFT;
> > > +
> > > +return regmap_write(data->regmap, AS6200_REG_CONFIG, config_val); } } 
> > > +return -EINVAL; }
> > > +
> > > +static irqreturn_t as6200_alert_isr(int irq, void *dev_id) { struct 
> > > +iio_dev *indio_dev = dev_id;
> > > +
> > > +iio_push_event(indio_dev,
> > > +IIO_UNMOD_EVENT_CODE(IIO_TEMP,
> > > +0,
> > > +IIO_EV_TYPE_THRESH,
> > > +IIO_EV_DIR_EITHER),
> > > +iio_get_time_ns());
> > > +return IRQ_HANDLED;
> > > +}
> > > +
> > > +static int as6200_setup_irq(struct iio_dev *indio_dev, bool set_gpio, 
> > > +u8 pol) { int err; struct as6200_data *data = iio_priv(indio_dev); 
> > > +struct device *dev = &data->client->dev; int gpio = -1; int irq_num; 
> > > +int irq_trig;
> > > +
> > > +if (pol == 1)
> > > +irq_trig = IRQF_TRIGGER_RISING;
> > > +else
> > > +irq_trig = IRQF_TRIGGER_FALLING;
> > > +
> > > +if (set_gpio) {
> > > +gpio = of_get_named_gpio_flags(dev->of_node,
> > > +"as6200,irq-gpio", 0, 0);
> > > +err = gpio_request(gpio, "as6200_irq"); if (err) { dev_err(dev, 
> > > +"requesting gpio %d failed\n", gpio); return err; } err = 
> > > +gpio_direction_input(gpio); if (err) { dev_err(dev, "gpio %d cannot 
> > > +apply direction\n", gpio); return err; } }
> > > +data->gpio = gpio;
> > > +irq_num = gpio_to_irq(gpio);
> > > +err = request_irq(irq_num, as6200_alert_isr, irq_trig, "as6200", 
> > > +dev); if (err) { dev_err(dev, "error requesting irq %d\n", err); 
> > > +return err; }
> > > +data->irqn = irq_num;
> > > +
> > > +return 0;
> > > +}
> > > +
> > > +static ssize_t as6200_show_thigh(struct device *dev, struct 
> > > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev = 
> > > +dev_to_iio_dev(dev); struct as6200_data *data = iio_priv(indio_dev); 
> > > +unsigned int reg_val = 0; int err = 0; int val;
> > > +
> > > +err = regmap_read(data->regmap, AS6200_REG_THIGH, &reg_val); reg_val 
> > > += reg_val >> 4; val = (625 * reg_val) / 10000; return sprintf(buf, 
> > > +"%d%cC\n", val, (unsigned char)(248)); }
> > > +
> > > +static ssize_t as6200_show_tlow(struct device *dev, struct 
> > > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev = 
> > > +dev_to_iio_dev(dev); struct as6200_data *data = iio_priv(indio_dev); 
> > > +unsigned int reg_val = 0x00; int err = 0; int val;
> > > +
> > > +err = regmap_read(data->regmap, AS6200_REG_TLOW, &reg_val); reg_val = 
> > > +reg_val >> 4; val = (625 * reg_val) / 10000; return sprintf(buf, 
> > > +"%d%cC\n", val, (unsigned char)(248)); }
> > > +
> > > +static ssize_t as6200_show_thigh_reg(struct device *dev, struct 
> > > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev = 
> > > +dev_to_iio_dev(dev); struct as6200_data *data = iio_priv(indio_dev); 
> > > +unsigned int reg_val = 0; int err = 0;
> > > +
> > > +err = regmap_read(data->regmap, AS6200_REG_THIGH, &reg_val); return 
> > > +sprintf(buf, "%hX\n", reg_val); }
> > > +
> > > +static ssize_t as6200_show_tlow_reg(struct device *dev, struct 
> > > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev = 
> > > +dev_to_iio_dev(dev); struct as6200_data *data = iio_priv(indio_dev); 
> > > +unsigned int reg_val = 0x00; int err = 0;
> > > +
> > > +err = regmap_read(data->regmap, AS6200_REG_TLOW, &reg_val); return 
> > > +sprintf(buf, "%hX\n", reg_val); }
> > > +
> > > +static ssize_t as6200_show_config(struct device *dev, struct 
> > > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev = 
> > > +dev_to_iio_dev(dev); struct as6200_data *data = iio_priv(indio_dev); 
> > > +unsigned int reg_val = 0x00; int err = 0;
> > > +
> > > +err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val); return 
> > > +sprintf(buf, "%hX\n", reg_val); }
> > > +
> > > +static ssize_t as6200_show_al(struct device *dev, struct 
> > > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev = 
> > > +dev_to_iio_dev(dev); struct as6200_data *data = iio_priv(indio_dev); 
> > > +unsigned int reg_val = 0x00; int err = 0;
> > > +u16 pol = 0;
> > > +
> > > +err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val); pol = 
> > > +(reg_val & AS6200_CONFIG_POL_MASK) >> AS6200_CONFIG_POL_SHIFT; 
> > > +reg_val = (reg_val & AS6200_CONFIG_AL_MASK) >> 
> > > +AS6200_CONFIG_AL_SHIFT; if (pol == 1) { if (reg_val == 0) return 
> > > +sprintf(buf, "off\n"); else if (reg_val == 1) return sprintf(buf, 
> > > +"on\n"); else return sprintf(buf, "invalid\n"); } else if (pol == 0) 
> > > +{ if (reg_val == 0) return sprintf(buf, "on\n"); else if (reg_val == 
> > > +1) return sprintf(buf, "off\n"); else return sprintf(buf, 
> > > +"invalid\n"); } else return sprintf(buf, "invalid\n"); }
> > > +
> > > +static ssize_t as6200_show_sm(struct device *dev, struct 
> > > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev = 
> > > +dev_to_iio_dev(dev); struct as6200_data *data = iio_priv(indio_dev); 
> > > +unsigned int reg_val = 0x00; int err = 0;
> > > +
> > > +err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val); return 
> > > +sprintf(buf, "%hX\n", (reg_val & AS6200_CONFIG_SM_MASK)
> > > +>> AS6200_CONFIG_SM_SHIFT);
> > > +}
> > > +
> > > +static ssize_t as6200_show_im(struct device *dev, struct 
> > > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev = 
> > > +dev_to_iio_dev(dev); struct as6200_data *data = iio_priv(indio_dev); 
> > > +unsigned int reg_val = 0x00; int err = 0;
> > > +
> > > +err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val); return 
> > > +sprintf(buf, "%hX\n", (reg_val & AS6200_CONFIG_IM_MASK)
> > > +>> AS6200_CONFIG_IM_SHIFT);
> > > +}
> > > +
> > > +static ssize_t as6200_show_pol(struct device *dev, struct 
> > > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev = 
> > > +dev_to_iio_dev(dev); struct as6200_data *data = iio_priv(indio_dev); 
> > > +unsigned int reg_val = 0x00; int err = 0;
> > > +
> > > +err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val); return 
> > > +sprintf(buf, "%hX\n", (reg_val & AS6200_CONFIG_POL_MASK)
> > > + >> AS6200_CONFIG_POL_SHIFT);
> > > +}
> > > +
> > > +static ssize_t as6200_show_cf(struct device *dev, struct 
> > > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev = 
> > > +dev_to_iio_dev(dev); struct as6200_data *data = iio_priv(indio_dev); 
> > > +unsigned int reg_val = 0x00; int err = 0;
> > > +
> > > +err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val); reg_val 
> > > += (reg_val & AS6200_CONFIG_CF_MASK) >> AS6200_CONFIG_CF_SHIFT; switch 
> > > +(reg_val) { case 0:
> > > +return sprintf(buf, "1\n");
> > > +case 1:
> > > +return sprintf(buf, "2\n");
> > > +case 2:
> > > +return sprintf(buf, "4\n");
> > > +case 3:
> > > +return sprintf(buf, "6\n");
> > > +}
> > > +return sprintf(buf, "invalid\n");
> > > +}
> > > +
> > > +static ssize_t as6200_show_ss(struct device *dev, struct 
> > > +device_attribute *attr, char *buf) { struct iio_dev *indio_dev = 
> > > +dev_to_iio_dev(dev); struct as6200_data *data = iio_priv(indio_dev); 
> > > +unsigned int reg_val = 0x00; int err = 0;
> > > +
> > > +err = regmap_read(data->regmap, AS6200_REG_CONFIG, &reg_val); return 
> > > +sprintf(buf, "%hX\n", (reg_val & AS6200_CONFIG_SS_MASK)
> > > +>> AS6200_CONFIG_SS_SHIFT);
> > > +}
> > > +
> > > +static ssize_t as6200_set_thigh(struct device *dev, struct 
> > > +device_attribute *attr, const char *buf, size_t count) { int err = 0; 
> > > +struct iio_dev *indio_dev = dev_to_iio_dev(dev); struct as6200_data 
> > > +*data = iio_priv(indio_dev); struct i2c_client *client = 
> > > +data->client;
> > > +s16 reg_val;
> > > +int val;
> > > +
> > > +err = kstrtoint(buf, 0, &val);
> > > +if (err == 0) {
> > > +if ((val < -40) | (val > 150))
> > > +return count;
> > > +val = (val * 10000) / 625;
> > > +reg_val = val << 4;
> > > +err = regmap_write(data->regmap, AS6200_REG_THIGH, reg_val); } else 
> > > +dev_info(&client->dev, "Converting value for THIGH failed, err = 
> > > +%hx", err); return count; }
> > > +
> > > +static ssize_t as6200_set_tlow(struct device *dev, struct 
> > > +device_attribute *attr, const char *buf, size_t count) { struct 
> > > +iio_dev *indio_dev = dev_to_iio_dev(dev); struct as6200_data *data = 
> > > +iio_priv(indio_dev); struct i2c_client *client = data->client; int 
> > > +err = 0;
> > > +s16 reg_val;
> > > +int val;
> > > +
> > > +err = kstrtoint(buf, 0, &val);
> > > +if (err == 0) {
> > > +if ((val < -40) | (val > 150)) {
> > > +dev_info(&client->dev,
> > > +"Value for THIGH is invalid min = -40%cC, max = 150°C, val = %d°C", 
> > > +(unsigned char)(248), val); return count; } val = (val * 10000) / 
> > > +625; reg_val = val << 4; err = regmap_write(data->regmap, 
> > > +AS6200_REG_TLOW, reg_val); } else dev_info(&client->dev, "Converting 
> > > +value for TLOW failed, err = %hx", err); return count; }
> > > +
> > > +static ssize_t as6200_set_thigh_reg(struct device *dev, struct 
> > > +device_attribute *attr, const char *buf, size_t count) { int err = 0; 
> > > +struct iio_dev *indio_dev = dev_to_iio_dev(dev); struct as6200_data 
> > > +*data = iio_priv(indio_dev); struct i2c_client *client = 
> > > +data->client;
> > > +u16 reg_val;
> > > +
> > > +err = kstrtou16(buf, 0, &reg_val);
> > > +if (err == 0)
> > > +err = regmap_write(data->regmap, AS6200_REG_THIGH, reg_val); else 
> > > +dev_info(&client->dev, "Converting value for THIGH failed, err = 
> > > +%hx", err); return count; }
> > > +
> > > +static ssize_t as6200_set_tlow_reg(struct device *dev, struct 
> > > +device_attribute *attr, const char *buf, size_t count) { struct 
> > > +iio_dev *indio_dev = dev_to_iio_dev(dev); struct as6200_data *data = 
> > > +iio_priv(indio_dev); struct i2c_client *client = data->client; int 
> > > +err = 0;
> > > +u16 reg_val;
> > > +
> > > +err = kstrtou16(buf, 0, &reg_val);
> > > +if (err == 0)
> > > +err = regmap_write(data->regmap, AS6200_REG_TLOW, reg_val); else 
> > > +dev_info(&client->dev, "Converting value for TLOW failed, err = %hx", 
> > > +err); return count; }
> > > +
> > > +static ssize_t as6200_set_configreg(struct device *dev, struct 
> > > +device_attribute *attr, const char *buf, size_t count) { struct 
> > > +iio_dev *indio_dev = dev_to_iio_dev(dev); struct as6200_data *data = 
> > > +iio_priv(indio_dev); struct i2c_client *client = data->client; int 
> > > +err = 0;
> > > +u16 reg_val;
> > > +
> > > +err = kstrtou16(buf, 0, &reg_val);
> > > +if (err == 0)
> > > +err = regmap_write(data->regmap, AS6200_REG_CONFIG, reg_val); else 
> > > +dev_info(&client->dev, "Converting value for CONFIG failed, err = 
> > > +%hx", err); return count; }
> > > +
> > > +
> > > +static ssize_t as6200_set_sm(struct device *dev, struct 
> > > +device_attribute *attr, const char *buf, size_t count) { struct 
> > > +iio_dev *indio_dev = dev_to_iio_dev(dev); struct as6200_data *data = 
> > > +iio_priv(indio_dev); struct i2c_client *client = data->client; int 
> > > +err;
> > > +u16 val;
> > > +
> > > +err = kstrtou16(buf, 0, &val);
> > > +if (err == 0) {
> > > +err = regmap_update_bits(data->regmap, AS6200_REG_CONFIG, 
> > > +AS6200_CONFIG_SM_MASK, val << AS6200_CONFIG_SM_SHIFT); } else 
> > > +dev_info(&client->dev, "Converting value for SM field failed, err = 
> > > +%hx", err); return count; }
> > > +
> > > +static ssize_t as6200_set_im(struct device *dev, struct 
> > > +device_attribute *attr, const char *buf, size_t count) { struct 
> > > +iio_dev *indio_dev = dev_to_iio_dev(dev); struct as6200_data *data = 
> > > +iio_priv(indio_dev); struct i2c_client *client = data->client; int 
> > > +err;
> > > +u16 val;
> > > +
> > > +err = kstrtou16(buf, 0, &val);
> > > +if (err == 0) {
> > > +err = regmap_update_bits(data->regmap, AS6200_REG_CONFIG, 
> > > +AS6200_CONFIG_IM_MASK, val << AS6200_CONFIG_IM_SHIFT); } else 
> > > +dev_info(&client->dev, "Converting value for IM field failed, err = 
> > > +%hx", err); return count; }
> > > +
> > > +static ssize_t as6200_set_pol(struct device *dev, struct 
> > > +device_attribute *attr, const char *buf, size_t count) { struct 
> > > +iio_dev *indio_dev = dev_to_iio_dev(dev); struct as6200_data *data = 
> > > +iio_priv(indio_dev); struct i2c_client *client = data->client; int 
> > > +err; int irq_num = data->irqn;
> > > +u16 val;
> > > +
> > > +err = kstrtou16(buf, 0, &val);
> > > +if (err == 0) {
> > > +free_irq(irq_num, dev);
> > > +err = regmap_update_bits(data->regmap, AS6200_REG_CONFIG, 
> > > +AS6200_CONFIG_POL_MASK, val << AS6200_CONFIG_POL_SHIFT); 
> > > +as6200_setup_irq(indio_dev, false, val); } else 
> > > +dev_info(&client->dev, "Converting value for POL field failed, err = 
> > > +%hx", err); return count; }
> > > +
> > > +static ssize_t as6200_set_cf(struct device *dev, struct 
> > > +device_attribute *attr, const char *buf, size_t count) { struct 
> > > +iio_dev *indio_dev = dev_to_iio_dev(dev); struct as6200_data *data = 
> > > +iio_priv(indio_dev); struct i2c_client *client = data->client; int 
> > > +err;
> > > +u16 val;
> > > +
> > > +err = kstrtou16(buf, 0, &val);
> > > +if (err == 0) {
> > > +switch (val) {
> > > +case 1:
> > > +case 2:
> > > +case 4:
> > > +case 6:
> > > +err = regmap_update_bits(data->regmap, AS6200_REG_CONFIG, 
> > > +AS6200_CONFIG_CF_MASK, val << AS6200_CONFIG_CF_SHIFT); break;
> > > +default:
> > > +dev_info(&client->dev,
> > > +"Value for CF field invalid, val = %hx", val); return count; } } else 
> > > +dev_info(&client->dev, "Converting value for CF field failed, err = 
> > > +%hx", err); return count; }
> > > +
> > > +static ssize_t as6200_set_ss(struct device *dev, struct 
> > > +device_attribute *attr, const char *buf, size_t count) { struct 
> > > +iio_dev *indio_dev = dev_to_iio_dev(dev); struct as6200_data *data = 
> > > +iio_priv(indio_dev); struct i2c_client *client = data->client; int 
> > > +err;
> > > +u16 val;
> > > +
> > > +err = kstrtou16(buf, 0, &val);
> > > +if (err == 0) {
> > > +err = regmap_update_bits(data->regmap, AS6200_REG_CONFIG, 
> > > +AS6200_CONFIG_SS_MASK, val << AS6200_CONFIG_SS_SHIFT); } else 
> > > +dev_info(&client->dev, "Converting value for SS field failed, err = 
> > > +%hx", err); return count; }
> > > +
> > > +static IIO_DEVICE_ATTR(thigh, S_IWUSR | S_IRUGO, as6200_show_thigh, 
> > > +as6200_set_thigh, 0); static IIO_DEVICE_ATTR(tlow, S_IWUSR | S_IRUGO, 
> > > +as6200_show_tlow, as6200_set_tlow, 0); static 
> > > +IIO_DEVICE_ATTR(thigh_reg, S_IWUSR | S_IRUGO, as6200_show_thigh_reg, 
> > > +as6200_set_thigh_reg, 0); static IIO_DEVICE_ATTR(tlow_reg, S_IWUSR | 
> > > +S_IRUGO, as6200_show_tlow_reg, as6200_set_tlow_reg, 0); static 
> > > +IIO_DEVICE_ATTR(config, S_IWUSR | S_IRUGO, as6200_show_config, 
> > > +as6200_set_configreg, 0); static IIO_DEVICE_ATTR(al, S_IRUGO, 
> > > +as6200_show_al, NULL, 0); static IIO_DEVICE_ATTR(sm, S_IWUSR | 
> > > +S_IRUGO, as6200_show_sm, as6200_set_sm, 0); static 
> > > +IIO_DEVICE_ATTR(im, S_IWUSR | S_IRUGO, as6200_show_im, as6200_set_im, 
> > > +0); static IIO_DEVICE_ATTR(pol, S_IWUSR | S_IRUGO, as6200_show_pol, 
> > > +as6200_set_pol, 0); static IIO_DEVICE_ATTR(cf, S_IWUSR | S_IRUGO, 
> > > +as6200_show_cf, as6200_set_cf, 0); static IIO_DEVICE_ATTR(ss, S_IWUSR 
> > > +| S_IRUGO, as6200_show_ss, as6200_set_ss, 0);
> > > +
> > > +static IIO_CONST_ATTR(sampling_frequency_available, "4 1 0.25 
> > > +0.125");
> > > +
> > > +static struct attribute *as6200_attrs[] = { 
> > > +&iio_dev_attr_thigh.dev_attr.attr,
> > > +&iio_dev_attr_tlow.dev_attr.attr,
> > > +&iio_dev_attr_thigh_reg.dev_attr.attr,
> > > +&iio_dev_attr_tlow_reg.dev_attr.attr,
> > > +&iio_dev_attr_config.dev_attr.attr,
> > > +&iio_dev_attr_al.dev_attr.attr,
> > > +&iio_dev_attr_sm.dev_attr.attr,
> > > +&iio_dev_attr_im.dev_attr.attr,
> > > +&iio_dev_attr_pol.dev_attr.attr,
> > > +&iio_dev_attr_cf.dev_attr.attr,
> > > +&iio_dev_attr_ss.dev_attr.attr,
> > > +&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> > > +NULL,
> > > +};
> > > +
> > > +static struct attribute_group as6200_attr_group = { .attrs = 
> > > +as6200_attrs, };
> > > +
> > > +static const struct iio_chan_spec as6200_channels[] = { { .type = 
> > > +IIO_TEMP, .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | 
> > > +BIT(IIO_CHAN_INFO_SCALE), .info_mask_shared_by_type = 
> > > +BIT(IIO_CHAN_INFO_SAMP_FREQ), } };
> > > +
> > > +static const struct iio_info as6200_info = { .read_raw = 
> > > +as6200_read_raw, .write_raw = as6200_write_raw, .attrs = 
> > > +&as6200_attr_group, .driver_module = THIS_MODULE, };
> > > +
> > > +static int as6200_i2c_of_probe(struct i2c_client *i2c, struct 
> > > +as6200_data *as6200) { struct device_node *np = i2c->dev.of_node; 
> > > +struct irq_data *irq_data;
> > > +
> > > +if (!np) {
> > > +dev_err(&i2c->dev, "Device Tree not found\n"); return -EINVAL; }
> > > +
> > > +irq_data = irq_get_irq_data(i2c->irq);
> > 
> > what is this good for?
> > 
> > > +if (!irq_data) {
> > > +dev_err(&i2c->dev, "Invalid IRQ: %d\n", i2c->irq); return -EINVAL; }
> > > +
> > > +as6200->irq_flags = irqd_get_trigger_type(irq_data);
> > > +dev_dbg(&i2c->dev, "IRQ flags are 0x%08lx\n", as6200->irq_flags); 
> > > +return 0; }
> > > +
> > > +static int as6200_i2c_probe(struct i2c_client *client, const struct 
> > > +i2c_device_id *id) { struct iio_dev *indio_dev; struct as6200_data 
> > > +*data; int ret;
> > > +
> > > +indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data)); if 
> > > +(!indio_dev) return -ENOMEM;
> > > +
> > > +data = iio_priv(indio_dev);
> > > +i2c_set_clientdata(client, indio_dev);
> > > +data->client = client;
> > > +
> > > +ret = as6200_i2c_of_probe(client, data); if (ret < 0) return ret;
> > > +
> > > +data->regmap = devm_regmap_init_i2c(client, &as6200_regmap_config);
> > > +if (IS_ERR(data->regmap)) {
> > > +ret = PTR_ERR(data->regmap);
> > > +dev_err(&client->dev, "regmap init failed: %d\n", ret); return ret; }
> > > +
> > > +indio_dev->dev.parent = &client->dev; indio_dev->name = id->name; 
> > > +indio_dev->modes = INDIO_DIRECT_MODE; indio_dev->info = &as6200_info;
> > > +
> > > +indio_dev->channels = as6200_channels; indio_dev->num_channels = 
> > > +ARRAY_SIZE(as6200_channels);
> > > +
> > > +mutex_init(&data->update_lock);
> > > +ret = as6200_setup_irq(indio_dev, true, 0);
> > > +
> > 
> > no newline here
> > 
> > > +if (ret < 0)
> > > +goto cleanup_gpio_irq;
> > > +
> > > +return iio_device_register(indio_dev);
> > > +
> > > +cleanup_gpio_irq:
> > > +free_irq(data->irqn, &client->dev);
> > > +gpio_free(data->gpio);
> > > +
> > > +return ret;
> > > +}
> > > +
> > > +static int as6200_i2c_remove(struct i2c_client *client) { struct 
> > > +iio_dev *indio_dev; struct as6200_data *data;
> > > +
> > > +indio_dev = i2c_get_clientdata(client); data = iio_priv(indio_dev);
> > 
> > most drivers do that via initialization, not assignment for conciseness
> > 
> > > +
> > > +iio_device_unregister(indio_dev);
> > > +free_irq(data->irqn, &client->dev);
> > > +gpio_free(data->gpio);
> > > +return 0;
> > > +}
> > > +
> > > +static const struct of_device_id as6200_of_match[] = { { .compatible 
> > > += "ams,as6200", }, {}, }; MODULE_DEVICE_TABLE(of, as6200_of_match);
> > > +
> > > +
> > > +static const struct i2c_device_id as6200_i2c_id[] = { { "as6200", 0 
> > > +}, { } }; MODULE_DEVICE_TABLE(i2c, as6200_id);
> > > +
> > > +static struct i2c_driver as6200_i2c_driver = { .driver = { .name = 
> > > +"as6200", .owner = THIS_MODULE, .of_match_table = as6200_of_match, }, 
> > > +.probe = as6200_i2c_probe, .remove = as6200_i2c_remove, .id_table = 
> > > +as6200_i2c_id, };
> > > +
> > > +module_i2c_driver(as6200_i2c_driver);
> > > +
> > > +MODULE_DESCRIPTION("ams AS6200 temperature sensor"); 
> > > +MODULE_AUTHOR("Elitsa Polizoeva <elitsa.polizoeva@ams.com>"); 
> > > +MODULE_AUTHOR("Florian Lobmaier <florian.lobmaier@ams.com>"); 
> > > +MODULE_LICENSE("GPL");
> > > 
> > > -----Original Message-----
> > > From: Lars-Peter Clausen [mailto:lars@metafoo.de]
> > > Sent: Dienstag, 10. November 2015 12:52
> > > To: Florian Lobmaier <Florian.Lobmaier@ams.com>; jic23@kernel.org
> > > Cc: Elitsa Polizoeva <Elitsa.Polizoeva@ams.com>; knaack.h@gmx.de; 
> > > pmeerw@pmeerw.net; linux-kernel@vger.kernel.org; 
> > > linux-iio@vger.kernel.org
> > > Subject: Re: [PATCH V1 1/1] iio: as6200: add AS6200 temperature sensor 
> > > driver from ams AG
> > > 
> > > On 11/10/2015 10:38 AM, Florian Lobmaier wrote:
> > > > The AS6200 is a compact temperature sensor chip with I2C interface.
> > > > 
> > > > Add a driver to support the AS6200 temperature sensor.
> > > > 
> > > > Signed-off-by: Elitsa Polizoeva <elitsa.polizoeva@ams.com>
> > > > Signed-off-by: Florian Lobmaier <florian.lobmaier@ams.com>
> > > 
> > > Hi,
> > > 
> > > Thanks for the patch.
> > > 
> > > As Peter already said this patch introduces a lot of custom ABI, none of which is documented and most of which is probably not acceptable since. The whole idea of a framework is that you expose the capabilities of a device through a standard device independent ABI, this allows to write generic applications and libraries that can manage the devices through this ABI.
> > > This allows to leverage existing developments rather than starting from scratch each time. If your device uses a complete custom ABI there is not much point of having a driver in the first place since any application needs device specific knowledge anyway to talk to the driver, in this case you could just directly implement the I2C communication in the application.
> > > 
> > > Please also consider reading and following Documentation/CodingStyle
> > > 
> > > [...]
> > > > +static int as6200_read_reg(struct i2c_client *client,
> > > > +u8 reg_num, u16 *reg_val)
> > > > +{
> > > > +int err = 0;
> > > > +char tx_buf[1];
> > > > +char rx_buf[2];
> > > > +
> > > > +if ((reg_num >= 0) & (reg_num <= 3)) { tx_buf[0] = reg_num; err = 
> > > > +i2c_master_send(client, tx_buf, 1); if (err == 1) err = 
> > > > +i2c_master_recv(client, rx_buf, 2);
> > > 
> > > This is not thread safe. Another thread could interrupt between
> > > i2c_master_send() and i2c_master_recv() and cause undefined behavior. 
> > > Use
> > > i2c_smbus_read_word_swapped() which makes sure that the I2C communication happens atomically.
> > > 
> > > > +if (err == 2) {
> > > > +*reg_val = rx_buf[0];
> > > > +*reg_val = *reg_val << 8;
> > > > +*reg_val = *reg_val | rx_buf[1];
> > > > +}
> > > > +return err;
> > > > +} else {
> > > > +return -EINVAL;
> > > > +}
> > > > +}
> > > [...]
> > > > +
> > > > +static irqreturn_t alert_isr(int irq, void *dev_id) { 
> > > > +dev_warn(dev_id, "Temperature outside of limits!");
> > > 
> > > Please use IIO threshold events for this. Such out-of-band communication is really not acceptable.
> > > 
> > > > +return IRQ_HANDLED;
> > > > +}
> > > > +
> > > > +static int setupIRQ(struct iio_dev *indio_dev, bool set_gpio, u8 
> > > > +pol) { int err; struct as6200_data *data = iio_priv(indio_dev); 
> > > > +struct device *dev = &data->client->dev; int gpio = -1; int 
> > > > +irq_num; int irq_trig;
> > > > +
> > > > +if (pol == 1)
> > > > +irq_trig = IRQF_TRIGGER_RISING;
> > > > +else
> > > > +irq_trig = IRQF_TRIGGER_FALLING;
> > > > +
> > > > +if (set_gpio) {
> > > > +gpio = of_get_named_gpio_flags(dev->of_node,
> > > > +"as6200,irq-gpio", 0, 0);
> > > > +err = gpio_request(gpio, "as6200_irq"); if (err) { dev_info(dev, "%s: 
> > > > +requesting gpio %d failed\n", as6200_id[0].name, gpio); return err; 
> > > > +} err = gpio_direction_input(gpio); if (err) { dev_info(dev, "%s: 
> > > > +gpio %d cannot apply direction\n", as6200_id[0].name, gpio); return 
> > > > +err; } } irq_num = gpio_to_irq(gpio); dev_info(dev, "%s: 
> > > > +registering for IRQ %d\n", as6200_id[0].name, irq_num);
> > > 
> > > Please drop all these dev_info(). That's just noise in the boot log, imagine every driver did this you wouldn't be able to spot the critical information.
> > > 
> > > > +err = request_irq(irq_num, alert_isr, irq_trig, as6200_id[0].name, 
> > > > +dev);
> > > 
> > > Don't do all the GPIO translation. This pin is only used as a interrupt, so specify it directly as an interrupt and use it that way as well.
> > > 
> > > > +if (err) {
> > > > +dev_info(dev, "%s: error requesting irq %d\n", as6200_id[0].name, 
> > > > +err);
> > > 
> > > For errors use dev_err. Also the as6200_id[0].name is redundant since dev_info/dev_err already prefixes the message with the device name.
> > > 
> > > > +return err;
> > > > +}
> > > > +dev_info(dev, "%s: registered for IRQ %d\n", as6200_id[0].name, 
> > > > +irq_num); mutex_lock(&data->update_lock);
> > > > +data->irqn = irq_num;
> > > > +mutex_unlock(&data->update_lock);
> > > 
> > > What exactly is protect by that mutex here?
> > > 
> > > > +
> > > > +return 0;
> > > > +}
> > > > +
> > > [...]
> > > > +if (err == 0) {
> > > > +if ((val < -40) | (val > 150)) {
> > > > +dev_info(&client->dev,
> > > > +"Value for THIGH is invalid min = -40%cC, max = 150°C, val = %d°C", 
> > > > +(unsigned char)(248), val);
> > > 
> > > Please no out-of-band error reporting.
> > > 
> > > > +return count;
> > > > +}
> > > > +val = (val * 10000) / 625;
> > > > +reg_val = val << 4;
> > > [...]
> > > > +static int as6200_probe(struct i2c_client *client, const struct 
> > > > +i2c_device_id *id) { struct iio_dev *indio_dev = NULL; struct 
> > > > +as6200_data *data = NULL;
> > > 
> > > No need to initialize those here with dummy, this will just hide warnings in case you forgot to initialize them with actual data.
> > > 
> > > > +
> > > > +indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > > > +
> > > > +if (!indio_dev)
> > > > +return -ENOMEM;
> > > > +
> > > > +data = iio_priv(indio_dev);
> > > > +i2c_set_clientdata(client, indio_dev);
> > > > +data->client = client;
> > > > +
> > > > +indio_dev->dev.parent = &client->dev; indio_dev->name = 
> > > > +dev_name(&client->dev);
> > > 
> > > use id->name for this. dev_name() contains things like the I2C bus and device address, etc. Whereas the IIO device name should describe the type of device.
> > > 
> > > > +indio_dev->modes = INDIO_DIRECT_MODE; indio_dev->info = 
> > > > +&as6200_info;
> > > > +
> > > > +indio_dev->channels = as6200_channels; indio_dev->num_channels = 
> > > > +ARRAY_SIZE(as6200_channels);
> > > > +
> > > > +initClientData(data);
> > > > +mutex_init(&data->update_lock);
> > > > +setupIRQ(indio_dev, true, 0);
> > > > +
> > > > +return iio_device_register(indio_dev);
> > > 
> > > Error handling is missing here, you need to free the resources that were acquired in case of an error.
> > > 
> > > > +}
> > > > +
> > > [...]
> > > 
> > > 
> > > 
> > 
> > 
> 
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
--324295856-1400631042-1470045608=:28515--
