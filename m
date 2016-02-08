Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-009.synserver.de ([212.40.185.9]:1175 "EHLO
	smtp-out-169.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754316AbcBHRCH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2016 12:02:07 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Marc Andre <marc.andre@netline.ch>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/5] iio:ad5064: Use a enum for the register map layout type
Date: Mon,  8 Feb 2016 18:01:49 +0100
Message-Id: <1454950910-26049-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1454950910-26049-1-git-send-email-lars@metafoo.de>
References: <1454950910-26049-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently the ad5064 only supports two different register map variations
and this is represented by a bool. This patch changes since to a enum so
we can support more variations in the future.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5064.c | 54 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index 7cc3e93..b7f717c 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -50,14 +50,23 @@
 #define AD5064_LDAC_PWRDN_3STATE		0x3
 
 /**
+ * enum ad5064_regmap_type - Register layout variant
+ * @AD5064_REGMAP_ADI: Analog Devices register map layout
+ * @AD5064_REGMAP_LTC: LTC register map layout
+ */
+enum ad5064_regmap_type {
+	AD5064_REGMAP_ADI,
+	AD5064_REGMAP_LTC,
+};
+
+/**
  * struct ad5064_chip_info - chip specific information
  * @shared_vref:	whether the vref supply is shared between channels
  * @internal_vref:	internal reference voltage. 0 if the chip has no
 			internal vref.
  * @channel:		channel specification
  * @num_channels:	number of channels
- * @powerdown_ltc:	Use alternative power down addressing as required by
- *			ltc2617 and others.
+ * @regmap_type:	register map layout variant
  */
 
 struct ad5064_chip_info {
@@ -65,7 +74,7 @@ struct ad5064_chip_info {
 	unsigned long internal_vref;
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
-	bool powerdown_ltc;
+	enum ad5064_regmap_type regmap_type;
 };
 
 struct ad5064_state;
@@ -153,7 +162,7 @@ static int ad5064_sync_powerdown_mode(struct ad5064_state *st,
 	unsigned int val, address;
 	int ret;
 
-	if (st->chip_info->powerdown_ltc) {
+	if (st->chip_info->regmap_type == AD5064_REGMAP_LTC) {
 		val = 0;
 		address = chan->address;
 	} else {
@@ -393,171 +402,190 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
 		.shared_vref = false,
 		.channels = ad5024_channels,
 		.num_channels = 4,
+		.regmap_type = AD5064_REGMAP_ADI,
 	},
 	[ID_AD5025] = {
 		.shared_vref = false,
 		.channels = ad5025_channels,
 		.num_channels = 2,
+		.regmap_type = AD5064_REGMAP_ADI,
 	},
 	[ID_AD5044] = {
 		.shared_vref = false,
 		.channels = ad5044_channels,
 		.num_channels = 4,
+		.regmap_type = AD5064_REGMAP_ADI,
 	},
 	[ID_AD5045] = {
 		.shared_vref = false,
 		.channels = ad5045_channels,
 		.num_channels = 2,
+		.regmap_type = AD5064_REGMAP_ADI,
 	},
 	[ID_AD5064] = {
 		.shared_vref = false,
 		.channels = ad5064_channels,
 		.num_channels = 4,
+		.regmap_type = AD5064_REGMAP_ADI,
 	},
 	[ID_AD5064_1] = {
 		.shared_vref = true,
 		.channels = ad5064_channels,
 		.num_channels = 4,
+		.regmap_type = AD5064_REGMAP_ADI,
 	},
 	[ID_AD5065] = {
 		.shared_vref = false,
 		.channels = ad5065_channels,
 		.num_channels = 2,
+		.regmap_type = AD5064_REGMAP_ADI,
 	},
 	[ID_AD5628_1] = {
 		.shared_vref = true,
 		.internal_vref = 2500000,
 		.channels = ad5024_channels,
 		.num_channels = 8,
+		.regmap_type = AD5064_REGMAP_ADI,
 	},
 	[ID_AD5628_2] = {
 		.shared_vref = true,
 		.internal_vref = 5000000,
 		.channels = ad5024_channels,
 		.num_channels = 8,
+		.regmap_type = AD5064_REGMAP_ADI,
 	},
 	[ID_AD5629_1] = {
 		.shared_vref = true,
 		.internal_vref = 2500000,
 		.channels = ad5629_channels,
 		.num_channels = 8,
+		.regmap_type = AD5064_REGMAP_ADI,
 	},
 	[ID_AD5629_2] = {
 		.shared_vref = true,
 		.internal_vref = 5000000,
 		.channels = ad5629_channels,
 		.num_channels = 8,
+		.regmap_type = AD5064_REGMAP_ADI,
 	},
 	[ID_AD5648_1] = {
 		.shared_vref = true,
 		.internal_vref = 2500000,
 		.channels = ad5044_channels,
 		.num_channels = 8,
+		.regmap_type = AD5064_REGMAP_ADI,
 	},
 	[ID_AD5648_2] = {
 		.shared_vref = true,
 		.internal_vref = 5000000,
 		.channels = ad5044_channels,
 		.num_channels = 8,
+		.regmap_type = AD5064_REGMAP_ADI,
 	},
 	[ID_AD5666_1] = {
 		.shared_vref = true,
 		.internal_vref = 2500000,
 		.channels = ad5064_channels,
 		.num_channels = 4,
+		.regmap_type = AD5064_REGMAP_ADI,
 	},
 	[ID_AD5666_2] = {
 		.shared_vref = true,
 		.internal_vref = 5000000,
 		.channels = ad5064_channels,
 		.num_channels = 4,
+		.regmap_type = AD5064_REGMAP_ADI,
 	},
 	[ID_AD5668_1] = {
 		.shared_vref = true,
 		.internal_vref = 2500000,
 		.channels = ad5064_channels,
 		.num_channels = 8,
+		.regmap_type = AD5064_REGMAP_ADI,
 	},
 	[ID_AD5668_2] = {
 		.shared_vref = true,
 		.internal_vref = 5000000,
 		.channels = ad5064_channels,
 		.num_channels = 8,
+		.regmap_type = AD5064_REGMAP_ADI,
 	},
 	[ID_AD5669_1] = {
 		.shared_vref = true,
 		.internal_vref = 2500000,
 		.channels = ad5669_channels,
 		.num_channels = 8,
+		.regmap_type = AD5064_REGMAP_ADI,
 	},
 	[ID_AD5669_2] = {
 		.shared_vref = true,
 		.internal_vref = 5000000,
 		.channels = ad5669_channels,
 		.num_channels = 8,
+		.regmap_type = AD5064_REGMAP_ADI,
 	},
 	[ID_LTC2606] = {
 		.shared_vref = true,
 		.internal_vref = 0,
 		.channels = ltc2607_channels,
 		.num_channels = 1,
-		.powerdown_ltc = true,
+		.regmap_type = AD5064_REGMAP_LTC,
 	},
 	[ID_LTC2607] = {
 		.shared_vref = true,
 		.internal_vref = 0,
 		.channels = ltc2607_channels,
 		.num_channels = 2,
-		.powerdown_ltc = true,
+		.regmap_type = AD5064_REGMAP_LTC,
 	},
 	[ID_LTC2609] = {
 		.shared_vref = false,
 		.internal_vref = 0,
 		.channels = ltc2607_channels,
 		.num_channels = 4,
-		.powerdown_ltc = true,
+		.regmap_type = AD5064_REGMAP_LTC,
 	},
 	[ID_LTC2616] = {
 		.shared_vref = true,
 		.internal_vref = 0,
 		.channels = ltc2617_channels,
 		.num_channels = 1,
-		.powerdown_ltc = true,
+		.regmap_type = AD5064_REGMAP_LTC,
 	},
 	[ID_LTC2617] = {
 		.shared_vref = true,
 		.internal_vref = 0,
 		.channels = ltc2617_channels,
 		.num_channels = 2,
-		.powerdown_ltc = true,
+		.regmap_type = AD5064_REGMAP_LTC,
 	},
 	[ID_LTC2619] = {
 		.shared_vref = false,
 		.internal_vref = 0,
 		.channels = ltc2617_channels,
 		.num_channels = 4,
-		.powerdown_ltc = true,
+		.regmap_type = AD5064_REGMAP_LTC,
 	},
 	[ID_LTC2626] = {
 		.shared_vref = true,
 		.internal_vref = 0,
 		.channels = ltc2627_channels,
 		.num_channels = 1,
-		.powerdown_ltc = true,
+		.regmap_type = AD5064_REGMAP_LTC,
 	},
 	[ID_LTC2627] = {
 		.shared_vref = true,
 		.internal_vref = 0,
 		.channels = ltc2627_channels,
 		.num_channels = 2,
-		.powerdown_ltc = true,
+		.regmap_type = AD5064_REGMAP_LTC,
 	},
 	[ID_LTC2629] = {
 		.shared_vref = false,
 		.internal_vref = 0,
 		.channels = ltc2627_channels,
 		.num_channels = 4,
-		.powerdown_ltc = true,
+		.regmap_type = AD5064_REGMAP_LTC,
 	},
 };
 
-- 
2.1.4

