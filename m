Return-Path: <SRS0=14rJ=BS=onstation.org=masneyb@kernel.org>
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
Subject: [PATCH 13/13] staging: iio: tsl2x7x: add goto for TSL2X7X_LUX_CALC_OVER_FLOW
Date: Thu, 19 Oct 2017 16:06:32 -0400
Message-Id: <20171019200632.25820-14-masneyb@onstation.org>
In-Reply-To: <20171019200632.25820-1-masneyb@onstation.org>
References: <20171019200632.25820-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

This patch adds a return_max label for the two cases that need to set
the lux to TSL2X7X_LUX_CALC_OVER_FLOW and return.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 42ed9c015aaf..898304d65f64 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -364,10 +364,8 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 	chip->als_cur_info.als_ch0 = ch0;
 	chip->als_cur_info.als_ch1 = ch1;
 
-	if (ch0 >= chip->als_saturation || ch1 >= chip->als_saturation) {
-		lux = TSL2X7X_LUX_CALC_OVER_FLOW;
+	if (ch0 >= chip->als_saturation || ch1 >= chip->als_saturation)
 		goto return_max;
-	}
 
 	if (!ch0) {
 		/* have no data, so return LAST VALUE */
@@ -418,11 +416,12 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
 	lux = lux64;
 	lux = (lux + 500) / 1000;
 
-	if (lux > TSL2X7X_LUX_CALC_OVER_FLOW) /* check for overflow */
+	if (lux > TSL2X7X_LUX_CALC_OVER_FLOW) { /* check for overflow */
+return_max:
 		lux = TSL2X7X_LUX_CALC_OVER_FLOW;
+	}
 
 	/* Update the structure with the latest lux. */
-return_max:
 	chip->als_cur_info.lux = lux;
 	ret = lux;
 
-- 
2.13.6
