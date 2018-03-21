Return-Path: <SRS0=Ao9w=GL=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 09/11] staging: iio: tsl2x7x: remove ch0 and ch1 variables from tsl2x7x_get_lux()
Date: Wed, 21 Mar 2018 06:29:10 -0400
Message-Id: <20180321102912.5130-10-masneyb@onstation.org>
In-Reply-To: <20180321102912.5130-1-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

Remove the ch0 and ch1 variables from tsl2x7x_get_lux() and
write those values directly into the chip->als_cur_info.als_ch0
and chip->als_cur_info.als_ch01 variables.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 1e38e8449f9e..65b7fbca8c5d 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -336,7 +336,6 @@ static int tsl2x7x_write_control_reg(struct tsl2X7X_chip *chip, u8 data)
  */
 static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 {
-	u16 ch0, ch1; /* separated ch0/ch1 data from device */
 	u32 lux; /* raw lux calculated from device data */
 	u64 lux64;
 	u32 ratio;
@@ -382,24 +381,24 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 	}
 
 	/* extract ALS/lux data */
-	ch0 = le16_to_cpup((const __le16 *)&buf[0]);
-	ch1 = le16_to_cpup((const __le16 *)&buf[2]);
+	chip->als_cur_info.als_ch0 = le16_to_cpup((const __le16 *)&buf[0]);
+	chip->als_cur_info.als_ch1 = le16_to_cpup((const __le16 *)&buf[2]);
 
-	chip->als_cur_info.als_ch0 = ch0;
-	chip->als_cur_info.als_ch1 = ch1;
-
-	if (ch0 >= chip->als_saturation || ch1 >= chip->als_saturation) {
+	if (chip->als_cur_info.als_ch0 >= chip->als_saturation ||
+	    chip->als_cur_info.als_ch1 >= chip->als_saturation) {
 		lux = TSL2X7X_LUX_CALC_OVER_FLOW;
 		goto return_max;
 	}
 
-	if (!ch0) {
+	if (!chip->als_cur_info.als_ch0) {
 		/* have no data, so return LAST VALUE */
 		ret = chip->als_cur_info.lux;
 		goto out_unlock;
 	}
+
 	/* calculate ratio */
-	ratio = (ch1 << 15) / ch0;
+	ratio = (chip->als_cur_info.als_ch1 << 15) / chip->als_cur_info.als_ch0;
+
 	/* convert to unscaled lux using the pointer to the table */
 	p = (struct tsl2x7x_lux *)chip->tsl2x7x_device_lux;
 	while (p->ratio != 0 && p->ratio < ratio)
@@ -408,9 +407,9 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 	if (p->ratio == 0) {
 		lux = 0;
 	} else {
-		lux = DIV_ROUND_UP(ch0 * p->ch0,
+		lux = DIV_ROUND_UP(chip->als_cur_info.als_ch0 * p->ch0,
 				   tsl2x7x_als_gain[chip->settings.als_gain]) -
-		      DIV_ROUND_UP(ch1 * p->ch1,
+		      DIV_ROUND_UP(chip->als_cur_info.als_ch1 * p->ch1,
 				   tsl2x7x_als_gain[chip->settings.als_gain]);
 	}
 
-- 
2.14.3
