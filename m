Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:45789 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932889AbdHVNfY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Aug 2017 09:35:24 -0400
Message-Id: <52441ded22e8c9ca84792576e72ca310f01416eb.1503407738.git.lukas@wunner.de>
In-Reply-To: <cover.1503407738.git.lukas@wunner.de>
References: <cover.1503407738.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 22 Aug 2017 15:33:00 +0200
Subject: [PATCH 6/6] iio: adc: mcp320x: Add support for mcp3550/1/3
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Phil Elwell <phil@raspberrypi.org>,
        Oskar Andero <oskar.andero@gmail.com>,
        Andrea Galbusera <gizero@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Manfred Schlaegl <manfred.schlaegl@gmx.at>,
        Michael Welling <mwelling@ieee.org>,
        Soeren Andersen <san@rosetechnology.dk>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These ADCs are marketed as single-channel 22 bit delta-sigma ADCs, but
in reality their resolution is 21 bit with an overrange or underrange
of 12% beyond Vref.  In other words, "full scale" means +/- 2^20.

This driver does not explicitly signal back to the user when an
overrange or underrange occurs, but the user can detect it by comparing
the raw value to +/- 2^20 (or the scaled value to Vref).

The chips feature an extended temperature range and high accuracy,
low noise characteristics, but their conversion times are slow with
up to 80 ms +/- 2% (on the MCP3550-50).

Hence, unlike the other ADCs supported by the driver, conversion does
not take place in realtime upon lowering CS.  Instead, CS is asserted
for 8 usec to start the conversion.  After waiting for the duration of
the conversion, the result can be fetched.  While waiting, control of
the bus is ceased so it may be used by a different device.

After the result has been fetched and 10 us have passed, the chip goes
into shutdown and an additional power-up delay of 144 clock periods is
then required to wake the analog circuitry upon the next conversion
(footnote below table 4-1, page 16 in the spec).

Optionally, the chips can be used in so-called "continuous conversion
mode":  Conversions then take place continuously and the last result may
be fetched at any time without observing a delay.  The mode is enabled
by permanently driving CS low, e.g. by wiring it to ground.  The driver
defaults to "single conversion mode" but can be instructed to use
"continuous conversion mode" by setting a corresponding boolean in the
device tree.

After power-on reset, the chip sometimes fails to perform conversions
and clocks out "all ones".  For some reason it can be unwedged by
carrying out two consecutive conversions, without any delay between them.
If there is a delay the chip stays wedged.  I tried various other things
to no avail, such as extending the conversion time, extending the CS
assertion time to start a conversion or clocking out a few bytes.
This may be an undocumented bug in the chip's internal state machine,
possibly caused by the SPI pins' state on boot of the bcm2837.
The driver unconditionally performs these two conversions on ->probe to
ascertain all subsequent conversions succeed.  On platforms that support
system sleep, it may be necessary to repeat this procedure upon resume.

The chips clock out a 3 byte word, unlike the other ADCs supported by
the driver which all have a lower resolution than 16 bit and thus make
do with 2 bytes.  Calculate the word length on probe by rounding up the
resolution to full bytes.  Crucially, if the clock idles low, the
transfer is preceded by a useless Data Ready bit, increasing its
length from 24 bit to 25 bit = 4 bytes (section 5.5 in the spec).
Autosense this based on the SPI slave's configuration.

Cc: Mathias Duckeck <m.duckeck@kunbus.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/iio/adc/Kconfig   |   5 +-
 drivers/iio/adc/mcp320x.c | 137 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 133 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 57625653fcb6..84dd04621650 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -475,12 +475,13 @@ config	MAX9611
 	  called max9611.
 
 config MCP320X
-	tristate "Microchip Technology MCP3x01/02/04/08"
+	tristate "Microchip Technology MCP3x01/02/04/08 and MCP3550/1/3"
 	depends on SPI
 	help
 	  Say yes here to build support for Microchip Technology's
 	  MCP3001, MCP3002, MCP3004, MCP3008, MCP3201, MCP3202, MCP3204,
-	  MCP3208 or MCP3301 analog to digital converter.
+	  MCP3208, MCP3301, MCP3550, MCP3551 and MCP3553 analog to digital
+	  converters.
 
 	  This driver can also be built as a module. If so, the module will be
 	  called mcp320x.
diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 6e10fa934aca..c4ea8794c4c6 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -19,6 +19,11 @@
  * ------------
  * 13 bit converter
  * MCP3301
+ * ------------
+ * 22 bit converter
+ * MCP3550
+ * MCP3551
+ * MCP3553
  *
  * Datasheet can be found here:
  * http://ww1.microchip.com/downloads/en/DeviceDoc/21293C.pdf  mcp3001
@@ -28,6 +33,7 @@
  * http://ww1.microchip.com/downloads/en/DeviceDoc/21034D.pdf  mcp3202
  * http://ww1.microchip.com/downloads/en/DeviceDoc/21298c.pdf  mcp3204/08
  * http://ww1.microchip.com/downloads/en/DeviceDoc/21700E.pdf  mcp3301
