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
Subject: [PATCH 08/13] staging: iio: tsl2x7x: add range checking to three sysfs attributes
Date: Fri, 20 Apr 2018 20:41:48 -0400
Message-Id: <20180421004153.19073-9-masneyb@onstation.org>
In-Reply-To: <20180421004153.19073-1-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

The sysfs attributes in_illuminance0_target_input,
in_illuminance0_calibrate, and in_proximity0_calibrate did not have
proper range checking in place so this patch adds the correct range
checks.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 56730baea927..15bc0af1bb6c 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -835,9 +835,10 @@ static ssize_t in_illuminance0_target_input_store(struct device *dev,
 	if (kstrtoul(buf, 0, &value))
 		return -EINVAL;
 
-	if (value)
-		chip->settings.als_cal_target = value;
+	if (value < 0 || value > 65535)
+		return -ERANGE;
 
+	chip->settings.als_cal_target = value;
 	ret = tsl2x7x_invoke_change(indio_dev);
 	if (ret < 0)
 		return ret;
@@ -853,14 +854,12 @@ static ssize_t in_illuminance0_calibrate_store(struct device *dev,
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
@@ -946,14 +945,12 @@ static ssize_t in_proximity0_calibrate_store(struct device *dev,
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
