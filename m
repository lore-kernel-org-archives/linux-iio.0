Return-Path: <SRS0=/7h8=ZT=gmail.com=tduszyns@kernel.org>
From: Tomasz Duszynski <tduszyns@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Subject: [PATCHv2 2/4] iio: chemical: add driver for dsm501/ppd42ns particle sensors
Date: Mon,  6 Feb 2017 17:16:50 +0100
Message-Id: <20170206161650.8512-1-tduszyns@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds support for dsm501 and ppd42ns particle sensors.

Both sensors work on the same principle. Heater (resistor) heats up air
in sensor chamber which induces upward flow. Particles convect up through
a light beam provided by internal infra-red LED. Light scattered by
particles is picked by photodiode and internal electronics outputs PWM
signal.

Measuring low time occupancy of the signal during 30s measurement period
particles number in cubic meter can be computed.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 Changes in v2:
  o whitespace fix
  o drop excessive comments about conversion to pcs/0.01cf
  o fix 'concentartion' typo in dsm501_number_concentartion handler name

 drivers/iio/chemical/Kconfig  |  10 ++
 drivers/iio/chemical/Makefile |   1 +
 drivers/iio/chemical/dsm501.c | 225 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 236 insertions(+)
 create mode 100644 drivers/iio/chemical/dsm501.c

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index cea7f9857a1f..986d612aa77f 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -21,6 +21,16 @@ config ATLAS_PH_SENSOR
 	 To compile this driver as module, choose M here: the
 	 module will be called atlas-ph-sensor.

+config DSM501
+	tristate "Samyoung DSM501 particle sensor"
+	depends on GPIOLIB
+	help
+	 Say yes here to build support for the Samyoung DSM501
+	 particle sensor.
+
+	 To compile this driver as a module, choose M here: the module
+	 will be called dsm501.
+
 config IAQCORE
 	tristate "AMS iAQ-Core VOC sensors"
 	depends on I2C
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index b02202b41289..76f50ff8ba7d 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -4,5 +4,6 @@

 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ATLAS_PH_SENSOR)	+= atlas-ph-sensor.o
+obj-$(CONFIG_DSM501)		+= dsm501.o
 obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
 obj-$(CONFIG_VZ89X)		+= vz89x.o
