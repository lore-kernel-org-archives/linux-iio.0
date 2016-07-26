Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34902 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572AbcGZG2S (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2016 02:28:18 -0400
Received: by mail-pf0-f195.google.com with SMTP id h186so13253488pfg.2
        for <linux-iio@vger.kernel.org>; Mon, 25 Jul 2016 23:28:17 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [RFC v2 2/3] iio: adc: ti-adc161s626: add support for TI 1-channel differential ADCs
Date: Mon, 25 Jul 2016 23:28:10 -0700
Message-Id: <1469514491-6638-3-git-send-email-mranostay@gmail.com>
In-Reply-To: <1469514491-6638-1-git-send-email-mranostay@gmail.com>
References: <1469514491-6638-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add support for Texas Instruments ADC141S626, and ADC161S626 chips.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 .../devicetree/bindings/iio/adc/ti-adc161s626.txt  |  17 ++
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-adc161s626.c                    | 248 +++++++++++++++++++++
 4 files changed, 278 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt
 create mode 100644 drivers/iio/adc/ti-adc161s626.c

diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt
new file mode 100644
index 000000000000..2bdad2d13d6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti-adc161s626.txt
@@ -0,0 +1,17 @@
+* Texas Instruments ADC141S626, and ADC161S626 chip
+
+Required properties:
+ - compatible: Should be "ti,adc141s626" or "ti,adc161s626"
+ - reg: spi chip select number for the device
+
+Recommended properties:
+ - spi-max-frequency: Definition as per
+		Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Example:
+adc@0 {
+	compatible = "ti,adc161s626";
+	reg = <0>;
+	spi-max-frequency = <4300000>;
+};
+
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1de31bdd4ce4..2658f2f69bad 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -426,6 +426,18 @@ config TI_ADC128S052
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-adc128s052.
 
+config TI_ADC161S626
+	tristate "Texas Instruments ADC161S626 1-channel differential ADC"
+	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  If you say yes here you get support for Texas Instruments ADC141S626,
+	  and ADC161S626 chips.
+
+	  This driver can also be build as a module. If so, the module will be
+	  called ti-adc161s626.
+
 config TI_ADS1015
 	tristate "Texas Instruments ADS1015 ADC"
 	depends on I2C && !SENSORS_ADS1015
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 0ba0d500eedb..1d805770c1a0 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
 obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
 obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
 obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
+obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
 obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
 obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
 obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
new file mode 100644
index 000000000000..f94b69f9c288
--- /dev/null
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -0,0 +1,248 @@
+/*
+ * ti-adc161s626.c - Texas Instruments ADC161S626 1-channel differential ADC
+ *
+ * ADC Devices Supported:
+ *  adc141s626 - 14-bit ADC
+ *  adc161s626 - 16-bit ADC
+ *
+ * Copyright (C) 2016 Matt Ranostay <mranostay@gmail.com>
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
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/spi/spi.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define TI_ADC_DRV_NAME	"ti-adc161s626"
+
+enum {
+	TI_ADC141S626,
+	TI_ADC161S626,
+};
+
+static const struct iio_chan_spec ti_adc141s626_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.channel = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 14,
+			.storagebits = 16,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct iio_chan_spec ti_adc161s626_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.channel = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+struct ti_adc_data {
+	struct iio_dev *indio_dev;
+	struct spi_device *spi;
+	u8 read_size;
+	u8 shift;
+
+	u8 buffer[16] ____cacheline_aligned;
+};
+
+static int ti_adc_read_measurement(struct ti_adc_data *data,
+				   struct iio_chan_spec const *chan, int *val)
+{
+	int ret;
+
+	switch (data->read_size) {
+	case 2: {
+		__be16 buf;
+
+		ret = spi_read(data->spi, (void *) &buf, 2);
+		if (ret)
+			return ret;
+
+		*val = be16_to_cpu(buf);
+		break;
+	}
+	case 3: {
+		__be32 buf;
+
+		ret = spi_read(data->spi, (void *) &buf, 3);
+		if (ret)
+			return ret;
+
+		*val = be32_to_cpu(buf) >> 8;
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	*val = sign_extend32(*val >> data->shift, chan->scan_type.realbits - 1);
+
+	return 0;
+}
+
+static irqreturn_t ti_adc_trigger_handler(int irq, void *private)
+{
+	struct iio_poll_func *pf = private;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ti_adc_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = ti_adc_read_measurement(data, &indio_dev->channels[0],
+				     (int *) &data->buffer);
+	if (!ret)
+		iio_push_to_buffers_with_timestamp(indio_dev,
+					data->buffer,
+					iio_get_time_ns(indio_dev));
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int ti_adc_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct ti_adc_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (mask != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ti_adc_read_measurement(data, chan, val);
+	iio_device_release_direct_mode(indio_dev);
+
+	if (!ret)
+		return IIO_VAL_INT;
+
+	return 0;
+}
+
+static const struct iio_info ti_adc_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = ti_adc_read_raw,
+};
+
+static int ti_adc_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct ti_adc_data *data;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	indio_dev->info = &ti_adc_info;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
+	indio_dev->name = TI_ADC_DRV_NAME;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	spi_set_drvdata(spi, indio_dev);
+
+	data = iio_priv(indio_dev);
+	data->spi = spi;
+
+	switch (spi_get_device_id(spi)->driver_data) {
+	case TI_ADC141S626:
+		indio_dev->channels = ti_adc141s626_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ti_adc141s626_channels);
+		data->shift = 0;
+		data->read_size = 2;
+		break;
+	case TI_ADC161S626:
+		indio_dev->channels = ti_adc161s626_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ti_adc161s626_channels);
+		data->shift = 6;
+		data->read_size = 3;
+		break;
+	}
+
+	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+					 ti_adc_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_unreg_buffer;
+
+	return 0;
+
+error_unreg_buffer:
+	iio_triggered_buffer_cleanup(indio_dev);
+
+	return ret;
+}
+
+static int ti_adc_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+
+	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+
+	return 0;
+}
+
+static const struct of_device_id ti_adc_dt_ids[] = {
+	{ .compatible = "ti,adc141s626", },
+	{ .compatible = "ti,adc161s626", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ti_adc_dt_ids);
+
+static const struct spi_device_id ti_adc_id[] = {
+	{"adc141s626", TI_ADC141S626},
+	{"adc161s626", TI_ADC161S626},
+	{},
+};
+MODULE_DEVICE_TABLE(spi, ti_adc_id);
+
+static struct spi_driver ti_adc_driver = {
+	.driver = {
+		.name	= TI_ADC_DRV_NAME,
+		.of_match_table = of_match_ptr(ti_adc_dt_ids),
+	},
+	.probe		= ti_adc_probe,
+	.remove		= ti_adc_remove,
+	.id_table	= ti_adc_id,
+};
+module_spi_driver(ti_adc_driver);
+
+MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
+MODULE_DESCRIPTION("Texas Instruments ADC1x1S 1-channel differential ADC");
+MODULE_LICENSE("GPL");
-- 
2.7.4

