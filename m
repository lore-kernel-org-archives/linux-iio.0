Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:32999 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753500AbcH2UXh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 16:23:37 -0400
Date: Mon, 29 Aug 2016 16:22:56 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6] iio: stx104: Add IIO support for the ADC channels
Message-ID: <20160829202243.GA10236@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Apex Embedded Systems STX104 features 16 channels of single-ended (8
channels of true differential) 16-bit analog input. Differential input
configuration may be selected via a physical jumper on the device.
Similarly, input polarity (unipolar/bipolar) is configured via a
physical jumper on the device.

Input gain selection is available to the user via software, thus
allowing eight possible input ranges: +-10V, +-5V, +-2.5V, +-1.25V,
0 to 10V, 0 to 5V, 0 to 2.5V, and 0 to 1.25V. Four input gain
configurations are supported: x1, x2, x4, and x8.

This ADC resolution is 16-bits (1/65536 of full scale). Analog input
samples are taken on software trigger; neither FIFO sampling nor
interrupt triggering is supported by this driver.

The Apex Embedded Systems STX104 is primarily an analog-to-digital
converter device. The STX104 IIO driver was initially placed in the DAC
directory because only the DAC portion of the STX104 was supported at
the time. Now that ADC support has been added to the STX104 IIO driver,
the driver should be moved to the more appropriate ADC directory.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
Changes in v6:
  - Use switch-case to branch logic for read_raw/write_raw mask evaluation; this
    should make it clearer when evaluating the various possible code paths
  - IIO_CHAN_INFO_HARDWAREGAIN is used to expose the device gain setting
  - Raw analog input value is returned by IIO_CHAN_INFO_RAW; constants and
    values should be exposed to userspace for processing rather than doing all
    the math within the driver, so IIO_CHAN_INFO_OFFSET and IIO_CHAN_INFO_SCALE
    now expose the relevant offset and scale values necessary for processing

 MAINTAINERS                       |   4 +-
 drivers/iio/adc/Kconfig           |  15 ++++
 drivers/iio/adc/Makefile          |   1 +
 drivers/iio/{dac => adc}/stx104.c | 153 ++++++++++++++++++++++++++++++++------
 drivers/iio/dac/Kconfig           |  10 ---
 drivers/iio/dac/Makefile          |   1 -
 6 files changed, 147 insertions(+), 37 deletions(-)
 rename drivers/iio/{dac => adc}/stx104.c (60%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ae09eb4..6f0ff72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -809,11 +809,11 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 F:	sound/aoa/
 
-APEX EMBEDDED SYSTEMS STX104 DAC DRIVER
+APEX EMBEDDED SYSTEMS STX104 IIO DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	drivers/iio/dac/stx104.c
+F:	drivers/iio/adc/stx104.c
 
 APM DRIVER
 M:	Jiri Kosina <jikos@kernel.org>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index e4022fd..36695e8 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -409,6 +409,21 @@ config ROCKCHIP_SARADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called rockchip_saradc.
 
+config STX104
+	tristate "Apex Embedded Systems STX104 driver"
+	depends on X86 && ISA_BUS_API
+	select GPIOLIB
+	help
+	  Say yes here to build support for the Apex Embedded Systems STX104
+	  integrated analog PC/104 card.
+
+	  This driver supports the 16 channels of single-ended (8 channels of
+	  differential) analog inputs, 2 channels of analog output, 4 digital
+	  inputs, and 4 digital outputs provided by the STX104.
+
+	  The base port addresses for the devices may be configured via the base
+	  array module parameter.
+
 config TI_ADC081C
 	tristate "Texas Instruments ADC081C/ADC101C/ADC121C family"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 33254eb..bdd69d6 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
 obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
 obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
 obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
+obj-$(CONFIG_STX104) += stx104.o
 obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
 obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
 obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
diff --git a/drivers/iio/dac/stx104.c b/drivers/iio/adc/stx104.c
similarity index 60%
rename from drivers/iio/dac/stx104.c
rename to drivers/iio/adc/stx104.c
index 792a971..7ca12d5 100644
--- a/drivers/iio/dac/stx104.c
+++ b/drivers/iio/adc/stx104.c
@@ -1,5 +1,5 @@
 /*
- * DAC driver for the Apex Embedded Systems STX104
+ * IIO driver for the Apex Embedded Systems STX104
  * Copyright (C) 2016 William Breathitt Gray
  *
  * This program is free software; you can redistribute it and/or modify
@@ -20,19 +20,30 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/isa.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/spinlock.h>
 
-#define STX104_NUM_CHAN 2
-
-#define STX104_CHAN(chan) {				\
+#define STX104_OUT_CHAN(chan) {				\
 	.type = IIO_VOLTAGE,				\
 	.channel = chan,				\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
 	.indexed = 1,					\
 	.output = 1					\
 }
+#define STX104_IN_CHAN(chan, diff) {					\
+	.type = IIO_VOLTAGE,						\
+	.channel = chan,						\
+	.channel2 = chan,						\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_HARDWAREGAIN) |	\
+		BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_SCALE),	\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.indexed = 1,							\
+	.differential = diff						\
+}
+
+#define STX104_NUM_OUT_CHAN 2
 
 #define STX104_EXTENT 16
 
@@ -47,8 +58,8 @@ MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
  * @base:		base port address of the IIO device
  */
 struct stx104_iio {
-	unsigned chan_out_states[STX104_NUM_CHAN];
-	unsigned base;
+	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
+	unsigned int base;
 };
 
 /**
@@ -69,28 +80,95 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
 	struct stx104_iio *const priv = iio_priv(indio_dev);
+	unsigned int adc_config;
+	int adbu;
+	int gain;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		/* get gain configuration */
+		adc_config = inb(priv->base + 11);
+		gain = adc_config & 0x3;
+
+		*val = 1 << gain;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_RAW:
+		if (chan->output) {
+			*val = priv->chan_out_states[chan->channel];
+			return IIO_VAL_INT;
+		}
+
+		/* select ADC channel */
+		outb(chan->channel | (chan->channel << 4), priv->base + 2);
+
+		/* trigger ADC sample capture and wait for completion */
+		outb(0, priv->base);
+		while (inb(priv->base + 8) & BIT(7));
+
+		*val = inw(priv->base);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OFFSET:
+		/* get ADC bipolar/unipolar configuration */
+		adc_config = inb(priv->base + 11);
+		adbu = !(adc_config & BIT(2));
+
+		*val = -32768 * adbu;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/* get ADC bipolar/unipolar and gain configuration */
+		adc_config = inb(priv->base + 11);
+		adbu = !(adc_config & BIT(2));
+		gain = adc_config & 0x3;
+
+		*val = 5;
+		*val2 = 15 - adbu + gain;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	}
 
