Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:65435 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932171AbcLNKAr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2016 05:00:47 -0500
Date: Wed, 14 Dec 2016 11:00:21 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, ak@it-klinger.de
Subject: [PATCH v2 2/2] iio: adc: hx711: Add IIO driver for AVIA HX711
Message-ID: <20161214100021.GA26522@andreas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is the IIO driver for AVIA HX711 ADC which ist mostly used in weighting
cells.

The protocol is quite simple and using GPIO's:
One GPIO is used as clock (SCK) while another GPIO is read (DOUT)

The raw value read from the chip is delivered. 
To get a weight one needs to subtract the zero offset and scale it.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/adc/Kconfig  |  18 ++++
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/hx711.c  | 231 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 250 insertions(+)
 create mode 100644 drivers/iio/adc/hx711.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 932de1f9d1e7..918f582288c9 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -205,6 +205,24 @@ config HI8435
 	  This driver can also be built as a module. If so, the module will be
 	  called hi8435.
 
+config HX711
+	tristate "AVIA HX711 ADC for weight cells"
+	depends on GPIOLIB
+	help
+	  If you say yes here you get support for AVIA HX711 ADC which is used
+	  for weight cells
+
+	  This driver uses two GPIOs, one for setting the clock and the other
+	  one for getting the data
+
+	  Currently the raw value is read from the chip and delivered.
+	  For getting an actual weight one needs to subtract the
+	  zero offset and multiply by a scale factor.
+	  This should be done in userspace.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called hx711.
+
 config INA2XX_ADC
 	tristate "Texas Instruments INA2xx Power Monitors IIO driver"
 	depends on I2C && !SENSORS_INA2XX
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index b1aa456e6af3..d46e289900ef 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
 obj-$(CONFIG_DA9150_GPADC) += da9150-gpadc.o
 obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
 obj-$(CONFIG_HI8435) += hi8435.o
+obj-$(CONFIG_HX711) += hx711.o
 obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
 obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
 obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
