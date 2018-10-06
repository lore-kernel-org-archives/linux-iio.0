Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44763 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeJGDB6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Oct 2018 23:01:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id z21-v6so9963574edb.11
        for <linux-iio@vger.kernel.org>; Sat, 06 Oct 2018 12:57:21 -0700 (PDT)
From: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
To: linux-iio@vger.kernel.org
Cc: Charles-Antoine Couret <charles-antoine.couret@essensium.com>
Subject: [PATCH] Add AD7949 ADC driver family
Date: Sat,  6 Oct 2018 21:56:30 +0200
Message-Id: <20181006195630.16823-1-charles-antoine.couret@essensium.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Compatible with AD7682 and AD7689 chips.
It is a Analog Devices ADC driver 14/16 bits 4/8 channels
with SPI protocol

Datasheet of the device:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD7949.pdf
---
 drivers/iio/adc/Kconfig  |  10 ++
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7949.c | 331 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 342 insertions(+)
 create mode 100644 drivers/iio/adc/ad7949.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 4a754921fb6f..42e66efff6c0 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -116,6 +116,16 @@ config AD7923
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7923.
 
+config AD7949
+	tristate "Analog Devices AD7949 and similar ADCs driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices
+	  AD7949, AD7682, AD7689 8 Channel ADCs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7949.
+
 config AD799X
 	tristate "Analog Devices AD799x ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 03db7b578f9c..88804c867aa9 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_AD7766) += ad7766.o
 obj-$(CONFIG_AD7791) += ad7791.o
 obj-$(CONFIG_AD7793) += ad7793.o
 obj-$(CONFIG_AD7887) += ad7887.o
+obj-$(CONFIG_AD7949) += ad7949.o
 obj-$(CONFIG_AD799X) += ad799x.o
 obj-$(CONFIG_ASPEED_ADC) += aspeed_adc.o
 obj-$(CONFIG_AT91_ADC) += at91_adc.o
diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
new file mode 100644
index 000000000000..ac430ef217be
--- /dev/null
+++ b/drivers/iio/adc/ad7949.c
@@ -0,0 +1,331 @@
+/*
+ * ad7949.c - Analog Devices ADC driver 14/16 bits 4/8 channels
+ *
+ * Copyright (C) 2018 CMC NV
+ *
+ * http://www.analog.com/media/en/technical-documentation/data-sheets/AD7949.pdf
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/delay.h>
+
+#define AD7949_MASK_CFG			0x3C7F
+#define AD7949_MASK_CHANNEL_SEL		0x380
+#define AD7949_MASK_TOTAL		0x3FFF
+#define AD7949_OFFSET_CHANNEL_SEL	7
+#define AD7949_CFG_READ_BACK		0x1
+#define AD7949_CFG_REG_SIZE_BITS	14
+
+enum {
+	HEIGHT_14BITS = 0,
+	QUAD_16BITS,
+	HEIGHT_16BITS,
+};
+
+struct ad7949_adc_spec {
+	u8 num_channels;
+	u8 resolution;
+};
+
+static const struct ad7949_adc_spec ad7949_adc_spec[] = {
+	[HEIGHT_14BITS]  = { .num_channels = 8, .resolution = 14 },
+	[QUAD_16BITS] = { .num_channels = 4, .resolution = 16 },
+	[HEIGHT_16BITS] = { .num_channels = 8, .resolution = 16 },
+};
+
+/**
+ * struct ad7949_adc_chip - AD ADC chip
+ * @lock: protects write sequences
+ * @vref: regulator generating Vref
+ * @iio_dev: reference to iio structure
+ * @resolution: resolution of the chip
+ */
+struct ad7949_adc_chip {
+	struct mutex lock;
+	struct regulator *vref;
+	struct iio_dev *indio_dev;
+	struct spi_device *spi;
+	u8 resolution;
+	u16 cfg;
+	unsigned int current_channel;
+};
+
+static u16 ad7949_spi_read_cfg(struct ad7949_adc_chip *ad7949_adc)
+{
+	return ad7949_adc->cfg;
+}
+
+static int ad7949_spi_bits_per_word(struct ad7949_adc_chip *ad7949_adc)
+{
+	u16 cfg = ad7949_spi_read_cfg(ad7949_adc) & AD7949_MASK_TOTAL;
+	bool is_cfg_read_back = cfg & AD7949_CFG_READ_BACK ? false : true;
+	int ret = ad7949_adc->resolution;
+
+	if (is_cfg_read_back)
+		ret += AD7949_CFG_REG_SIZE_BITS;
+
+	return ret;
+}
+
+static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
+			        u16 mask)
+{
+	int ret;
+	u16 cfg = ad7949_spi_read_cfg(ad7949_adc) & AD7949_MASK_TOTAL;
+	int bits_per_word = ad7949_spi_bits_per_word(ad7949_adc);
+	int shift = (bits_per_word - AD7949_CFG_REG_SIZE_BITS);
+	u32 buf_value = ((val & mask) | (cfg & ~mask)) << shift;
+	struct spi_message msg;
+	struct spi_transfer tx[] = {
+		{
+			.tx_buf = &buf_value,
+			.len = 4,
+			.bits_per_word = bits_per_word,
+		},
+	};
+
+	ad7949_adc->cfg = buf_value >> shift;
+	spi_message_init(&msg);
+	spi_message_add_tail(&tx[0], &msg);
+	ret = spi_sync(ad7949_adc->spi, &msg);
+	udelay(2);
+
+	return ret;
+}
+
+static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
+				   unsigned int channel)
+{
+	int ret;
+	int bits_per_word = ad7949_spi_bits_per_word(ad7949_adc);
+	int shift = (bits_per_word - AD7949_CFG_REG_SIZE_BITS);
+	u32 buf_value = 0;
+	struct spi_message msg;
+	struct spi_transfer tx[] = {
+		{
+			.rx_buf = &buf_value,
+			.len = 4,
+			.bits_per_word = bits_per_word,
+		},
+	};
+
+	if (!val)
+		return -EINVAL;
+
+	ad7949_spi_write_cfg(ad7949_adc, channel << AD7949_OFFSET_CHANNEL_SEL,
+			     AD7949_MASK_CHANNEL_SEL);
+	spi_message_init(&msg);
+	spi_message_add_tail(&tx[0], &msg);
+	ret = spi_sync(ad7949_adc->spi, &msg);
+	udelay(2);
+
+	ad7949_adc->current_channel = channel;
+	*val = (buf_value >> shift);
+	return ret;
+}
+
+#define AD7949_ADC_CHANNEL(chan) {				\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.scan_index = (chan),					\
+	.channel = (chan),					\
+	.address = (chan),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+}
+
+static const struct iio_chan_spec ad7949_adc_channels[] = {
+	AD7949_ADC_CHANNEL(0),
+	AD7949_ADC_CHANNEL(1),
+	AD7949_ADC_CHANNEL(2),
+	AD7949_ADC_CHANNEL(3),
+	AD7949_ADC_CHANNEL(4),
+	AD7949_ADC_CHANNEL(5),
+	AD7949_ADC_CHANNEL(6),
+	AD7949_ADC_CHANNEL(7),
+};
+
+static int ad7949_spi_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct ad7949_adc_chip *ad7949_adc = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&ad7949_adc->lock);
+		ret = ad7949_spi_read_channel(ad7949_adc, val, chan->channel);
+		mutex_unlock(&ad7949_adc->lock);
+
+		if (ret < 0)
+			return ret;
+
+		ret = IIO_VAL_INT;
+		break;
+
+	case IIO_CHAN_INFO_SCALE:
+		ret = regulator_get_voltage(ad7949_adc->vref);
+		if (ret < 0)
+			return ret;
+
+		*val = ret / 5000;
+		*val2 = 0;
+		ret = IIO_VAL_INT;
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int ad7949_spi_reg_access(struct iio_dev *indio_dev,
+			unsigned reg, unsigned writeval,
+			unsigned *readval)
+{
+	struct ad7949_adc_chip *ad7949_adc = iio_priv(indio_dev);
+	int ret = 0;
+
+	if (readval)
+		*readval = ad7949_spi_read_cfg(ad7949_adc);
+	else
+		ret = ad7949_spi_write_cfg(ad7949_adc,
+			writeval & AD7949_MASK_TOTAL, AD7949_MASK_TOTAL);
+
+	return ret;
+}
+
+static const struct iio_info ad7949_spi_info = {
+	.read_raw	   = ad7949_spi_read_raw,
+	.debugfs_reg_access = ad7949_spi_reg_access,
+};
+
+static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
+{
+	/* Sequencer disabled, CFG readback disabled, IN0 as default channel */
+	ad7949_adc->current_channel = 0;
+	return ad7949_spi_write_cfg(ad7949_adc, 0x3C79, AD7949_MASK_TOTAL);
+}
+
+static int ad7949_spi_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	const struct ad7949_adc_spec *spec;
+	struct ad7949_adc_chip *ad7949_adc;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*ad7949_adc));
+	if (!indio_dev) {
+		dev_err(dev, "can not allocate iio device\n");
+		return -ENOMEM;
+	}
+
+	spi->max_speed_hz = 33000000;
+	spi->mode = SPI_MODE_0;
+	spi->irq = -1;
+	spi->bits_per_word = 8;
+	spi_setup(spi);
+
+	indio_dev->dev.parent = dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
+	indio_dev->info = &ad7949_spi_info;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad7949_adc_channels;
+	spi_set_drvdata(spi, indio_dev);
+
+	ad7949_adc = iio_priv(indio_dev);
+	ad7949_adc->indio_dev = indio_dev;
+	ad7949_adc->spi = spi;
+
+	spec = &ad7949_adc_spec[spi_get_device_id(spi)->driver_data];
+	indio_dev->num_channels = spec->num_channels;
+	ad7949_adc->resolution = spec->resolution;
+
+	ad7949_adc->vref = devm_regulator_get(dev, "vref");
+	if (IS_ERR(ad7949_adc->vref)) {
+		dev_err(dev, "fail to request regulator\n");
+		return PTR_ERR(ad7949_adc->vref);
+	}
+
+	ret = regulator_enable(ad7949_adc->vref);
+	if (ret < 0) {
+		dev_err(dev, "fail to enable regulator\n");
+		goto err_regulator;
+	}
+
+	mutex_init(&ad7949_adc->lock);
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(dev, "fail to register iio device: %d\n", ret);
+		goto err;
+	}
+
+	ret = ad7949_spi_init(ad7949_adc);
+	if (ret) {
+		dev_err(dev, "enable to init this device: %d\n", ret);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	mutex_destroy(&ad7949_adc->lock);
+err_regulator:
+	regulator_disable(ad7949_adc->vref);
+	return ret;
+}
+
+static int ad7949_spi_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad7949_adc_chip *ad7949_adc = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	mutex_destroy(&ad7949_adc->lock);
+	regulator_disable(ad7949_adc->vref);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id ad7949_spi_of_id[] = {
+	{ .compatible = "ad7949" },
+	{ .compatible = "ad7682" },
+	{ .compatible = "ad7689" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad7949_spi_of_id);
+#endif
+
+static const struct spi_device_id ad7949_spi_id[] = {
+	{ "ad7949", HEIGHT_14BITS  },
+	{ "ad7682", QUAD_16BITS },
+	{ "ad7689", HEIGHT_16BITS },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad7949_spi_id);
+
+static struct spi_driver ad7949_spi_driver = {
+	.driver = {
+		.name		= "ad7949",
+		.of_match_table	= of_match_ptr(ad7949_spi_of_id),
+	},
+	.probe	  = ad7949_spi_probe,
+	.remove   = ad7949_spi_remove,
+	.id_table = ad7949_spi_id,
+};
+module_spi_driver(ad7949_spi_driver);
+
+MODULE_AUTHOR("Charles-Antoine Couret <charles-antoine.couret@essensium.com>");
+MODULE_DESCRIPTION("Analog Devices 14/16-bit 8-channel ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1
