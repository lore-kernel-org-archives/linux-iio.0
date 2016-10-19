Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] iio: light: tsl2583: return proper error code in sysfs store functions
Date: Wed, 19 Oct 2016 06:32:07 -0400
Message-Id: <1476873130-24926-4-git-send-email-masneyb@onstation.org>
In-Reply-To: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
References: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

illuminance0_calibbias_store(), illuminance0_input_target_store(), and
illuminance0_calibrate_store() did not return an error code when
an invalid value was passed in. The input was checked to see if the
input was valid, however the caller would not be notified that an
invalid value was passed in. This patch changes these three functions to
return -EINVAL when invalid input is passed in.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index bbb8fc3..a60433e 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -657,9 +657,10 @@ static ssize_t illuminance0_calibbias_store(struct device *dev,
 
 	if (kstrtoint(buf, 0, &value))
 		return -EINVAL;
+	else if (!value)
+		return -EINVAL;
 
-	if (value)
-		chip->taos_settings.als_gain_trim = value;
+	chip->taos_settings.als_gain_trim = value;
 
 	return len;
 }
@@ -684,9 +685,10 @@ static ssize_t illuminance0_input_target_store(struct device *dev,
 
 	if (kstrtoint(buf, 0, &value))
 		return -EINVAL;
+	else if (!value)
+		return -EINVAL;
 
-	if (value)
-		chip->taos_settings.als_cal_target = value;
+	chip->taos_settings.als_cal_target = value;
 
 	return len;
 }
@@ -713,9 +715,10 @@ static ssize_t illuminance0_calibrate_store(struct device *dev,
 
 	if (kstrtoint(buf, 0, &value))
 		return -EINVAL;
+	else if (value != 1)
+		return -EINVAL;
 
-	if (value == 1)
-		taos_als_calibrate(indio_dev);
+	taos_als_calibrate(indio_dev);
 
 	return len;
 }
-- 
2.7.4
