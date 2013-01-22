Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:42649 "EHLO
	ppsw-43.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335Ab3AVQQr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Jan 2013 11:16:47 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, denis.ciocca@st.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 07/10] iio:magn:st_magn drop unwanted EXPORT_SYMBOLs
Date: Tue, 22 Jan 2013 16:16:36 +0000
Message-Id: <1358871399-11216-8-git-send-email-jic23@kernel.org>
In-Reply-To: <1358871399-11216-1-git-send-email-jic23@kernel.org>
References: <50FEBB20.7070407@kernel.org>
 <1358871399-11216-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

---
 drivers/iio/magnetometer/st_magn_buffer.c | 2 --
 drivers/iio/magnetometer/st_magn_core.c   | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
index 06bf621..1d518db 100644
--- a/drivers/iio/magnetometer/st_magn_buffer.c
+++ b/drivers/iio/magnetometer/st_magn_buffer.c
@@ -88,13 +88,11 @@ int st_magn_allocate_ring(struct iio_dev *indio_dev)
 	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
 		&st_sensors_trigger_handler, &st_magn_buffer_setup_ops);
 }
-EXPORT_SYMBOL(st_magn_allocate_ring);
 
 void st_magn_deallocate_ring(struct iio_dev *indio_dev)
 {
 	iio_triggered_buffer_cleanup(indio_dev);
 }
-EXPORT_SYMBOL(st_magn_deallocate_ring);
 
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics magnetometers buffer");
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 845f5db..25450bd 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -310,7 +310,6 @@ int st_magn_set_axis_enable(struct iio_dev *indio_dev, u8 active_bit)
 {
 	return 0;
 }
-EXPORT_SYMBOL(st_magn_set_axis_enable);
 
 int st_magn_set_enable(struct iio_dev *indio_dev, bool enable)
 {
@@ -319,7 +318,6 @@ int st_magn_set_enable(struct iio_dev *indio_dev, bool enable)
 	return st_sensors_set_enable(indio_dev,
 				&st_magn_sensors[mdata->index], enable);
 }
-EXPORT_SYMBOL(st_magn_set_enable);
 
 static ssize_t st_magn_sysfs_set_sampling_frequency(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t size)
-- 
1.8.1.1

