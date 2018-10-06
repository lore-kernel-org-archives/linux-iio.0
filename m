Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39563 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeJGDf5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Oct 2018 23:35:57 -0400
Received: by mail-ed1-f68.google.com with SMTP id d15-v6so2236071edq.6
        for <linux-iio@vger.kernel.org>; Sat, 06 Oct 2018 13:31:14 -0700 (PDT)
From: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
To: linux-iio@vger.kernel.org
Cc: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Subject: [PATCH 1/2] Add driver for Texas Instrument DAC7311 It is a driver for Texas Instruments 8/10/12-bit 1-channel compatible with DAC6311 and DAC5311 chips.
Date: Sat,  6 Oct 2018 22:31:07 +0200
Message-Id: <20181006203108.20439-1-charles-antoine.couret@essensium.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Datasheet of this chip:
http://www.ti.com/lit/ds/symlink/dac7311.pdf

Signed-off-by: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
---
 drivers/iio/dac/Kconfig      |   9 +
 drivers/iio/dac/Makefile     |   1 +
 drivers/iio/dac/ti-dac7311.c | 361 +++++++++++++++++++++++++++++++++++
 3 files changed, 371 insertions(+)
 create mode 100644 drivers/iio/dac/ti-dac7311.c

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 80beb64e9e0c..ac205c8f5de0 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -356,6 +356,15 @@ config TI_DAC5571
 
 	  If compiled as a module, it will be called ti-dac5571.
 
+config TI_DAC7311
+	tristate "Texas Instruments 8/10/12-bit 1-channel DAC driver"
+	depends on SPI
+	help
+	  Driver for the Texas Instruments
+	  DAC7311, DAC6311, DAC5311.
+
+	  If compiled as a module, it will be called ti-dac7311.
+
 config VF610_DAC
 	tristate "Vybrid vf610 DAC driver"
 	depends on OF
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index a1b37cf99441..4b02021cc30f 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -39,4 +39,5 @@ obj-$(CONFIG_STM32_DAC_CORE) += stm32-dac-core.o
 obj-$(CONFIG_STM32_DAC) += stm32-dac.o
 obj-$(CONFIG_TI_DAC082S085) += ti-dac082s085.o
 obj-$(CONFIG_TI_DAC5571) += ti-dac5571.o
+obj-$(CONFIG_TI_DAC7311) += ti-dac7311.o
 obj-$(CONFIG_VF610_DAC) += vf610_dac.o
