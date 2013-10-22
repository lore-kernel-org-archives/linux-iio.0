Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.cosmopool.net ([178.63.74.76]:58268 "EHLO
	mail.cosmopool.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160Ab3JVUGn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Oct 2013 16:06:43 -0400
Message-Id: <E1VYiDp-0000pb-1i@stardust.g4.wien.funkfeuer.at>
To: Peter Meerwald <pmeerw@pmeerw.net>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: Add new driver dht11-gpio
In-reply-to: <alpine.DEB.2.01.1310222030570.23009@pmeerw.net>
References: <E1VYf74-0000gd-5Z@stardust.g4.wien.funkfeuer.at> <alpine.DEB.2.01.1310222030570.23009@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date: Tue, 22 Oct 2013 22:06:33 +0200
From: Harald Geyer <harald@ccbib.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> > This driver handles DHT11 and DHT22 sensors.
> 
> comments inline, mostly nitpicking

Thanks for the review.

> > Signed-off-by: Harald Geyer <harald@ccbib.org>
> > ---
> > Now this is tested with both DHT11 and DHT22 hardware, so I'm asking
> > for full review this time. As this hadn't had a thorough review yet,
> > I don't list changes to the last version posted.
> > 
> > Thanks,
> > Harald
> > 
> >  .../bindings/iio/humidity/dht11-gpio.txt           |   14 +
> >  drivers/iio/Kconfig                                |    1 +
> >  drivers/iio/Makefile                               |    1 +
> >  drivers/iio/humidity/Kconfig                       |   14 +
> >  drivers/iio/humidity/Makefile                      |    5 +
> >  drivers/iio/humidity/dht11-gpio.c                  |  332 ++++++++++++++++
> ++++
> >  6 files changed, 367 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/humidity/dht11-gp
> io.txt
> >  create mode 100644 drivers/iio/humidity/Kconfig
> >  create mode 100644 drivers/iio/humidity/Makefile
> >  create mode 100644 drivers/iio/humidity/dht11-gpio.c
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/humidity/dht11-gpio.txt 
> b/Documentation/devicetree/bindings/iio/humidity/dht11-gpio.txt
> > new file mode 100644
> > index 0000000..c91bb27
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/humidity/dht11-gpio.txt
> > @@ -0,0 +1,14 @@
> > +* DHT11 humidity/temperature sensor (and compatibles like DHT22)
> > +
> > +Required properties:
> > +  - compatible: Should be "dht11-gpio"
> > +  - gpios: Should specify the GPIO connected to the sensors data
> 
> sensor's
> 
> > +    line, see "gpios property" in
> > +    Documentation/devicetree/bindings/gpio/gpio.txt.
> > +
> > +Example:
> > +
> > +humidity_sensor {
> > +	compatible = "dht11-gpio";
> > +	gpios = <&gpio0 6 0>;
> > +}
> > diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> > index 90cf0cd..a5ed882 100644
> > --- a/drivers/iio/Kconfig
> > +++ b/drivers/iio/Kconfig
> > @@ -65,6 +65,7 @@ source "drivers/iio/common/Kconfig"
> >  source "drivers/iio/dac/Kconfig"
> >  source "drivers/iio/frequency/Kconfig"
> >  source "drivers/iio/gyro/Kconfig"
> > +source "drivers/iio/humidity/Kconfig"
> >  source "drivers/iio/imu/Kconfig"
> >  source "drivers/iio/light/Kconfig"
> >  source "drivers/iio/magnetometer/Kconfig"
> > diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> > index bcf7e9e..b3b5096 100644
> > --- a/drivers/iio/Makefile
> > +++ b/drivers/iio/Makefile
> > @@ -18,6 +18,7 @@ obj-y += common/
> >  obj-y += dac/
> >  obj-y += gyro/
> >  obj-y += frequency/
> > +obj-y += humidity/
> >  obj-y += imu/
> >  obj-y += light/
> >  obj-y += magnetometer/
> > diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> > new file mode 100644
> > index 0000000..aa7e481
> > --- /dev/null
> > +++ b/drivers/iio/humidity/Kconfig
> > @@ -0,0 +1,14 @@
> > +#
> > +# humidity sensor drivers
> > +#
> > +menu "Humidity sensors"
> > +
> > +config DHT11_GPIO
> > +	tristate "DHT11 (and compatible sensors) driver"
> > +	help
> > +	  This driver supports reading data via a single interrupts
> 
> interrupt
> 
> > +	  generating GPIO line. Currently tested are DHT11 and DHT22.
> > +	  Other sensors should work as well as long as they speak the
> > +	  same protocol.
> > +
> > +endmenu
> > diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
> > new file mode 100644
> > index 0000000..5e8226f
> > --- /dev/null
> > +++ b/drivers/iio/humidity/Makefile
> > @@ -0,0 +1,5 @@
> > +#
> > +# Makefile for IIO humidity sensor drivers
> > +#
> > +
> > +obj-$(CONFIG_DHT11_GPIO) += dht11-gpio.o
> > diff --git a/drivers/iio/humidity/dht11-gpio.c b/drivers/iio/humidity/dht11
> -gpio.c
> > new file mode 100644
> > index 0000000..fcbfa3e
> > --- /dev/null
> > +++ b/drivers/iio/humidity/dht11-gpio.c
> > @@ -0,0 +1,332 @@
> > +/*
> > + * DHT11/DHT22 bit banging GPIO driver
> > + *
> > + * Copyright (c) Harald Geyer <harald@ccbib.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/printk.h>
> > +#include <linux/slab.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/wait.h>
> > +#include <linux/bitops.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio.h>
> > +#include <linux/of_gpio.h>
> > +
> > +#include <linux/iio/iio.h>
> > +
> > +#define DRIVER_NAME	"dht11-gpio"
> > +
> > +#define DATA_VALID_TIME	2000000000 /* 2s in ns */
> 
> prefix with DHT11_

Do you think this is needed, even as all these defines are
local to this file? (It would force rather unpleasant line
breaks...) Is there some general rule when to prefix and
when not to?
 
> > +
> > +#define EDGES_PREAMBLE	4
> > +#define BITS_PER_READ	40
> > +#define EDGES_PER_READ	(2*BITS_PER_READ + EDGES_PREAMBLE + 1)
> > +
> > +/* Data transmission timing (nano seconds) */
> > +#define STARTUP		18    /* ms */
> 
> just a line above nano seconds were promised, and now this: ms?! :)

