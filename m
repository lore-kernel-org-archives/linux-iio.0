Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58213 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdALWvu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jan 2017 17:51:50 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, marek.vasut@gmail.com, geert@linux-m68k.org
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3] iio: adc: Add Maxim MAX11100 driver
Date: Thu, 12 Jan 2017 23:51:39 +0100
Message-Id: <1484261499-7729-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jacopo Mondi <jacopo@jmondi.org>

Add IIO driver for Maxim MAX11100 single-channel ADC.
Add DT bindings documentation.

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Tested-by: Marek Vasut <marek.vasut@gmail.com>

---

Sending v3 incorporating last comments from review and from testing.

One final thing I would like to be clarified is about the measure unit
returned by read_raw().
Currently (value_raw * value_scale) return the ADC input value in mV.
While testing the patch I've been questioned if that should not actually
be in uV. This is easily achievable making _scale return a value in uV.
I have found no mention of this in the ABI documentation as it speaks of
generic voltage.
Can we have a final word on this?

Thanks Marek for having tested this.

v1 -> v2:
    - incorporated pmeerw's review comments
    - retrieve vref from dts and use that to convert read_raw result
      to mV
    - add device tree bindings documentation

v2 -> v3:
    - add _SCALE bit of read_raw function and change _RAW bit accordingly
    - call regulator_get_voltage when accessing the _SCALE part of read_raw
      and not during probe
    - add back remove function as regulator has to be disabled when detaching
      the module. Do not use devm_ version of iio_register/unregister functions
      anymore but do unregister in the remove.
    - remove mutex as access to SPI bus is protected by SPI core. Thanks marex

---

 .../devicetree/bindings/iio/adc/max11100.txt       |  17 ++
 drivers/iio/adc/Kconfig                            |   9 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/max11100.c                         | 187 +++++++++++++++++++++
 4 files changed, 214 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/max11100.txt
 create mode 100644 drivers/iio/adc/max11100.c

diff --git a/Documentation/devicetree/bindings/iio/adc/max11100.txt b/Documentation/devicetree/bindings/iio/adc/max11100.txt
new file mode 100644
index 0000000..6877c11
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/max11100.txt
@@ -0,0 +1,17 @@
+* Maxim max11100 Analog to Digital Converter (ADC)
+
+Required properties:
+  - compatible: Should be "maxim,max11100"
+  - vref-supply: phandle to the regulator that provides reference voltage
+
+Optional properties:
+  - spi-max-frequency: SPI maximum frequency
+
+Example:
+
+adc0: max11100@0 {
+        compatible = "maxim,max11100";
+        vref-supply = <&adc0_vref>;
+        spi-max-frequency = <240000>;
+};
+
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 38bc319..c32bc7a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -307,6 +307,15 @@ config MAX1027
 	  To compile this driver as a module, choose M here: the module will be
 	  called max1027.
 
+config MAX11100
+	tristate "Maxim max11100 ADC driver"
+	depends on SPI_MASTER
+	help
+	  Say yes here to build support for Maxim max11100 SPI ADC
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called max11100.
+
 config MAX1363
 	tristate "Maxim max1363 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d36c4be..5684369 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
 obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
 obj-$(CONFIG_LTC2485) += ltc2485.o
 obj-$(CONFIG_MAX1027) += max1027.o
+obj-$(CONFIG_MAX11100) += max11100.o
 obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
new file mode 100644
index 0000000..78e2a45
--- /dev/null
+++ b/drivers/iio/adc/max11100.c
@@ -0,0 +1,187 @@
+/*
+ * iio/adc/max11100.c
+ * Maxim max11100 ADC Driver with IIO interface
+ *
+ * Copyright (C) 2016 Renesas Electronics Corporation
+ * Copyright (C) 2016 Jacopo Mondi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/driver.h>
+
+/*
+ * LSB is the ADC single digital step
+ * 1 LSB = (vref_mv / 2 ^ 16)
+ *
+ * LSB is used to calculate analog voltage value
+ * from the number of ADC steps count
+ *
+ * Ain = (count * LSB)
+ */
+#define MAX11100_LSB_DIV		(1 << 16)
+
+struct max11100_state {
+	const struct max11100_chip_desc *desc;
+	struct regulator *vref_reg;
+	struct spi_device *spi;
+};
+
+static struct iio_chan_spec max11100_channels[] = {
+	{ /* [0] */
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static struct max11100_chip_desc {
+	unsigned int num_chan;
+	const struct iio_chan_spec *channels;
+} max11100_desc = {
+	.num_chan = ARRAY_SIZE(max11100_channels),
+	.channels = max11100_channels,
+};
+
+static int max11100_read_single(struct iio_dev *indio_dev, int *val)
+{
+	int ret;
+	struct max11100_state *state = iio_priv(indio_dev);
+	uint8_t buffer[3];
+
+	ret = spi_read(state->spi, buffer, sizeof(buffer));
+	if (ret) {
+		dev_err(&indio_dev->dev, "SPI transfer failed\n");
+		return ret;
+	}
+
+	/* the first 8 bits sent out from ADC must be 0s */
+	if (buffer[0]) {
+		dev_err(&indio_dev->dev, "Invalid value: buffer[0] != 0\n");
+		return -EINVAL;
+	}
+
+	*val = (buffer[1] << 8) | buffer[2];
+
+	return 0;
+}
+
+static int max11100_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long info)
+{
+	int ret, vref_uv;
+	struct max11100_state *state = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = max11100_read_single(indio_dev, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		vref_uv = regulator_get_voltage(state->vref_reg);
+		if (vref_uv < 0)
+			/* dummy regulator "get_voltage" returns -EINVAL */
+			return -EINVAL;
+
+		*val =  vref_uv / 1000;
+		*val2 = MAX11100_LSB_DIV;
+		return IIO_VAL_FRACTIONAL;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info max11100_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = max11100_read_raw,
+};
+
+static int max11100_probe(struct spi_device *spi)
+{
+	int ret;
+	struct iio_dev *indio_dev;
+	struct max11100_state *state;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, indio_dev);
+
+	state = iio_priv(indio_dev);
+	state->spi = spi;
+	state->desc = &max11100_desc;
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
+	indio_dev->info = &max11100_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = state->desc->channels;
+	indio_dev->num_channels = state->desc->num_chan;
+
+	state->vref_reg = devm_regulator_get(&spi->dev, "vref");
+	if (IS_ERR(state->vref_reg))
+		return PTR_ERR(state->vref_reg);
+
+	ret = regulator_enable(state->vref_reg);
+	if (ret)
+		return ret;
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto disable_regulator;
+
+	return 0;
+
+disable_regulator:
+	regulator_disable(state->vref_reg);
+
+	return ret;
+}
+
+static int max11100_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct max11100_state *state = iio_priv(indio_dev);
+
+	regulator_disable(state->vref_reg);
+
+	iio_device_unregister(indio_dev);
+
+	return 0;
+}
+
+static const struct of_device_id max11100_ids[] = {
+	{.compatible = "maxim,max11100"},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, max11100_ids);
+
+static struct spi_driver max11100_driver = {
+	.driver = {
+		.name	= "max11100",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(max11100_ids),
+	},
+	.probe		= max11100_probe,
+	.remove		= max11100_remove,
+};
+
+module_spi_driver(max11100_driver);
+
+MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
+MODULE_DESCRIPTION("Maxim max11100 ADC Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

