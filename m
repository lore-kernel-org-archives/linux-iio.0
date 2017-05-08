Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from atl4mhob10.myregisteredsite.com ([209.17.115.48]:43988 "EHLO
        atl4mhob10.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752875AbdEHH0c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 May 2017 03:26:32 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.211])
        by atl4mhob10.registeredsite.com (8.14.4/8.14.4) with ESMTP id v487QUWV019043
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
        for <linux-iio@vger.kernel.org>; Mon, 8 May 2017 03:26:30 -0400
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v2] iio:ad5064: Add support for ltc2633 and similar devices
Date: Mon,  8 May 2017 09:26:24 +0200
Message-Id: <1494228384-28786-1-git-send-email-mike.looijmans@topic.nl>
In-Reply-To: <646b634f-c0ad-f39c-a395-02461f5e8352@metafoo.de>
References: <1493199875-11912-1-git-send-email-mike.looijmans@topic.nl> <646b634f-c0ad-f39c-a395-02461f5e8352@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Linear Technology LTC2631, LTC2633 and LTC2635 are very similar
to the AD5064 device, in particular the LTC2627.

This patch adds support for those devices. Only the LTC2633 has been
tested, which is the 2-channel variant. The LTC2631 is the 1-channel,
and the LTC2635 the 4-channel version. The actual DAC resolution depends
on the exact chip type and can be 12, 10 or 8 bits, using the upper bits
so this has no effect on the register map. The internal reference is set
to 2.5V on "L" versions, and it's 4.096V for "H" versions.

Datasheets:
    LTC2631: http://www.linear.com/docs/26553
    LTC2633: http://www.linear.com/docs/39529
    LTC2635: http://www.linear.com/docs/28754

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
v2: Add separate definitions for 8, 10 and 12-bit versions

 drivers/iio/dac/Kconfig  |  3 +-
 drivers/iio/dac/ad5064.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index d3084028..31ffb67 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -13,7 +13,8 @@ config AD5064
 	  AD5045, AD5064, AD5064-1, AD5065, AD5625, AD5625R, AD5627, AD5627R,
 	  AD5628, AD5629R, AD5645R, AD5647R, AD5648, AD5665, AD5665R, AD5666,
 	  AD5667, AD5667R, AD5668, AD5669R, LTC2606, LTC2607, LTC2609, LTC2616,
-	  LTC2617, LTC2619, LTC2626, LTC2627, LTC2629 Digital to Analog Converter.
+	  LTC2617, LTC2619, LTC2626, LTC2627, LTC2629, LTC2631, LTC2633, LTC2635
+	  Digital to Analog Converter.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5064.
diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index 6803e4a..3f9399c 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -2,8 +2,8 @@
  * AD5024, AD5025, AD5044, AD5045, AD5064, AD5064-1, AD5065, AD5625, AD5625R,
  * AD5627, AD5627R, AD5628, AD5629R, AD5645R, AD5647R, AD5648, AD5665, AD5665R,
  * AD5666, AD5667, AD5667R, AD5668, AD5669R, LTC2606, LTC2607, LTC2609, LTC2616,
- * LTC2617, LTC2619, LTC2626, LTC2627, LTC2629 Digital to analog converters
- * driver
+ * LTC2617, LTC2619, LTC2626, LTC2627, LTC2629, LTC2631, LTC2633, LTC2635
+ * Digital to analog converters driver
  *
  * Copyright 2011 Analog Devices Inc.
  *
