Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:53519 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753932AbcLSQ2I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Dec 2016 11:28:08 -0500
Subject: Re: [PATCH v3 2/2] iio: adc: hx711: Add IIO driver for AVIA HX711
To: Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20161214161740.GA13896@andreas>
Cc: linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <78dfc4c0-f792-12b4-ca07-0242e95f7ee5@metafoo.de>
Date: Mon, 19 Dec 2016 17:28:02 +0100
MIME-Version: 1.0
In-Reply-To: <20161214161740.GA13896@andreas>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/14/2016 05:17 PM, Andreas Klinger wrote:
[...]
> +#include <linux/err.h>
> +#include <linux/gpio.h>

Since you used the consumer API linux/gpio.h is not needed.

> +#include <linux/gpio/consumer.h>
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
> +
> +#define HX711_GAIN_32		2	/* gain = 32 for channel B  */
> +#define HX711_GAIN_64		3	/* gain = 64 for channel A  */
> +#define HX711_GAIN_128		1	/* gain = 128 for channel A */
> +
> +struct hx711_data {
> +	struct device		*dev;
> +	struct gpio_desc	*gpiod_sck;
> +	struct gpio_desc	*gpiod_dout;
> +	int			gain_pulse;
> +	struct mutex		lock;
> +};
> +
> +static int hx711_read(struct hx711_data *hx711_data)
> +{
> +	int i, ret;
> +	int value = 0;
> +
> +	mutex_lock(&hx711_data->lock);
> +
> +	if (hx711_reset(hx711_data)) {

If you reset the device before each conversion wont this clear the channel
and gain selection? Wouldn't the driver always read from channel A at 128
gain regardless of what has been selected?

> +		dev_err(hx711_data->dev, "reset failed!");
> +		mutex_unlock(&hx711_data->lock);
> +		return -1;

If there is an error it should be propagated to the higher layers. At the
moment you only return a bogus conversion value.

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
> +	for (i = 0; i < hx711_data->gain_pulse; i++)
> +		ret = hx711_cycle(hx711_data);
> +
> +	mutex_unlock(&hx711_data->lock);
> +
> +	return value;
> +}
> +
> +static int hx711_read_raw(struct iio_dev *iio_dev,
> +				const struct iio_chan_spec *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct hx711_data *hx711_data = iio_priv(iio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = hx711_read(hx711_data);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
[...]
> +static struct attribute *hx711_attributes[] = {
> +	&iio_dev_attr_gain.dev_attr.attr,

For IIO devices the gain is typically expressed through the scale attribute.
Which is kind of the inverse of gain. It would be good if this driver
follows this standard notation. The scale is the value of 1LSB in mV. So
this includes the resolution of the ADC, the reference voltage and any gain
that is applied to the input signal.

The possible values can be listed in the scale_available attribute.

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
> +	.attrs			= &hx711_attribute_group,
> +};
> +
> +static const struct iio_chan_spec hx711_chan_spec[] = {
> +	{ .type = IIO_VOLTAGE,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW),

Given that there are two separate physical input channels this should be
expressed here and there should be two IIO channels for the device.

> +	},
> +};
> +
> +static int hx711_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct hx711_data *hx711_data = NULL;

The = NULL is not needed as it is overwritten a few lines below.

> +	struct iio_dev *iio;
> +	int ret = 0;

Again = 0 no needed.

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
> +	hx711_data->gpiod_sck = devm_gpiod_get(dev, "sck", GPIOD_OUT_HIGH);
> +	if (IS_ERR(hx711_data->gpiod_sck)) {
> +		dev_err(dev, "failed to get sck-gpiod: err=%ld\n",
> +					PTR_ERR(hx711_data->gpiod_sck));
> +		return PTR_ERR(hx711_data->gpiod_sck);
> +	}
> +
> +	hx711_data->gpiod_dout = devm_gpiod_get(dev, "dout", GPIOD_OUT_HIGH);
> +	if (IS_ERR(hx711_data->gpiod_dout)) {
> +		dev_err(dev, "failed to get dout-gpiod: err=%ld\n",
> +					PTR_ERR(hx711_data->gpiod_dout));
> +		return PTR_ERR(hx711_data->gpiod_dout);
> +	}
> +
> +	ret = gpiod_direction_input(hx711_data->gpiod_dout);

If dout is used as a input GPIO you should request it with GPIOD_IN. In that
case you can remove the gpiod_direction_input() call.

> +	if (ret < 0) {
> +		dev_err(hx711_data->dev, "gpiod_direction_input: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = gpiod_direction_output(hx711_data->gpiod_sck, 0);

Similar to above. If you want this to be a output GPIO with the default
value of 0 request it with GPIOD_OUT_LOW.

> +	if (ret < 0) {
> +		dev_err(hx711_data->dev, "gpiod_direction_output: %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, iio);

There is no matching platform_get_drvdata() so this can probably be removed.

> +
> +	iio->name = pdev->name;

This should be the part name. E.g. "hx711" in this case.

> +	iio->dev.parent = &pdev->dev;
> +	iio->info = &hx711_iio_info;
> +	iio->modes = INDIO_DIRECT_MODE;
> +	iio->channels = hx711_chan_spec;
> +	iio->num_channels = ARRAY_SIZE(hx711_chan_spec);
> +
> +	return devm_iio_device_register(dev, iio);
> +}

