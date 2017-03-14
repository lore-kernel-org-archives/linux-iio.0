Return-Path: <SRS0=R9fJ=2X=farole.net=miguel.robles@kernel.org>
From: Miguel Robles <miguel.robles@farole.net>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Miguel Robles <miguel.robles@farole.net>
Subject: [PATCH] [PATCH] Staging: iio: cdc: ad7152.c, use octal permissions instead of symbolic
Date: Tue, 14 Mar 2017 16:52:43 +0100
Message-Id: <1489506763-11364-1-git-send-email-miguel.robles@farole.net>
List-ID: <linux-iio@vger.kernel.org>

Fix checkpatch warnings:
Symbolic permissions are not preferred. Consider using octal permissions.

Signed-off-by: Miguel Robles <miguel.robles@farole.net>
---
 drivers/staging/iio/cdc/ad7152.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index e8609b8..dd0c24c 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -155,13 +155,13 @@ static ssize_t ad7152_start_gain_calib(struct device *dev,
 }
 
 static IIO_DEVICE_ATTR(in_capacitance0_calibbias_calibration,
-		       S_IWUSR, NULL, ad7152_start_offset_calib, 0);
+		       0200, NULL, ad7152_start_offset_calib, 0);
 static IIO_DEVICE_ATTR(in_capacitance1_calibbias_calibration,
-		       S_IWUSR, NULL, ad7152_start_offset_calib, 1);
+		       0200, NULL, ad7152_start_offset_calib, 1);
 static IIO_DEVICE_ATTR(in_capacitance0_calibscale_calibration,
-		       S_IWUSR, NULL, ad7152_start_gain_calib, 0);
+		       0200, NULL, ad7152_start_gain_calib, 0);
 static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
-		       S_IWUSR, NULL, ad7152_start_gain_calib, 1);
+		       0200, NULL, ad7152_start_gain_calib, 1);
 
 /* Values are Update Rate (Hz), Conversion Time (ms) + 1*/
 static const unsigned char ad7152_filter_rate_table[][2] = {
-- 
2.7.4
