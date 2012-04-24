Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 02/11] staging:iio:dac:ad5446: Remove duplicated write sample functions
Date: Tue, 24 Apr 2012 18:49:32 +0200
Message-Id: <1335286181-20474-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1335286181-20474-1-git-send-email-lars@metafoo.de>
References: <1335286181-20474-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

AD5620_LOAD and AD5446_LOAD are both 0, so all these three functions are
identical and we can replace them with only one.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/dac/ad5446.c |   34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index de796c2..0da5c6c 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -26,19 +26,9 @@
 
 static void ad5446_store_sample(struct ad5446_state *st, unsigned val)
 {
-	st->data.d16 = cpu_to_be16(AD5446_LOAD | val);
-}
-
-static void ad5542_store_sample(struct ad5446_state *st, unsigned val)
-{
 	st->data.d16 = cpu_to_be16(val);
 }
 
-static void ad5620_store_sample(struct ad5446_state *st, unsigned val)
-{
-	st->data.d16 = cpu_to_be16(AD5620_LOAD | val);
-}
-
 static void ad5660_store_sample(struct ad5446_state *st, unsigned val)
 {
 	val |= AD5660_LOAD;
@@ -174,61 +164,61 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
 	},
 	[ID_AD5541A] = {
 		.channel = AD5446_CHANNEL(16, 16, 0),
-		.store_sample = ad5542_store_sample,
+		.store_sample = ad5446_store_sample,
 	},
 	[ID_AD5542A] = {
 		.channel = AD5446_CHANNEL(16, 16, 0),
-		.store_sample = ad5542_store_sample,
+		.store_sample = ad5446_store_sample,
 	},
 	[ID_AD5543] = {
 		.channel = AD5446_CHANNEL(16, 16, 0),
-		.store_sample = ad5542_store_sample,
+		.store_sample = ad5446_store_sample,
 	},
 	[ID_AD5512A] = {
 		.channel = AD5446_CHANNEL(12, 16, 4),
-		.store_sample = ad5542_store_sample,
+		.store_sample = ad5446_store_sample,
 	},
 	[ID_AD5553] = {
 		.channel = AD5446_CHANNEL(14, 16, 0),
-		.store_sample = ad5542_store_sample,
+		.store_sample = ad5446_store_sample,
 	},
 	[ID_AD5601] = {
 		.channel = AD5446_CHANNEL(8, 16, 6),
-		.store_sample = ad5542_store_sample,
+		.store_sample = ad5446_store_sample,
 		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5611] = {
 		.channel = AD5446_CHANNEL(10, 16, 4),
-		.store_sample = ad5542_store_sample,
+		.store_sample = ad5446_store_sample,
 		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5621] = {
 		.channel = AD5446_CHANNEL(12, 16, 2),
-		.store_sample = ad5542_store_sample,
+		.store_sample = ad5446_store_sample,
 		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5620_2500] = {
 		.channel = AD5446_CHANNEL(12, 16, 2),
 		.int_vref_mv = 2500,
-		.store_sample = ad5620_store_sample,
+		.store_sample = ad5446_store_sample,
 		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5620_1250] = {
 		.channel = AD5446_CHANNEL(12, 16, 2),
 		.int_vref_mv = 1250,
-		.store_sample = ad5620_store_sample,
+		.store_sample = ad5446_store_sample,
 		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5640_2500] = {
 		.channel = AD5446_CHANNEL(14, 16, 0),
 		.int_vref_mv = 2500,
-		.store_sample = ad5620_store_sample,
+		.store_sample = ad5446_store_sample,
 		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5640_1250] = {
 		.channel = AD5446_CHANNEL(14, 16, 0),
 		.int_vref_mv = 1250,
-		.store_sample = ad5620_store_sample,
+		.store_sample = ad5446_store_sample,
 		.store_pwr_down = ad5620_store_pwr_down,
 	},
 	[ID_AD5660_2500] = {
-- 
1.7.9.5
