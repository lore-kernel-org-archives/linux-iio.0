Return-Path: <SRS0=0nmU=46=gmail.com=harinath922@kernel.org>
From: Harinath Nampally <harinath922@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: light: Replace snprintf calls with scnprintf
Date: Wed, 24 May 2017 19:22:11 -0400
Message-Id: <1495668131-5239-1-git-send-email-harinath922@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the miscoded use of return value of snprintf
by using the scnprintf function which returns the length of actual
string created in the buffer.

Signed-off-by: Harinath Nampally <harinath922@gmail.com>
---
 drivers/staging/iio/light/tsl2x7x.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 1467199..6908bc1 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -921,7 +921,7 @@ static ssize_t power_state_show(struct device *dev,
 {
 	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", chip->tsl2x7x_chip_status);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", chip->tsl2x7x_chip_status);
 }
 
 static ssize_t power_state_store(struct device *dev,
@@ -954,17 +954,17 @@ static ssize_t in_illuminance0_calibscale_available_show(struct device *dev,
 	case tmd2671:
 	case tsl2771:
 	case tmd2771:
-		return snprintf(buf, PAGE_SIZE, "%s\n", "1 8 16 128");
+		return scnprintf(buf, PAGE_SIZE, "%s\n", "1 8 16 128");
 	}
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", "1 8 16 120");
+	return scnprintf(buf, PAGE_SIZE, "%s\n", "1 8 16 120");
 }
 
 static ssize_t in_proximity0_calibscale_available_show(struct device *dev,
 						struct device_attribute *attr,
 						char *buf)
 {
-		return snprintf(buf, PAGE_SIZE, "%s\n", "1 2 4 8");
+		return scnprintf(buf, PAGE_SIZE, "%s\n", "1 2 4 8");
 }
 
 static ssize_t in_illuminance0_integration_time_show(struct device *dev,
@@ -979,7 +979,7 @@ static ssize_t in_illuminance0_integration_time_show(struct device *dev,
 	y /= 1000;
 	z %= 1000;
 
-	return snprintf(buf, PAGE_SIZE, "%d.%03d\n", y, z);
+	return scnprintf(buf, PAGE_SIZE, "%d.%03d\n", y, z);
 }
 
 static ssize_t in_illuminance0_integration_time_store(struct device *dev,
@@ -1016,7 +1016,7 @@ static ssize_t in_illuminance0_target_input_show(struct device *dev,
 {
 	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
 			chip->tsl2x7x_settings.als_cal_target);
 }
 
@@ -1054,7 +1054,7 @@ static ssize_t in_intensity0_thresh_period_show(struct device *dev,
 	y = filter_delay / 1000;
 	z = filter_delay % 1000;
 
-	return snprintf(buf, PAGE_SIZE, "%d.%03d\n", y, z);
+	return scnprintf(buf, PAGE_SIZE, "%d.%03d\n", y, z);
 }
 
 static ssize_t in_intensity0_thresh_period_store(struct device *dev,
@@ -1102,7 +1102,7 @@ static ssize_t in_proximity0_thresh_period_show(struct device *dev,
 	y = filter_delay / 1000;
 	z = filter_delay % 1000;
 
-	return snprintf(buf, PAGE_SIZE, "%d.%03d\n", y, z);
+	return scnprintf(buf, PAGE_SIZE, "%d.%03d\n", y, z);
 }
 
 static ssize_t in_proximity0_thresh_period_store(struct device *dev,
@@ -1163,7 +1163,7 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
 	int offset = 0;
 
 	while (i < (TSL2X7X_MAX_LUX_TABLE_SIZE * 3)) {
-		offset += snprintf(buf + offset, PAGE_SIZE, "%u,%u,%u,",
+		offset += scnprintf(buf + offset, PAGE_SIZE, "%u,%u,%u,",
 			chip->tsl2x7x_device_lux[i].ratio,
 			chip->tsl2x7x_device_lux[i].ch0,
 			chip->tsl2x7x_device_lux[i].ch1);
@@ -1178,7 +1178,7 @@ static ssize_t in_illuminance0_lux_table_show(struct device *dev,
 		i++;
 	}
 
-	offset += snprintf(buf + offset, PAGE_SIZE, "\n");
+	offset += scnprintf(buf + offset, PAGE_SIZE, "\n");
 	return offset;
 }
 
-- 
2.7.4