@@ -168,6 +168,24 @@ enum ad5064_type {
 	ID_LTC2626,
 	ID_LTC2627,
 	ID_LTC2629,
+	ID_LTC2631_L12,
+	ID_LTC2631_H12,
+	ID_LTC2631_L10,
+	ID_LTC2631_H10,
+	ID_LTC2631_L8,
+	ID_LTC2631_H8,
+	ID_LTC2633_L12,
+	ID_LTC2633_H12,
+	ID_LTC2633_L10,
+	ID_LTC2633_H10,
+	ID_LTC2633_L8,
+	ID_LTC2633_H8,
+	ID_LTC2635_L12,
+	ID_LTC2635_H12,
+	ID_LTC2635_L10,
+	ID_LTC2635_H10,
+	ID_LTC2635_L8,
+	ID_LTC2635_H8,
 };
 
 static int ad5064_write(struct ad5064_state *st, unsigned int cmd,
@@ -425,6 +443,19 @@ static int ad5064_write_raw(struct iio_dev *indio_dev,
 static DECLARE_AD5064_CHANNELS(ltc2607_channels, 16, 0, ltc2617_ext_info);
 static DECLARE_AD5064_CHANNELS(ltc2617_channels, 14, 2, ltc2617_ext_info);
 static DECLARE_AD5064_CHANNELS(ltc2627_channels, 12, 4, ltc2617_ext_info);
+#define ltc2631_12_channels ltc2627_channels
+static DECLARE_AD5064_CHANNELS(ltc2631_10_channels, 10, 6, ltc2617_ext_info);
+static DECLARE_AD5064_CHANNELS(ltc2631_8_channels, 8, 8, ltc2617_ext_info);
+
+#define LTC2631_INFO(vref, pchannels, nchannels)	\
+	{						\
+		.shared_vref = true,			\
+		.internal_vref = vref,			\
+		.channels = pchannels,			\
+		.num_channels = nchannels,		\
+		.regmap_type = AD5064_REGMAP_LTC,	\
+	}
+
 
 static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
 	[ID_AD5024] = {
@@ -724,6 +755,24 @@ static int ad5064_write_raw(struct iio_dev *indio_dev,
 		.num_channels = 4,
 		.regmap_type = AD5064_REGMAP_LTC,
 	},
+	[ID_LTC2631_L12] = LTC2631_INFO(2500000, ltc2631_12_channels, 1),
+	[ID_LTC2631_H12] = LTC2631_INFO(4096000, ltc2631_12_channels, 1),
+	[ID_LTC2631_L10] = LTC2631_INFO(2500000, ltc2631_10_channels, 1),
+	[ID_LTC2631_H10] = LTC2631_INFO(4096000, ltc2631_10_channels, 1),
+	[ID_LTC2631_L8] = LTC2631_INFO(2500000, ltc2631_8_channels, 1),
+	[ID_LTC2631_H8] = LTC2631_INFO(4096000, ltc2631_8_channels, 1),
+	[ID_LTC2633_L12] = LTC2631_INFO(2500000, ltc2631_12_channels, 2),
+	[ID_LTC2633_H12] = LTC2631_INFO(4096000, ltc2631_12_channels, 2),
+	[ID_LTC2633_L10] = LTC2631_INFO(2500000, ltc2631_10_channels, 2),
+	[ID_LTC2633_H10] = LTC2631_INFO(4096000, ltc2631_10_channels, 2),
+	[ID_LTC2633_L8] = LTC2631_INFO(2500000, ltc2631_8_channels, 2),
+	[ID_LTC2633_H8] = LTC2631_INFO(4096000, ltc2631_8_channels, 2),
+	[ID_LTC2635_L12] = LTC2631_INFO(2500000, ltc2631_12_channels, 4),
+	[ID_LTC2635_H12] = LTC2631_INFO(4096000, ltc2631_12_channels, 4),
+	[ID_LTC2635_L10] = LTC2631_INFO(2500000, ltc2631_10_channels, 4),
+	[ID_LTC2635_H10] = LTC2631_INFO(4096000, ltc2631_10_channels, 4),
+	[ID_LTC2635_L8] = LTC2631_INFO(2500000, ltc2631_8_channels, 4),
+	[ID_LTC2635_H8] = LTC2631_INFO(4096000, ltc2631_8_channels, 4),
 };
 
 static inline unsigned int ad5064_num_vref(struct ad5064_state *st)
@@ -982,6 +1031,24 @@ static int ad5064_i2c_remove(struct i2c_client *i2c)
 	{"ltc2626", ID_LTC2626},
 	{"ltc2627", ID_LTC2627},
 	{"ltc2629", ID_LTC2629},
+	{"ltc2631-l12", ID_LTC2631_L12},
+	{"ltc2631-h12", ID_LTC2631_H12},
+	{"ltc2631-l10", ID_LTC2631_L10},
+	{"ltc2631-h10", ID_LTC2631_H10},
+	{"ltc2631-l8", ID_LTC2631_L8},
+	{"ltc2631-h8", ID_LTC2631_H8},
+	{"ltc2633-l12", ID_LTC2633_L12},
+	{"ltc2633-h12", ID_LTC2633_H12},
+	{"ltc2633-l10", ID_LTC2633_L10},
+	{"ltc2633-h10", ID_LTC2633_H10},
+	{"ltc2633-l8", ID_LTC2633_L8},
+	{"ltc2633-h8", ID_LTC2633_H8},
+	{"ltc2635-l12", ID_LTC2635_L12},
+	{"ltc2635-h12", ID_LTC2635_H12},
+	{"ltc2635-l10", ID_LTC2635_L10},
+	{"ltc2635-h10", ID_LTC2635_H10},
+	{"ltc2635-l8", ID_LTC2635_L8},
+	{"ltc2635-h8", ID_LTC2635_H8},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ad5064_i2c_ids);
-- 
1.9.1

