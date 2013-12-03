Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45524 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876Ab3LCUTl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Dec 2013 15:19:41 -0500
Message-ID: <529E3CDC.5010701@kernel.org>
Date: Tue, 03 Dec 2013 20:19:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Harald Geyer <harald@ccbib.org>
CC: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: Add new driver dht11
References: <E1VYf74-0000gd-5Z@stardust.g4.wien.funkfeuer.at> <alpine.DEB.2.01.1310222030570.23009@pmeerw.net> <E1VYiDp-0000pb-1i@stardust.g4.wien.funkfeuer.at> <alpine.DEB.2.01.1310222210230.23009@pmeerw.net> <E1VYjUo-0000uN-OY@stardust.g4.wien.funkfeuer.at> <5267E795.7030804@metafoo.de> <E1VZfrE-0000lZ-Ma@stardust.g4.wien.funkfeuer.at> <52909438.8000602@kernel.org> <E1VkHFl-00012T-4U@stardust.g4.wien.funkfeuer.at> <5292474A.8040101@kernel.org> <E1Vn8Z7-0001H3-5v@stardust.g4.wien.funkfeuer.at>
In-Reply-To: <E1Vn8Z7-0001H3-5v@stardust.g4.wien.funkfeuer.at>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/01/13 15:04, Harald Geyer wrote:
> This driver handles DHT11 and DHT22 sensors.
> 
> Signed-off-by: Harald Geyer <harald@ccbib.org>
Applied with 2 white space at end of line and one two many blank lines at the end of the
file fixed.

Applied to the togreg branch of iio.git (pushed out for now as testing until the
autobuilders are done).

Thanks for your hard work on this 'interesting' device ;)

Peter/Lars, if you want to add an ack/reviewed by then you have a day or two...

Note given it is a trivial binding and has been posted for a lot more than 3 weeks
I'm happy to take this one without and device tree specific feedback...

