Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:42616 "EHLO
	ppsw-43.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273Ab3AVQQq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Jan 2013 11:16:46 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, denis.ciocca@st.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 01/10] iio:st_sensors drop some unused exports
Date: Tue, 22 Jan 2013 16:16:30 +0000
Message-Id: <1358871399-11216-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1358871399-11216-1-git-send-email-jic23@kernel.org>
References: <50FEBB20.7070407@kernel.org>
 <1358871399-11216-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Apply this to the patch that introduces the library.
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 6 ++----
 include/linux/iio/common/st_sensors.h           | 6 ------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 661cc2b..25d7b62 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -20,7 +20,7 @@
 
 #define ST_SENSORS_WAI_ADDRESS		0x0f
 
-int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
+static int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
 						u8 reg_addr, u8 mask, u8 data)
 {
 	int err;
@@ -37,7 +37,6 @@ int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
 st_sensors_write_data_with_mask_error:
 	return err;
 }
-EXPORT_SYMBOL(st_sensors_write_data_with_mask);
 
 int st_sensors_get_sampling_frequency_avl(struct iio_dev *indio_dev,
 			const struct st_sensor_odr_avl *odr_avl, char *buf)
@@ -152,7 +151,7 @@ st_sensors_match_odr_error:
 	return ret;
 }
 
-int st_sensors_set_fullscale(struct iio_dev *indio_dev,
+static int st_sensors_set_fullscale(struct iio_dev *indio_dev,
 			const struct st_sensors *sensor, unsigned int fs)
 {
 	int err, i;
@@ -175,7 +174,6 @@ st_accel_set_fullscale_error:
 	dev_err(&indio_dev->dev, "failed to set new fullscale.\n");
 	return err;
 }
-EXPORT_SYMBOL(st_sensors_set_fullscale);
 
 int st_sensors_set_enable(struct iio_dev *indio_dev,
 				const struct st_sensors *sensor, bool enable)
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index f27b1e0..b7bfd5d 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -235,18 +235,12 @@ int st_sensors_set_enable(struct iio_dev *indio_dev,
 int st_sensors_set_axis_enable(struct iio_dev *indio_dev,
 			const struct st_sensors *sensor, u8 axis_enable);
 
-int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
-						u8 reg_addr, u8 mask, u8 data);
-
 int st_sensors_get_sampling_frequency_avl(struct iio_dev *indio_dev,
 			const struct st_sensor_odr_avl *odr_avl, char *buf);
 
 int st_sensors_get_scale_avl(struct iio_dev *indio_dev,
 		const struct st_sensor_fullscale_avl *fullscale_avl, char *buf);
 
-int st_sensors_set_fullscale(struct iio_dev *indio_dev,
-			const struct st_sensors *sensor, unsigned int fs);
-
 int st_sensors_set_odr(struct iio_dev *indio_dev,
 			const struct st_sensors *sensor, unsigned int odr);
 
-- 
1.8.1.1