+ * http://ww1.microchip.com/downloads/en/DeviceDoc/21950D.pdf  mcp3550/1/3
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -51,25 +57,50 @@ enum {
 	mcp3204,
 	mcp3208,
 	mcp3301,
+	mcp3550_50,
+	mcp3550_60,
+	mcp3551,
+	mcp3553,
 };
 
 struct mcp320x_chip_info {
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
 	unsigned int resolution;
+	unsigned int conv_time; /* usec */
 };
 
+/**
+ * struct mcp320x - Microchip SPI ADC instance
+ * @spi: SPI slave (parent of the IIO device)
+ * @msg: SPI message to select a channel and receive a value from the ADC
+ * @transfer: SPI transfers used by @msg
+ * @start_conv_msg: SPI message to start a conversion by briefly asserting CS
+ * @start_conv_transfer: SPI transfer used by @start_conv_msg
+ * @continuous_conv: whether CS is permanently driven low such that conversions
+ *	take place continuously, obviating the need to explicitly start them
+ *	and wait for them to finish
+ * @reg: regulator generating Vref
+ * @lock: protects read sequences
+ * @chip_info: ADC properties
+ * @tx_buf: buffer for @transfer[0] (not used on single-channel converters)
+ * @rx_buf: buffer for @transfer[1]
+ */
 struct mcp320x {
 	struct spi_device *spi;
 	struct spi_message msg;
 	struct spi_transfer transfer[2];
 
+	struct spi_message start_conv_msg;
+	struct spi_transfer start_conv_transfer;
+	bool continuous_conv;
+
 	struct regulator *reg;
 	struct mutex lock;
 	const struct mcp320x_chip_info *chip_info;
 
 	u8 tx_buf ____cacheline_aligned;
-	u8 rx_buf[2];
+	u8 rx_buf[4];
 };
 
 static int mcp320x_channel_to_tx_data(int device_index,
@@ -96,10 +127,19 @@ static int mcp320x_channel_to_tx_data(int device_index,
 static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
 				  bool differential, int device_index, int *val)
 {
+	unsigned int overflow;
 	int ret;
 
-	adc->rx_buf[0] = 0;
-	adc->rx_buf[1] = 0;
+	if (adc->chip_info->conv_time && !adc->continuous_conv) {
+		ret = spi_sync(adc->spi, &adc->start_conv_msg);
+		if (ret < 0)
+			return ret;
+
+		usleep_range(adc->chip_info->conv_time,
+			     adc->chip_info->conv_time + 100);
+	}
+
+	memset(&adc->rx_buf, 0, sizeof(adc->rx_buf));
 	if (adc->chip_info->num_channels > 1)
 		adc->tx_buf = mcp320x_channel_to_tx_data(device_index, channel,
 							 differential);
@@ -129,6 +169,34 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
 		*val = sign_extend32((adc->rx_buf[0] & 0x1f) << 8
 				    | adc->rx_buf[1], 12);
 		return 0;
+	case mcp3550_50:
+	case mcp3550_60:
+	case mcp3551:
+	case mcp3553:
+		/* strip leading Data Ready bit in SPI mode 0,0 */
+		if (!(adc->spi->mode & SPI_CPOL)) {
+			adc->rx_buf[0] <<= 1;
+			adc->rx_buf[0] |= adc->rx_buf[1] >> 7;
+			adc->rx_buf[1] <<= 1;
+			adc->rx_buf[1] |= adc->rx_buf[2] >> 7;
+			adc->rx_buf[2] <<= 1;
+			adc->rx_buf[2] |= adc->rx_buf[3] >> 7;
+		}
+		/*
+		 * If the input is within -vref and vref, bit 21 is the sign.
+		 * Up to 12% overrange or underrange are allowed, in which case
+		 * bit 23 is the sign and bit 0 to 21 is the value.
+		 */
+		overflow = adc->rx_buf[0] >> 6;
+		if ((!overflow && adc->rx_buf[0] & 0x20) || overflow == 2)
+			adc->rx_buf[0] |= 0xc0;  /* negative or underrange */
+		else if (overflow == 1)
+			adc->rx_buf[0] &= ~0xc0; /* overrange */
+		else if (overflow == 3)
+			return -EIO; /* cannot have overrange AND underrange */
+		*val = sign_extend32(adc->rx_buf[0] << 16 | adc->rx_buf[1] << 8
+							  | adc->rx_buf[2], 23);
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -288,6 +356,31 @@ static const struct mcp320x_chip_info mcp320x_chip_infos[] = {
 		.num_channels = ARRAY_SIZE(mcp3201_channels),
 		.resolution = 13
 	},
+	[mcp3550_50] = {
+		.channels = mcp3201_channels,
+		.num_channels = ARRAY_SIZE(mcp3201_channels),
+		.resolution = 21,
+		/* 2% max deviation + 144 clock periods to exit shutdown */
+		.conv_time = 80000 * 1.02 + 144000 / 102.4,
+	},
+	[mcp3550_60] = {
+		.channels = mcp3201_channels,
+		.num_channels = ARRAY_SIZE(mcp3201_channels),
+		.resolution = 21,
+		.conv_time = 66670 * 1.02 + 144000 / 122.88,
+	},
+	[mcp3551] = {
+		.channels = mcp3201_channels,
+		.num_channels = ARRAY_SIZE(mcp3201_channels),
+		.resolution = 21,
+		.conv_time = 73100 * 1.02 + 144000 / 112.64,
+	},
+	[mcp3553] = {
+		.channels = mcp3201_channels,
+		.num_channels = ARRAY_SIZE(mcp3201_channels),
+		.resolution = 21,
+		.conv_time = 16670 * 1.02 + 144000 / 122.88,
+	},
 };
 
 static int mcp320x_probe(struct spi_device *spi)
@@ -295,7 +388,7 @@ static int mcp320x_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct mcp320x *adc;
 	const struct mcp320x_chip_info *chip_info;
-	int ret;
+	int ret, device_index;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
 	if (!indio_dev)
@@ -311,7 +404,8 @@ static int mcp320x_probe(struct spi_device *spi)
 	indio_dev->info = &mcp320x_info;
 	spi_set_drvdata(spi, indio_dev);
 
-	chip_info = &mcp320x_chip_infos[spi_get_device_id(spi)->driver_data];
+	device_index = spi_get_device_id(spi)->driver_data;
+	chip_info = &mcp320x_chip_infos[device_index];
 	indio_dev->channels = chip_info->channels;
 	indio_dev->num_channels = chip_info->num_channels;
 
@@ -320,7 +414,8 @@ static int mcp320x_probe(struct spi_device *spi)
 	adc->transfer[0].tx_buf = &adc->tx_buf;
 	adc->transfer[0].len = sizeof(adc->tx_buf);
 	adc->transfer[1].rx_buf = adc->rx_buf;
-	adc->transfer[1].len = sizeof(adc->rx_buf);
+	adc->transfer[1].len = DIV_ROUND_UP(chip_info->resolution, 8);
+
 	if (chip_info->num_channels == 1)
 		/* single-channel converters are rx only (no MOSI pin) */
 		spi_message_init_with_transfers(&adc->msg,
@@ -329,6 +424,26 @@ static int mcp320x_probe(struct spi_device *spi)
 		spi_message_init_with_transfers(&adc->msg, adc->transfer,
 						ARRAY_SIZE(adc->transfer));
 
+	if (device_index == mcp3550_50 || device_index == mcp3551 ||
+	    device_index == mcp3550_60 || device_index == mcp3553) {
+		unsigned int val;
+
+		/* rx len increases from 24 to 25 bit in SPI mode 0,0 */
+		if (!(spi->mode & SPI_CPOL))
+			adc->transfer[1].len++;
+
+		/* conversions are started by asserting CS pin for 8 usec */
+		adc->start_conv_transfer.delay_usecs = 8;
+		spi_message_init_with_transfers(&adc->start_conv_msg,
+						&adc->start_conv_transfer, 1);
+		adc->continuous_conv = device_property_read_bool(&spi->dev,
+					"microchip,continuous-conversion");
+
+		/* perform two consecutive conversions to unwedge device */
+		mcp320x_adc_conversion(adc, 0, 1, device_index, &val);
+		mcp320x_adc_conversion(adc, 0, 1, device_index, &val);
+	}
+
 	adc->reg = devm_regulator_get(&spi->dev, "vref");
 	if (IS_ERR(adc->reg))
 		return PTR_ERR(adc->reg);
@@ -383,6 +498,10 @@ static const struct of_device_id mcp320x_dt_ids[] = {
 	{ .compatible = "microchip,mcp3204" },
 	{ .compatible = "microchip,mcp3208" },
 	{ .compatible = "microchip,mcp3301" },
+	{ .compatible = "microchip,mcp3550-50" },
+	{ .compatible = "microchip,mcp3550-60" },
+	{ .compatible = "microchip,mcp3551" },
+	{ .compatible = "microchip,mcp3553" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mcp320x_dt_ids);
@@ -398,6 +517,10 @@ static const struct spi_device_id mcp320x_id[] = {
 	{ "mcp3204", mcp3204 },
 	{ "mcp3208", mcp3208 },
 	{ "mcp3301", mcp3301 },
+	{ "mcp3550-50", mcp3550_50 },
+	{ "mcp3550-60", mcp3550_60 },
+	{ "mcp3551", mcp3551 },
+	{ "mcp3553", mcp3553 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, mcp320x_id);
@@ -414,5 +537,5 @@ static struct spi_driver mcp320x_driver = {
 module_spi_driver(mcp320x_driver);
 
 MODULE_AUTHOR("Oskar Andero <oskar.andero@gmail.com>");
-MODULE_DESCRIPTION("Microchip Technology MCP3x01/02/04/08");
+MODULE_DESCRIPTION("Microchip Technology MCP3x01/02/04/08 and MCP3550/1/3");
 MODULE_LICENSE("GPL v2");
-- 
2.11.0

