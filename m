Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52237 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbcL3REZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 12:04:25 -0500
Subject: Re: [PATCH v4 2/2] iio: adc: hx711: Add IIO driver for AVIA HX711
To: Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20161221152514.GA14554@andreas>
Cc: linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5eb0ed15-a5f3-fa73-b39a-da39a0b34f97@kernel.org>
Date: Fri, 30 Dec 2016 17:04:17 +0000
MIME-Version: 1.0
In-Reply-To: <20161221152514.GA14554@andreas>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/12/16 15:25, Andreas Klinger wrote:
> This is the IIO driver for AVIA HX711 ADC which ist mostly used in weighting
> cells.
> 
> The protocol is quite simple and using GPIOs:
> One GPIO is used as clock (SCK) while another GPIO is read (DOUT)
> 
> The raw value read from the chip is delivered. 
> To get a weight one needs to subtract the zero offset and scale it.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
I argue myself in an out of using fractional types for the scale (these aren't
well handled for writeable values as it's very hard to know what fraction we
should output!).

Otherwise a few points that may well repeat what Peter said.

Hard bit is done though (all that bit bashing) so only minor stuff to clean
up.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/Kconfig  |  19 ++
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/hx711.c  | 466 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 486 insertions(+)
>  create mode 100644 drivers/iio/adc/hx711.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 932de1f9d1e7..1dcf2ace1697 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -205,6 +205,25 @@ config HI8435
>  	  This driver can also be built as a module. If so, the module will be
>  	  called hi8435.
>  
> +config HX711
> +	tristate "AVIA HX711 ADC for weight cells"
> +	depends on GPIOLIB
> +	help
> +	  If you say yes here you get support for AVIA HX711 ADC which is used
> +	  for weigh cells
> +
> +	  This driver uses two GPIOs, one acts as the clock and controls the
> +	  channel selection and gain, the other one is used for the measurement
> +          data
> +
> +	  Currently the raw value is read from the chip and delivered.
> +	  To get an actual weight one needs to subtract the
> +	  zero offset and multiply by a scale factor.
> +	  This should be done in userspace.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called hx711.
> +
>  config INA2XX_ADC
>  	tristate "Texas Instruments INA2xx Power Monitors IIO driver"
>  	depends on I2C && !SENSORS_INA2XX
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index b1aa456e6af3..d46e289900ef 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
>  obj-$(CONFIG_DA9150_GPADC) += da9150-gpadc.o
>  obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
>  obj-$(CONFIG_HI8435) += hi8435.o
> +obj-$(CONFIG_HX711) += hx711.o
>  obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
>  obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> new file mode 100644
> index 000000000000..f4b5f587e9c0
> --- /dev/null
> +++ b/drivers/iio/adc/hx711.c
> @@ -0,0 +1,466 @@
> +/*
> + * HX711: analog to digital converter for weight sensor module
> + *
> + * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/slab.h>
> +#include <linux/sched.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +
> +/*
> + * gain to pulse and scale conversion
> + */
/* gain to pulse and scale conversion */
(we are very fussy about comment syntax, particularly as otherwise
I'll get inundated with patches fixing it ;)
> +#define HX711_CHAN_A		0	/* channel id for A  */
> +#define HX711_CHAN_B		1	/* channel id for B  */
> +
> +#define HX711_GAIN_MAX		3
> +
> +struct hx711_gain_to_scale {
> +	int			gain;
> +	int			gain_pulse;
> +	int			scale;
> +	int			channel;
> +};
> +
> +static struct hx711_gain_to_scale hx711_gain_to_scale[HX711_GAIN_MAX] = {
> +	{ 128, 1, 0, HX711_CHAN_A },
> +	{  32, 2, 0, HX711_CHAN_B },
> +	{  64, 3, 0, HX711_CHAN_A }
> +};
> +
> +static int hx711_get_gain_to_pulse(int gain)
> +{
> +	int i;
> +
> +	for (i = 0; i < HX711_GAIN_MAX; i++)
> +		if (hx711_gain_to_scale[i].gain == gain)
> +			return hx711_gain_to_scale[i].gain_pulse;
> +	return 1;
> +}
> +
> +static int hx711_get_gain_to_scale(int gain)
> +{
> +	int i;
> +
> +	for (i = 0; i < HX711_GAIN_MAX; i++)
> +		if (hx711_gain_to_scale[i].gain == gain)
> +			return hx711_gain_to_scale[i].scale;
> +	return 0;
> +}
> +
> +static int hx711_get_scale_to_gain(int scale)
> +{
> +	int i;
> +
> +	for (i = 0; i < HX711_GAIN_MAX; i++)
> +		if (hx711_gain_to_scale[i].scale == scale)
> +			return hx711_gain_to_scale[i].gain;
> +	return -EINVAL;
> +}
> +
> +struct hx711_data {
> +	struct device		*dev;
> +	struct gpio_desc	*gpiod_pd_sck;
> +	struct gpio_desc	*gpiod_dout;
> +	struct regulator	*reg_avdd;
> +	int			gain_set;	/* gain set on device */
> +	int			gain_chan_a;	/* gain for channel A */
> +	struct mutex		lock;
> +};
> +
> +static int hx711_read(struct hx711_data *hx711_data);
> +
> +static int hx711_reset(struct hx711_data *hx711_data)
> +{
> +	int ret;
> +	int val = gpiod_get_value(hx711_data->gpiod_dout);
> +
> +	if (val) {
> +		int i;
> +
> +		/*
> +		 * an examination with the oszilloscope indicated
> +		 * that the first value read after the reset is not stable
> +		 * if we reset too short;
> +		 * the shorter the reset cycle
> +		 * the less reliable the first value after reset is;
> +		 * there were no problems encountered with a value
> +		 * of 10 ms or higher
> +		 */
> +		gpiod_set_value(hx711_data->gpiod_pd_sck, 1);
> +		msleep(10);
> +		gpiod_set_value(hx711_data->gpiod_pd_sck, 0);
> +
> +		/*
> +		 * a maximum reset cycle time of 56 ms was measured.
> +		 * we round it up to 100 ms
> +		 */
> +		for (i = 0; i < 100; i++) {
> +			val = gpiod_get_value(hx711_data->gpiod_dout);
> +			if (!val)
> +				break;
> +			/* sleep at least 1 ms */
> +			msleep(1);
> +		}
> +
> +		/*
> +		 * after a reset the gain is 128 so we do a dummy read
> +		 *   to set the gain for the next read
> +		 */
> +		ret = hx711_read(hx711_data);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return val;
> +}
> +
> +static int hx711_cycle(struct hx711_data *hx711_data)
> +{
> +	int val;
> +
> +	/*
> +	 * if preempted for more then 60us while PD_SCK is high:
> +	 * hx711 is going in reset
> +	 * ==> measuring is false
> +	 */
> +	preempt_disable();
> +	gpiod_set_value(hx711_data->gpiod_pd_sck, 1);
> +	val = gpiod_get_value(hx711_data->gpiod_dout);
> +	/*
> +	 * here we are not waiting for 0.2 us as suggested by the datasheet,
> +	 * because the oszilloscope showed in a test scenario
> +	 * at least 1.15 us for PD_SCK high (T3 in datasheet)
> +	 * and 0.56 us for PD_SCK low on TI Sitara with 800 MHz
> +	 */
> +	gpiod_set_value(hx711_data->gpiod_pd_sck, 0);
> +	preempt_enable();
> +
> +	return val;
> +}
> +
> +static int hx711_read(struct hx711_data *hx711_data)
> +{
> +	int i, ret;
> +	int value = 0;
> +
> +	if (hx711_reset(hx711_data)) {
> +		dev_err(hx711_data->dev, "reset failed!");
> +		return -EIO;
> +	}
> +
> +	for (i = 0; i < 24; i++) {
> +		value <<= 1;
> +		ret = hx711_cycle(hx711_data);
> +		if (ret)
> +			value++;
> +	}
> +
> +	value ^= 0x800000;
> +
> +	for (i = 0; i < hx711_get_gain_to_pulse(hx711_data->gain_set); i++)
> +		hx711_cycle(hx711_data);
> +
> +	return value;
> +}
> +
> +static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
> +{
> +	int ret;
> +
> +	if (chan == HX711_CHAN_A) {
> +		if (hx711_data->gain_set == 32) {
> +			hx711_data->gain_set = hx711_data->gain_chan_a;
> +
> +			ret = hx711_read(hx711_data);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	} else {
> +		if (hx711_data->gain_set != 32) {
> +			hx711_data->gain_set = 32;
> +
> +			ret = hx711_read(hx711_data);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int hx711_read_raw(struct iio_dev *iio_dev,
> +				const struct iio_chan_spec *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct hx711_data *hx711_data = iio_priv(iio_dev);
> +	int ret;
> +
> +	mutex_lock(&hx711_data->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = hx711_set_gain_for_channel(hx711_data, chan->channel);
> +		if (ret < 0) {
> +			mutex_unlock(&hx711_data->lock);
> +			return ret;
> +		}
> +
> +		*val = hx711_read(hx711_data);
> +		mutex_unlock(&hx711_data->lock);
> +		if (*val < 0)
> +			return *val;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = hx711_get_gain_to_scale(hx711_data->gain_set);
> +		mutex_unlock(&hx711_data->lock);
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		mutex_unlock(&hx711_data->lock);
> +		return -EINVAL;
> +	}
> +}
> +
> +static int hx711_write_raw(struct iio_dev *iio_dev,
> +				struct iio_chan_spec const *chan,
> +				int val,
> +				int val2,
> +				long mask)
> +{
> +	struct hx711_data *hx711_data = iio_priv(iio_dev);
> +	int ret;
> +	int gain;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * a scale greater than 1 mV per LSB is not possible
> +		 * with the HX711, therefore val must be 0
> +		 */
> +		if (val != 0)
> +			return -EINVAL;
> +
> +		mutex_lock(&hx711_data->lock);
> +
> +		gain = hx711_get_scale_to_gain(val2);
> +		if (gain < 0) {
> +			mutex_unlock(&hx711_data->lock);
> +			return gain;
> +		}
> +
> +		if (gain != hx711_data->gain_set) {
> +			hx711_data->gain_set = gain;
> +			if (gain != 32)
> +				hx711_data->gain_chan_a = gain;
> +
> +			ret = hx711_read(hx711_data);
> +			if (ret < 0) {
> +				mutex_unlock(&hx711_data->lock);
> +				return ret;
> +			}
> +		}
> +
> +		mutex_unlock(&hx711_data->lock);
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hx711_write_raw_get_fmt(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *chan,
> +		long mask)
> +{
> +	return IIO_VAL_INT_PLUS_NANO;
> +}
> +
> +static ssize_t hx711_scale_available_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	return sprintf(buf, "0.%09d 0.%09d 0.%09d\n",
> +			hx711_gain_to_scale[0].scale,
> +			hx711_gain_to_scale[2].scale,
> +			hx711_gain_to_scale[1].scale);
If you did use the fractional types as defined below, you could then
use the core functions to give you the pretty printed output.

Hmm.. Not all these scales are available for each of the channels.
You should have separate scale_availables
in_voltage0_scale_available, in_voltage1_scale_available
(though no actual need for the one that only has one scale)

It shouldn't be up to userspace to guess which is relevant to a given
channel.
> +}
> +
> +static IIO_DEVICE_ATTR(scale_available, S_IRUGO,
> +	hx711_scale_available_show, NULL, 0);
> +
> +static struct attribute *hx711_attributes[] = {
> +	&iio_dev_attr_scale_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group hx711_attribute_group = {
> +	.attrs = hx711_attributes,
> +};
> +
> +static const struct iio_info hx711_iio_info = {
> +	.driver_module		= THIS_MODULE,
> +	.read_raw		= hx711_read_raw,
> +	.write_raw		= hx711_write_raw,
> +	.write_raw_get_fmt	= hx711_write_raw_get_fmt,
> +	.attrs			= &hx711_attribute_group,
> +};
> +
> +static const struct iio_chan_spec hx711_chan_spec[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.channel = HX711_CHAN_A,
I'd be tempted to just make the two channels directly 0 and 1 and loose
this define throughout. Don't think it makes much difference to readability
elsewhare, but here it had me momentarily confused...
> +		.indexed = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.channel = HX711_CHAN_B,
> +		.indexed = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};
> +
> +static int hx711_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct hx711_data *hx711_data;
> +	struct iio_dev *iio;
It's mostly become convention to call this indio_dev but it doesn't
realy matter if you prefer iio.
> +	int ret;
> +	int i;
> +
> +	iio = devm_iio_device_alloc(dev, sizeof(struct hx711_data));
> +	if (!iio) {
> +		dev_err(dev, "failed to allocate IIO device\n");
> +		return -ENOMEM;
> +	}
> +
> +	hx711_data = iio_priv(iio);
> +	hx711_data->dev = dev;
> +
> +	mutex_init(&hx711_data->lock);
> +
> +	/* PD_SCK stands for power down and serial clock input of HX711
> +	 * in the driver it is an output
> +	 */
> +	hx711_data->gpiod_pd_sck = devm_gpiod_get(dev, "sck", GPIOD_OUT_LOW);
> +	if (IS_ERR(hx711_data->gpiod_pd_sck)) {
> +		dev_err(dev, "failed to get sck-gpiod: err=%ld\n",
> +					PTR_ERR(hx711_data->gpiod_pd_sck));
> +		return PTR_ERR(hx711_data->gpiod_pd_sck);
> +	}
> +
> +	/* DOUT stands for serial data output of HX711
Please use
/*
 * DOUT...

Same elsewhere for multiline comments. 
> +	 * for the driver it is an input
> +	 */
> +	hx711_data->gpiod_dout = devm_gpiod_get(dev, "dout", GPIOD_IN);
> +	if (IS_ERR(hx711_data->gpiod_dout)) {
> +		dev_err(dev, "failed to get dout-gpiod: err=%ld\n",
> +					PTR_ERR(hx711_data->gpiod_dout));
> +		return PTR_ERR(hx711_data->gpiod_dout);
> +	}
> +
> +	hx711_data->reg_avdd = devm_regulator_get(dev, "avdd");
> +	if (IS_ERR(hx711_data->reg_avdd))
> +		return PTR_ERR(hx711_data->reg_avdd);
> +
> +	ret = regulator_enable(hx711_data->reg_avdd);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * with
> +	 * full scale differential input range: AVDD / GAIN
> +	 * full scale output data: 2^24
> +	 * we can say:
> +	 *     AVDD / GAIN = 2^24
> +	 * therefore:
> +	 *     1 LSB = AVDD / GAIN / 2^24
> +	 * AVDD is in uV, but we need 10^-9 mV
> +	 * approximately to fit into a 32 bit number:
> +	 * 1 LSB = (AVDD * 100) / GAIN / 1678 [10^-9 mV]
> +	 */
> +	ret = regulator_get_voltage(hx711_data->reg_avdd);
> +	if (ret < 0)
> +		return ret;
> +	/* we need 10^-9 mV */
> +	ret *= 100;
> +
> +	for (i = 0; i < HX711_GAIN_MAX; i++)
> +		hx711_gain_to_scale[i].scale =
> +			ret / hx711_gain_to_scale[i].gain / 1678;
I wonder if we can manipulate things to be able to use one of the
fractional IIO types instead of doing this manually here. Will still
have to be careful with limits of the storage though.
Also, don't think we do anything clever with input of these right
now so you may be stuck doing it this way.
> +
> +	hx711_data->gain_set = 128;
> +	hx711_data->gain_chan_a = 128;
> +
> +	platform_set_drvdata(pdev, iio);
> +
> +	iio->name = "hx711";
> +	iio->dev.parent = &pdev->dev;
> +	iio->info = &hx711_iio_info;
> +	iio->modes = INDIO_DIRECT_MODE;
> +	iio->channels = hx711_chan_spec;
> +	iio->num_channels = ARRAY_SIZE(hx711_chan_spec);
> +
> +	return devm_iio_device_register(dev, iio);
> +}
> +
> +static int hx711_remove(struct platform_device *pdev)
> +{
> +	struct hx711_data *hx711_data;
> +	struct iio_dev *iio;
> +
> +	iio = platform_get_drvdata(pdev);
> +	hx711_data = iio_priv(iio);
> +
> +	regulator_disable(hx711_data->reg_avdd);
Ah. The usual fun of having using devm_ functions.
They are safe 'until' you do something in the probe before one of them that
needs to be unwound.

The result here is that we turn the power off before the userspace interface
for the device is removed (as the unregister occurs only after this remove
function is done).  Thus any reads in that period result in attempting to
talk to hardware that is turned off.

Hence, you need to not use the non managed version of iio_device_register
and manually call iio_device_unregister here. (nearly everyone makes this
mistake at least once!)
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_hx711_match[] = {
> +	{ .compatible = "avia,hx711", },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, of_hx711_match);
> +
> +static struct platform_driver hx711_driver = {
> +	.probe		= hx711_probe,
> +	.remove		= hx711_remove,
> +	.driver		= {
> +		.name		= "hx711-gpio",
> +		.of_match_table	= of_hx711_match,
> +	},
> +};
> +
> +module_platform_driver(hx711_driver);
> +
> +MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
> +MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:hx711-gpio");
> +
> 

