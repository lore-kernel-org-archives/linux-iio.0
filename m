Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33851 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbcGPBlQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jul 2016 21:41:16 -0400
Subject: Re: [RCF 1/3] hwmon: Add ads1118 driver
To: Joshua Clayton <stillcompiling@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Russell King <linux@armlinux.org.uk>,
	Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <cover.1468626668.git.stillcompiling@gmail.com>
 <0294fbcb211e8f14f4e68fed4d9375cf23c6a70e.1468626668.git.stillcompiling@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <578990A1.6020300@roeck-us.net>
Date: Fri, 15 Jul 2016 18:40:49 -0700
MIME-Version: 1.0
In-Reply-To: <0294fbcb211e8f14f4e68fed4d9375cf23c6a70e.1468626668.git.stillcompiling@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/15/2016 05:18 PM, Joshua Clayton wrote:
> Add new driver for Texas Instruments ADS1118 and and ADS1018.
> This driver works with ADS1018, because of code borrowed
> from asd1015, which is similar, but I can only test ADS1118
>

Browsing through the datasheet, I think this should probably be implemented
as iio driver (and iio already has a driver for ads1015).

Jonathan, what do you think ?

Thanks,
Guenter

> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> ---
>   drivers/hwmon/Kconfig   |  11 ++
>   drivers/hwmon/Makefile  |   1 +
>   drivers/hwmon/ads1118.c | 516 ++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 528 insertions(+)
>   create mode 100644 drivers/hwmon/ads1118.c
>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index ff94007..cadde38 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1459,6 +1459,17 @@ config SENSORS_ADS1015
>   	  This driver can also be built as a module.  If so, the module
>   	  will be called ads1015.
>
> +config SENSORS_ADS1118
> +	tristate "Texas Instruments ADS1018/ADS1118"
> +	depends on SPI
> +	help
> +	  If you say yes here you get support for Texas Instruments
> +	  ADS1118 16-bit 4-input ADC device and temperature sensor,
> +	  and the 12-bit ADS1018.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called ads1118.
> +
>   config SENSORS_ADS7828
>   	tristate "Texas Instruments ADS7828 and compatibles"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 2ef5b7c..a3b4b2e 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_SENSORS_ADM1029)	+= adm1029.o
>   obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
>   obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
>   obj-$(CONFIG_SENSORS_ADS1015)	+= ads1015.o
> +obj-$(CONFIG_SENSORS_ADS1118)	+= ads1118.o
>   obj-$(CONFIG_SENSORS_ADS7828)	+= ads7828.o
>   obj-$(CONFIG_SENSORS_ADS7871)	+= ads7871.o
>   obj-$(CONFIG_SENSORS_ADT7X10)	+= adt7x10.o
> diff --git a/drivers/hwmon/ads1118.c b/drivers/hwmon/ads1118.c
> new file mode 100644
> index 0000000..65ee337
> --- /dev/null
> +++ b/drivers/hwmon/ads1118.c
> @@ -0,0 +1,516 @@
> +/*
> + * ads1118.c - hwmon driver for Texas Instruments ADS1118 16-bit 4-input ADC
> + * / temperature sensor, and Texas Instruments ADS1018, a faster, 12-bit
> + * chip  of the same family.
> + *
> + * Author: Joshua Clayton
> + *
> + * Loosely based on ads1015.c by Dirk Eibach and others
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/spi/spi.h>
> +
> +struct ads_table {
> +	unsigned int rates[8];
> +	unsigned int divisor;
> +};
> +
> +struct ads_channel {
> +	unsigned int delay_ms;
> +	int pga;
> +	u16 cfg;
> +	bool enabled;
> +};
> +
> +/* PGA fullscale voltages in microvolts */
> +static const unsigned int fullscale_table[8] = {
> +	6144000, 4096000, 2048000, 1024000, 512000, 256000, 256000, 256000 };
> +
> +static const struct ads_table ads1018_table = {
> +	.rates = {128, 250, 490, 920, 1600, 2400, 3300, 3300},
> +	.divisor = 0x7ff0,
> +};
> +
> +static const struct ads_table ads1118_table = {
> +	.rates = {8, 16, 32, 64, 128, 250, 475, 860},
> +	.divisor = 0x7fff,
> +};
> +
> +#define ADS1118_NUM_CHANS 5
> +#define ADS1118_TEMP_CHAN 4
> +
> +struct ads1118 {
> +	struct device *hwmon_dev;
> +	struct device *dev;
> +	struct mutex update_lock; /* mutex protect updates */
> +	struct ads_channel channel_data[ADS1118_NUM_CHANS];
> +	const struct ads_table *ref;
> +};
> +
> +/*
> + * NOTE: the bit offsets in the datasheet are 16 bit big
> + * endian. I've swapped upper and lower bytes in the defines
> + * so no twiddling is needed when sending the cfg to the device.
> + */
> +#define ADS1118_MODE	0	/* single shot mode */
> +#define ADS1118_PGA	1	/* programmmed gain */
> +#define ADS1118_MUX	4	/* input channel */
> +#define ADS1118_SS	7	/* start a conversion */
> +#define ADS1118_NOP	8	/* validation pattern */
> +#define ADS1118_PULL_UP	11	/* pullup resistor on MISO */
> +#define ADS1118_TS_MODE	12	/* temperature sensor mode */
> +#define ADS1118_DR	13	/* data rate table index */
> +
> +#define ADS1118_ADC_CFG (BIT(ADS1118_MODE) | BIT(ADS1118_SS) | \
> +		(0x3 << ADS1118_NOP) | BIT(ADS1118_PULL_UP))
> +#define ADS1118_TEMP_CFG (ADS1118_ADC_CFG | BIT(ADS1118_TS_MODE))
> +
> +/* MUX values for AINN (second input or ground) */
> +#define ADS1118_MUX_AINN1 0
> +#define ADS1118_MUX_AINN3 1
> +#define ADS1118_MUX_AINN_GND 4
> +
> +#define ADS1118_DEFAULT_PGA 0
> +#define ADS1118_DEFAULT_DR 7
> +
> +static inline void ads1118_set_cfg(u16 *cfg, u16 value, int offset)
> +{
> +	*cfg &= ~(0x07 << offset);
> +	*cfg |= ((value & 0x07) << offset);
> +}
> +
> +static int ads1118_channel_set_pga(struct ads_channel *chan, u32 fullscale)
> +{
> +	int i;
> +
> +	for (i = 7; i >= 0; --i)
> +		if (fullscale_table[i] == fullscale)
> +			break;
> +
> +	if (i < 0)
> +		return -EINVAL;
> +
> +	chan->pga = fullscale / 1000;
> +	ads1118_set_cfg(&chan->cfg, i, ADS1118_PGA);
> +
> +	return 0;
> +}
> +
> +static int ads1118_chan_set_mux(struct ads_channel *chan, u16 in1, u16 in2)
> +{
> +	switch (in1) {
> +	case 0:
> +		if (in2 == ADS1118_MUX_AINN1)
> +			break;
> +	case 1:
> +	case 2:
> +		if (in2 == ADS1118_MUX_AINN3)
> +			break;
> +	case 3:
> +		if (in2 == ADS1118_MUX_AINN_GND)
> +			break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ads1118_set_cfg(&chan->cfg, in1 + in2, ADS1118_MUX);
> +
> +	return 0;
> +}
> +
> +static int ads1118_chan_set_rate(struct ads1118 *ads,
> +				 struct ads_channel *chan, u32 rate)
> +{
> +	int i;
> +
> +	for (i = 7; i >= 0; --i)
> +		if (ads->ref->rates[i] == rate)
> +			break;
> +
> +	if (i < 0)
> +		return -EINVAL;
> +
> +	chan->delay_ms = DIV_ROUND_UP(1000, rate);
> +	ads1118_set_cfg(&chan->cfg, i, ADS1118_DR);
> +
> +	return 0;
> +}
> +
> +static int ads1118_read_adc(struct ads1118 *ads, struct ads_channel *chan,
> +			    s16 *value)
> +{
> +	int ret;
> +	u16 buf;
> +	struct spi_device *spi = to_spi_device(ads->dev);
> +
> +	mutex_lock(&ads->update_lock);
> +
> +	ret = spi_write(spi, &chan->cfg, sizeof(chan->cfg));
> +	if (ret < 0)
> +		goto err_unlock;
> +
> +	/* wait until conversion finished */
> +	msleep(chan->delay_ms);
> +
> +	ret = spi_read(spi, &buf, sizeof(buf));
> +	if (ret)
> +		dev_info(&spi->dev, "error reading: %d\n", ret);
> +
> +	*value = (s16)be16_to_cpu(buf);
> +
> +err_unlock:
> +	mutex_unlock(&ads->update_lock);
> +	return ret;
> +}
> +
> +static ssize_t show_in(struct device *dev, struct device_attribute *da,
> +	char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +	struct ads1118 *ads = dev_get_drvdata(dev);
> +	struct ads_channel *chan = &ads->channel_data[attr->index];
> +	s16 read_value;
> +	int microvolts;
> +	int ret;
> +
> +	ret = ads1118_read_adc(ads, chan, &read_value);
> +	if (ret < 0)
> +		return ret;
> +
> +	microvolts = DIV_ROUND_CLOSEST(read_value * chan->pga,
> +				       ads->ref->divisor);
> +
> +	return sprintf(buf, "%d\n", microvolts);
> +}
> +
> +static ssize_t show_temp(struct device *dev, struct device_attribute *da,
> +			 char *buf)
> +{
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> +	struct ads1118 *ads = dev_get_drvdata(dev);
> +	struct ads_channel *chan = &ads->channel_data[attr->index];
> +	s16 read_value;
> +	int ret;
> +
> +	ret = ads1118_read_adc(ads, chan, &read_value);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * The ads1118 datasheet indicates 32nds of degree steps, but
> +	 * 14 bits left justified means a divisor of 128.
> +	 */
> +	return sprintf(buf, "%d\n", (((int)read_value) * 1000) >> 7);
> +}
> +
> +static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in, NULL, 0);
> +static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in, NULL, 1);
> +static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_in, NULL, 2);
> +static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_in, NULL, 3);
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL,
> +		ADS1118_TEMP_CHAN);
> +
> +static struct attribute *ads1118_attributes[] = {
> +	&sensor_dev_attr_in0_input.dev_attr.attr,
> +	&sensor_dev_attr_in1_input.dev_attr.attr,
> +	&sensor_dev_attr_in2_input.dev_attr.attr,
> +	&sensor_dev_attr_in3_input.dev_attr.attr,
> +
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	NULL
> +};
> +
> +static umode_t ads1118_attrs_visible(struct kobject *kobj,
> +				     struct attribute *attr, int n)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct ads1118 *ads = dev_get_drvdata(dev);
> +
> +	if (ads->channel_data[n].enabled)
> +		return attr->mode;
> +
> +	return 0;
> +}
> +
> +static const struct attribute_group ads1118_attr_group = {
> +	.attrs = ads1118_attributes,
> +	.is_visible = ads1118_attrs_visible,
> +};
> +
> +static const struct attribute_group *groups[] = {
> +	&ads1118_attr_group,
> +	NULL
> +};
> +
> +#ifdef CONFIG_OF
> +static int ads1118_of_get_chan(struct device *dev, struct device_node *node)
> +{
> +	u32 chan_i;
> +
> +	if (!of_device_is_available(node))
> +		return -EINVAL;
> +
> +	if (of_property_read_u32(node, "reg", &chan_i)) {
> +		dev_err(dev, "reg value missing in %s\n", node->full_name);
> +		return -EINVAL;
> +	}
> +
> +	if (chan_i >= ADS1118_TEMP_CHAN) {
> +		dev_err(dev, "reg value %d out of range in %s\n",
> +				chan_i, node->full_name);
> +		return -EINVAL;
> +	}
> +
> +	return (int)chan_i;
> +}
> +
> +static int ads1118_of_get_chan_pga(struct device *dev,
> +				   struct device_node *node,
> +				   struct ads_channel *chan)
> +{
> +	int ret;
> +	u32 fullscale;
> +
> +	ret = of_property_read_u32(node, "ti,fullscale", &fullscale);
> +	if (ret == -EINVAL) {
> +		fullscale = fullscale_table[ADS1118_DEFAULT_PGA];
> +	} else if (ret) {
> +		dev_err(dev, "bad ti,fullscale on %s: should be u32\n",
> +			node->full_name);
> +		return ret;
> +	}
> +
> +	ret = ads1118_channel_set_pga(chan, fullscale);
> +	if (ret)
> +		dev_err(dev, "bad ti,fullscale on %s: invalid value\n",
> +			node->full_name);
> +
> +	return ret;
> +}
> +
> +static int ads1118_of_get_chan_datarate(struct ads1118 *ads,
> +					 struct device_node *node,
> +					 struct ads_channel *chan)
> +{
> +	int ret;
> +	u32 rate;
> +
> +	ret = of_property_read_u32(node, "ti,datarate", &rate);
> +	if (ret == -EINVAL) {
> +		rate = ads->ref->rates[ADS1118_DEFAULT_DR];
> +	} else if (ret) {
> +		dev_err(ads->dev, "bad ti,datarate on %s: should be u32\n",
> +			node->full_name);
> +		return ret;
> +	}
> +
> +	ret = ads1118_chan_set_rate(ads, chan, rate);
> +	if (ret)
> +		dev_err(ads->dev, "bad ti,datarate on %s: invalid value\n",
> +			node->full_name);
> +
> +	return ret;
> +}
> +
> +static int ads1118_of_get_chan_mux(struct device *dev,
> +				    struct device_node *node,
> +				    struct ads_channel *chan,
> +				    int chan_i)
> +{
> +	int ret;
> +	u32 de;
> +	u16 in2;
> +
> +	ret = of_property_read_u32(node, "ti,differential-endpoint", &de);
> +	if (ret == -EINVAL) {
> +		in2 = ADS1118_MUX_AINN_GND;
> +		goto set_mux;
> +	} else if (ret) {
> +		dev_err(dev, "bad ti,differential-endpoint on %s: should be a u32\n",
> +			node->full_name);
> +		return ret;
> +	}
> +
> +	switch (de) {
> +	case 1:
> +		in2 = ADS1118_MUX_AINN1;
> +		break;
> +	case 3:
> +		in2 = ADS1118_MUX_AINN3;
> +		break;
> +	default:
> +		dev_err(dev, "bad ti,differential-endpoint %d on %s\n",
> +			de, node->full_name);
> +		return -EINVAL;
> +	}
> +
> +set_mux:
> +	ret = ads1118_chan_set_mux(chan, (u16)chan_i, in2);
> +	if (ret)
> +		dev_err(dev, "bad ti,differential-endpoint pair %d, %d on %s\n",
> +			chan_i, de, node->full_name);
> +
> +	return ret;
> +}
> +
> +static void ads1118_of_cfg_chan(struct ads1118 *ads, struct device_node *node)
> +{
> +	int ret;
> +	int chan_i;
> +	struct ads_channel *chan;
> +
> +	chan_i = ads1118_of_get_chan(ads->dev, node);
> +	if (chan_i < 0)
> +		return;
> +
> +	chan = &ads->channel_data[chan_i];
> +	chan->cfg = ADS1118_ADC_CFG;
> +	ret = ads1118_of_get_chan_pga(ads->dev, node, chan);
> +	if (ret)
> +		return;
> +
> +	ret = ads1118_of_get_chan_datarate(ads, node, chan);
> +	if (ret)
> +		return;
> +
> +	ret = ads1118_of_get_chan_mux(ads->dev, node, chan, chan_i);
> +	if (ret)
> +		return;
> +
> +	chan->enabled = true;
> +}
> +
> +static void ads1118_of_get_pullup(struct ads1118 *ads)
> +{
> +	int i;
> +
> +	if (of_find_property(ads->dev->of_node, "ti,pullup-disable", NULL))
> +		for (i = 0; i < ADS1118_NUM_CHANS; ++i)
> +			ads->channel_data[i].cfg &= ~(BIT(ADS1118_PULL_UP));
> +}
> +#endif
> +
> +static void ads1118_temp_chan_enable(struct ads1118 *ads)
> +{
> +	struct ads_channel *chan = &ads->channel_data[ADS1118_TEMP_CHAN];
> +	unsigned int rate = ads->ref->rates[ADS1118_DEFAULT_DR];
> +
> +	chan->cfg = ADS1118_TEMP_CFG;
> +	ads1118_chan_set_rate(ads, chan, rate);
> +	chan->enabled = true;
> +}
> +
> +static int ads1118_get_cfg(struct ads1118 *ads)
> +{
> +	struct device_node *node;
> +
> +#ifndef CONFIG_OF
> +	return -EINVAL;
> +#else
> +	if (!ads->dev->of_node
> +	    || !of_get_next_child(ads->dev->of_node, NULL))
> +		return -EINVAL;
> +
> +	if (of_find_property(ads->dev->of_node, "ti,tempsensor", NULL))
> +		ads1118_temp_chan_enable(ads);
> +
> +	ads1118_of_get_pullup(ads);
> +
> +	for_each_child_of_node(ads->dev->of_node, node) {
> +		ads1118_of_cfg_chan(ads, node);
> +	}
> +
> +	return 0;
> +#endif
> +}
> +
> +static void ads1118_enable_all(struct ads1118 *ads)
> +{
> +	unsigned int i;
> +	unsigned int fullscale = fullscale_table[ADS1118_DEFAULT_PGA];
> +	unsigned int rate = ads->ref->rates[ADS1118_DEFAULT_DR];
> +
> +	ads1118_temp_chan_enable(ads);
> +
> +	for (i = 0; i < ADS1118_TEMP_CHAN; ++i) {
> +		struct ads_channel *chan = &ads->channel_data[i];
> +
> +		chan->cfg = ADS1118_ADC_CFG;
> +		ads1118_channel_set_pga(chan, fullscale);
> +		ads1118_chan_set_rate(ads, chan, rate);
> +		ads1118_chan_set_mux(chan, (u16)i, ADS1118_MUX_AINN_GND);
> +		chan->enabled = true;
> +	}
> +}
> +
> +static const struct of_device_id ads_1x18_ids[] = {
> +	{ .compatible = "ti,ads1018", .data = &ads1018_table, },
> +	{ .compatible = "ti,ads1118", .data = &ads1118_table, },
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, ads_1x18_ids);
> +
> +static int ads1118_probe(struct spi_device *spi)
> +{
> +	const struct of_device_id *of_id;
> +	struct ads1118 *ads;
> +	int err;
> +
> +	ads = devm_kzalloc(&spi->dev, sizeof(struct ads1118),
> +			    GFP_KERNEL);
> +	if (!ads)
> +		return -ENOMEM;
> +
> +	of_id = of_match_device(ads_1x18_ids, &spi->dev);
> +	if (!of_id)
> +		return -EINVAL;
> +
> +	ads->ref = of_id->data;
> +	ads->dev = &spi->dev;
> +	mutex_init(&ads->update_lock);
> +	err = ads1118_get_cfg(ads);
> +	if (err)
> +		ads1118_enable_all(ads);
> +
> +	ads->hwmon_dev =
> +		devm_hwmon_device_register_with_groups(ads->dev, "ads11118",
> +						       ads, groups);
> +	if (IS_ERR(ads->hwmon_dev)) {
> +		err = PTR_ERR(ads->hwmon_dev);
> +		dev_err(ads->dev, "error initializing hwmon: %d\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct spi_driver ads1118_driver = {
> +	.driver = {
> +		.name = "ads1118",
> +		.of_match_table = ads_1x18_ids,
> +	},
> +	.probe = ads1118_probe,
> +};
> +
> +module_spi_driver(ads1118_driver);
> +
> +MODULE_AUTHOR("Joshua Clayton <stillcompiling@gmail.com>");
> +MODULE_DESCRIPTION("ADS1118 driver");
> +MODULE_LICENSE("GPL");
>

