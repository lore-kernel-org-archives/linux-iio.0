Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org,
	gregkh@linuxfoundation.org,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	knaack.h@gmx.de,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 3/9] staging: iio: tsl2583: fixed ordering of comments
Date: Thu,  3 Nov 2016 08:56:14 -0400
Message-Id: <1478177780-28699-4-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478177780-28699-1-git-send-email-masneyb@onstation.org>
References: <1478177780-28699-1-git-send-email-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

in taos_defaults()

The comments in taos_defaults() appear after the line of code
that they apply to. This patch moves the comments so that they appear
before the code. Some of the comments were updated to be more
informative.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 388440b..709f446 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -143,16 +143,23 @@ static const struct gainadj gainadj[] = {
  */
 static void taos_defaults(struct tsl2583_chip *chip)
 {
-	/* Operational parameters */
+	/*
+	 * The integration time must be a multiple of 50ms and within the
+	 * range [50, 600] ms.
+	 */
 	chip->taos_settings.als_time = 100;
-	/* must be a multiple of 50mS */
+
+	/*
+	 * This is an index into the gainadj table. Assume clear glass as the
+	 * default.
+	 */
 	chip->taos_settings.als_gain = 0;
-	/* this is actually an index into the gain table */
-	/* assume clear glass as default */
+
+	/* Default gain trim to account for aperture effects */
 	chip->taos_settings.als_gain_trim = 1000;
-	/* default gain trim to account for aperture effects */
-	chip->taos_settings.als_cal_target = 130;
+
 	/* Known external ALS reading used for calibration */
+	chip->taos_settings.als_cal_target = 130;
 }
 
 /*
-- 
2.5.5
