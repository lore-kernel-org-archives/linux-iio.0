Return-Path: <SRS0=zzH2=HX=onstation.org=masneyb@kernel.org>
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
Subject: [PATCH v2 02/11] staging: iio: tsl2x7x: add range checking to three sysfs attributes
Date: Thu,  3 May 2018 22:53:10 -0400
Message-Id: <20180504025319.28953-3-masneyb@onstation.org>
In-Reply-To: <20180504025319.28953-1-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

The sysfs attributes in_illuminance0_target_input,
in_illuminance0_calibrate, and in_proximity0_calibrate did not have
proper range checking in place so this patch adds the correct range
checks.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 01bff4593640..b4d77f65ca12 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -814,15 +814,13 @@ static ssize_t in_illuminance0_target_input_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	unsigned long value;
+	u16 value;
 	int ret;
 
-	if (kstrtoul(buf, 0, &value))
+	if (kstrtou16(buf, 0, &value))
 		return -EINVAL;
 
-	if (value)
-		chip->settings.als_cal_target = value;
-
+	chip->settings.als_cal_target = value;
 	ret = tsl2x7x_invoke_change(indio_dev);
 	if (ret < 0)
 		return ret;
@@ -838,14 +836,12 @@ static ssize_t in_illuminance0_calibrate_store(struct device *dev,
 	bool value;
 	int ret;
 
-	if (strtobool(buf, &value))
+	if (kstrtobool(buf, &value) || !value)
 		return -EINVAL;
 
-	if (value) {
-		ret = tsl2x7x_als_calibrate(indio_dev);
-		if (ret < 0)
-			return ret;
-	}
+	ret = tsl2x7x_als_calibrate(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	ret = tsl2x7x_invoke_change(indio_dev);
 	if (ret < 0)
@@ -932,14 +928,12 @@ static ssize_t in_proximity0_calibrate_store(struct device *dev,
 	bool value;
 	int ret;
 
-	if (strtobool(buf, &value))
+	if (kstrtobool(buf, &value) || !value)
 		return -EINVAL;
 
-	if (value) {
-		ret = tsl2x7x_prox_cal(indio_dev);
-		if (ret < 0)
-			return ret;
-	}
+	ret = tsl2x7x_prox_cal(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	ret = tsl2x7x_invoke_change(indio_dev);
 	if (ret < 0)
-- 
2.14.3
