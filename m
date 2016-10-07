Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: [PATCH 1/4] staging: iio: isl29018: add documentation about the infrared suppression
Date: Thu,  6 Oct 2016 20:48:34 -0400
Message-Id: <1475801317-29449-1-git-send-email-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

Add documentation from the ISL29018 Data Sheet (FN6619.4, Oct 8, 2012)
about the infrared suppression that can be controlled
with the proximity_on_chip_ambient_infrared_suppression sysfs attribute.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29018.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 51226bd..52bfb1cb 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -307,6 +307,24 @@ static ssize_t in_illuminance_integration_time_available_show
 	return len;
 }
 
+/*
+ * From ISL29018 Data Sheet (FN6619.4, Oct 8, 2012) regarding the
+ * infrared suppression:
+ *
+ *   Proximity Sensing Scheme: Bit 7. This bit programs the function
+ * of the proximity detection. Logic 0 of this bit, Scheme 0, makes
+ * full n (4, 8, 12, 16) bits (unsigned) proximity detection. The range
+ * of Scheme 0 proximity count is from 0 to 2^n. Logic 1 of this bit,
+ * Scheme 1, makes n-1 (3, 7, 11, 15) bits (2's complementary)
+ * proximity_less_ambient detection. The range of Scheme 1
+ * proximity count is from -2^(n-1) to 2^(n-1) . The sign bit is extended
+ * for resolutions less than 16. While Scheme 0 has wider dynamic
+ * range, Scheme 1 proximity detection is less affected by the
+ * ambient IR noise variation.
+ *
+ * 0 Sensing IR from LED and ambient
+ * 1 Sensing IR from LED with ambient IR rejection
+ */
 static ssize_t proximity_on_chip_ambient_infrared_suppression_show
 			(struct device *dev, struct device_attribute *attr,
 			 char *buf)
-- 
2.5.5
