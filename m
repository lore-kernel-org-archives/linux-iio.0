Return-Path: <SRS0=gLGt=F2=onstation.org=masneyb@kernel.org>
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
Subject: [PATCH 08/12] staging: iio: tsl2x7x: add error handling to tsl2x7x_prox_cal()
Date: Sat,  3 Mar 2018 20:49:38 -0500
Message-Id: <20180304014942.18727-9-masneyb@onstation.org>
In-Reply-To: <20180304014942.18727-1-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

tsl2x7x_prox_cal() did not have any error checks. This patch adds
the missing error handling and ensures that any errors are reported to
user space via in_proximity0_calibrate_store().

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 380a6c96a69a..8adc6db44790 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -807,10 +807,10 @@ static void tsl2x7x_prox_calculate(int *data, int length,
  * Calculates a standard deviation based on the samples,
  * and sets the threshold accordingly.
  */
-static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
+static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
 {
 	int prox_history[MAX_SAMPLES_CAL + 1];
-	int i;
+	int i, ret;
 	struct tsl2x7x_prox_stat prox_stat_data[2];
 	struct tsl2x7x_prox_stat *cal;
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
@@ -825,25 +825,33 @@ static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
 	}
 
 	/* have to stop to change settings */
-	tsl2x7x_chip_off(indio_dev);
+	ret = tsl2x7x_chip_off(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	/* Enable proximity detection save just in case prox not wanted yet*/
 	tmp_irq_settings = chip->settings.interrupts_en;
 	chip->settings.interrupts_en |= TSL2X7X_CNTL_PROX_INT_ENBL;
 
 	/*turn on device if not already on*/
-	tsl2x7x_chip_on(indio_dev);
+	ret = tsl2x7x_chip_on(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	/*gather the samples*/
 	for (i = 0; i < chip->settings.prox_max_samples_cal; i++) {
 		usleep_range(15000, 17500);
-		tsl2x7x_get_prox(indio_dev);
+		ret = tsl2x7x_get_prox(indio_dev);
+		if (ret < 0)
+			return ret;
 		prox_history[i] = chip->prox_data;
 		dev_info(&chip->client->dev, "2 i=%d prox data= %d\n",
 			 i, chip->prox_data);
 	}
 
-	tsl2x7x_chip_off(indio_dev);
+	ret = tsl2x7x_chip_off(indio_dev);
+	if (ret < 0)
+		return ret;
 	cal = &prox_stat_data[PROX_STAT_CAL];
 	tsl2x7x_prox_calculate(prox_history,
 			       chip->settings.prox_max_samples_cal, cal);
@@ -857,8 +865,13 @@ static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
 
 	/* back to the way they were */
 	chip->settings.interrupts_en = tmp_irq_settings;
-	if (current_state == TSL2X7X_CHIP_WORKING)
-		tsl2x7x_chip_on(indio_dev);
+	if (current_state == TSL2X7X_CHIP_WORKING) {
+		ret = tsl2x7x_chip_on(indio_dev);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
 }
 
 static ssize_t
@@ -1018,8 +1031,11 @@ static ssize_t in_proximity0_calibrate_store(struct device *dev,
 	if (strtobool(buf, &value))
 		return -EINVAL;
 
-	if (value)
-		tsl2x7x_prox_cal(indio_dev);
+	if (value) {
+		ret = tsl2x7x_prox_cal(indio_dev);
+		if (ret < 0)
+			return ret;
+	}
 
 	ret = tsl2x7x_invoke_change(indio_dev);
 	if (ret < 0)
-- 
2.14.3
