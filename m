Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:52880 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751881AbeCDBy4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Mar 2018 20:54:56 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH 07/12] staging: iio: tsl2x7x: correct 'Avoid CamelCase' warning from checkpatch
Date: Sat,  3 Mar 2018 20:49:37 -0500
Message-Id: <20180304014942.18727-8-masneyb@onstation.org>
In-Reply-To: <20180304014942.18727-1-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The statP and calP variables triggered an 'Avoid CamelCase' warning
from checkpatch.pl. This patch renames these variables to stat and cal
to fix this warning.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index cc209b64ed5a..380a6c96a69a 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -773,7 +773,7 @@ static int tsl2x7x_invoke_change(struct iio_dev *indio_dev)
 }
 
 static void tsl2x7x_prox_calculate(int *data, int length,
-				   struct tsl2x7x_prox_stat *statP)
+				   struct tsl2x7x_prox_stat *stat)
 {
 	int i;
 	int sample_sum;
@@ -783,21 +783,21 @@ static void tsl2x7x_prox_calculate(int *data, int length,
 		length = 1;
 
 	sample_sum = 0;
-	statP->min = INT_MAX;
-	statP->max = INT_MIN;
+	stat->min = INT_MAX;
+	stat->max = INT_MIN;
 	for (i = 0; i < length; i++) {
 		sample_sum += data[i];
-		statP->min = min(statP->min, data[i]);
-		statP->max = max(statP->max, data[i]);
+		stat->min = min(stat->min, data[i]);
+		stat->max = max(stat->max, data[i]);
 	}
 
-	statP->mean = sample_sum / length;
+	stat->mean = sample_sum / length;
 	sample_sum = 0;
 	for (i = 0; i < length; i++) {
-		tmp = data[i] - statP->mean;
+		tmp = data[i] - stat->mean;
 		sample_sum += tmp * tmp;
 	}
-	statP->stddev = int_sqrt((long)sample_sum / length);
+	stat->stddev = int_sqrt((long)sample_sum / length);
 }
 
 /**
@@ -812,7 +812,7 @@ static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
 	int prox_history[MAX_SAMPLES_CAL + 1];
 	int i;
 	struct tsl2x7x_prox_stat prox_stat_data[2];
-	struct tsl2x7x_prox_stat *calP;
+	struct tsl2x7x_prox_stat *cal;
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 	u8 tmp_irq_settings;
 	u8 current_state = chip->tsl2x7x_chip_status;
@@ -844,13 +844,13 @@ static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
 	}
 
 	tsl2x7x_chip_off(indio_dev);
-	calP = &prox_stat_data[PROX_STAT_CAL];
+	cal = &prox_stat_data[PROX_STAT_CAL];
 	tsl2x7x_prox_calculate(prox_history,
-			       chip->settings.prox_max_samples_cal, calP);
-	chip->settings.prox_thres_high = (calP->max << 1) - calP->mean;
+			       chip->settings.prox_max_samples_cal, cal);
+	chip->settings.prox_thres_high = (cal->max << 1) - cal->mean;
 
 	dev_info(&chip->client->dev, " cal min=%d mean=%d max=%d\n",
-		 calP->min, calP->mean, calP->max);
+		 cal->min, cal->mean, cal->max);
 	dev_info(&chip->client->dev,
 		 "%s proximity threshold set to %d\n",
 		 chip->client->name, chip->settings.prox_thres_high);
-- 
2.14.3

