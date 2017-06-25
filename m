Return-Path: <SRS0=mYNF=56=gmail.com=gauravpathak129@kernel.org>
From: Gaurav Pathak <gauravpathak129@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Gaurav Pathak <gauravpathak129@gmail.com>
Subject: [PATCH] Fixed coding style issue; reduced lines containing more than 80 chars
Date: Sun, 25 Jun 2017 21:31:31 +0530
Message-Id: <1498406491-13733-1-git-send-email-gauravpathak129@gmail.com>
In-Reply-To: <20170625164706.7e66a6e3@kernel.org>
References: <20170625164706.7e66a6e3@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Gaurav Pathak <gauravpathak129@gmail.com>
---
 drivers/staging/iio/light/tsl2x7x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 1467199..7d02a8b 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -1007,7 +1007,7 @@ static ssize_t in_illuminance0_integration_time_store(struct device *dev,
 	return IIO_VAL_INT_PLUS_MICRO;
 }
 
-static IIO_CONST_ATTR(in_illuminance0_integration_time_available,
+static IIO_CONST_ATTR(in_illuminance0_integration_time_avail,
 		".00272 - .696");
 
 static ssize_t in_illuminance0_target_input_show(struct device *dev,
@@ -1583,7 +1583,7 @@ static struct attribute *tsl2x7x_ALS_device_attrs[] = {
 	&dev_attr_power_state.attr,
 	&dev_attr_in_illuminance0_calibscale_available.attr,
 	&dev_attr_in_illuminance0_integration_time.attr,
-	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
+	&iio_const_attr_in_illuminance0_integration_time_avail.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
 	&dev_attr_in_illuminance0_lux_table.attr,
@@ -1600,7 +1600,7 @@ static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
 	&dev_attr_power_state.attr,
 	&dev_attr_in_illuminance0_calibscale_available.attr,
 	&dev_attr_in_illuminance0_integration_time.attr,
-	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
+	&iio_const_attr_in_illuminance0_integration_time_avail.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
 	&dev_attr_in_illuminance0_lux_table.attr,
@@ -1619,7 +1619,7 @@ static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
 	&dev_attr_power_state.attr,
 	&dev_attr_in_illuminance0_calibscale_available.attr,
 	&dev_attr_in_illuminance0_integration_time.attr,
-	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
+	&iio_const_attr_in_illuminance0_integration_time_avail.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
 	&dev_attr_in_illuminance0_lux_table.attr,
-- 
2.7.4