-	if (mask != IIO_CHAN_INFO_RAW)
-		return -EINVAL;
-
-	*val = priv->chan_out_states[chan->channel];
-
-	return IIO_VAL_INT;
+	return -EINVAL;
 }
 
 static int stx104_write_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int val, int val2, long mask)
 {
 	struct stx104_iio *const priv = iio_priv(indio_dev);
-	const unsigned chan_addr_offset = 2 * chan->channel;
 
-	if (mask != IIO_CHAN_INFO_RAW)
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		/* Only four gain states (x1, x2, x4, x8) */
+		switch (val) {
+		case 1:
+			outb(0, priv->base + 11);
+			break;
+		case 2:
+			outb(1, priv->base + 11);
+			break;
+		case 4:
+			outb(2, priv->base + 11);
+			break;
+		case 8:
+			outb(3, priv->base + 11);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		return 0;
+	case IIO_CHAN_INFO_RAW:
+		if (chan->output) {
+			/* DAC can only accept up to a 16-bit value */
+			if ((unsigned int)val > 65535)
+				return -EINVAL;
+
+			priv->chan_out_states[chan->channel] = val;
+			outw(val, priv->base + 4 + 2 * chan->channel);
+
+			return 0;
+		}
 		return -EINVAL;
+	}
 
-	priv->chan_out_states[chan->channel] = val;
-	outw(val, priv->base + 4 + chan_addr_offset);
-
-	return 0;
+	return -EINVAL;
 }
 
 static const struct iio_info stx104_info = {
@@ -99,9 +177,22 @@ static const struct iio_info stx104_info = {
 	.write_raw = stx104_write_raw
 };
 
-static const struct iio_chan_spec stx104_channels[STX104_NUM_CHAN] = {
-	STX104_CHAN(0),
-	STX104_CHAN(1)
+/* single-ended input channels configuration */
+static const struct iio_chan_spec stx104_channels_sing[] = {
+	STX104_OUT_CHAN(0), STX104_OUT_CHAN(1),
+	STX104_IN_CHAN(0, 0), STX104_IN_CHAN(1, 0), STX104_IN_CHAN(2, 0),
+	STX104_IN_CHAN(3, 0), STX104_IN_CHAN(4, 0), STX104_IN_CHAN(5, 0),
+	STX104_IN_CHAN(6, 0), STX104_IN_CHAN(7, 0), STX104_IN_CHAN(8, 0),
+	STX104_IN_CHAN(9, 0), STX104_IN_CHAN(10, 0), STX104_IN_CHAN(11, 0),
+	STX104_IN_CHAN(12, 0), STX104_IN_CHAN(13, 0), STX104_IN_CHAN(14, 0),
+	STX104_IN_CHAN(15, 0)
+};
+/* differential input channels configuration */
+static const struct iio_chan_spec stx104_channels_diff[] = {
+	STX104_OUT_CHAN(0), STX104_OUT_CHAN(1),
+	STX104_IN_CHAN(0, 1), STX104_IN_CHAN(1, 1), STX104_IN_CHAN(2, 1),
+	STX104_IN_CHAN(3, 1), STX104_IN_CHAN(4, 1), STX104_IN_CHAN(5, 1),
+	STX104_IN_CHAN(6, 1), STX104_IN_CHAN(7, 1)
 };
 
 static int stx104_gpio_get_direction(struct gpio_chip *chip,
@@ -188,13 +279,27 @@ static int stx104_probe(struct device *dev, unsigned int id)
 
 	indio_dev->info = &stx104_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = stx104_channels;
-	indio_dev->num_channels = STX104_NUM_CHAN;
+
+	/* determine if differential inputs */
+	if (inb(base[id] + 8) & BIT(5)) {
+		indio_dev->num_channels = ARRAY_SIZE(stx104_channels_diff);
+		indio_dev->channels = stx104_channels_diff;
+	} else {
+		indio_dev->num_channels = ARRAY_SIZE(stx104_channels_sing);
+		indio_dev->channels = stx104_channels_sing;
+	}
+
 	indio_dev->name = dev_name(dev);
 
 	priv = iio_priv(indio_dev);
 	priv->base = base[id];
 
+	/* configure device for software trigger operation */
+	outb(0, base[id] + 9);
+
+	/* initialize gain setting to x1 */
+	outb(0, base[id] + 11);
+
 	/* initialize DAC output to 0V */
 	outw(0, base[id] + 4);
 	outw(0, base[id] + 6);
@@ -251,5 +356,5 @@ static struct isa_driver stx104_driver = {
 module_isa_driver(stx104_driver, num_stx104);
 
 MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
-MODULE_DESCRIPTION("Apex Embedded Systems STX104 DAC driver");
+MODULE_DESCRIPTION("Apex Embedded Systems STX104 IIO driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index b9f0442..6048aed 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -254,16 +254,6 @@ config MCP4922
 	  To compile this driver as a module, choose M here: the module
 	  will be called mcp4922.
 
-config STX104
-	tristate "Apex Embedded Systems STX104 DAC driver"
-	depends on X86 && ISA_BUS_API
-	select GPIOLIB
-	help
-	  Say yes here to build support for the 2-channel DAC and GPIO on the
-	  Apex Embedded Systems STX104 integrated analog PC/104 card. The base
-	  port addresses for the devices may be configured via the base array
-	  module parameter.
-
 config VF610_DAC
 	tristate "Vybrid vf610 DAC driver"
 	depends on OF
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index b1a1206..e6abef9 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -27,5 +27,4 @@ obj-$(CONFIG_MAX517) += max517.o
 obj-$(CONFIG_MAX5821) += max5821.o
 obj-$(CONFIG_MCP4725) += mcp4725.o
 obj-$(CONFIG_MCP4922) += mcp4922.o
-obj-$(CONFIG_STX104) += stx104.o
 obj-$(CONFIG_VF610_DAC) += vf610_dac.o
-- 
2.7.3

