Return-Path: <SRS0=6Xdg=H6=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	drew.paterson@ams.com
Subject: [PATCH v3 7/9] staging: iio: tsl2x7x: add range checking to tsl2x7x_write_raw
Date: Thu, 10 May 2018 20:12:21 -0400
Message-Id: <20180511001223.12378-8-masneyb@onstation.org>
In-Reply-To: <20180511001223.12378-1-masneyb@onstation.org>
References: <20180511001223.12378-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

The CALIBBIAS and INT_TIME masks in tsl2x7x_write_raw did not have any
range checking in place so this patch adds the appropriate range
checking. The defines TSL2X7X_ALS_GAIN_TRIM_{MIN,MAX} are also
introduced by this patch.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 0218eabcd6d7..f9500afab30c 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -103,6 +103,9 @@
 #define TSL2X7X_CNTL_PROXPON_ENBL	0x0F
 #define TSL2X7X_CNTL_INTPROXPON_ENBL	0x2F
 
+#define TSL2X7X_ALS_GAIN_TRIM_MIN	250
+#define TSL2X7X_ALS_GAIN_TRIM_MAX	4000
+
 /* TAOS txx2x7x Device family members */
 enum {
 	tsl2571,
@@ -581,7 +584,7 @@ static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
 
 	ret = (chip->settings.als_cal_target * chip->settings.als_gain_trim) /
 			lux_val;
-	if (ret < 250 || ret > 4000)
+	if (ret < TSL2X7X_ALS_GAIN_TRIM_MIN || ret > TSL2X7X_ALS_GAIN_TRIM_MAX)
 		return -ERANGE;
 
 	chip->settings.als_gain_trim = ret;
@@ -1209,9 +1212,17 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 		}
 		break;
 	case IIO_CHAN_INFO_CALIBBIAS:
+		if (val < TSL2X7X_ALS_GAIN_TRIM_MIN ||
+		    val > TSL2X7X_ALS_GAIN_TRIM_MAX)
+			return -EINVAL;
+
 		chip->settings.als_gain_trim = val;
 		break;
 	case IIO_CHAN_INFO_INT_TIME:
+		if (val != 0 || val2 < tsl2x7x_int_time_avail[chip->id][1] ||
+		    val2 > tsl2x7x_int_time_avail[chip->id][5])
+			return -EINVAL;
+
 		chip->settings.als_time = 256 -
 			(val2 / tsl2x7x_int_time_avail[chip->id][3]);
 		break;
-- 
2.14.3
