Return-Path: <Paul.Cercueil@analog.com>
From: Paul Cercueil <paul.cercueil@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Antonio Fiol <antonio@fiol.es>, "Dmitry
 Eremin-Solenikov" <dbaryshkov@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, "Ian
 Campbell" <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, Paul Cercueil <paul.cercueil@analog.com>
Subject: [PATCH 2/2] iio: dac: Add support for the AD5592R/AD5593R ADCs/DACs
Date: Fri, 2 Oct 2015 14:45:56 +0200
Message-ID: <1443789956-25340-2-git-send-email-paul.cercueil@analog.com>
In-Reply-To: <1443789956-25340-1-git-send-email-paul.cercueil@analog.com>
References: <1443789956-25340-1-git-send-email-paul.cercueil@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This patch adds support for the AD5592R (spi) and AD5593R (i2c)
ADC/DAC devices.

Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
---
 drivers/iio/dac/Kconfig               |  22 +++
 drivers/iio/dac/Makefile              |   2 +
 drivers/iio/dac/ad5592r-base.c        | 290 ++++++++++++++++++++++++++++++++++
 drivers/iio/dac/ad5592r-base.h        |  59 +++++++
 drivers/iio/dac/ad5592r.c             | 121 ++++++++++++++
 drivers/iio/dac/ad5593r.c             | 121 ++++++++++++++
 include/dt-bindings/iio/adi,ad5592r.h |  13 ++
 7 files changed, 628 insertions(+)
 create mode 100644 drivers/iio/dac/ad5592r-base.c
 create mode 100644 drivers/iio/dac/ad5592r-base.h
 create mode 100644 drivers/iio/dac/ad5592r.c
 create mode 100644 drivers/iio/dac/ad5593r.c
 create mode 100644 include/dt-bindings/iio/adi,ad5592r.h

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index e701e28..e520059 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -72,6 +72,28 @@ config AD5449
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5449.
 
+config AD5592R
+	tristate "Analog Devices AD5592R ADC/DAC driver"
+	depends on SPI_MASTER
+	depends on OF
+	help
+	  Say yes here to build support for Analog Devices AD5592R
+	  Digital to Analog / Analog to Digital Converter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad5592r.
+
+config AD5593R
+	tristate "Analog Devices AD5593R ADC/DAC driver"
+	depends on I2C
+	depends on OF
+	help
+	  Say yes here to build support for Analog Devices AD5593R
+	  Digital to Analog / Analog to Digital Converter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad5593r.
+
 config AD5504
 	tristate "Analog Devices AD5504/AD5501 DAC SPI driver"
 	depends on SPI
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 63ae056..181fc28 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -11,6 +11,8 @@ obj-$(CONFIG_AD5064) += ad5064.o
 obj-$(CONFIG_AD5504) += ad5504.o
 obj-$(CONFIG_AD5446) += ad5446.o
 obj-$(CONFIG_AD5449) += ad5449.o
+obj-$(CONFIG_AD5592R) += ad5592r.o ad5592r-base.o
+obj-$(CONFIG_AD5593R) += ad5593r.o ad5592r-base.o
 obj-$(CONFIG_AD5755) += ad5755.o
 obj-$(CONFIG_AD5764) += ad5764.o
 obj-$(CONFIG_AD5791) += ad5791.o
diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
new file mode 100644
index 0000000..347f209
--- /dev/null
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -0,0 +1,290 @@
+/*
+ * AD5592R Digital <-> Analog converters driver
+ *
+ * Copyright 2014 Analog Devices Inc.
+ * Author: Paul Cercueil <paul.cercueil@analog.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+/*
+ * TODO:
+ *     - Add support for using channels as GPIOs
+ */
+
+#include "ad5592r-base.h"
+
+#include <dt-bindings/iio/adi,ad5592r.h>
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+
+static int ad5592r_set_channel_modes(struct ad5592r_state *st)
+{
+	const struct ad5592r_rw_ops *ops = st->ops;
+	int ret;
+	unsigned i;
+	struct iio_dev *iio_dev = iio_priv_to_dev(st);
+	u8 pulldown = 0, open_drain = 0, tristate = 0,
+	   dac = 0, adc = 0, gpio_in = 0, gpio_out = 0;
+	u16 read_back;
+
+	for (i = 0; i < st->chip_info->num_channels; i++) {
+		switch (st->channel_modes[i]) {
+		case CH_MODE_DAC:
+			dac |= BIT(i);
+
+		/* fall-through */
+		case CH_MODE_ADC:
+			adc |= BIT(i);
+			break;
+
+		case CH_MODE_GPIO_OUT:
+			gpio_out |= BIT(i);
+
+		/* fall-through */
+		case CH_MODE_GPIO_IN:
+			gpio_in |= BIT(i);
+			break;
+
+		case CH_MODE_GPIO_OPEN_DRAIN:
+			open_drain |= BIT(i);
+			break;
+
+		case CH_MODE_GPIO_TRISTATE:
+			tristate |= BIT(i);
+			break;
+
+		default:
+			pulldown |= BIT(i);
+			break;
+		}
+	}
+
+	mutex_lock(&iio_dev->mlock);
+
+	/* Configure pins that we use */
+	ret = ops->reg_write(st, AD5592R_REG_DAC_EN, dac);
+	if (ret)
+		goto err_unlock;
+
+	ret = ops->reg_write(st, AD5592R_REG_ADC_EN, adc);
+	if (ret)
+		goto err_unlock;
+
+	ret = ops->reg_write(st, AD5592R_REG_GPIO_OUT_EN, gpio_out);
+	if (ret)
+		goto err_unlock;
+
+	ret = ops->reg_write(st, AD5592R_REG_GPIO_IN_EN, gpio_in);
+	if (ret)
+		goto err_unlock;
+
+	ret = ops->reg_write(st, AD5592R_REG_OPEN_DRAIN, open_drain);
+	if (ret)
+		goto err_unlock;
+
+	ret = ops->reg_write(st, AD5592R_REG_TRISTATE, tristate);
+	if (ret)
+		goto err_unlock;
+
+	/* Pull down unused pins to GND */
+	ret = ops->reg_write(st, AD5592R_REG_PULLDOWN, pulldown);
+	if (ret)
+		goto err_unlock;
+
+	/* Verify that we can read back at least one register */
+	ret = ops->reg_read(st, AD5592R_REG_ADC_EN, &read_back);
+	if (!ret && (read_back & 0xff) != adc)
+		ret = -EIO;
+
+err_unlock:
+	mutex_unlock(&iio_dev->mlock);
+	return ret;
+}
+
+static int ad5592r_write_raw(struct iio_dev *iio_dev,
+	struct iio_chan_spec const *chan, int val, int val2, long mask)
+{
+	struct ad5592r_state *st = iio_priv(iio_dev);
+	int ret = -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (val >= (1 << chan->scan_type.realbits) || val < 0)
+			return -EINVAL;
+
+		mutex_lock(&iio_dev->mlock);
+		ret = st->ops->dac_write(st, chan->address, val);
+		mutex_unlock(&iio_dev->mlock);
+		break;
+
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int ad5592r_read_raw(struct iio_dev *iio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long m)
+{
+	struct ad5592r_state *st = iio_priv(iio_dev);
+	int ret = -EINVAL;
+	u16 read_val;
+
+	switch (m) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&iio_dev->mlock);
+		ret = st->ops->adc_read(st, chan->channel, &read_val);
+		mutex_unlock(&iio_dev->mlock);
+		if (ret)
+			return ret;
+
+		if ((read_val >> 12 & 0x7) != chan->channel) {
+			dev_err(st->dev, "Error while reading channel %u\n",
+					chan->channel);
+			return -EIO;
+		}
+
+		read_val &= GENMASK(11, 0);
+
+		dev_dbg(st->dev, "ADC read: 0x%04hX\n", read_val);
+		*val = (int) read_val;
+		return IIO_VAL_INT;
+
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static void ad5592r_reset(struct ad5592r_state *st)
+{
+	struct iio_dev *iio_dev = iio_priv_to_dev(st);
+
+	mutex_lock(&iio_dev->mlock);
+	st->ops->reg_write(st, AD5592R_REG_RESET, 0xdac);
+	udelay(250);
+	mutex_unlock(&iio_dev->mlock);
+}
+
+static const struct iio_info ad5592r_info = {
+	.read_raw = ad5592r_read_raw,
+	.write_raw = ad5592r_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static void ad5592r_setup_channel(struct iio_dev *iio_dev,
+		struct iio_chan_spec *chan, bool output, unsigned id)
+{
+	chan->type = IIO_VOLTAGE;
+	chan->indexed = 1;
+	chan->output = output;
+	chan->channel = id;
+	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	chan->address = id;
+	chan->scan_type.sign = 'u';
+	chan->scan_type.realbits = 12;
+	chan->scan_type.storagebits = 16;
+}
+
+static int ad5592r_alloc_channels(struct ad5592r_state *st)
+{
+	unsigned i, curr_channel = 0,
+		 num_channels = st->chip_info->num_channels;
+	struct iio_dev *iio_dev = iio_priv_to_dev(st);
+	struct iio_chan_spec *channels;
+	int ret;
+
+	ret = of_property_read_u8_array(st->dev->of_node, "channel-modes",
+			st->channel_modes, num_channels);
+	if (ret)
+		return ret;
+
+	channels = devm_kzalloc(st->dev,
+			2 * num_channels * sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	for (i = 0; i < num_channels; i++) {
+		switch (st->channel_modes[i]) {
+		case CH_MODE_DAC:
+			ad5592r_setup_channel(iio_dev, &channels[curr_channel],
+					true, curr_channel);
+			curr_channel++;
+			break;
+
+		case CH_MODE_ADC:
+			ad5592r_setup_channel(iio_dev, &channels[curr_channel],
+					false, curr_channel);
+			curr_channel++;
+
+		/* fall-through */
+		default:
+			continue;
+		}
+	}
+
+	iio_dev->num_channels = curr_channel;
+	iio_dev->channels = channels;
+	return 0;
+}
+
+int ad5592r_probe(struct device *dev, const char *name,
+		const struct ad5592r_rw_ops *ops,
+		const struct ad5592r_chip_info *chip_info)
+{
+	struct iio_dev *iio_dev;
+	struct ad5592r_state *st;
+	int ret;
+
+	iio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(iio_dev);
+	st->dev = dev;
+	st->ops = ops;
+	st->chip_info = chip_info;
+	dev_set_drvdata(dev, iio_dev);
+
+	BUG_ON(st->chip_info->num_channels > 8);
+
+	iio_dev->dev.parent = dev;
+	iio_dev->name = name;
+	iio_dev->info = &ad5592r_info;
+	iio_dev->modes = INDIO_DIRECT_MODE;
+
+	ad5592r_reset(st);
+
+	ret = ad5592r_alloc_channels(st);
+	if (ret)
+		return ret;
+
+	ret = ad5592r_set_channel_modes(st);
+	if (ret)
+		return ret;
+
+	return iio_device_register(iio_dev);
+}
+EXPORT_SYMBOL_GPL(ad5592r_probe);
+
+int ad5592r_remove(struct device *dev)
+{
+	struct iio_dev *iio_dev = dev_get_drvdata(dev);
+
+	iio_device_unregister(iio_dev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ad5592r_remove);
+
+MODULE_AUTHOR("Paul Cercueil <paul.cercueil@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5592R multi-channel converters");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/dac/ad5592r-base.h b/drivers/iio/dac/ad5592r-base.h
new file mode 100644
index 0000000..40ef550
--- /dev/null
+++ b/drivers/iio/dac/ad5592r-base.h
@@ -0,0 +1,59 @@
+/*
+ * AD5592R / AD5593R Digital <-> Analog converters driver
+ *
+ * Copyright 2015 Analog Devices Inc.
+ * Author: Paul Cercueil <paul.cercueil@analog.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#ifndef __DRIVERS_IIO_DAC_AD5592R_BASE_H__
+#define __DRIVERS_IIO_DAC_AD5592R_BASE_H__
+
+#include <linux/types.h>
+
+struct device;
+struct ad5592r_state;
+
+enum ad5592r_registers {
+	AD5592R_REG_NOOP		= 0x0,
+	AD5592R_REG_DAC_READBACK	= 0x1,
+	AD5592R_REG_ADC_SEQ		= 0x2,
+	AD5592R_REG_CTRL		= 0x3,
+	AD5592R_REG_ADC_EN		= 0x4,
+	AD5592R_REG_DAC_EN		= 0x5,
+	AD5592R_REG_PULLDOWN		= 0x6,
+	AD5592R_REG_LDAC		= 0x7,
+	AD5592R_REG_GPIO_OUT_EN		= 0x8,
+	AD5592R_REG_GPIO_SET		= 0x9,
+	AD5592R_REG_GPIO_IN_EN		= 0xA,
+	AD5592R_REG_PD			= 0xB,
+	AD5592R_REG_OPEN_DRAIN		= 0xC,
+	AD5592R_REG_TRISTATE		= 0xD,
+	AD5592R_REG_RESET		= 0xF,
+};
+
+struct ad5592r_chip_info {
+	unsigned num_channels;
+};
+
+struct ad5592r_rw_ops {
+	int (*dac_write)(struct ad5592r_state *st, unsigned chan, u16 value);
+	int (*adc_read)(struct ad5592r_state *st, unsigned chan, u16 *value);
+	int (*reg_write)(struct ad5592r_state *st, u8 reg, u16 value);
+	int (*reg_read)(struct ad5592r_state *st, u8 reg, u16 *value);
+};
+
+struct ad5592r_state {
+	struct device *dev;
+	const struct ad5592r_chip_info *chip_info;
+	const struct ad5592r_rw_ops *ops;
+	u8 channel_modes[8];
+};
+
+int ad5592r_probe(struct device *dev, const char *name,
+		const struct ad5592r_rw_ops *ops,
+		const struct ad5592r_chip_info *chip_info);
+int ad5592r_remove(struct device *dev);
+
+#endif /* __DRIVERS_IIO_DAC_AD5592R_BASE_H__ */
diff --git a/drivers/iio/dac/ad5592r.c b/drivers/iio/dac/ad5592r.c
new file mode 100644
index 0000000..663dfd9
--- /dev/null
+++ b/drivers/iio/dac/ad5592r.c
@@ -0,0 +1,121 @@
+/*
+ * AD5592R Digital <-> Analog converters driver
+ *
+ * Copyright 2015 Analog Devices Inc.
+ * Author: Paul Cercueil <paul.cercueil@analog.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include "ad5592r-base.h"
+
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+
+static int ad5592r_dac_write(struct ad5592r_state *st, unsigned chan, u16 value)
+{
+	struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
+	u16 msg = cpu_to_be16(BIT(15) | (chan << 12) | value);
+
+	return spi_write(spi, &msg, sizeof(msg));
+}
+
+static int ad5592r_adc_read(struct ad5592r_state *st, unsigned chan, u16 *value)
+{
+	struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
+	u16 msg = cpu_to_be16((AD5592R_REG_ADC_SEQ << 11) | BIT(chan));
+	int ret;
+
+	ret = spi_write(spi, &msg, sizeof(msg));
+	if (ret)
+		return ret;
+
+	spi_read(spi, &msg, sizeof(msg)); /* Invalid data */
+
+	ret = spi_read(spi, &msg, sizeof(msg));
+	if (ret)
+		return ret;
+
+	*value = be16_to_cpu(msg);
+	return 0;
+}
+
+static int ad5592r_reg_write(struct ad5592r_state *st, u8 reg, u16 value)
+{
+	struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
+	u16 msg = cpu_to_be16((reg << 11) | value);
+
+	return spi_write(spi, &msg, sizeof(msg));
+}
+
+static int ad5592r_reg_read(struct ad5592r_state *st, u8 reg, u16 *value)
+{
+	struct spi_device *spi = container_of(st->dev, struct spi_device, dev);
+	u16 msg = cpu_to_be16((AD5592R_REG_LDAC << 11) | BIT(6) | (reg << 2));
+	int ret;
+
+	ret = spi_write(spi, &msg, sizeof(msg));
+	if (ret)
+		return ret;
+
+	ret = spi_read(spi, &msg, sizeof(msg));
+	if (ret)
+		return ret;
+
+	if (value)
+		*value = be16_to_cpu(msg);
+	return 0;
+}
+
+static const struct ad5592r_rw_ops ad5592r_rw_ops = {
+	.dac_write = ad5592r_dac_write,
+	.adc_read = ad5592r_adc_read,
+	.reg_write = ad5592r_reg_write,
+	.reg_read = ad5592r_reg_read,
+};
+
+static const struct ad5592r_chip_info ad5592r_chip_info = {
+	.num_channels = 8,
+};
+
+static int ad5592r_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+
+	return ad5592r_probe(&spi->dev, id->name,
+			&ad5592r_rw_ops, &ad5592r_chip_info);
+}
+
+static int ad5592r_spi_remove(struct spi_device *spi)
+{
+	return ad5592r_remove(&spi->dev);
+}
+
+static const struct spi_device_id ad5592r_spi_ids[] = {
+	{ .name = "ad5592r", },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad5592r_spi_ids);
+
+static const struct of_device_id ad5592r_of_match[] = {
+	{ .compatible = "adi,ad5592r", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ad5592r_of_match);
+
+static struct spi_driver ad5592r_spi_driver = {
+	.driver = {
+		.name = "ad5592r",
+		.of_match_table = of_match_ptr(ad5592r_of_match),
+	},
+	.probe = ad5592r_spi_probe,
+	.remove = ad5592r_spi_remove,
+	.id_table = ad5592r_spi_ids,
+};
+module_spi_driver(ad5592r_spi_driver);
+
+MODULE_AUTHOR("Paul Cercueil <paul.cercueil@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5592R multi-channel converters");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/dac/ad5593r.c b/drivers/iio/dac/ad5593r.c
new file mode 100644
index 0000000..94ebba1
--- /dev/null
+++ b/drivers/iio/dac/ad5593r.c
@@ -0,0 +1,121 @@
+/*
+ * AD5593R Digital <-> Analog converters driver
+ *
+ * Copyright 2015 Analog Devices Inc.
+ * Author: Paul Cercueil <paul.cercueil@analog.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include "ad5592r-base.h"
+
+#include <linux/bitops.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#define MODE_CONF		(0 << 4)
+#define MODE_DAC_WRITE		(1 << 4)
+#define MODE_ADC_READBACK	(4 << 4)
+#define MODE_DAC_READBACK	(5 << 4)
+#define MODE_GPIO_READBACK	(6 << 4)
+#define MODE_REG_READBACK	(7 << 4)
+
+static int ad5593r_dac_write(struct ad5592r_state *st, unsigned chan, u16 value)
+{
+	struct i2c_client *i2c = container_of(st->dev, struct i2c_client, dev);
+
+	value = cpu_to_be16(value);
+	return i2c_smbus_write_word_data(i2c, MODE_DAC_WRITE | chan, value);
+}
+
+static int ad5593r_adc_read(struct ad5592r_state *st, unsigned chan, u16 *value)
+{
+	struct i2c_client *i2c = container_of(st->dev, struct i2c_client, dev);
+	s32 val;
+
+	val = i2c_smbus_write_word_data(i2c, MODE_CONF | AD5592R_REG_ADC_SEQ,
+			cpu_to_be16(BIT(chan)));
+	if (val < 0)
+		return (int) val;
+
+	i2c_smbus_read_word_data(i2c, MODE_ADC_READBACK); /* Invalid data */
+
+	val = i2c_smbus_read_word_data(i2c, MODE_ADC_READBACK);
+	if (val < 0)
+		return (int) val;
+
+	*value = be16_to_cpu((u16) val);
+	return 0;
+}
+
+static int ad5593r_reg_write(struct ad5592r_state *st, u8 reg, u16 value)
+{
+	struct i2c_client *i2c = container_of(st->dev, struct i2c_client, dev);
+
+	value = cpu_to_be16(value);
+	return i2c_smbus_write_word_data(i2c, MODE_CONF | reg, value);
+}
+
+static int ad5593r_reg_read(struct ad5592r_state *st, u8 reg, u16 *value)
+{
+	struct i2c_client *i2c = container_of(st->dev, struct i2c_client, dev);
+	s32 val;
+
+	val = i2c_smbus_read_word_data(i2c, MODE_REG_READBACK | reg);
+	if (val < 0)
+		return (int) val;
+
+	*value = be16_to_cpu((u16) val);
+	return 0;
+}
+
+static const struct ad5592r_rw_ops ad5593r_rw_ops = {
+	.dac_write = ad5593r_dac_write,
+	.adc_read = ad5593r_adc_read,
+	.reg_write = ad5593r_reg_write,
+	.reg_read = ad5593r_reg_read,
+};
+
+static const struct ad5592r_chip_info ad5592r_chip_info = {
+	.num_channels = 8,
+};
+
+static int ad5593r_i2c_probe(struct i2c_client *i2c,
+		const struct i2c_device_id *id)
+{
+	return ad5592r_probe(&i2c->dev, id->name,
+			&ad5593r_rw_ops, &ad5592r_chip_info);
+}
+
+static int ad5593r_i2c_remove(struct i2c_client *i2c)
+{
+	return ad5592r_remove(&i2c->dev);
+}
+
+static const struct i2c_device_id ad5593r_i2c_ids[] = {
+	{ .name = "ad5593r", },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, ad5593r_i2c_ids);
+
+static const struct of_device_id ad5593r_of_match[] = {
+	{ .compatible = "adi,ad5593r", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ad5593r_of_match);
+
+static struct i2c_driver ad5593r_driver = {
+	.driver = {
+		.name = "ad5593r",
+		.of_match_table = of_match_ptr(ad5593r_of_match),
+	},
+	.probe = ad5593r_i2c_probe,
+	.remove = ad5593r_i2c_remove,
+	.id_table = ad5593r_i2c_ids,
+};
+module_i2c_driver(ad5593r_driver);
+
+MODULE_AUTHOR("Paul Cercueil <paul.cercueil@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5592R multi-channel converters");
+MODULE_LICENSE("GPL v2");
diff --git a/include/dt-bindings/iio/adi,ad5592r.h b/include/dt-bindings/iio/adi,ad5592r.h
new file mode 100644
index 0000000..fcb6293
--- /dev/null
+++ b/include/dt-bindings/iio/adi,ad5592r.h
@@ -0,0 +1,13 @@
+
+#ifndef _DT_BINDINGS_ADI_AD5592R_H
+#define _DT_BINDINGS_ADI_AD5592R_H
+
+#define CH_MODE_UNUSED		0
+#define CH_MODE_DAC		1
+#define CH_MODE_ADC		2
+#define CH_MODE_GPIO_OUT	3
+#define CH_MODE_GPIO_IN		4
+#define CH_MODE_GPIO_OPEN_DRAIN	5
+#define CH_MODE_GPIO_TRISTATE	6
+
+#endif /* _DT_BINDINGS_ADI_AD5592R_H */
-- 
2.5.3
