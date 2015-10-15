Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from netline-mail3.netline.ch ([78.47.214.34]:53573 "EHLO
	netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597AbbJOMb0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 15 Oct 2015 08:31:26 -0400
From: Marc Andre <marc.andre@netline.ch>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, marc.andre@netline.ch
Subject: [PATCH v2 1/2] iio:ad5064: Add support for ltc2617 and similar devices
Date: Thu, 15 Oct 2015 14:31:03 +0200
Message-Id: <1444912264-44606-2-git-send-email-marc.andre@netline.ch>
In-Reply-To: <1444912264-44606-1-git-send-email-marc.andre@netline.ch>
References: <CAEnQRZC4sxWXkUgz7316NrzHYa9GkfneG82PcPKgK00S76W=GA@mail.gmail.com>
 <1444912264-44606-1-git-send-email-marc.andre@netline.ch>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Linear Technology LTC2606, LTC2607, LTC2609, LTC2616, LTC2617,
LTC2619, LTC2626, LTC2627 and LTC2629 devices are very similar
to the AD5064 device.

This patch adds basic support for those devices.

Datasheet for LTC devices:
LTC2606, LTC2616, LTC2626: http://www.linear.com/docs/6398
LTC2607, LTC2617, LTC2627: http://www.linear.com/docs/8977
LTC2709, LTC2619, LTC2629: http://www.linear.com/docs/8477

Signed-off-by: Marc Andre <marc.andre@netline.ch>
---
 drivers/iio/dac/ad5064.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index 978f130..a76f4cf 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -1,6 +1,8 @@
 /*
  * AD5024, AD5025, AD5044, AD5045, AD5064, AD5064-1, AD5065, AD5628, AD5629R,
- * AD5648, AD5666, AD5668, AD5669R Digital to analog converters driver
+ * AD5648, AD5666, AD5668, AD5669R, LTC2606, LTC2607, LTC2609, LTC2616,
+ * LTC2617, LTC2619, LTC2626, LTC2627, LTC2629
+ * Digital to analog converters driver
  *
  * Copyright 2011 Analog Devices Inc.
  *
@@ -123,6 +125,15 @@ enum ad5064_type {
 	ID_AD5668_2,
 	ID_AD5669_1,
 	ID_AD5669_2,
+	ID_LTC2606,
+	ID_LTC2607,
+	ID_LTC2609,
+	ID_LTC2616,
+	ID_LTC2617,
+	ID_LTC2619,
+	ID_LTC2626,
+	ID_LTC2627,
+	ID_LTC2629,
 };
 
 static int ad5064_write(struct ad5064_state *st, unsigned int cmd,
@@ -339,6 +350,7 @@ static DECLARE_AD5065_CHANNELS(ad5045_channels, 14, 6);
 static DECLARE_AD5065_CHANNELS(ad5065_channels, 16, 4);
 
 static DECLARE_AD5064_CHANNELS(ad5629_channels, 12, 4);
+static DECLARE_AD5064_CHANNELS(ltc2617_channels, 14, 2);
 static DECLARE_AD5064_CHANNELS(ad5669_channels, 16, 0);
 
 static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
@@ -449,6 +461,60 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
 		.channels = ad5669_channels,
 		.num_channels = 8,
 	},
+	[ID_LTC2606] = {
+		.shared_vref = true,
+		.internal_vref = 0,
+		.channels = ad5669_channels,
+		.num_channels = 1,
+	},
+	[ID_LTC2607] = {
+		.shared_vref = true,
+		.internal_vref = 0,
+		.channels = ad5669_channels,
+		.num_channels = 2,
+	},
+	[ID_LTC2609] = {
+		.shared_vref = false,
+		.internal_vref = 0,
+		.channels = ad5669_channels,
+		.num_channels = 4,
+	},
+	[ID_LTC2616] = {
+		.shared_vref = true,
+		.internal_vref = 0,
+		.channels = ltc2617_channels,
+		.num_channels = 1,
+	},
+	[ID_LTC2617] = {
+		.shared_vref = true,
+		.internal_vref = 0,
+		.channels = ltc2617_channels,
+		.num_channels = 2,
+	},
+	[ID_LTC2619] = {
+		.shared_vref = false,
+		.internal_vref = 0,
+		.channels = ltc2617_channels,
+		.num_channels = 4,
+	},
+	[ID_LTC2626] = {
+		.shared_vref = true,
+		.internal_vref = 0,
+		.channels = ad5629_channels,
+		.num_channels = 1,
+	},
+	[ID_LTC2627] = {
+		.shared_vref = true,
+		.internal_vref = 0,
+		.channels = ad5629_channels,
+		.num_channels = 2,
+	},
+	[ID_LTC2629] = {
+		.shared_vref = false,
+		.internal_vref = 0,
+		.channels = ad5629_channels,
+		.num_channels = 4,
+	},
 };
 
 static inline unsigned int ad5064_num_vref(struct ad5064_state *st)
@@ -660,6 +726,15 @@ static const struct i2c_device_id ad5064_i2c_ids[] = {
 	{"ad5669-1", ID_AD5669_1},
 	{"ad5669-2", ID_AD5669_2},
 	{"ad5669-3", ID_AD5669_2}, /* similar enough to ad5669-2 */
+	{"ltc2606", ID_LTC2606},
+	{"ltc2607", ID_LTC2607},
+	{"ltc2609", ID_LTC2609},
+	{"ltc2616", ID_LTC2616},
+	{"ltc2617", ID_LTC2617},
+	{"ltc2619", ID_LTC2619},
+	{"ltc2626", ID_LTC2626},
+	{"ltc2627", ID_LTC2627},
+	{"ltc2629", ID_LTC2629},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ad5064_i2c_ids);
-- 
1.9.1