diff --git a/drivers/iio/dac/ti-dac7311.c b/drivers/iio/dac/ti-dac7311.c
new file mode 100644
index 000000000000..e7e61a7ce619
--- /dev/null
+++ b/drivers/iio/dac/ti-dac7311.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0
+/* ti-dac7311.c - Texas Instruments 8/10/12-bit 1-channel DAC driver
+ *
+ * Copyright (C) 2018 CMC NV
+ *
+ * http://www.ti.com/lit/ds/symlink/dac7311.pdf
+ */
+
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+enum {
+	SINGLE_8BITS = 0,
+	SINGLE_10BITS,
+	SINGLE_12BITS,
+};
+
+enum {
+	POWER_RUNNING = 0,
+	POWER_1KOHM_TO_GND,
+	POWER_100KOHM_TO_GND,
+	POWER_TRI_STATE,
+};
+
+struct ti_dac_spec {
+	u8 num_channels;
+	u8 resolution;
+};
+
+static const struct ti_dac_spec ti_dac_spec[] = {
+	[SINGLE_8BITS]  = { .num_channels = 1, .resolution = 8  },
+	[SINGLE_10BITS] = { .num_channels = 1, .resolution = 10 },
+	[SINGLE_12BITS] = { .num_channels = 1, .resolution = 12 },
+};
+
+/**
+ * struct ti_dac_chip - TI DAC chip
+ * @lock: protects write sequences
+ * @vref: regulator generating Vref
+ * @mesg: SPI message to perform a write
+ * @xfer: SPI transfer used by @mesg
+ * @val: cached value
+ * @powerdown: whether the chip is powered down
+ * @powerdown_mode: selected by the user
+ * @resolution: resolution of the chip
+ * @buf: buffer for @xfer
+ */
+struct ti_dac_chip {
+	struct mutex lock;
+	struct regulator *vref;
+	struct spi_message mesg;
+	struct spi_transfer xfer;
+	u16 val;
+	bool powerdown;
+	u8 powerdown_mode;
+	u8 resolution;
+	u8 buf[2] ____cacheline_aligned;
+};
+
+static int ti_dac_cmd(struct ti_dac_chip *ti_dac, u8 power, u16 val)
+{
+	u8 shift = 14 - ti_dac->resolution;
+
+	ti_dac->buf[0] = (val << shift) & 0xFF;
+	ti_dac->buf[1] = (power << 6) | (val >> (8 - shift));
+	return spi_sync(ti_dac->mesg.spi, &ti_dac->mesg);
+}
+
+static const char * const ti_dac_powerdown_modes[] = {
+	"running",
+	"1kohm_to_gnd",
+	"100kohm_to_gnd",
+	"three_state",
+};
+
+static int ti_dac_get_powerdown_mode(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan)
+{
+	struct ti_dac_chip *ti_dac = iio_priv(indio_dev);
+
+	return ti_dac->powerdown_mode;
+}
+
+static int ti_dac_set_powerdown_mode(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     unsigned int mode)
+{
+	struct ti_dac_chip *ti_dac = iio_priv(indio_dev);
+	int ret = 0;
+
+	if (ti_dac->powerdown_mode == mode)
+		return ret;
+
+	mutex_lock(&ti_dac->lock);
+	if (ti_dac->powerdown) {
+		ret = ti_dac_cmd(ti_dac, ti_dac->powerdown_mode, ti_dac->val);
+		if (ret)
+			goto out;
+	}
+	ti_dac->powerdown_mode = mode;
+
+out:
+	mutex_unlock(&ti_dac->lock);
+	return ret;
+}
+
+static const struct iio_enum ti_dac_powerdown_mode = {
+	.items = ti_dac_powerdown_modes,
+	.num_items = ARRAY_SIZE(ti_dac_powerdown_modes),
+	.get = ti_dac_get_powerdown_mode,
+	.set = ti_dac_set_powerdown_mode,
+};
+
+static ssize_t ti_dac_read_powerdown(struct iio_dev *indio_dev,
+				     uintptr_t private,
+				     const struct iio_chan_spec *chan,
+				     char *buf)
+{
+	struct ti_dac_chip *ti_dac = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", ti_dac->powerdown);
+}
+
+static ssize_t ti_dac_write_powerdown(struct iio_dev *indio_dev,
+				      uintptr_t private,
+				      const struct iio_chan_spec *chan,
+				      const char *buf, size_t len)
+{
+	struct ti_dac_chip *ti_dac = iio_priv(indio_dev);
+	bool powerdown;
+	int ret;
+
+	ret = strtobool(buf, &powerdown);
+	if (ret)
+		return ret;
+
+	if (ti_dac->powerdown == powerdown)
+		return len;
+
+	mutex_lock(&ti_dac->lock);
+		ret = ti_dac_cmd(ti_dac, ti_dac->powerdown_mode, 0);
+	if (!ret)
+		ti_dac->powerdown = powerdown;
+	mutex_unlock(&ti_dac->lock);
+
+	return ret ? ret : len;
+}
+
+static const struct iio_chan_spec_ext_info ti_dac_ext_info[] = {
+	{
+		.name	   = "powerdown",
+		.read	   = ti_dac_read_powerdown,
+		.write	   = ti_dac_write_powerdown,
+		.shared	   = IIO_SHARED_BY_TYPE,
+	},
+	IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE, &ti_dac_powerdown_mode),
+	IIO_ENUM_AVAILABLE("powerdown_mode", &ti_dac_powerdown_mode),
+	{ },
+};
+
+#define TI_DAC_CHANNEL(chan) {					\
+	.type = IIO_VOLTAGE,					\
+	.channel = (chan),					\
+	.address = (chan),					\
+	.output = true,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.ext_info = ti_dac_ext_info,				\
+}
+
+static const struct iio_chan_spec ti_dac_channels[] = {
+	TI_DAC_CHANNEL(0),
+};
+
+static int ti_dac_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct ti_dac_chip *ti_dac = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*val = ti_dac->val;
+		ret = IIO_VAL_INT;
+		break;
+
+	case IIO_CHAN_INFO_SCALE:
+		ret = regulator_get_voltage(ti_dac->vref);
+		if (ret < 0)
+			return ret;
+
+		*val = ret / 1000;
+		*val2 = ti_dac->resolution;
+		ret = IIO_VAL_FRACTIONAL_LOG2;
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int ti_dac_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	struct ti_dac_chip *ti_dac = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (ti_dac->val == val)
+			return 0;
+
+		if (val >= (1 << ti_dac->resolution) || val < 0)
+			return -EINVAL;
+
+		if (ti_dac->powerdown)
+			return -EBUSY;
+
+		mutex_lock(&ti_dac->lock);
+		ret = ti_dac_cmd(ti_dac, ti_dac->powerdown_mode, val);
+		if (!ret)
+			ti_dac->val = val;
+		mutex_unlock(&ti_dac->lock);
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int ti_dac_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan, long mask)
+{
+	return IIO_VAL_INT;
+}
+
+static const struct iio_info ti_dac_info = {
+	.read_raw	   = ti_dac_read_raw,
+	.write_raw	   = ti_dac_write_raw,
+	.write_raw_get_fmt = ti_dac_write_raw_get_fmt,
+};
+
+static int ti_dac_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	const struct ti_dac_spec *spec;
+	struct ti_dac_chip *ti_dac;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*ti_dac));
+	if (!indio_dev) {
+		dev_err(dev, "can not allocate iio device\n");
+		return -ENOMEM;
+	}
+
+	spi->max_speed_hz = 50000000;
+	spi->mode = SPI_MODE_1;
+	spi->irq = -1;
+	spi->bits_per_word = 16;
+	spi_setup(spi);
+
+	indio_dev->dev.parent = dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
+	indio_dev->info = &ti_dac_info;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ti_dac_channels;
+	spi_set_drvdata(spi, indio_dev);
+
+	ti_dac = iio_priv(indio_dev);
+	ti_dac->powerdown_mode = POWER_RUNNING;
+	ti_dac->val = 0;
+	ti_dac->xfer.tx_buf = &ti_dac->buf;
+	ti_dac->xfer.len = sizeof(ti_dac->buf);
+	spi_message_init_with_transfers(&ti_dac->mesg, &ti_dac->xfer, 1);
+	ti_dac->mesg.spi = spi;
+
+	spec = &ti_dac_spec[spi_get_device_id(spi)->driver_data];
+	indio_dev->num_channels = spec->num_channels;
+	ti_dac->resolution = spec->resolution;
+
+	ti_dac->vref = devm_regulator_get(dev, "vref");
+	if (IS_ERR(ti_dac->vref)) {
+		dev_err(dev, "error to get regulator\n");
+		return PTR_ERR(ti_dac->vref);
+	}
+
+	ret = regulator_enable(ti_dac->vref);
+	if (ret < 0) {
+		dev_err(dev, "can not enable regulator\n");
+		return ret;
+	}
+
+	mutex_init(&ti_dac->lock);
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(dev, "fail to register iio device: %d\n", ret);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	mutex_destroy(&ti_dac->lock);
+	regulator_disable(ti_dac->vref);
+	return ret;
+}
+
+static int ti_dac_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ti_dac_chip *ti_dac = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	mutex_destroy(&ti_dac->lock);
+	regulator_disable(ti_dac->vref);
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id ti_dac_of_id[] = {
+	{ .compatible = "ti,dac5311" },
+	{ .compatible = "ti,dac6311" },
+	{ .compatible = "ti,dac7311" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ti_dac_of_id);
+#endif
+
+static const struct spi_device_id ti_dac_spi_id[] = {
+	{ "dac5311", SINGLE_8BITS  },
+	{ "dac6311", SINGLE_10BITS },
+	{ "dac7311", SINGLE_12BITS },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ti_dac_spi_id);
+
+static struct spi_driver ti_dac_driver = {
+	.driver = {
+		.name		= "ti-dac7311",
+		.of_match_table	= of_match_ptr(ti_dac_of_id),
+	},
+	.probe	  = ti_dac_probe,
+	.remove   = ti_dac_remove,
+	.id_table = ti_dac_spi_id,
+};
+module_spi_driver(ti_dac_driver);
+
+MODULE_AUTHOR("Charles-Antoine Couret <charles-antoine.couret@essensium.com>");
+MODULE_DESCRIPTION("Texas Instruments 8/10/12-bit 1-channel DAC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1