diff --git a/drivers/iio/chemical/dsm501.c b/drivers/iio/chemical/dsm501.c
new file mode 100644
index 000000000000..1ad238ddb1a0
--- /dev/null
+++ b/drivers/iio/chemical/dsm501.c
@@ -0,0 +1,225 @@
+/*
+ * Samyoung DSM501 particle sensor driver
+ *
+ * Copyright (C) 2017 Tomasz Duszynski <tduszyns@gmail.com>
+ *
+ * Datasheets:
+ *  http://www.samyoungsnc.com/products/3-1%20Specification%20DSM501.pdf
+ *  http://wiki.timelab.org/images/f/f9/PPD42NS.pdf
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
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/timekeeping.h>
+
+#define DSM501_DRV_NAME "dsm501"
+#define DSM501_IRQ_NAME "dsm501_irq"
+
+#define DSM501_DEFAULT_MEASUREMENT_TIME 30 /* seconds */
+
+struct dsm501_data {
+	ktime_t ts;
+	ktime_t low_time;
+	ktime_t meas_time;
+
+	int irq;
+	struct gpio_desc *gpio;
+
+	struct mutex lock;
+
+	int (*number_concentration)(struct dsm501_data *data);
+};
+
+/*
+ * Series of data points in Fig. 8-3 (Low Ratio vs Particle)
+ * can be approximated by following polynomials:
+ *
+ * p(r) = 0 (undefined) for r < 4
+ * p(r) = 2353564.2r - 4373814.7 for 4 <= r < 20
+ * p(r) = 4788112.4r - 53581390 for r >= 20
+ */
+static int dsm501_number_concentration(struct dsm501_data *data)
+{
+	s64 retval = 0, r = div64_s64(ktime_to_ns(data->low_time) * 100,
+				      ktime_to_ns(data->meas_time));
+
+	if (r >= 4 && r < 20)
+		retval = 23535642 * r - 43738147;
+	else if (r >= 20)
+		retval = 47881124 * r - 535813900;
+
+	return div_s64(retval, 10);
+}
+
+/*
+ * Series of data points in Fig. 2 (Lo Pulse Occupancy Time vs Concentration)
+ * can be approximated by following polynomial:
+ *
+ * p(r) = 3844.2r^3 - 16201.3r^2 + 1848746.1r + 52497.2
+ */
+static int ppd42ns_number_concentration(struct dsm501_data *data)
+{
+	s64 retval, r3, r2, r = div64_s64(ktime_to_ns(data->low_time) * 100,
+					  ktime_to_ns(data->meas_time));
+
+	r2 = r * r;
+	r3 = r2 * r;
+
+	retval = 38442 * r3;
+	retval -= 162013 * r2;
+	retval += 18487461 * r;
+	retval += 524972;
+
+	return div_s64(retval, 10);
+}
+
+static irqreturn_t dsm501_irq(int irq, void *dev_id)
+{
+	struct dsm501_data *data = iio_priv(dev_id);
+	int val = gpiod_get_value(data->gpio);
+	ktime_t dt, ts = ktime_get();
+
+	if (ktime_to_ns(data->ts) == 0) {
+		data->ts = ts;
+		data->low_time = ktime_set(0, 0);
+	}
+
+	if (val) {
+		dt = ktime_sub(ts, data->ts);
+		data->low_time = ktime_add(data->low_time, dt);
+	} else {
+		data->ts = ts;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int dsm501_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	struct dsm501_data *data = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
+	unsigned long irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
+	int ret;
+
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		mutex_lock(&data->lock);
+		data->ts = ktime_set(0, 0);
+
+		ret = request_irq(data->irq, dsm501_irq, irqflags,
+				  DSM501_IRQ_NAME, indio_dev);
+		if (ret) {
+			dev_err(dev, "Failed to request interrupt %d\n", data->irq);
+			mutex_unlock(&data->lock);
+			return ret;
+		}
+
+		msleep_interruptible(ktime_to_ms(data->meas_time));
+		free_irq(data->irq, indio_dev);
+
+		*val = data->number_concentration(data);
+		mutex_unlock(&data->lock);
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info dsm501_info = {
+	.driver_module	= THIS_MODULE,
+	.read_raw = dsm501_read_raw,
+};
+
+static const struct iio_chan_spec dsm501_channels[] = {
+	{
+		.type = IIO_NUMBERCONCENTRATION,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+	},
+};
+
+static int dsm501_probe(struct platform_device *pdev)
+{
+	struct dsm501_data *data;
+	struct iio_dev *indio_dev;
+	struct device *dev = &pdev->dev;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	platform_set_drvdata(pdev, indio_dev);
+
+	data->gpio = devm_gpiod_get_index(dev, NULL, 0, GPIOD_IN);
+	if (IS_ERR(data->gpio)) {
+		dev_err(dev, "Failed to get GPIO\n");
+		return PTR_ERR(data->gpio);
+	}
+
+	data->irq = gpiod_to_irq(data->gpio);
+	if (data->irq < 0) {
+		dev_err(dev, "GPIO has no interrupt\n");
+		return data->irq;
+	}
+
+	data->meas_time = ktime_set(DSM501_DEFAULT_MEASUREMENT_TIME, 0);
+	data->number_concentration = of_device_get_match_data(dev);
+	mutex_init(&data->lock);
+
+	indio_dev->name = DSM501_DRV_NAME;
+	indio_dev->dev.parent = dev;
+	indio_dev->info = &dsm501_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = dsm501_channels;
+	indio_dev->num_channels = ARRAY_SIZE(dsm501_channels);
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static const struct of_device_id dsm501_id[] = {
+	{
+		.compatible = "samyoung,dsm501",
+		.data = dsm501_number_concentration,
+	},
+	{
+		.compatible = "shinyei,ppd42ns",
+		.data = ppd42ns_number_concentration,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, dsm501_id);
+
+static struct platform_driver dsm501_driver = {
+	.driver	= {
+		.name = DSM501_DRV_NAME,
+		.of_match_table = of_match_ptr(dsm501_id)
+	},
+	.probe = dsm501_probe
+};
+module_platform_driver(dsm501_driver);
+
+MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
+MODULE_DESCRIPTION("Samyoung DSM501 particle sensor driver");
+MODULE_LICENSE("GPL v2");
--
2.11.1