Sure, the exception from the rule is noted as end of line comment.
Is there some better way to do this?

> > +#define SENSOR_RESPONSE	80000
> > +#define START_BIT	50000
> > +#define DATA_BIT_LOW	27000
> > +#define DATA_BIT_HIGH	70000
> > +
> > +/* TODO?: Support systems without DT? */
> > +
> > +struct dht11_gpio {
> > +	struct device			*dev;
> > +
> > +	int				gpio;
> > +	int				irq;
> > +
> > +	struct completion		completion;
> > +
> > +	s64				timestamp;
> > +	int				temperature;
> > +	int				humidity;
> > +
> > +	/* num_edges: -1 means "no transmission in progress" */
> > +	int				num_edges;
> > +	struct {s64 ts; int value; }	edges[EDGES_PER_READ];
> > +};
> > +
> > +/*
> > + * dht11_edges_print: show the data as actually received by the
> > + *                    driver.
> > + * This is dead code, keeping it for now just in case somebody needs
> > + * it for porting the driver to new sensor HW, etc.
> > + *
> > +static void dht11_edges_print(struct dht11_gpio *dht11)
> > +{
> > +	int i;
> > +
> > +	for (i = 1; i < dht11->num_edges; ++i) {
> > +		pr_err("dht11: %d: %lld ns %s\n", i,
> 
> inconsistent driver name; dht11-gpio was used before
> 
> > +			dht11->edges[i].ts - dht11->edges[i-1].ts,
> > +			dht11->edges[i-1].value ? "high" : "low");
> > +	}
> > +}
> > +*/
> > +
> > +static unsigned char dht11_gpio_decode_byte(int *timing, int threshold)
> > +{
> > +	unsigned char ret = 0;
> > +	int i;
> > +
> > +	for (i = 0; i < 8; ++i) {
> > +		ret <<= 1;
> > +		if (timing[i] >= threshold)
> > +			++ret;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int dht11_gpio_decode(struct dht11_gpio *dht11, int offset)
> > +{
> > +	int i, t, timing[BITS_PER_READ], threshold, timeres = SENSOR_RESPONSE;
> > +	unsigned char temp_int, temp_dec, hum_int, hum_dec, checksum;
> > +
> > +	/* Calculate timestamp resolution */
> > +	for (i = 0; i < dht11->num_edges; ++i) {
> > +		t = dht11->edges[i].ts - dht11->edges[i-1].ts;
> > +		if (t > 0 && t < timeres)
> > +			timeres = t;
> > +	}
> > +	if (2*timeres > DATA_BIT_HIGH) {
> > +		pr_err("dht11-gpio: timeresolution %d too bad for decoding\n",
> > +			timeres);
> > +		return -EIO;
> > +	}
> > +	threshold = DATA_BIT_HIGH/timeres;

I'm inclined to change this to:
	threshold = DATA_BIT_HIGH / timeres;

> > +	if (DATA_BIT_LOW/timeres + 1 >= threshold)
> > +		pr_err("dht11-gpio: WARNING: decoding ambiguous\n");
> > +
> > +	/* scale down with timeres and check validity */
> > +	for (i = 0; i < BITS_PER_READ; ++i) {
> > +		t = dht11->edges[offset + 2*i + 2].ts -
> > +			dht11->edges[offset + 2*i + 1].ts;
> > +		if (!dht11->edges[offset + 2*i + 1].value)
> > +			return -EIO; /* lost synchronisation */
> > +		timing[i] = t / timeres;

and leave this as is.

> inconsistent whitespace around / operator

Would that be consistent enough? (The rule being, that a / operator
on it's own gets spaces, but the same operator in a statement
together with operators with lower binding power gets none.)

> > +	}
> > +
> > +	hum_int = dht11_gpio_decode_byte(timing, threshold);
> > +	hum_dec = dht11_gpio_decode_byte(&timing[8], threshold);
> > +	temp_int = dht11_gpio_decode_byte(&timing[16], threshold);
> > +	temp_dec = dht11_gpio_decode_byte(&timing[24], threshold);
> > +	checksum = dht11_gpio_decode_byte(&timing[32], threshold);
> > +
> > +	if (((hum_int + hum_dec + temp_int + temp_dec) & 0x00ff) != checksum)
> 
> maybe 0xff instead of 0x00ff is clearer

Ok, I'm happy either way.

> > +		return -EIO;
> > +
> > +	dht11->timestamp = iio_get_time_ns();
> > +	if (hum_int < 20) {  /* DHT22 */
> > +		dht11->temperature = (((temp_int & 0x7f) << 8) + temp_dec) *
> > +					((temp_int & 0x80) ? -100 : 100);
> > +		dht11->humidity = ((hum_int << 8) + hum_dec) * 100;
> > +	} else if (temp_dec == 0 && hum_dec == 0) {  /* DHT11 */
> 
> extra space before comment

Actually I think that code is much more readable if end of line
comments are visually separated by two or more spaces (and
check_patch.pl is happy with that). I see now, that I have not
been entirely consistent and would rather add extra spaces rather
then remove them. What do you think?
 
> > +		dht11->temperature = temp_int * 1000;
> > +		dht11->humidity = hum_int * 1000;
> > +	} else {
> > +		dev_err(dht11->dev,
> > +			"Don't know how to decode data: %d %d %d %d\n",
> > +			hum_int, hum_dec, temp_int, temp_dec);
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int dht11_gpio_read_raw(struct iio_dev *iio_dev,
> > +			const struct iio_chan_spec *chan,
> > +			int *val, int *val2, long m)
> > +{
> > +	struct dht11_gpio *dht11 = iio_priv(iio_dev);
> > +	int ret = 0;
> 
> the initialization of ret is not used; don't or init with -EINVAL to save 
> an assignment
> 
> > +
> > +	if (dht11->timestamp + DATA_VALID_TIME < iio_get_time_ns()) {
> > +		INIT_COMPLETION(dht11->completion);
> > +
> > +		dht11->num_edges = 0;
> > +		ret = gpio_direction_output(dht11->gpio, 0);
> > +		if (ret)
> > +			goto err;
> > +		msleep(STARTUP);
> > +		ret = gpio_direction_input(dht11->gpio);
> > +		if (ret)
> > +			goto err;
> > +
> > +		ret = wait_for_completion_killable_timeout(&dht11->completion,
> > +								 HZ);
> > +		if (ret == 0 && dht11->num_edges < EDGES_PER_READ - 1) {
> > +			dev_err(&iio_dev->dev,
> > +					"Only %d signal edges detected\n",
> > +					dht11->num_edges);
> > +			ret = -ETIMEDOUT;
> > +		}
> > +		if (ret < 0)
> > +			goto err;
> > +
> > +		ret = dht11_gpio_decode(dht11,
> > +				dht11->num_edges == EDGES_PER_READ ?
> > +					EDGES_PREAMBLE : EDGES_PREAMBLE - 2);
> > +		if (ret)
> > +			goto err;
> > +	}
> > +
> > +	ret = IIO_VAL_INT;
> > +	if (chan->channel == 0)
> > +		*val = dht11->temperature;
> > +	else if (chan->channel == 1)
> > +		*val = dht11->humidity;
> 
> use channel type to discriminate channels

Yes, very good point.

I agree with the rest of the comments. Thanks for the review.
Harald
 
> > +	else
> > +		ret = -EINVAL;
> > +err:
> > +	dht11->num_edges = -1;
> > +	return ret;
> > +}
> > +
> > +static const struct iio_info dht11_gpio_iio_info = {
> > +	.driver_module		= THIS_MODULE,
> > +	.read_raw		= dht11_gpio_read_raw,
> > +};
> > +
> > +/*
> > + * IRQ handler called on GPIO edges
> > +*/
> > +static irqreturn_t dht11_gpio_handle_irq(int irq, void *data)
> > +{
> > +	struct iio_dev *iio = data;
> > +	struct dht11_gpio *dht11 = iio_priv(iio);
> > +
> > +	/* TODO: Consider making the handler safe for IRQ sharing */
> > +	if (dht11->num_edges < EDGES_PER_READ && dht11->num_edges >= 0) {
> > +		dht11->edges[dht11->num_edges].ts = iio_get_time_ns();
> > +		dht11->edges[dht11->num_edges++].value =
> > +						gpio_get_value(dht11->gpio);
> > +
> > +		if (dht11->num_edges >= EDGES_PER_READ)
> > +			complete(&dht11->completion);
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static const struct iio_chan_spec dht11_gpio_chan_spec[] = {
> > +	{ .type = IIO_TEMP, .channel = 0,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), },
> > +	{ .type = IIO_HUMIDITYRELATIVE, .channel = 1,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> 
> .channel is not needed; there aren't multiple channels of the same type
> 
> > +}
> 
> weird indentation level
> 
> > +};
> > +
> > +static const struct of_device_id dht11_gpio_dt_ids[] = {
> > +	{ .compatible = "dht11-gpio", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, dht11_gpio_dt_ids);
> > +
> > +static int dht11_gpio_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *node = dev->of_node;
> > +	struct dht11_gpio *dht11;
> > +	struct iio_dev *iio;
> > +	int ret = 0;
> 
> don't initialize ret
> 
> > +
> > +	/* Allocate the IIO device. */
> 
> obvious comment
> 
> > +	iio = devm_iio_device_alloc(dev, sizeof(*dht11));
> > +	if (!iio) {
> > +		dev_err(dev, "Failed to allocate IIO device\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	dht11 = iio_priv(iio);
> > +	dht11->dev = dev;
> > +
> > +	dht11->gpio = ret = of_get_gpio(node, 0);
> > +	if (ret < 0)
> > +		return ret;
> > +	ret = devm_gpio_request_one(dev, dht11->gpio, GPIOF_IN, pdev->name);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dht11->irq = gpio_to_irq(dht11->gpio);
> > +	if (dht11->irq < 0) {
> > +		dev_err(dev, "GPIO %d has no interrupt\n", dht11->gpio);
> > +		return -EINVAL;
> > +	}
> > +	ret = devm_request_irq(dev, dht11->irq, dht11_gpio_handle_irq,
> > +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> > +				pdev->name, iio);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dht11->timestamp = iio_get_time_ns() - DATA_VALID_TIME - 1;
> > +	dht11->num_edges = -1;
> > +
> > +	platform_set_drvdata(pdev, iio);
> > +
> > +	init_completion(&dht11->completion);
> > +	iio->name = pdev->name;
> > +	iio->dev.parent = &pdev->dev;
> > +	iio->info = &dht11_gpio_iio_info;
> > +	iio->modes = INDIO_DIRECT_MODE;
> > +	iio->channels = dht11_gpio_chan_spec;
> > +	iio->num_channels = ARRAY_SIZE(dht11_gpio_chan_spec);
> > +
> > +	/* Register IIO device. */
> 
> the function name is pretty obvious, no comment needed
> 
> > +	ret = iio_device_register(iio);
> 
> maybe just return here, the extra output is not needed
> 
> > +	if (ret) {
> > +		dev_err(dev, "Failed to register IIO device\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int dht11_gpio_remove(struct platform_device *pdev)
> > +{
> > +	struct iio_dev *iio = platform_get_drvdata(pdev);
> > +
> > +	iio_device_unregister(iio);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver dht11_gpio_driver = {
> > +	.driver = {
> > +		.name	= DRIVER_NAME,
> > +		.owner	= THIS_MODULE,
> > +		.of_match_table = dht11_gpio_dt_ids,
> > +	},
> > +	.probe  = dht11_gpio_probe,
> > +	.remove = dht11_gpio_remove,
> > +};
> > +
> > +module_platform_driver(dht11_gpio_driver);
> > +
> > +MODULE_AUTHOR("Harald Geyer <harald@ccbib.org>");
> > +MODULE_DESCRIPTION("DHT11 humidity/temperature sensor driver");
> > +MODULE_LICENSE("GPL v2");
> > +
> > 
> 
> -- 
> 
> Peter Meerwald
> +43-664-2444418 (mobile)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
