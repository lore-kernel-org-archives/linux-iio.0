Return-Path: <SRS0=iwlF=HK=onstation.org=masneyb@kernel.org>
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
Subject: [PATCH 13/13] staging: iio: tsl2x7x: rename prox_config to als_prox_config
Date: Fri, 20 Apr 2018 20:41:53 -0400
Message-Id: <20180421004153.19073-14-masneyb@onstation.org>
In-Reply-To: <20180421004153.19073-1-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

The configuration register on the device is represented with the
prox_config member on the tsl2x7x_settings structure. According to the
TSL2772 data sheet, this register can hold: 1) the proximity drive
level, 2) ALS/Proximity long wait, and 3) the ALS gain level. This
patch renames prox_config to als_prox_config since ALS settings can
be stored here as well.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 7 ++++---
 drivers/staging/iio/light/tsl2x7x.h | 5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 05c0f3d5fac0..708b2c6bdf4b 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -56,7 +56,7 @@
 #define TSL2X7X_PRX_MAXTHRESHLO		0X0A
 #define TSL2X7X_PRX_MAXTHRESHHI		0X0B
 #define TSL2X7X_PERSISTENCE		0x0C
-#define TSL2X7X_PRX_CONFIG		0x0D
+#define TSL2X7X_ALS_PRX_CONFIG		0x0D
 #define TSL2X7X_PRX_COUNT		0x0E
 #define TSL2X7X_GAIN			0x0F
 #define TSL2X7X_NOTUSED			0x10
@@ -207,7 +207,7 @@ static const struct tsl2x7x_settings tsl2x7x_default_settings = {
 	.prox_time = 255, /* 2.73 ms */
 	.prox_gain = 0,
 	.wait_time = 255,
-	.prox_config = 0,
+	.als_prox_config = 0,
 	.als_gain_trim = 1000,
 	.als_cal_target = 150,
 	.als_persistence = 1,
@@ -594,7 +594,8 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 	/* Non calculated parameters */
 	chip->tsl2x7x_config[TSL2X7X_PRX_TIME] = chip->settings.prox_time;
 	chip->tsl2x7x_config[TSL2X7X_WAIT_TIME] = chip->settings.wait_time;
-	chip->tsl2x7x_config[TSL2X7X_PRX_CONFIG] = chip->settings.prox_config;
+	chip->tsl2x7x_config[TSL2X7X_ALS_PRX_CONFIG] =
+		chip->settings.als_prox_config;
 
 	chip->tsl2x7x_config[TSL2X7X_ALS_MINTHRESHLO] =
 		(chip->settings.als_thresh_low) & 0xFF;
diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
index 85d8fe7a94c8..6e30e71a2127 100644
--- a/drivers/staging/iio/light/tsl2x7x.h
+++ b/drivers/staging/iio/light/tsl2x7x.h
@@ -48,7 +48,8 @@ struct tsl2x7x_lux {
  *                          increments. Total integration time is
  *                          (256 - prx_time) * 2.73.
  *  @prox_gain:             Index into the tsl2x7x_prx_gain array.
- *  @prox_config:           Prox configuration filters.
+ *  @als_prox_config:       The value of the ALS / Proximity configuration
+ *                          register.
  *  @als_cal_target:        Known external ALS reading for calibration.
  *  @als_persistence:       H/W Filters, Number of 'out of limits' ALS readings.
  *  @als_interrupt_en:      Enable/Disable ALS interrupts
@@ -73,7 +74,7 @@ struct tsl2x7x_settings {
 	int wait_time;
 	int prox_time;
 	int prox_gain;
-	int prox_config;
+	int als_prox_config;
 	int als_cal_target;
 	u8 als_persistence;
 	bool als_interrupt_en;
-- 
2.14.3