new file mode 100644
index 000000000000..420f9451f3d1
--- /dev/null
+++ b/drivers/iio/adc/hx711.c
@@ -0,0 +1,231 @@
+/*
+ * HX711: analog to digital converter for weight sensor module
+ *
+ * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ */
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+
+#define HX711_GAIN_32		2	/* gain = 32 for channel B  */
+#define HX711_GAIN_64		3	/* gain = 64 for channel A  */
+#define HX711_GAIN_128		1	/* gain = 128 for channel A */
+
+struct hx711_data {
+	struct device		*dev;
+	struct gpio_desc	*gpiod_sck;
+	struct gpio_desc	*gpiod_dout;
+	int			gain_pulse;
+	struct mutex		lock;
+};
+
+static int hx711_reset(struct hx711_data *hx711_data)
+{
+	int i, val;
+
+	val = gpiod_get_value(hx711_data->gpiod_dout);
+	if (val) {
+		gpiod_set_value(hx711_data->gpiod_sck, 1);
+		udelay(80);
+		gpiod_set_value(hx711_data->gpiod_sck, 0);
+
+		for (i = 0; i < 1000; i++) {
+			val = gpiod_get_value(hx711_data->gpiod_dout);
+			if (!val)
+				break;
+			/* sleep at least 1 ms */
+			msleep(1);
+		}
+	}
+
+	return val;
+}
+
+static int hx711_cycle(struct hx711_data *hx711_data)
+{
+	int val;
+
+	/* if preempted for more then 60us while SCK is high:
+	 * hx711 is going in reset
+	 * ==> measuring is false
+	 */
+	preempt_disable();
+	gpiod_set_value(hx711_data->gpiod_sck, 1);
+	val = gpiod_get_value(hx711_data->gpiod_dout);
+	gpiod_set_value(hx711_data->gpiod_sck, 0);
+	preempt_enable();
+
+	return val;
+}
+
+static int hx711_read(struct hx711_data *hx711_data)
+{
+	int i, ret;
+	int value = 0;
+
+	if (hx711_reset(hx711_data)) {
+		dev_err(hx711_data->dev, "reset failed!");
+		return -1;
+	}
+
+	for (i = 0; i < 24; i++) {
+		value <<= 1;
+		ret = hx711_cycle(hx711_data);
+		if (ret)
+			value++;
+	}
+
+	value ^= 0x800000;
+
+	for (i = 0; i < hx711_data->gain_pulse; i++)
+		ret = hx711_cycle(hx711_data);
+
+	return value;
+}
+
+static int hx711_read_raw(struct iio_dev *iio_dev,
+				const struct iio_chan_spec *chan,
+				int *val, int *val2, long mask)
+{
+	struct hx711_data *hx711_data = iio_priv(iio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			mutex_lock(&hx711_data->lock);
+			*val = hx711_read(hx711_data);
+			mutex_unlock(&hx711_data->lock);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info hx711_iio_info = {
+	.driver_module		= THIS_MODULE,
+	.read_raw		= hx711_read_raw,
+};
+
+static const struct iio_chan_spec hx711_chan_spec[] = {
+	{ .type = IIO_VOLTAGE,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW),
+	},
+};
+
+static int hx711_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct hx711_data *hx711_data = NULL;
+	struct iio_dev *iio;
+	int ret = 0, ival;
+
+	iio = devm_iio_device_alloc(dev, sizeof(struct hx711_data));
+	if (!iio) {
+		dev_err(dev, "failed to allocate IIO device\n");
+		return -ENOMEM;
+	}
+
+	hx711_data = iio_priv(iio);
+	hx711_data->dev = dev;
+
+	mutex_init(&hx711_data->lock);
+
+	hx711_data->gpiod_sck = devm_gpiod_get(dev, "sck", GPIOD_OUT_HIGH);
+	if (IS_ERR(hx711_data->gpiod_sck)) {
+		dev_err(dev, "failed to get sck-gpiod: err=%ld\n",
+					PTR_ERR(hx711_data->gpiod_sck));
+		return PTR_ERR(hx711_data->gpiod_sck);
+	}
+
+	hx711_data->gpiod_dout = devm_gpiod_get(dev, "dout", GPIOD_OUT_HIGH);
+	if (IS_ERR(hx711_data->gpiod_dout)) {
+		dev_err(dev, "failed to get dout-gpiod: err=%ld\n",
+					PTR_ERR(hx711_data->gpiod_dout));
+		return PTR_ERR(hx711_data->gpiod_dout);
+	}
+
+	of_property_read_u32 (node, "gain", &ival);
+	switch (ival) {
+	case 32:
+		hx711_data->gain_pulse = HX711_GAIN_32;
+		break;
+	case 64:
+		hx711_data->gain_pulse = HX711_GAIN_64;
+		break;
+	default:
+		hx711_data->gain_pulse = HX711_GAIN_128;
+	}
+	dev_dbg(hx711_data->dev, "gain: %d\n", hx711_data->gain_pulse);
+
+	ret = gpiod_direction_input(hx711_data->gpiod_dout);
+	if (ret < 0) {
+		dev_err(hx711_data->dev, "gpiod_direction_input: %d\n", ret);
+		return ret;
+	}
+
+	ret = gpiod_direction_output(hx711_data->gpiod_sck, 0);
+	if (ret < 0) {
+		dev_err(hx711_data->dev, "gpiod_direction_output: %d\n", ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, iio);
+
+	iio->name = pdev->name;
+	iio->dev.parent = &pdev->dev;
+	iio->info = &hx711_iio_info;
+	iio->modes = INDIO_DIRECT_MODE;
+	iio->channels = hx711_chan_spec;
+	iio->num_channels = ARRAY_SIZE(hx711_chan_spec);
+
+	return devm_iio_device_register(dev, iio);
+}
+
+static const struct of_device_id of_hx711_match[] = {
+	{ .compatible = "avia,hx711", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, of_hx711_match);
+
+static struct platform_driver hx711_driver = {
+	.probe		= hx711_probe,
+	.driver		= {
+		.name		= "hx711-gpio",
+		.of_match_table	= of_hx711_match,
+	},
+};
+
+module_platform_driver(hx711_driver);
+
+MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
+MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:hx711-gpio");
+
-- 
2.1.4

