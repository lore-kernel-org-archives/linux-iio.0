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
Subject: [PATCH 06/13] staging: iio: tsl2x7x: convert in_proximity0_calibscale_available to use IIO_CONST_ATTR
Date: Thu, 19 Oct 2017 16:06:25 -0400
Message-Id: <20171019200632.25820-7-masneyb@onstation.org>
In-Reply-To: <20171019200632.25820-1-masneyb@onstation.org>
References: <20171019200632.25820-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

The sysfs attribute in_proximity0_calibscale_available is currently
created by using DEVICE_ATTR_RO(). Convert this over to use
IIO_CONST_ATTR().

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 3a3340aadc1a..80968dd456a0 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -886,12 +886,7 @@ static ssize_t in_illuminance0_calibscale_available_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%s\n", "1 8 16 120");
 }
 
-static ssize_t in_proximity0_calibscale_available_show(struct device *dev,
-						struct device_attribute *attr,
-						char *buf)
-{
-		return snprintf(buf, PAGE_SIZE, "%s\n", "1 2 4 8");
-}
+static IIO_CONST_ATTR(in_proximity0_calibscale_available, "1 2 4 8");
 
 static IIO_CONST_ATTR(in_illuminance0_integration_time_available,
 		".00272 - .696");
@@ -1371,8 +1366,6 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 	return tsl2x7x_invoke_change(indio_dev);
 }
 
-static DEVICE_ATTR_RO(in_proximity0_calibscale_available);
-
 static DEVICE_ATTR_RO(in_illuminance0_calibscale_available);
 
 static DEVICE_ATTR_RW(in_illuminance0_target_input);
@@ -1468,13 +1461,13 @@ static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
 	&dev_attr_in_illuminance0_lux_table.attr,
-	&dev_attr_in_proximity0_calibrate.attr,
+	&iio_const_attr_in_proximity0_calibscale_available.dev_attr.attr,
 	NULL
 };
 
 static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
 	&dev_attr_in_proximity0_calibrate.attr,
-	&dev_attr_in_proximity0_calibscale_available.attr,
+	&iio_const_attr_in_proximity0_calibscale_available.dev_attr.attr,
 	NULL
 };
 
@@ -1485,7 +1478,7 @@ static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
 	&dev_attr_in_illuminance0_calibrate.attr,
 	&dev_attr_in_illuminance0_lux_table.attr,
 	&dev_attr_in_proximity0_calibrate.attr,
-	&dev_attr_in_proximity0_calibscale_available.attr,
+	&iio_const_attr_in_proximity0_calibscale_available.dev_attr.attr,
 	NULL
 };
 
-- 
2.13.6
