Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from netline-mail3.netline.ch ([78.47.214.34]:51555 "EHLO
	netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbbJOJMf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 15 Oct 2015 05:12:35 -0400
From: Marc Andre <marc.andre@netline.ch>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, marc.andre@netline.ch
Subject: [PATCH 2/2] iio:ad5064: Fix power down operation with LTC2617
Date: Thu, 15 Oct 2015 11:12:06 +0200
Message-Id: <1444900326-43839-3-git-send-email-marc.andre@netline.ch>
In-Reply-To: <1444900326-43839-1-git-send-email-marc.andre@netline.ch>
References: <1444900326-43839-1-git-send-email-marc.andre@netline.ch>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

LTC2617 device (and the other devices from Linear Technology) have
a different behavior for power down than the Analog Device devices.
The command must be addressed with the right channel address. Also,
only a single power down mode (90k to ground) is available.

This patch adjusts the driver to handle the LTC case specifically.

I decided to implement the different power down modes as a
separate iio_ext_info structure. An alternative implementation
would be to set the iio_ext_info structure not const
and then adjust the enum in the probe() function based on a
chip_info setting. In my view this would be less ideal because
it uses more memory for the kernel.

The different addressing is handled with a flag in the chip_info
structure. Alternatively we could implement a copy of all
set_powerdown_...() functions. I think this is less nice.

Signed-off-by: Marc Andre <marc.andre@netline.ch>
---
 drivers/iio/dac/ad5064.c | 120 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 82 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index a76f4cf..1b89625 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -1,8 +1,8 @@
 /*
  * AD5024, AD5025, AD5044, AD5045, AD5064, AD5064-1, AD5065, AD5628, AD5629R,
  * AD5648, AD5666, AD5668, AD5669R, LTC2606, LTC2607, LTC2609, LTC2616,
- * LTC2617, LTC2619, LTC2626, LTC2627, LTC2629
- * Digital to analog converters driver
+ * LTC2617, LTC2619, LTC2626, LTC2627, LTC2629 Digital to analog converters
+ * driver
  *
  * Copyright 2011 Analog Devices Inc.
  *
@@ -52,10 +52,12 @@
 /**
  * struct ad5064_chip_info - chip specific information
  * @shared_vref:	whether the vref supply is shared between channels
- * @internal_vref:	internal reference voltage. 0 if the chip has no internal
- *			vref.
+ * @internal_vref:	internal reference voltage. 0 if the chip has no
+			internal vref.
  * @channel:		channel specification
  * @num_channels:	number of channels
+ * @powerdown_ltc:	Use alternative power down addressing as required by
+ *			ltc2617 and others.
  */
 
 struct ad5064_chip_info {
@@ -63,6 +65,7 @@ struct ad5064_chip_info {
 	unsigned long internal_vref;
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
+	bool powerdown_ltc;
 };
 
 struct ad5064_state;
@@ -147,15 +150,21 @@ static int ad5064_write(struct ad5064_state *st, unsigned int cmd,
 static int ad5064_sync_powerdown_mode(struct ad5064_state *st,
 	const struct iio_chan_spec *chan)
 {
-	unsigned int val;
+	unsigned int val, address;
 	int ret;
 
-	val = (0x1 << chan->address);
+	if (st->chip_info->powerdown_ltc) {
+		val = 0;
+		address = chan->address;
+	} else {
+		address = 0;
+		val = (0x1 << chan->address);
 
-	if (st->pwr_down[chan->channel])
-		val |= st->pwr_down_mode[chan->channel] << 8;
+		if (st->pwr_down[chan->channel])
+			val |= st->pwr_down_mode[chan->channel] << 8;
+	}
 
-	ret = ad5064_write(st, AD5064_CMD_POWERDOWN_DAC, 0, val, 0);
+	ret = ad5064_write(st, AD5064_CMD_POWERDOWN_DAC, address, val, 0);
 
 	return ret;
 }
@@ -166,6 +175,10 @@ static const char * const ad5064_powerdown_modes[] = {
 	"three_state",
 };
 
+static const char * const ltc2617_powerdown_modes[] = {
+	"90kohm_to_gnd",
+};
+
 static int ad5064_get_powerdown_mode(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan)
 {
@@ -196,6 +209,13 @@ static const struct iio_enum ad5064_powerdown_mode_enum = {
 	.set = ad5064_set_powerdown_mode,
 };
 
+static const struct iio_enum ltc2617_powerdown_mode_enum = {
+	.items = ltc2617_powerdown_modes,
+	.num_items = ARRAY_SIZE(ltc2617_powerdown_modes),
+	.get = ad5064_get_powerdown_mode,
+	.set = ad5064_set_powerdown_mode,
+};
+
 static ssize_t ad5064_read_dac_powerdown(struct iio_dev *indio_dev,
 	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
 {
@@ -306,7 +326,19 @@ static const struct iio_chan_spec_ext_info ad5064_ext_info[] = {
 	{ },
 };
 
-#define AD5064_CHANNEL(chan, addr, bits, _shift) {		\
+static const struct iio_chan_spec_ext_info ltc2617_ext_info[] = {
+	{
+		.name = "powerdown",
+		.read = ad5064_read_dac_powerdown,
+		.write = ad5064_write_dac_powerdown,
+		.shared = IIO_SEPARATE,
+	},
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ltc2617_powerdown_mode_enum),
+	IIO_ENUM_AVAILABLE("powerdown_mode", &ltc2617_powerdown_mode_enum),
+	{ },
+};
+
+#define AD5064_CHANNEL(chan, addr, bits, _shift, _ext_info) {		\
 	.type = IIO_VOLTAGE,					\
 	.indexed = 1,						\
 	.output = 1,						\
@@ -320,38 +352,41 @@ static const struct iio_chan_spec_ext_info ad5064_ext_info[] = {
 		.storagebits = 16,				\
 		.shift = (_shift),				\
 	},							\
-	.ext_info = ad5064_ext_info,				\
+	.ext_info = (_ext_info),				\
 }
 
-#define DECLARE_AD5064_CHANNELS(name, bits, shift) \
+#define DECLARE_AD5064_CHANNELS(name, bits, shift, ext_info) \
 const struct iio_chan_spec name[] = { \
-	AD5064_CHANNEL(0, 0, bits, shift), \
-	AD5064_CHANNEL(1, 1, bits, shift), \
-	AD5064_CHANNEL(2, 2, bits, shift), \
-	AD5064_CHANNEL(3, 3, bits, shift), \
-	AD5064_CHANNEL(4, 4, bits, shift), \
-	AD5064_CHANNEL(5, 5, bits, shift), \
-	AD5064_CHANNEL(6, 6, bits, shift), \
-	AD5064_CHANNEL(7, 7, bits, shift), \
+	AD5064_CHANNEL(0, 0, bits, shift, ext_info), \
+	AD5064_CHANNEL(1, 1, bits, shift, ext_info), \
+	AD5064_CHANNEL(2, 2, bits, shift, ext_info), \
+	AD5064_CHANNEL(3, 3, bits, shift, ext_info), \
+	AD5064_CHANNEL(4, 4, bits, shift, ext_info), \
+	AD5064_CHANNEL(5, 5, bits, shift, ext_info), \
+	AD5064_CHANNEL(6, 6, bits, shift, ext_info), \
+	AD5064_CHANNEL(7, 7, bits, shift, ext_info), \
 }
 
-#define DECLARE_AD5065_CHANNELS(name, bits, shift) \
+#define DECLARE_AD5065_CHANNELS(name, bits, shift, ext_info) \
 const struct iio_chan_spec name[] = { \
-	AD5064_CHANNEL(0, 0, bits, shift), \
-	AD5064_CHANNEL(1, 3, bits, shift), \
+	AD5064_CHANNEL(0, 0, bits, shift, ext_info), \
+	AD5064_CHANNEL(1, 3, bits, shift, ext_info), \
 }
 
-static DECLARE_AD5064_CHANNELS(ad5024_channels, 12, 8);
-static DECLARE_AD5064_CHANNELS(ad5044_channels, 14, 6);
-static DECLARE_AD5064_CHANNELS(ad5064_channels, 16, 4);
+static DECLARE_AD5064_CHANNELS(ad5024_channels, 12, 8, ad5064_ext_info);
+static DECLARE_AD5064_CHANNELS(ad5044_channels, 14, 6, ad5064_ext_info);
+static DECLARE_AD5064_CHANNELS(ad5064_channels, 16, 4, ad5064_ext_info);
+
+static DECLARE_AD5065_CHANNELS(ad5025_channels, 12, 8, ad5064_ext_info);
+static DECLARE_AD5065_CHANNELS(ad5045_channels, 14, 6, ad5064_ext_info);
+static DECLARE_AD5065_CHANNELS(ad5065_channels, 16, 4, ad5064_ext_info);
 
-static DECLARE_AD5065_CHANNELS(ad5025_channels, 12, 8);
-static DECLARE_AD5065_CHANNELS(ad5045_channels, 14, 6);
-static DECLARE_AD5065_CHANNELS(ad5065_channels, 16, 4);
+static DECLARE_AD5064_CHANNELS(ad5629_channels, 12, 4, ad5064_ext_info);
+static DECLARE_AD5064_CHANNELS(ad5669_channels, 16, 0, ad5064_ext_info);
 
-static DECLARE_AD5064_CHANNELS(ad5629_channels, 12, 4);
-static DECLARE_AD5064_CHANNELS(ltc2617_channels, 14, 2);
-static DECLARE_AD5064_CHANNELS(ad5669_channels, 16, 0);
+static DECLARE_AD5064_CHANNELS(ltc2607_channels, 16, 0, ltc2617_ext_info);
+static DECLARE_AD5064_CHANNELS(ltc2617_channels, 14, 2, ltc2617_ext_info);
+static DECLARE_AD5064_CHANNELS(ltc2627_channels, 12, 4, ltc2617_ext_info);
 
 static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
 	[ID_AD5024] = {
@@ -464,56 +499,65 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
 	[ID_LTC2606] = {
 		.shared_vref = true,
 		.internal_vref = 0,
-		.channels = ad5669_channels,
+		.channels = ltc2607_channels,
 		.num_channels = 1,
+		.powerdown_ltc = true,
 	},
 	[ID_LTC2607] = {
 		.shared_vref = true,
 		.internal_vref = 0,
-		.channels = ad5669_channels,
+		.channels = ltc2607_channels,
 		.num_channels = 2,
+		.powerdown_ltc = true,
 	},
 	[ID_LTC2609] = {
 		.shared_vref = false,
 		.internal_vref = 0,
-		.channels = ad5669_channels,
+		.channels = ltc2607_channels,
 		.num_channels = 4,
+		.powerdown_ltc = true,
 	},
 	[ID_LTC2616] = {
 		.shared_vref = true,
 		.internal_vref = 0,
 		.channels = ltc2617_channels,
 		.num_channels = 1,
+		.powerdown_ltc = true,
 	},
 	[ID_LTC2617] = {
 		.shared_vref = true,
 		.internal_vref = 0,
 		.channels = ltc2617_channels,
 		.num_channels = 2,
+		.powerdown_ltc = true,
 	},
 	[ID_LTC2619] = {
 		.shared_vref = false,
 		.internal_vref = 0,
 		.channels = ltc2617_channels,
 		.num_channels = 4,
+		.powerdown_ltc = true,
 	},
 	[ID_LTC2626] = {
 		.shared_vref = true,
 		.internal_vref = 0,
-		.channels = ad5629_channels,
+		.channels = ltc2627_channels,
 		.num_channels = 1,
+		.powerdown_ltc = true,
 	},
 	[ID_LTC2627] = {
 		.shared_vref = true,
 		.internal_vref = 0,
-		.channels = ad5629_channels,
+		.channels = ltc2627_channels,
 		.num_channels = 2,
+		.powerdown_ltc = true,
 	},
 	[ID_LTC2629] = {
 		.shared_vref = false,
 		.internal_vref = 0,
-		.channels = ad5629_channels,
+		.channels = ltc2627_channels,
 		.num_channels = 4,
+		.powerdown_ltc = true,
 	},
 };
 
-- 
1.9.1