Jonathan
> ---
> changes since v2 (tested on DHT22):
> Remove some comments
> Use devm_iio_device_register()
> Rename driver: dht11-gpio -> dht11
> Move from INIT_COMPLETION to reinit_completion()
> 
> changes since v1 (tested on DHT11):
> Add dependency on GPIOLIB
> Prefix all local preprocessor macros with DHT11_
> Rename STARTUP to START_TRANSMISSION
> Remove leading zeros
> Simplify channel disambiguation
> Remove obvious comments
> Make whitespace more consistent
> Strip unnecessary output and simplify error handling
> Fix spelling errors
> 
> The v1 patch has been tested with DHT11 and DHT22 hardware.
> 
> Thanks,
> Harald
> 
>  .../devicetree/bindings/iio/humidity/dht11.txt     |   14 +
>  drivers/iio/Kconfig                                |    1 +
>  drivers/iio/Makefile                               |    1 +
>  drivers/iio/humidity/Kconfig                       |   15 +
>  drivers/iio/humidity/Makefile                      |    5 +
>  drivers/iio/humidity/dht11.c                       |  295 ++++++++++++++++++++
>  6 files changed, 331 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/humidity/dht11.txt
>  create mode 100644 drivers/iio/humidity/Kconfig
>  create mode 100644 drivers/iio/humidity/Makefile
>  create mode 100644 drivers/iio/humidity/dht11.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/humidity/dht11.txt b/Documentation/devicetree/bindings/iio/humidity/dht11.txt
> new file mode 100644
> index 0000000..ecc24c19
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/humidity/dht11.txt
> @@ -0,0 +1,14 @@
> +* DHT11 humidity/temperature sensor (and compatibles like DHT22)
> +
> +Required properties:
> +  - compatible: Should be "dht11"
> +  - gpios: Should specify the GPIO connected to the sensor's data
> +    line, see "gpios property" in
> +    Documentation/devicetree/bindings/gpio/gpio.txt.
> +
> +Example:
> +
> +humidity_sensor {
> +	compatible = "dht11";
> +	gpios = <&gpio0 6 0>;
> +}
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 90cf0cd..a5ed882 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -65,6 +65,7 @@ source "drivers/iio/common/Kconfig"
>  source "drivers/iio/dac/Kconfig"
>  source "drivers/iio/frequency/Kconfig"
>  source "drivers/iio/gyro/Kconfig"
> +source "drivers/iio/humidity/Kconfig"
>  source "drivers/iio/imu/Kconfig"
>  source "drivers/iio/light/Kconfig"
>  source "drivers/iio/magnetometer/Kconfig"
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index bcf7e9e..b3b5096 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -18,6 +18,7 @@ obj-y += common/
>  obj-y += dac/
>  obj-y += gyro/
>  obj-y += frequency/
> +obj-y += humidity/
>  obj-y += imu/
>  obj-y += light/
>  obj-y += magnetometer/
> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> new file mode 100644
> index 0000000..463c4d9
> --- /dev/null
> +++ b/drivers/iio/humidity/Kconfig
> @@ -0,0 +1,15 @@
> +#
> +# humidity sensor drivers
> +#
> +menu "Humidity sensors"
> +
> +config DHT11
> +	tristate "DHT11 (and compatible sensors) driver"
> +	depends on GPIOLIB
> +	help
> +	  This driver supports reading data via a single interrupt
> +	  generating GPIO line. Currently tested are DHT11 and DHT22.
> +	  Other sensors should work as well as long as they speak the
> +	  same protocol.
> +
> +endmenu
> diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
> new file mode 100644
> index 0000000..d5d36c0
> --- /dev/null
> +++ b/drivers/iio/humidity/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for IIO humidity sensor drivers
> +#
> +
> +obj-$(CONFIG_DHT11) += dht11.o
> diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
> new file mode 100644
> index 0000000..248f0da
> --- /dev/null
> +++ b/drivers/iio/humidity/dht11.c
> @@ -0,0 +1,295 @@
> +/*
> + * DHT11/DHT22 bit banging GPIO driver
> + *
> + * Copyright (c) Harald Geyer <harald@ccbib.org>
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
> +
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/sysfs.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/wait.h>
> +#include <linux/bitops.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/of_gpio.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define DRIVER_NAME	"dht11"
> +
> +#define DHT11_DATA_VALID_TIME	2000000000  /* 2s in ns */
> +
> +#define DHT11_EDGES_PREAMBLE 4
> +#define DHT11_BITS_PER_READ 40
> +#define DHT11_EDGES_PER_READ (2*DHT11_BITS_PER_READ + DHT11_EDGES_PREAMBLE + 1)
> +
> +/* Data transmission timing (nano seconds) */
> +#define DHT11_START_TRANSMISSION	18  /* ms */
> +#define DHT11_SENSOR_RESPONSE	80000
> +#define DHT11_START_BIT		50000
> +#define DHT11_DATA_BIT_LOW	27000
> +#define DHT11_DATA_BIT_HIGH	70000
> +
> +struct dht11 {
> +	struct device			*dev;
> +
> +	int				gpio;
> +	int				irq;
> +
> +	struct completion		completion;
> +
> +	s64				timestamp;
> +	int				temperature;
> +	int				humidity;
> +
> +	/* num_edges: -1 means "no transmission in progress" */
> +	int				num_edges;
> +	struct {s64 ts; int value; }	edges[DHT11_EDGES_PER_READ];
> +};
> +
> +static unsigned char dht11_decode_byte(int *timing, int threshold)
> +{
> +	unsigned char ret = 0;
> +	int i;
> +
> +	for (i = 0; i < 8; ++i) {
> +		ret <<= 1;
> +		if (timing[i] >= threshold)
> +			++ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int dht11_decode(struct dht11 *dht11, int offset)
> +{
> +	int i, t, timing[DHT11_BITS_PER_READ], threshold,
> +		timeres = DHT11_SENSOR_RESPONSE;
> +	unsigned char temp_int, temp_dec, hum_int, hum_dec, checksum;
> +
> +	/* Calculate timestamp resolution */
> +	for (i = 0; i < dht11->num_edges; ++i) {
> +		t = dht11->edges[i].ts - dht11->edges[i-1].ts;
> +		if (t > 0 && t < timeres)
> +			timeres = t;
> +	}
> +	if (2*timeres > DHT11_DATA_BIT_HIGH) {
> +		pr_err("dht11: timeresolution %d too bad for decoding\n",
> +			timeres);
> +		return -EIO;
> +	}
> +	threshold = DHT11_DATA_BIT_HIGH / timeres;
> +	if (DHT11_DATA_BIT_LOW/timeres + 1 >= threshold)
> +		pr_err("dht11: WARNING: decoding ambiguous\n");
> +
> +	/* scale down with timeres and check validity */
> +	for (i = 0; i < DHT11_BITS_PER_READ; ++i) {
> +		t = dht11->edges[offset + 2*i + 2].ts -
> +			dht11->edges[offset + 2*i + 1].ts;
> +		if (!dht11->edges[offset + 2*i + 1].value)
> +			return -EIO;  /* lost synchronisation */
> +		timing[i] = t / timeres;
> +	}
> +
> +	hum_int = dht11_decode_byte(timing, threshold);
> +	hum_dec = dht11_decode_byte(&timing[8], threshold);
> +	temp_int = dht11_decode_byte(&timing[16], threshold);
> +	temp_dec = dht11_decode_byte(&timing[24], threshold);
> +	checksum = dht11_decode_byte(&timing[32], threshold);
> +
> +	if (((hum_int + hum_dec + temp_int + temp_dec) & 0xff) != checksum)
> +		return -EIO;
> +
> +	dht11->timestamp = iio_get_time_ns();
> +	if (hum_int < 20) {  /* DHT22 */
> +		dht11->temperature = (((temp_int & 0x7f) << 8) + temp_dec) *
> +					((temp_int & 0x80) ? -100 : 100);
> +		dht11->humidity = ((hum_int << 8) + hum_dec) * 100;
> +	} else if (temp_dec == 0 && hum_dec == 0) {  /* DHT11 */
> +		dht11->temperature = temp_int * 1000;
> +		dht11->humidity = hum_int * 1000;
> +	} else {
> +		dev_err(dht11->dev,
> +			"Don't know how to decode data: %d %d %d %d\n",
> +			hum_int, hum_dec, temp_int, temp_dec);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dht11_read_raw(struct iio_dev *iio_dev,
> +			const struct iio_chan_spec *chan,
> +			int *val, int *val2, long m)
> +{
> +	struct dht11 *dht11 = iio_priv(iio_dev);
> +	int ret;
> +
> +	if (dht11->timestamp + DHT11_DATA_VALID_TIME < iio_get_time_ns()) {
> +		reinit_completion(&dht11->completion);
> +
> +		dht11->num_edges = 0;
> +		ret = gpio_direction_output(dht11->gpio, 0);
> +		if (ret)
> +			goto err;
> +		msleep(DHT11_START_TRANSMISSION);
> +		ret = gpio_direction_input(dht11->gpio);
> +		if (ret)
> +			goto err;
> +
> +		ret = wait_for_completion_killable_timeout(&dht11->completion,
> +								 HZ);
> +		if (ret == 0 && dht11->num_edges < DHT11_EDGES_PER_READ - 1) {
> +			dev_err(&iio_dev->dev,
> +					"Only %d signal edges detected\n",
> +					dht11->num_edges);
> +			ret = -ETIMEDOUT;
> +		}
> +		if (ret < 0)
> +			goto err;
> +
> +		ret = dht11_decode(dht11,
> +				dht11->num_edges == DHT11_EDGES_PER_READ ?
> +					DHT11_EDGES_PREAMBLE :
> +					DHT11_EDGES_PREAMBLE - 2);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	ret = IIO_VAL_INT;
> +	if (chan->type == IIO_TEMP)
> +		*val = dht11->temperature;
> +	else if (chan->type == IIO_HUMIDITYRELATIVE)
> +		*val = dht11->humidity;
> +	else
> +		ret = -EINVAL;
> +err:
> +	dht11->num_edges = -1;
> +	return ret;
> +}
> +
> +static const struct iio_info dht11_iio_info = {
> +	.driver_module		= THIS_MODULE,
> +	.read_raw		= dht11_read_raw,
> +};
> +
> +/*
> + * IRQ handler called on GPIO edges
> +*/
> +static irqreturn_t dht11_handle_irq(int irq, void *data)
> +{
> +	struct iio_dev *iio = data;
> +	struct dht11 *dht11 = iio_priv(iio);
> +
> +	/* TODO: Consider making the handler safe for IRQ sharing */
> +	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 0) {
> +		dht11->edges[dht11->num_edges].ts = iio_get_time_ns();
> +		dht11->edges[dht11->num_edges++].value =
> +						gpio_get_value(dht11->gpio);
> +
> +		if (dht11->num_edges >= DHT11_EDGES_PER_READ)
> +			complete(&dht11->completion);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_chan_spec dht11_chan_spec[] = {
> +	{ .type = IIO_TEMP, 
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), },
> +	{ .type = IIO_HUMIDITYRELATIVE, 
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), }
> +};
> +
> +static const struct of_device_id dht11_dt_ids[] = {
> +	{ .compatible = "dht11", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, dht11_dt_ids);
> +
> +static int dht11_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct dht11 *dht11;
> +	struct iio_dev *iio;
> +	int ret;
> +
> +	iio = devm_iio_device_alloc(dev, sizeof(*dht11));
> +	if (!iio) {
> +		dev_err(dev, "Failed to allocate IIO device\n");
> +		return -ENOMEM;
> +	}
> +
> +	dht11 = iio_priv(iio);
> +	dht11->dev = dev;
> +
> +	dht11->gpio = ret = of_get_gpio(node, 0);
> +	if (ret < 0)
> +		return ret;
> +	ret = devm_gpio_request_one(dev, dht11->gpio, GPIOF_IN, pdev->name);
> +	if (ret)
> +		return ret;
> +
> +	dht11->irq = gpio_to_irq(dht11->gpio);
> +	if (dht11->irq < 0) {
> +		dev_err(dev, "GPIO %d has no interrupt\n", dht11->gpio);
> +		return -EINVAL;
> +	}
> +	ret = devm_request_irq(dev, dht11->irq, dht11_handle_irq,
> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +				pdev->name, iio);
> +	if (ret)
> +		return ret;
> +
> +	dht11->timestamp = iio_get_time_ns() - DHT11_DATA_VALID_TIME - 1;
> +	dht11->num_edges = -1;
> +
> +	platform_set_drvdata(pdev, iio);
> +
> +	init_completion(&dht11->completion);
> +	iio->name = pdev->name;
> +	iio->dev.parent = &pdev->dev;
> +	iio->info = &dht11_iio_info;
> +	iio->modes = INDIO_DIRECT_MODE;
> +	iio->channels = dht11_chan_spec;
> +	iio->num_channels = ARRAY_SIZE(dht11_chan_spec);
> +
> +	return devm_iio_device_register(dev, iio);
> +}
> +
> +static struct platform_driver dht11_driver = {
> +	.driver = {
> +		.name	= DRIVER_NAME,
> +		.owner	= THIS_MODULE,
> +		.of_match_table = dht11_dt_ids,
> +	},
> +	.probe  = dht11_probe,
> +};
> +
> +module_platform_driver(dht11_driver);
> +
> +MODULE_AUTHOR("Harald Geyer <harald@ccbib.org>");
> +MODULE_DESCRIPTION("DHT11 humidity/temperature sensor driver");
> +MODULE_LICENSE("GPL v2");
> +
> 
