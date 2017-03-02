Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33015 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdCCEH2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Mar 2017 23:07:28 -0500
Received: by mail-qk0-f196.google.com with SMTP id j127so6241578qke.0
        for <linux-iio@vger.kernel.org>; Thu, 02 Mar 2017 20:07:27 -0800 (PST)
From: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
Subject: [PATCH] iio: dac: Add support for ltc2632 DACs
Date: Thu,  2 Mar 2017 14:01:27 -0500
Message-Id: <20170302190127.23157-1-maxime.roussinbelanger@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
---
 .../devicetree/bindings/iio/dac/ltc2632.txt        |  23 ++
 drivers/iio/dac/Kconfig                            |   7 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ltc2632.c                          | 325 +++++++++++++++++++++
 4 files changed, 356 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ltc2632.txt
 create mode 100644 drivers/iio/dac/ltc2632.c

diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
new file mode 100644
index 0000000..fd9aa0b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
@@ -0,0 +1,23 @@
+Linear Technology LTC2632 DAC device driver
+
+Required properties:
+ - compatible: Has to contain one of the following
+	lltc,ltc2632-l12
+	lltc,ltc2632-l10
+	lltc,ltc2632-l8
+	lltc,ltc2632-h12
+	lltc,ltc2632-h10
+	lltc,ltc2632-h8
+
+Property rules described in Documentation/devicetree/bindings/spi/spi-bus.txt
+apply. In particular, "reg" and "spi-max-frequency" properties must be given.
+
+Example:
+
+	spi_master {
+		dac: ltc2632@0 {
+			compatible = "lltc,ltc2632";
+			reg = <0>; /* CS0 */
+			spi-max-frequency = <1000000>;
+		};
+	};
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index d3084028..f32ca8a 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -118,6 +118,13 @@ config AD5624R_SPI
 	  Say yes here to build support for Analog Devices AD5624R, AD5644R and
 	  AD5664R converters (DAC). This driver uses the common SPI interface.
 
+config LTC2632
+	tristate "Linear Technology LTC2632-12/10/8 DAC spi driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Linear Technology LTC2632-12/10/8 converters (DAC).
+	  This driver uses the common SPI interface.
+
 config AD5686
 	tristate "Analog Devices AD5686R/AD5685R/AD5684R DAC SPI driver"
 	depends on SPI
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index f01bf4a..6e4d995 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_AD8801) += ad8801.o
 obj-$(CONFIG_CIO_DAC) += cio-dac.o
 obj-$(CONFIG_DPOT_DAC) += dpot-dac.o
 obj-$(CONFIG_LPC18XX_DAC) += lpc18xx_dac.o
+obj-$(CONFIG_LTC2632) += ltc2632.o
 obj-$(CONFIG_M62332) += m62332.o
 obj-$(CONFIG_MAX517) += max517.o
 obj-$(CONFIG_MAX5821) += max5821.o
diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
new file mode 100644
index 0000000..d6160fb
--- /dev/null
+++ b/drivers/iio/dac/ltc2632.c
@@ -0,0 +1,325 @@
+/*
+ * LTC2632 Digital to analog convertors spi driver
+ */
+
+#include <linux/device.h>
+#include <linux/spi/spi.h>
+#include <linux/module.h>
+
+#include <linux/iio/iio.h>
+
+#define LTC2632_DAC_CHANNELS                    2
+
+#define LTC2632_ADDR_DAC0                       0x0
+#define LTC2632_ADDR_DAC1                       0x1
+
+#define LTC2632_CMD_WRITE_INPUT_N               0x0
+#define LTC2632_CMD_UPDATE_DAC_N                0x1
+#define LTC2632_CMD_WRITE_INPUT_N_UPDATE_ALL    0x2
+#define LTC2632_CMD_WRITE_INPUT_N_UPDATE_N      0x3
+#define LTC2632_CMD_POWERDOWN_DAC_N             0x4
+#define LTC2632_CMD_POWERDOWN_CHIP              0x5
+#define LTC2632_CMD_INTERNAL_REFER              0x6
+#define LTC2632_CMD_EXTERNAL_REFER              0x7
+
+
+static ssize_t ltc2632_read_dac_powerdown(struct iio_dev *indio_dev,
+					  uintptr_t private,
+					  const struct iio_chan_spec *chan,
+					  char *buf);
+
+static ssize_t ltc2632_write_dac_powerdown(struct iio_dev *indio_dev,
+					   uintptr_t private,
+					   const struct iio_chan_spec *chan,
+					   const char *buf,
+					   size_t len);
+
+/**
+ * struct ltc2632_chip_info - chip specific information
+ * @channels:		channel spec for the DAC
+ */
+struct ltc2632_chip_info {
+	const struct iio_chan_spec *channels;
+	const int vref_mv;
+};
+
+/**
+ * struct ltc2632_state - driver instance specific data
+ * @spi_dev:		spi_device
+ * @pwr_down_cached	power down mask
+ */
+struct ltc2632_state {
+	struct spi_device *spi_dev;
+	unsigned int pwr_down_cached;
+};
+
+/**
+ * ltc2632_supported_device_ids
+ */
+enum ltc2632_supported_device_ids {
+	ID_LTC2632L12,
+	ID_LTC2632L10,
+	ID_LTC2632L8,
+	ID_LTC2632H12,
+	ID_LTC2632H10,
+	ID_LTC2632H8,
+};
+
+static const struct iio_chan_spec_ext_info ltc2632_ext_info[] = {
+	{
+		.name = "powerdown",
+		.read = ltc2632_read_dac_powerdown,
+		.write = ltc2632_write_dac_powerdown,
+		.shared = IIO_SEPARATE,
+	},
+	{ },
+};
+
+#define LTC2632_CHANNEL(_chan, _bits) { \
+		.type = IIO_VOLTAGE, \
+		.indexed = 1, \
+		.output = 1, \
+		.channel = (_chan), \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+		.address = (_chan), \
+		.scan_type = { \
+			.sign		= 'u', \
+			.realbits	= (_bits), \
+			.storagebits	= 16, \
+			.shift		= 16 - (_bits), \
+		}, \
+		.ext_info = ltc2632_ext_info, \
+}
+
+#define DECLARE_LTC2632_CHANNELS(_name, _bits) \
+	const struct iio_chan_spec _name ## _channels[] = { \
+		LTC2632_CHANNEL(0, _bits), \
+		LTC2632_CHANNEL(1, _bits), \
+	}
+
+static DECLARE_LTC2632_CHANNELS(ltc2632l12, 12);
+static DECLARE_LTC2632_CHANNELS(ltc2632l10, 10);
+static DECLARE_LTC2632_CHANNELS(ltc2632l8, 8);
+
+static DECLARE_LTC2632_CHANNELS(ltc2632h12, 12);
+static DECLARE_LTC2632_CHANNELS(ltc2632h10, 10);
+static DECLARE_LTC2632_CHANNELS(ltc2632h8, 8);
+
+static const struct ltc2632_chip_info ltc2632_chip_info_tbl[] = {
+	[ID_LTC2632L12] = {
+		.channels	= ltc2632l12_channels,
+		.vref_mv	= 2500,
+	},
+	[ID_LTC2632L10] = {
+		.channels	= ltc2632l10_channels,
+		.vref_mv	= 2500,
+	},
+	[ID_LTC2632L8] =  {
+		.channels	= ltc2632l8_channels,
+		.vref_mv	= 2500,
+	},
+	[ID_LTC2632H12] = {
+		.channels	= ltc2632h12_channels,
+		.vref_mv	= 4096,
+	},
+	[ID_LTC2632H10] = {
+		.channels	= ltc2632h10_channels,
+		.vref_mv	= 4096,
+	},
+	[ID_LTC2632H8] =  {
+		.channels	= ltc2632h8_channels,
+		.vref_mv	= 4096,
+	},
+};
+
+static int ltc2632_spi_write(struct spi_device *spi,
+			     u8 cmd, u8 addr, u16 val, u8 shift)
+{
+	u32 data;
+	u8 msg[3];
+
+	/*
+	 * The input shift register is 24 bits wide.
+	 * The next four are the command bits, C3 to C0,
+	 * followed by the 4-bit DAC address, A3 to A0, and then the
+	 * 12-, 10-, 8-bit data-word. The data-word comprises the 12-,
+	 * 10-, 8-bit input code followed by 4, 6, or 8 don't care bits.
+	 */
+	data = (cmd << 20) | (addr << 16) | (val << shift);
+	msg[0] = data >> 16;
+	msg[1] = data >> 8;
+	msg[2] = data;
+
+	return spi_write(spi, msg, 3);
+}
+
+static int ltc2632_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val,
+			    int *val2,
+			    long m)
+{
+	struct ltc2632_chip_info *chip_info;
+
+	const struct ltc2632_state *st = iio_priv(indio_dev);
+	const struct spi_device_id* spi_dev_id = spi_get_device_id(st->spi_dev);
+
+	chip_info = (struct ltc2632_chip_info*) spi_dev_id->driver_data;
+
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		*val = chip_info->vref_mv;
+		*val2 = chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	}
+	return -EINVAL;
+}
+
+static int ltc2632_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val,
+			     int val2,
+			     long mask)
+{
+	struct ltc2632_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (val >= (1 << chan->scan_type.realbits) || val < 0)
+			return -EINVAL;
+
+		return ltc2632_spi_write(st->spi_dev,
+					 LTC2632_CMD_WRITE_INPUT_N_UPDATE_N,
+					 chan->address, val,
+					 chan->scan_type.shift);
+	default:
+		return -EINVAL;
+	}
+
+}
+
+static ssize_t ltc2632_read_dac_powerdown(struct iio_dev *indio_dev,
+					  uintptr_t private,
+					  const struct iio_chan_spec *chan,
+					  char *buf)
+{
+	struct ltc2632_state *st = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n",
+		       !!(st->pwr_down_cached & (1 << chan->channel)));
+}
+
+static ssize_t ltc2632_write_dac_powerdown(struct iio_dev *indio_dev,
+					   uintptr_t private,
+					   const struct iio_chan_spec *chan,
+					   const char *buf,
+					   size_t len)
+{
+	bool pwr_down;
+	int ret;
+	struct ltc2632_state *st = iio_priv(indio_dev);
+
+	ret = strtobool(buf, &pwr_down);
+	if (ret)
+		return ret;
+
+	if (pwr_down)
+		st->pwr_down_cached |= (1 << chan->channel);
+	else
+		st->pwr_down_cached &= ~(1 << chan->channel);
+
+	ret = ltc2632_spi_write(st->spi_dev,
+				LTC2632_CMD_POWERDOWN_DAC_N,
+				chan->channel, 0, 0);
+
+	return ret ? ret : len;
+}
+
+static const struct iio_info ltc2632_info = {
+	.write_raw	= ltc2632_write_raw,
+	.read_raw	= ltc2632_read_raw,
+	.driver_module	= THIS_MODULE,
+};
+
+static int ltc2632_probe(struct spi_device *spi)
+{
+	struct ltc2632_state *st;
+	struct iio_dev *indio_dev;
+	struct ltc2632_chip_info* chip_info;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+	st = iio_priv(indio_dev);
+
+	spi_set_drvdata(spi, indio_dev);
+	st->spi_dev = spi;
+
+	chip_info = (struct ltc2632_chip_info*)
+			spi_get_device_id(spi)->driver_data;
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &ltc2632_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = chip_info->channels;
+	indio_dev->num_channels = LTC2632_DAC_CHANNELS;
+
+	ret = ltc2632_spi_write(spi, LTC2632_CMD_INTERNAL_REFER, 0, 0, 0);
+	if (ret)
+		dev_err(&spi->dev,
+			"Set internal reference command failed, %d\n", ret);
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ltc2632_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+
+	iio_device_unregister(indio_dev);
+
+	return 0;
+}
+
+static const struct spi_device_id ltc2632_id[] = {
+	{ "ltc2632-l12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632L12] },
+	{ "ltc2632-l10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632L10] },
+	{ "ltc2632-l8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632L8] },
+	{ "ltc2632-h12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H12] },
+	{ "ltc2632-h10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H10] },
+	{ "ltc2632-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H8] },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ltc2632_id);
+
+static struct spi_driver ltc2632_driver = {
+	.driver		= {
+		.name	= "ltc2632",
+	},
+	.probe		= ltc2632_probe,
+	.remove		= ltc2632_remove,
+	.id_table	= ltc2632_id,
+};
+module_spi_driver(ltc2632_driver);
+
+static const struct of_device_id ltc2632_of_match[] = {
+	{ .compatible = "lltc,ltc2632-l12", .data = (void*)&ltc2632_chip_info_tbl[ID_LTC2632L12] },
+	{ .compatible = "lltc,ltc2632-l10", .data = (void*)&ltc2632_chip_info_tbl[ID_LTC2632L10] },
+	{ .compatible = "lltc,ltc2632-l8",  .data = (void*)&ltc2632_chip_info_tbl[ID_LTC2632L8] },
+	{ .compatible = "lltc,ltc2632-h12", .data = (void*)&ltc2632_chip_info_tbl[ID_LTC2632H12] },
+	{ .compatible = "lltc,ltc2632-h10", .data = (void*)&ltc2632_chip_info_tbl[ID_LTC2632H10] },
+	{ .compatible = "lltc,ltc2632-h8",  .data = (void*)&ltc2632_chip_info_tbl[ID_LTC2632H8] },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ltc2632_of_match);
+
+MODULE_AUTHOR("Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>");
+MODULE_DESCRIPTION("LTC2632 DAC SPI driver");
+MODULE_LICENSE("GPL v2");
-- 
2.10.0

