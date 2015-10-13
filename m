Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-116.synserver.de ([212.40.185.116]:1498 "EHLO
	smtp-out-109.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752321AbbJMQZr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2015 12:25:47 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: Marc Andre <marc.andre@netline.ch>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] iio: ad5064: Fix ad5629/ad5669 shift
Date: Tue, 13 Oct 2015 18:15:38 +0200
Message-Id: <1444752938-4680-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1444752938-4680-1-git-send-email-lars@metafoo.de>
References: <1444752938-4680-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ad5629/ad5669 are the I2C variant of the ad5628/ad5668, which has a SPI
interface. They are mostly identical with the exception that the shift
factor is different. Currently the driver does not take care of this
difference which leads to incorrect DAC output values.

Fix this by introducing a custom channel spec for the ad5629/ad5669 with
the correct shift factor.

Fixes: commit 6a17a0768f77 ("iio:dac:ad5064: Add support for the ad5629r and ad5669r")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5064.c | 83 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index 7e7ebf3..978f130 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -113,12 +113,16 @@ enum ad5064_type {
 	ID_AD5065,
 	ID_AD5628_1,
 	ID_AD5628_2,
+	ID_AD5629_1,
+	ID_AD5629_2,
 	ID_AD5648_1,
 	ID_AD5648_2,
 	ID_AD5666_1,
 	ID_AD5666_2,
 	ID_AD5668_1,
 	ID_AD5668_2,
+	ID_AD5669_1,
+	ID_AD5669_2,
 };
 
 static int ad5064_write(struct ad5064_state *st, unsigned int cmd,
@@ -291,7 +295,7 @@ static const struct iio_chan_spec_ext_info ad5064_ext_info[] = {
 	{ },
 };
 
-#define AD5064_CHANNEL(chan, addr, bits) {			\
+#define AD5064_CHANNEL(chan, addr, bits, _shift) {		\
 	.type = IIO_VOLTAGE,					\
 	.indexed = 1,						\
 	.output = 1,						\
@@ -303,36 +307,39 @@ static const struct iio_chan_spec_ext_info ad5064_ext_info[] = {
 		.sign = 'u',					\
 		.realbits = (bits),				\
 		.storagebits = 16,				\
-		.shift = 20 - bits,				\
+		.shift = (_shift),				\
 	},							\
 	.ext_info = ad5064_ext_info,				\
 }
 
-#define DECLARE_AD5064_CHANNELS(name, bits) \
+#define DECLARE_AD5064_CHANNELS(name, bits, shift) \
 const struct iio_chan_spec name[] = { \
-	AD5064_CHANNEL(0, 0, bits), \
-	AD5064_CHANNEL(1, 1, bits), \
-	AD5064_CHANNEL(2, 2, bits), \
-	AD5064_CHANNEL(3, 3, bits), \
-	AD5064_CHANNEL(4, 4, bits), \
-	AD5064_CHANNEL(5, 5, bits), \
-	AD5064_CHANNEL(6, 6, bits), \
-	AD5064_CHANNEL(7, 7, bits), \
+	AD5064_CHANNEL(0, 0, bits, shift), \
+	AD5064_CHANNEL(1, 1, bits, shift), \
+	AD5064_CHANNEL(2, 2, bits, shift), \
+	AD5064_CHANNEL(3, 3, bits, shift), \
+	AD5064_CHANNEL(4, 4, bits, shift), \
+	AD5064_CHANNEL(5, 5, bits, shift), \
+	AD5064_CHANNEL(6, 6, bits, shift), \
+	AD5064_CHANNEL(7, 7, bits, shift), \
 }
 
-#define DECLARE_AD5065_CHANNELS(name, bits) \
+#define DECLARE_AD5065_CHANNELS(name, bits, shift) \
 const struct iio_chan_spec name[] = { \
-	AD5064_CHANNEL(0, 0, bits), \
-	AD5064_CHANNEL(1, 3, bits), \
+	AD5064_CHANNEL(0, 0, bits, shift), \
+	AD5064_CHANNEL(1, 3, bits, shift), \
 }
 
-static DECLARE_AD5064_CHANNELS(ad5024_channels, 12);
-static DECLARE_AD5064_CHANNELS(ad5044_channels, 14);
-static DECLARE_AD5064_CHANNELS(ad5064_channels, 16);
+static DECLARE_AD5064_CHANNELS(ad5024_channels, 12, 8);
+static DECLARE_AD5064_CHANNELS(ad5044_channels, 14, 6);
+static DECLARE_AD5064_CHANNELS(ad5064_channels, 16, 4);
 
-static DECLARE_AD5065_CHANNELS(ad5025_channels, 12);
-static DECLARE_AD5065_CHANNELS(ad5045_channels, 14);
-static DECLARE_AD5065_CHANNELS(ad5065_channels, 16);
+static DECLARE_AD5065_CHANNELS(ad5025_channels, 12, 8);
+static DECLARE_AD5065_CHANNELS(ad5045_channels, 14, 6);
+static DECLARE_AD5065_CHANNELS(ad5065_channels, 16, 4);
+
+static DECLARE_AD5064_CHANNELS(ad5629_channels, 12, 4);
+static DECLARE_AD5064_CHANNELS(ad5669_channels, 16, 0);
 
 static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
 	[ID_AD5024] = {
@@ -382,6 +389,18 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
 		.channels = ad5024_channels,
 		.num_channels = 8,
 	},
+	[ID_AD5629_1] = {
+		.shared_vref = true,
+		.internal_vref = 2500000,
+		.channels = ad5629_channels,
+		.num_channels = 8,
+	},
+	[ID_AD5629_2] = {
+		.shared_vref = true,
+		.internal_vref = 5000000,
+		.channels = ad5629_channels,
+		.num_channels = 8,
+	},
 	[ID_AD5648_1] = {
 		.shared_vref = true,
 		.internal_vref = 2500000,
@@ -418,6 +437,18 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
 		.channels = ad5064_channels,
 		.num_channels = 8,
 	},
+	[ID_AD5669_1] = {
+		.shared_vref = true,
+		.internal_vref = 2500000,
+		.channels = ad5669_channels,
+		.num_channels = 8,
+	},
+	[ID_AD5669_2] = {
+		.shared_vref = true,
+		.internal_vref = 5000000,
+		.channels = ad5669_channels,
+		.num_channels = 8,
+	},
 };
 
 static inline unsigned int ad5064_num_vref(struct ad5064_state *st)
@@ -623,12 +654,12 @@ static int ad5064_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id ad5064_i2c_ids[] = {
-	{"ad5629-1", ID_AD5628_1},
-	{"ad5629-2", ID_AD5628_2},
-	{"ad5629-3", ID_AD5628_2}, /* similar enough to ad5629-2 */
-	{"ad5669-1", ID_AD5668_1},
-	{"ad5669-2", ID_AD5668_2},
-	{"ad5669-3", ID_AD5668_2}, /* similar enough to ad5669-2 */
+	{"ad5629-1", ID_AD5629_1},
+	{"ad5629-2", ID_AD5629_2},
+	{"ad5629-3", ID_AD5629_2}, /* similar enough to ad5629-2 */
+	{"ad5669-1", ID_AD5669_1},
+	{"ad5669-2", ID_AD5669_2},
+	{"ad5669-3", ID_AD5669_2}, /* similar enough to ad5669-2 */
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, ad5064_i2c_ids);
-- 
2.1.4

