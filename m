Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:49826 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752715AbeDUAmL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 20 Apr 2018 20:42:11 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH 01/13] staging: iio: tsl2x7x: move integration_time* attributes to IIO_INTENSITY channel
Date: Fri, 20 Apr 2018 20:41:41 -0400
Message-Id: <20180421004153.19073-2-masneyb@onstation.org>
In-Reply-To: <20180421004153.19073-1-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The integration_time* attributes are currently associated with the
IIO_LIGHT channel but should be associated with the IIO_INTENSITY
channel. Directory listing of the sysfs attributes for a TSL2772
with this patch applied:

dev
events
in_illuminance0_calibrate
in_illuminance0_calibscale_available
in_illuminance0_input
in_illuminance0_lux_table
in_illuminance0_target_input
in_intensity0_calibbias
in_intensity0_calibscale
in_intensity0_integration_time
in_intensity0_integration_time_available
in_intensity0_raw
in_intensity1_raw
in_proximity0_calibrate
in_proximity0_calibscale
in_proximity0_calibscale_available
in_proximity0_raw
name
of_node
power
subsystem
uevent

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 9991b0483956..eeccfbb0eb1f 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -827,7 +827,7 @@ in_illuminance0_calibscale_available_show(struct device *dev,
 
 static IIO_CONST_ATTR(in_proximity0_calibscale_available, "1 2 4 8");
 
-static IIO_CONST_ATTR(in_illuminance0_integration_time_available,
+static IIO_CONST_ATTR(in_intensity0_integration_time_available,
 		".00272 - .696");
 
 static ssize_t in_illuminance0_target_input_show(struct device *dev,
@@ -1358,7 +1358,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 
 static struct attribute *tsl2x7x_ALS_device_attrs[] = {
 	&dev_attr_in_illuminance0_calibscale_available.attr,
-	&iio_const_attr_in_illuminance0_integration_time_available
+	&iio_const_attr_in_intensity0_integration_time_available
 		.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
@@ -1373,7 +1373,7 @@ static struct attribute *tsl2x7x_PRX_device_attrs[] = {
 
 static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
 	&dev_attr_in_illuminance0_calibscale_available.attr,
-	&iio_const_attr_in_illuminance0_integration_time_available
+	&iio_const_attr_in_intensity0_integration_time_available
 		.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
@@ -1389,7 +1389,7 @@ static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
 
 static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
 	&dev_attr_in_illuminance0_calibscale_available.attr,
-	&iio_const_attr_in_illuminance0_integration_time_available
+	&iio_const_attr_in_intensity0_integration_time_available
 		.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
@@ -1489,13 +1489,13 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.type = IIO_LIGHT,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
-					      BIT(IIO_CHAN_INFO_INT_TIME),
+			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
 			.channel = 0,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_INT_TIME) |
 				BIT(IIO_CHAN_INFO_CALIBSCALE) |
 				BIT(IIO_CHAN_INFO_CALIBBIAS),
 			.event_spec = tsl2x7x_events,
@@ -1529,13 +1529,13 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.type = IIO_LIGHT,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
-					      BIT(IIO_CHAN_INFO_INT_TIME),
+			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
 			.channel = 0,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_INT_TIME) |
 				BIT(IIO_CHAN_INFO_CALIBSCALE) |
 				BIT(IIO_CHAN_INFO_CALIBBIAS),
 			.event_spec = tsl2x7x_events,
@@ -1578,13 +1578,13 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.type = IIO_LIGHT,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
-					      BIT(IIO_CHAN_INFO_INT_TIME),
+			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
 			.channel = 0,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_INT_TIME) |
 				BIT(IIO_CHAN_INFO_CALIBSCALE) |
 				BIT(IIO_CHAN_INFO_CALIBBIAS),
 			.event_spec = tsl2x7x_events,
-- 
2.14.3

